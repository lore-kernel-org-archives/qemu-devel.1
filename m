Received: from eggs.gnu.org ([2001:4830:134:3::10]:37352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gSfDy-0003ET-Ih
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:36:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gSfDv-0000BE-7A
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:36:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gSfDu-0000Ai-Ue
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:36:35 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B4ABB0AC8
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 09:36:34 +0000 (UTC)
References: <20181129185754.7009-1-ehabkost@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <569403f1-ffbb-a160-7e0a-e625bfe0deff@redhat.com>
Date: Fri, 30 Nov 2018 10:36:32 +0100
MIME-Version: 1.0
In-Reply-To: <20181129185754.7009-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hostmem: Validate host-nodes before
 setting bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 29.11.18 19:57, Eduardo Habkost wrote:
> host_memory_backend_set_host_nodes() was not validating
> host-nodes before writing to backend->host_nodes, making QEMU
> write beyond the end of the bitmap.
> 
> Fix the crash and add a simple regression test for the fix.
> 
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  backends/hostmem.c                   | 13 +++++++---
>  tests/acceptance/host-nodes-limit.py | 36 ++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+), 3 deletions(-)
>  create mode 100644 tests/acceptance/host-nodes-limit.py
> 
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index 1a89342039..ef199d32fd 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -103,11 +103,18 @@ host_memory_backend_set_host_nodes(Object *obj, Visitor *v, const char *name,
>  {
>  #ifdef CONFIG_NUMA
>      HostMemoryBackend *backend = MEMORY_BACKEND(obj);
> -    uint16List *l = NULL;
> +    uint16List *l, *host_nodes = NULL;
>  
> -    visit_type_uint16List(v, name, &l, errp);
> +    visit_type_uint16List(v, name, &host_nodes, errp);
> +
> +    for (l = host_nodes; l; l = l->next) {
> +        if (l->value >= MAX_NODES) {
> +            error_setg(errp, "Invalid host-nodes value: %d", l->value);
> +            return;
> +        }
> +    }
>  

An alternative would be to use a temporary bitmap (on the stack)
instead and copy it only on success. E.g.

for (l = host_nodes; l; l = l->next) {
    if (l->value >= MAX_NODE) {
        error_setg(&local_err, "Invalid host-nodes value: %d", l->value);
        break;
    }
    bitmap_set(tmp, l->value, 1);
}

if (!local_err) {
    bitmap_copy(backend->host_nodes, tmp, MAX_NODE);
}
error_propagate...
free...


> -    while (l) {
> +    for (l = host_nodes; l; l = l->next) {
>          bitmap_set(backend->host_nodes, l->value, 1);
>          l = l->next;
>      }
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
> 


-- 

Thanks,

David / dhildenb
