Received: from eggs.gnu.org ([2001:4830:134:3::10]:44320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cGUWv-0007Iq-Gl
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 12:36:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cGUWq-0002Wo-Ev
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 12:36:49 -0500
Date: Mon, 12 Dec 2016 15:36:41 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161212173641.GD3808@thinpad.lan.raisama.net>
References: <148104617887.7699.984921868108236415.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<20161206191952.GD4027@thinpad.lan.raisama.net>
	<20161206193159.GE4027@thinpad.lan.raisama.net>
	<20161212132509.6a031fb6.cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161212132509.6a031fb6.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [RFC for-2.8] machine: Convert abstract typename
 on compat_props to subclass names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Dec 12, 2016 at 01:25:09PM +0100, Cornelia Huck wrote:
> On Tue, 6 Dec 2016 17:31:59 -0200
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > What about this?
> > 
> > (untested)
> 
> Have not tested it either, but I think it looks good. Some nits below.

Thanks!

> 
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  hw/core/machine.c | 35 ++++++++++++++++++++++++++++++++---
> >  1 file changed, 32 insertions(+), 3 deletions(-)
> > 
> 
> > @@ -565,10 +584,20 @@ void machine_register_compat_props(MachineState *machine)
> >      }
> > 
> >      for (i = 0; i < mc->compat_props->len; i++) {
> > +        ObjectClass *oc;
> 
> Move the declaration out of the loop?

I will do it on v2.

> 
> >          p = g_array_index(mc->compat_props, GlobalProperty *, i);
> > -        /* Machine compat_props must never cause errors: */
> > -        p->errp = &error_abort;
> > -        qdev_prop_register_global(p);
> > +        oc = object_class_by_name(p->driver);
> > +        if (oc && object_class_is_abstract(oc)) {
> > +            /* temporary hack to make sure we will never override
> > +             * globals set explicitly on -global: if an abstract class
> > +             * is on compat_props, register globals for each of their
> > +             * subclasses instead.
> > +             */
> 
> I think this should not just be a 'temporary hack'... rather document
> this behaviour for abstract classes?

I'm not sure. I believe the translation from abstract superclass
to subclasses just emulates the behavior implemented by Greg Kurz
at "qdev: fix the order compat and global properties are applied"
in a more complicated way (and only for compat_props, not for
-global).

This hack specifically would not be enough because it affects
only compat_props, and still behaves in a weird way when
non-abstract classes have subclasses.

> 
> > +            object_class_foreach(machine_register_compat_for_subclass,
> > +                                 p->driver, false, p);
> > +        } else {
> > +            register_compat_prop(p->driver, p->property, p->value);
> > +        }
> >      }
> >  }
> > 
> 

-- 
Eduardo
