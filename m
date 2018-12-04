Received: from eggs.gnu.org ([2001:4830:134:3::10]:57912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gUAlX-0007OK-6V
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:29:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gUAlS-0000UE-9A
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:29:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35667)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gUAlR-0000Tc-UX
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:29:26 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D4728309D55C
	for <qemu-devel@nongnu.org>; Tue,  4 Dec 2018 13:29:24 +0000 (UTC)
Date: Tue, 4 Dec 2018 14:29:01 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181204142901.23c3f37c@redhat.com>
In-Reply-To: <20181130122844.29103-1-ehabkost@redhat.com>
References: <20181130122844.29103-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hostmem: Validate host-nodes before
 setting bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>

On Fri, 30 Nov 2018 10:28:44 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> host_memory_backend_set_host_nodes() was not validating
> host-nodes before writing to backend->host_nodes, making QEMU
> write beyond the end of the bitmap.
> 
> Fix the crash and add a simple regression test for the fix.
> 
> While at it, fix memory leak of the list returned by
> visit_type_uint16List().
> 
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> Changes v1 -> v2:
> * Remove extra `l = l->next` statement
>   (reported by Stefano Garzarella)
> * Fix (existing) leak of `host_nodes`
>   (reported by Markus Armbruster)
> ---
>  backends/hostmem.c                   | 17 +++++++++----
>  tests/acceptance/host-nodes-limit.py | 36 ++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+), 4 deletions(-)
>  create mode 100644 tests/acceptance/host-nodes-limit.py
> 
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index 1a89342039..af800284e0 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -103,14 +103,23 @@ host_memory_backend_set_host_nodes(Object *obj, Visitor *v, const char *name,
>  {
>  #ifdef CONFIG_NUMA
>      HostMemoryBackend *backend = MEMORY_BACKEND(obj);
> -    uint16List *l = NULL;
> +    uint16List *l, *host_nodes = NULL;
>  
> -    visit_type_uint16List(v, name, &l, errp);
> +    visit_type_uint16List(v, name, &host_nodes, errp);
>  
> -    while (l) {
> +    for (l = host_nodes; l; l = l->next) {
> +        if (l->value >= MAX_NODES) {
> +            error_setg(errp, "Invalid host-nodes value: %d", l->value);
> +            goto out;
> +        }
> +    }
> +
> +    for (l = host_nodes; l; l = l->next) {
>          bitmap_set(backend->host_nodes, l->value, 1);
> -        l = l->next;
>      }
> +
> +out:
> +    qapi_free_uint16List(host_nodes);
>  #else
>      error_setg(errp, "NUMA node binding are not supported by this QEMU");
>  #endif
> diff --git a/tests/acceptance/host-nodes-limit.py b/tests/acceptance/host-nodes-limit.py
> new file mode 100644
> index 0000000000..e803e10104
> --- /dev/null
> +++ b/tests/acceptance/host-nodes-limit.py
> @@ -0,0 +1,36 @@
> +# Regression test for host-nodes limit validation
> +#
> +# Copyright (c) 2018 Red Hat, Inc.
> +#
> +# Author:
> +#  Eduardo Habkost <ehabkost@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +from avocado_qemu import Test
> +from subprocess import Popen, PIPE
> +
> +MAX_NODES = 128
> +
> +class HostNodesValidation(Test):
> +    def test_large_host_nodes(self):
> +        p = Popen([self.qemu_bin, '-display', 'none', '-nodefaults',
> +                   '-object', 'memory-backend-ram,id=m0,'
> +                              'size=4096,host-nodes=%d' % (MAX_NODES)],
> +                  stderr=PIPE, stdout=PIPE)
> +        stdout,stderr = p.communicate()
> +
> +        self.assertIn(b'Invalid host-nodes', stderr)
> +        self.assertEquals(stdout, b'')
> +        self.assertEquals(p.returncode, 1)
> +
> +    def test_valid_host_nodes(self):
> +        p = Popen([self.qemu_bin, '-display', 'none', '-nodefaults',
> +                   '-object', 'memory-backend-ram,id=m0,'
> +                              'size=4096,host-nodes=%d' % (MAX_NODES - 1)],
> +                  stderr=PIPE, stdout=PIPE)
> +        stdout,stderr = p.communicate()
> +
> +        self.assertIn(b'host-nodes must be empty', stderr)
> +        self.assertEquals(p.returncode, 1)
