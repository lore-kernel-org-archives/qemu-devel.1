Received: from eggs.gnu.org ([209.51.188.92]:54814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1guEu1-00051e-Ci
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:10:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1guEgf-0002el-Us
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:56:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1guEgc-0002X6-1L
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:56:13 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 028C189AD7
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 10:56:06 +0000 (UTC)
Date: Thu, 14 Feb 2019 11:56:03 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190214115603.1ca98b68@redhat.com>
In-Reply-To: <877ee36cj4.fsf@dusky.pond.sub.org>
References: <1549377087-205549-1-git-send-email-imammedo@redhat.com>
	<877ee36cj4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hostmem: fix crash when querying empty
 host-nodes property via QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com

On Wed, 13 Feb 2019 14:30:55 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Igor Mammedov <imammedo@redhat.com> writes:
> 
> > QEMU will crashes with
> >  qapi/qobject-output-visitor.c:210: qobject_output_complete: Assertion `qov->root && ((&qov->stack)->slh_first == ((void *)0))' failed
> > when trying to get value of empty hostmem.host-nodes property.
> >
> > Fix it by calling visitor even if host-nodes wasn't set
> > before exiting from property getter to return empty list.  
> 
> host-nodes or host_nodes?
> 
> If local variable host_nodes: that one's always set.  The case you fix
> has it set to NULL.

it's about property host-nodes:

  value = find_first_bit(backend->host_nodes, MAX_NODES);                      
  if (value == MAX_NODES) {                                                    
    goto ret;                                                                
  }

when no bits set, it exits without visiting being returned list.

I'll send v2 with commit message giving more explanation to make
it clearer.

> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  backends/hostmem.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/backends/hostmem.c b/backends/hostmem.c
> > index 0c8ef17..fe14be5 100644
> > --- a/backends/hostmem.c
> > +++ b/backends/hostmem.c
> > @@ -86,7 +86,7 @@ host_memory_backend_get_host_nodes(Object *obj, Visitor *v, const char *name,
> >  
> >      value = find_first_bit(backend->host_nodes, MAX_NODES);
> >      if (value == MAX_NODES) {
> > -        return;
> > +        goto ret;
> >      }
> >  
> >      *node = g_malloc0(sizeof(**node));
> > @@ -104,6 +104,7 @@ host_memory_backend_get_host_nodes(Object *obj, Visitor *v, const char *name,
> >          node = &(*node)->next;
> >      } while (true);
> >  
> > +ret:
> >      visit_type_uint16List(v, name, &host_nodes, errp);
> >  }  
> 
> Yes, an empty list needs to be visited just like a non-empty list.
> 
> Patch looks good.
> 
