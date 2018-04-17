Received: from eggs.gnu.org ([2001:4830:134:3::10]:38732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f8PZ5-0002eO-Nf
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 08:18:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f8PYz-0004y4-LR
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 08:18:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59348 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1f8PYz-0004wl-Fh
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 08:18:21 -0400
Date: Tue, 17 Apr 2018 14:18:03 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180417141803.2d588b97@redhat.com>
In-Reply-To: <13008b1f-4b59-c6e1-69d2-98f8280f6f34@redhat.com>
References: <20180329032149.44685-1-aik@ozlabs.ru>
	<bc4100f4-0a01-a526-c6ce-c2602a96e28a@redhat.com>
	<20180416152040.7b88b902@redhat.com>
	<e483d218-0e93-4a2b-43ea-4a961e559c4d@redhat.com>
	<20180416162706.43212a69@redhat.com>
	<13008b1f-4b59-c6e1-69d2-98f8280f6f34@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH qemu] RFC: memory/hmp: Print owners/parents
 in "info mtree"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, "Dr. David
	Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, peter.maydell@linaro.org

On Mon, 16 Apr 2018 17:29:23 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 16/04/2018 16:27, Igor Mammedov wrote:
> > On Mon, 16 Apr 2018 15:30:39 +0200
> > Paolo Bonzini <pbonzini@redhat.com> wrote:
> >  =20
> >> On 16/04/2018 15:20, Igor Mammedov wrote: =20
> >>> Generally object doesn't need to know its own name,
> >>> we use it only for debugging and nice error reporting so far.
> >>> I'd rather have 'id' property at Object level so we won't have
> >>> to fish out ID from parent /which we aren't supposed to do and
> >>> which doesn't work in some cases/ when it's needed within
> >>> object itself.   =20
> >>
> >> Having an 'id' at object level is also a mess, because that id is
> >> invalid after unparent. =20
> > I'd just consider 'id' as object name which is valid even if there
> > is no parent (during whole object lifecycle). =20
>=20
> What's the point of an object name if it cannot be unique?
It should be sufficient for it to be unique within parent's
scope and object_property_add_child() should make sure that
added object is unique within its parent's namespace.
Having named object from starters is useful as object
won't have to piggyback on parent (object_get_canonical_path_component)
when it need its own name. Then named object could use its name
freely anywhere including initfn, property setters/getters and
let object_property_add_child() take care of possible name
conflict.
=46rom debugging/error reporting pov 'id' might be ambiguous
sometimes but it's way better than unanimous "NULL" string
or crash due to no set parent.

It sort of relates to discussion Peter started with

https://patchwork.kernel.org/patch/10224775/
"
Code that used to look like this:
    object_initialize(&s->ic, sizeof(s->ic), TYPE_BCM2835_IC);
    object_property_add_child(obj, "ic", OBJECT(&s->ic), NULL);
    qdev_set_parent_bus(DEVICE(&s->ic), sysbus_get_default());
can now look like this:
    sysbus_init_child(obj, "ic", &s->ic, sizeof(s->ic), TYPE_BCM2835_IC);
"=20

Considering that in most cases where named objects are used
we parent them. We might be better of with API like

named_object_new(TYPE, NAME, PARENT, ERROR)
named_object_initialize(PTR, SIZE, TYPE, NAME, PARENT, ERROR)


> Paolo
>=20
> > That would allow for object to have a reachable name vs getting NULL
> > when parent isn't set.
> > Maybe Object::id is overkill, but we probably could use NamedObject
> > where it's needed and avoid reverse engineering id from path.
> >   =20
> >> Since this is just for debugging use,
> >> object_get_canonical_path_component is the right function.  We can just
> >> make it return NULL if there is no parent. =20
> >
> > looking at current use it out-grew just debugging usecases
> > and it's rather messy right now:
> >=20
> > ram_backend_memory_alloc, throttle_group_obj_complete,
> > xlnx_zynqmp_create_rpu, spapr_drc.c:realize, iothread_complete,
> > memory_region_name =20
>=20
> I agree, _but_ it's definitely okay for debugging usecases.
yep, since there isn't other way to do it now,
it's fine to use object_get_canonical_path_component()


>=20
> Paolo
