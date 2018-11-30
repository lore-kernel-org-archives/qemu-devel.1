Received: from eggs.gnu.org ([2001:4830:134:3::10]:56619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gSjln-0004j9-Ce
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:27:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gSjlk-0000WT-7n
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:27:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gSjlk-0000WK-1l
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:27:48 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3FF73811D3
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 14:27:47 +0000 (UTC)
Date: Fri, 30 Nov 2018 12:27:42 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181130142742.GG18284@habkost.net>
References: <20181130122844.29103-1-ehabkost@redhat.com>
	<87in0ek8du.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87in0ek8du.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, David Hildenbrand <david@redhat.com>

On Fri, Nov 30, 2018 at 02:22:21PM +0100, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > host_memory_backend_set_host_nodes() was not validating
> > host-nodes before writing to backend->host_nodes, making QEMU
> > write beyond the end of the bitmap.
> >
> > Fix the crash and add a simple regression test for the fix.
> >
> > While at it, fix memory leak of the list returned by
> > visit_type_uint16List().
> >
> > Reported-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > Changes v1 -> v2:
> > * Remove extra `l = l->next` statement
> >   (reported by Stefano Garzarella)
> > * Fix (existing) leak of `host_nodes`
> >   (reported by Markus Armbruster)
> > ---
> >  backends/hostmem.c                   | 17 +++++++++----
> >  tests/acceptance/host-nodes-limit.py | 36 ++++++++++++++++++++++++++++
> >  2 files changed, 49 insertions(+), 4 deletions(-)
> >  create mode 100644 tests/acceptance/host-nodes-limit.py
> >
> > diff --git a/backends/hostmem.c b/backends/hostmem.c
> > index 1a89342039..af800284e0 100644
> > --- a/backends/hostmem.c
> > +++ b/backends/hostmem.c
> > @@ -103,14 +103,23 @@ host_memory_backend_set_host_nodes(Object *obj, Visitor *v, const char *name,
> >  {
> >  #ifdef CONFIG_NUMA
> >      HostMemoryBackend *backend = MEMORY_BACKEND(obj);
> > -    uint16List *l = NULL;
> > +    uint16List *l, *host_nodes = NULL;
> >  
> > -    visit_type_uint16List(v, name, &l, errp);
> > +    visit_type_uint16List(v, name, &host_nodes, errp);
> >  
> > -    while (l) {
> > +    for (l = host_nodes; l; l = l->next) {
> > +        if (l->value >= MAX_NODES) {
> > +            error_setg(errp, "Invalid host-nodes value: %d", l->value);
> > +            goto out;
> > +        }
> > +    }
> > +
> > +    for (l = host_nodes; l; l = l->next) {
> >          bitmap_set(backend->host_nodes, l->value, 1);
> > -        l = l->next;
> >      }
> > +
> > +out:
> > +    qapi_free_uint16List(host_nodes);
> >  #else
> >      error_setg(errp, "NUMA node binding are not supported by this QEMU");
> >  #endif
> 
> Care to fix the leak in host_memory_backend_get_host_nodes(), too?

I don't understand yet if there's a leak at
host_memory_backend_get_host_nodes().  Won't
visit_type_uint16List() take ownership of the list on that case?

> 
> [...]
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

-- 
Eduardo
