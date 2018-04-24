Received: from eggs.gnu.org ([2001:4830:134:3::10]:50085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fAzvg-0005Np-O5
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:32:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fAzvd-0000XR-IX
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:32:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57388 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fAzvd-0000WF-Ch
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:32:25 -0400
Date: Tue, 24 Apr 2018 16:32:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180424153213.GE2521@work-vm>
References: <1520004397-28521-1-git-send-email-minyard@acm.org>
	<1520004397-28521-2-git-send-email-minyard@acm.org>
	<20180305140926.GK3131@work-vm>
	<88433e7c-2e0c-cef8-20a6-4fc9d3cacffb@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <88433e7c-2e0c-cef8-20a6-4fc9d3cacffb@acm.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] ipmi: Use proper struct reference
 for KCS vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <minyard@acm.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <cminyard@mvista.com>

* Corey Minyard (minyard@acm.org) wrote:
> On 03/05/2018 08:09 AM, Dr. David Alan Gilbert wrote:
> > * minyard@acm.org (minyard@acm.org) wrote:
> > > From: Corey Minyard <cminyard@mvista.com>
> > >=20
> > > The vmstate for isa_ipmi_kcs was referencing into the kcs structure=
,
> > > instead create a kcs structure separate and use that.
> > >=20
> > > There were also some issues in the state transfer.  The inlen field
> > > was not being transferred, so if a transaction was in process durin=
g
> > > the transfer it would be messed up.  And the use_irq field was
> > > transferred, but that should come from the configuration.
> > > And the
> > > name on the man VMStateDescription was incorrect, it needed to be
> > > differentiated from the BT one.
> > I think that's a bigger problem; lets see below.
> >=20
> > > To fix this, a new VMStateDescription is added that is hopefully
> > > correct, and the old one is kept (modified to remove use_irq) in
> > > a way that it can be received from the remote but will not be sent.
> > > So an upgrade should work for KCS.
> > >=20
> > > Signed-off-by: Corey Minyard <cminyard@mvista.com>
> > > Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > ---
> > >   hw/ipmi/isa_ipmi_kcs.c | 77 +++++++++++++++++++++++++++++++++++++=
+++++++++++--
> > >   1 file changed, 75 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
> > > index 689587b..2a2784d 100644
> > > --- a/hw/ipmi/isa_ipmi_kcs.c
> > > +++ b/hw/ipmi/isa_ipmi_kcs.c
> > > @@ -422,14 +422,86 @@ static void ipmi_isa_realize(DeviceState *dev=
, Error **errp)
> > >       isa_register_ioport(isadev, &iik->kcs.io, iik->kcs.io_base);
> > >   }
> > > -const VMStateDescription vmstate_ISAIPMIKCSDevice =3D {
> > > +static int ipmi_kcs_vmstate_post_load(void *opaque, int version)
> > > +{
> > > +    IPMIKCS *ik =3D opaque;
> > > +
> > > +    /* Make sure all the values are sane. */
> > > +    if (ik->outpos >=3D MAX_IPMI_MSG_SIZE || ik->outlen >=3D MAX_I=
PMI_MSG_SIZE ||
> > > +        ik->outpos >=3D ik->outlen) {
> > > +        ik->outpos =3D 0;
> > > +        ik->outlen =3D 0;
> > > +    }
> > > +
> > > +    if (ik->inlen >=3D MAX_IPMI_MSG_SIZE) {
> > > +        ik->inlen =3D 0;
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> > > +
> > > +static const VMStateDescription vmstate_IPMIKCS =3D {
> > > +    .name =3D TYPE_IPMI_INTERFACE_PREFIX "kcs",
> > > +    .version_id =3D 1,
> > > +    .minimum_version_id =3D 1,
> > > +    .post_load =3D ipmi_kcs_vmstate_post_load,
> > > +    .fields      =3D (VMStateField[]) {
> > > +        VMSTATE_BOOL(obf_irq_set, IPMIKCS),
> > > +        VMSTATE_BOOL(atn_irq_set, IPMIKCS),
> > > +        VMSTATE_BOOL(irqs_enabled, IPMIKCS),
> > > +        VMSTATE_UINT32(outpos, IPMIKCS),
> > > +        VMSTATE_UINT32(outlen, IPMIKCS),
> > > +        VMSTATE_UINT8_ARRAY(outmsg, IPMIKCS, MAX_IPMI_MSG_SIZE),
> > > +        VMSTATE_UINT32(inlen, IPMIKCS),
> > > +        VMSTATE_UINT8_ARRAY(inmsg, IPMIKCS, MAX_IPMI_MSG_SIZE),
> > > +        VMSTATE_BOOL(write_end, IPMIKCS),
> > > +        VMSTATE_UINT8(status_reg, IPMIKCS),
> > > +        VMSTATE_UINT8(data_out_reg, IPMIKCS),
> > > +        VMSTATE_INT16(data_in_reg, IPMIKCS),
> > > +        VMSTATE_INT16(cmd_reg, IPMIKCS),
> > > +        VMSTATE_UINT8(waiting_rsp, IPMIKCS),
> > > +        VMSTATE_END_OF_LIST()
> > > +    }
> > > +};
> > > +
> > > +static const VMStateDescription vmstate_ISAIPMIKCSDevice =3D {
> > > +    .name =3D TYPE_IPMI_INTERFACE_PREFIX "isa-kcs",
> > > +    .version_id =3D 2,
> > > +    .minimum_version_id =3D 2,
> > > +    .fields      =3D (VMStateField[]) {
> > > +        VMSTATE_STRUCT(kcs, ISAIPMIKCSDevice, 1, vmstate_IPMIKCS, =
IPMIKCS),
> > > +        VMSTATE_END_OF_LIST()
> > > +    }
> > > +};
> > I've got the following, which is only build tested but:
> >=20
> > +static const VMStateDescription vmstate_IPMIKCS =3D {
> > +    .name =3D TYPE_IPMI_INTERFACE_PREFIX "kcs",
> > +    .version_id =3D 2,
> > +    .minimum_version_id =3D 1,
> > +    .post_load =3D ipmi_kcs_vmstate_post_load,
> > +    .fields      =3D (VMStateField[]) {
> > +        VMSTATE_BOOL(obf_irq_set, IPMIKCS),
> > +        VMSTATE_BOOL(atn_irq_set, IPMIKCS),
> > +        VMSTATE_UNUSED(1), /* Was use_irq */
> > +        VMSTATE_BOOL(irqs_enabled, IPMIKCS),
> > +        VMSTATE_UINT32(outpos, IPMIKCS),
> > +        VMSTATE_UINT32_V(outlen, IPMIKCS,2),
> > +        VMSTATE_UINT8_ARRAY(outmsg, IPMIKCS, MAX_IPMI_MSG_SIZE),
> > +        VMSTATE_UINT32_V(inlen, IPMIKCS,2),
> > +        VMSTATE_UINT8_ARRAY(inmsg, IPMIKCS, MAX_IPMI_MSG_SIZE),
> > +        VMSTATE_BOOL(write_end, IPMIKCS),
> > +        VMSTATE_UINT8(status_reg, IPMIKCS),
> > +        VMSTATE_UINT8(data_out_reg, IPMIKCS),
> > +        VMSTATE_INT16(data_in_reg, IPMIKCS),
> > +        VMSTATE_INT16(cmd_reg, IPMIKCS),
> > +        VMSTATE_UINT8(waiting_rsp, IPMIKCS),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> > +static const VMStateDescription vmstate_ISAIPMIKCSDevice =3D {
> > +    .name =3D TYPE_IPMI_INTERFACE_PREFIX "isa-kcs",
> > +    .version_id =3D 2,
> > +    .minimum_version_id =3D 2,
> > +    .fields      =3D (VMStateField[]) {
> > +        VMSTATE_STRUCT(kcs, ISAIPMIKCSDevice, 2, vmstate_IPMIKCS, IP=
MIKCS),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> >=20
> > Note how the outlen and inlen fields use the _V modifier and are only
> > bound to v2, and I leave the UNUSED in for use_irq, that means we can
> > then mae the vmstate_v1_ISAIPMIKCSDevice just have:
> >=20
> > const VMStateDescription vmstate_v1_ISAIPMIKCSDevice =3D {
> >      .name =3D TYPE_IPMI_INTERFACE,
> >      .version_id =3D 1,
> >      .minimum_version_id =3D 1,
> >      .post_load =3D ipmi_kcs_v1_vmstate_post_load,
> >      .needed =3D ipmi_kcs_v1_vmstate_needed,
> >      .fields      =3D (VMStateField[]) {
> >          VMSTATE_STRUCT(kcs, ISAIPMIKCSDevice, 1, vmstate_IPMIKCS, IP=
MIKCS),
> >          VMSTATE_END_OF_LIST()
> >      }
> > };
> >=20
> > Note the '1'. in the VMSTATE_STRUCT.
> > As I say, that's untested, but if it works it saves a lot of
> > duplication.
> >=20
>=20
> Ah I misunderstood something.=A0 The version is sent for the section, a=
nd the
> version
> in the VMSTATE_STRUCT() is passed down when the structure is encoded an=
d
> decoded.=A0 I was thinking the version was transferred in the protocol,=
 but I
> can see
> now that is not the case.
>=20
> But....
>=20
> I implement that, and it doesn't work.=A0 It turns out that there is th=
e
> following in
> vmstate_load_state():
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else if (field->flags & VM=
S_STRUCT) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D vmsta=
te_load_state(f, field->vmsd, curr_elem,
> field->vmsd->version_id);
>=20
> So it doesn't matter what is in field->version_id, (which is where you =
say
> "Note
> the '1' in the VMSTATE_STRUCT).=A0 It passes in whatever the most curre=
nt
> version is from the vmsd.
>=20
> Plus that field value is used to compare for the incoming version. If y=
ou
> expect that the be the field passed down to the sub-structure, it's goi=
ng
> to need to be a different field.
>=20
> So this is not going to work, and the fix is not going to be easy, it
> appears.

I think you're right; so rereading, the 'version' in the
VMSTATE_STRUCT macro is behaving like as if it was VMSTATE_STRUCT_V
(named like the other _V macros) - do you agree?
(In actual fact I can see somewhere I used it like that)

<from your follow on mail>

> I've spent some time looking at this, and my conclusion is that this on=
ly
> works by accident.  There appears to be confusion about what this
> field does all over the code.
>=20
> I'm willing to put together a patch that clears up the confusion, but i=
t's
> going to be big and messy.  I could also create a new vmstate type,
> like VMSTATE_VSTRUCT(), which does what I need, and then we convert
> everything else over a piece at a time.

Can you give me some more detail about what you found?
If as I say above the main problem is that field is really
operating like a VMSTATE_STRUCT_V then we just need a rename there.
Adding a new flag/macro like you say for actually selecting the version
to use in the substructure would be doable if it fits nicely but
that doesn't seem like as massive change.
Have you found any places that you think are actually calling it
with the wrong expectation.

> > > +
> > > +/*
> > > + * Old version of the vmstate transfer that has a number of issues=
.
> > > + * We changed the vm state description name, so we need a separate
> > > + * structure and need to register it separately.
> > > + */
> > > +static int ipmi_kcs_v1_vmstate_post_load(void *opaque, int version=
)
> > > +{
> > > +    ISAIPMIKCSDevice *iik =3D opaque;
> > > +
> > > +    return ipmi_kcs_vmstate_post_load(&iik->kcs, version);
> > > +}
> > > +
> > > +static bool ipmi_kcs_v1_vmstate_needed(void *opaque)
> > > +{
> > > +    /* Never transmit this, it is just for receiving old versions.=
 */
> > > +    return false;
> > > +}
> > > +
> > > +const VMStateDescription vmstate_v1_ISAIPMIKCSDevice =3D {
> > >       .name =3D TYPE_IPMI_INTERFACE,
> > >       .version_id =3D 1,
> > >       .minimum_version_id =3D 1,
> > > +    .post_load =3D ipmi_kcs_v1_vmstate_post_load,
> > > +    .needed =3D ipmi_kcs_v1_vmstate_needed,
> > >       .fields      =3D (VMStateField[]) {
> > >           VMSTATE_BOOL(kcs.obf_irq_set, ISAIPMIKCSDevice),
> > >           VMSTATE_BOOL(kcs.atn_irq_set, ISAIPMIKCSDevice),
> > > -        VMSTATE_BOOL(kcs.use_irq, ISAIPMIKCSDevice),
> > > +        VMSTATE_UNUSED(1), /* Was use_irq */
> > >           VMSTATE_BOOL(kcs.irqs_enabled, ISAIPMIKCSDevice),
> > >           VMSTATE_UINT32(kcs.outpos, ISAIPMIKCSDevice),
> > >           VMSTATE_UINT8_ARRAY(kcs.outmsg, ISAIPMIKCSDevice, MAX_IPM=
I_MSG_SIZE),
> > > @@ -451,6 +523,7 @@ static void isa_ipmi_kcs_init(Object *obj)
> > >       ipmi_bmc_find_and_link(obj, (Object **) &iik->kcs.bmc);
> > >       vmstate_register(NULL, 0, &vmstate_ISAIPMIKCSDevice, iik);
> > > +    vmstate_register(NULL, 0, &vmstate_v1_ISAIPMIKCSDevice, iik);
> > OK, a bit scary - I don't think anyone else does that trick of
> > registering it under two names with a '_needed' always saying false.
>=20
> Yes, I was wondering if I was abusing that interface.
>=20
> > So I think we have the istuation where the old version had two things
> > with the same name, and if you instantiated both device types you
> > probably lost one of them?
>=20
> Yes, something like that.=A0 Or more likely, the transfer would just fa=
il.
>=20
> > In the new world both the 'bt' one is incompatible and renamed,
> > but this one has the hack to load the old kcs version;  so I guess
> > that's OK.
> >=20
> > Could you just add a comment above that second vmstate_register
> >    ' old version had different (clashing) name, register both'
>=20
> Certainly.
>=20
> > However it's worth asking if it's really worth it, if you just ekpt t=
his
> > one called TYPE_IPMI_INTERFACE then you wouldn't need that hack, and =
the
> > only downside I can see is that loading an image that had a ipmi-bt
> > would fail badly, as opposed to failing clearly.
>=20
> I was wondering that, too.=A0 I'd be ok with that.
>=20
> But with the above bug I'm not sure it's possible to fix.=A0 There's no=
 way to
> pass the
> version being processed to the handling of vmstate_IPMIKCS.

I think I'd take a fix for that as long as it was relatively small;
I've got less stomach for a big fix for that field all over the code -
some well placed comemnts explaining what's going on to the unwary
would be welcome though.

Dave

> -corey
>=20
> >=20
> > Dave
> >=20
> > >   }
> > >   static void *isa_ipmi_kcs_get_backend_data(IPMIInterface *ii)
> > > --=20
> > > 2.7.4
> > >=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
