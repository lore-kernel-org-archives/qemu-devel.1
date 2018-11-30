Received: from eggs.gnu.org ([2001:4830:134:3::10]:44987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gShCV-0007Am-Iz
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:43:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gShCS-0004Qj-F1
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:43:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gShCS-0004Qa-8v
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:43:12 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97DBFC0C0565
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 11:43:11 +0000 (UTC)
Date: Fri, 30 Nov 2018 09:43:07 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181130114307.GW18284@habkost.net>
References: <20181129185754.7009-1-ehabkost@redhat.com>
	<CAGxU2F46CNfEeRNbD59sJmZE5W9nrCcZcQgr-ZQTcXb8mqeq5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F46CNfEeRNbD59sJmZE5W9nrCcZcQgr-ZQTcXb8mqeq5A@mail.gmail.com>
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
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, Markus Armbruster <armbru@redhat.com>, david@redhat.com

On Fri, Nov 30, 2018 at 09:32:21AM +0100, Stefano Garzarella wrote:
> On Thu, Nov 29, 2018 at 7:59 PM Eduardo Habkost <ehabkost@redhat.com> wrote:
> >
> > host_memory_backend_set_host_nodes() was not validating
> > host-nodes before writing to backend->host_nodes, making QEMU
> > write beyond the end of the bitmap.
> >
> > Fix the crash and add a simple regression test for the fix.
> >
> > Reported-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  backends/hostmem.c                   | 13 +++++++---
> >  tests/acceptance/host-nodes-limit.py | 36 ++++++++++++++++++++++++++++
> >  2 files changed, 46 insertions(+), 3 deletions(-)
> >  create mode 100644 tests/acceptance/host-nodes-limit.py
> >
> > diff --git a/backends/hostmem.c b/backends/hostmem.c
> > index 1a89342039..ef199d32fd 100644
> > --- a/backends/hostmem.c
> > +++ b/backends/hostmem.c
> > @@ -103,11 +103,18 @@ host_memory_backend_set_host_nodes(Object *obj, Visitor *v, const char *name,
> >  {
> >  #ifdef CONFIG_NUMA
> >      HostMemoryBackend *backend = MEMORY_BACKEND(obj);
> > -    uint16List *l = NULL;
> > +    uint16List *l, *host_nodes = NULL;
> >
> > -    visit_type_uint16List(v, name, &l, errp);
> > +    visit_type_uint16List(v, name, &host_nodes, errp);
> > +
> > +    for (l = host_nodes; l; l = l->next) {
> > +        if (l->value >= MAX_NODES) {
> > +            error_setg(errp, "Invalid host-nodes value: %d", l->value);
> > +            return;
> > +        }
> > +    }
> >
> > -    while (l) {
> > +    for (l = host_nodes; l; l = l->next) {
> >          bitmap_set(backend->host_nodes, l->value, 1);
> >          l = l->next;
> >      }
> 
> Using the for loop instead of the while, maybe we need to remove the l
> = l->next in the for body.

Yeah, we must remove it.  I did remove it locally but I think I
forgot to amend the commit before submitting.  Thanks for
catching!

-- 
Eduardo
