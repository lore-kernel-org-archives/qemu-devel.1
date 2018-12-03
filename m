Received: from eggs.gnu.org ([2001:4830:134:3::10]:45704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gTdww-0004AC-3C
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 21:27:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gTdwt-0007p7-VD
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 21:27:06 -0500
Date: Mon, 3 Dec 2018 12:36:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181203013640.GR30479@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-17-clg@kaod.org>
	<20181128042547.GZ2251@umbus.fritz.box>
	<a57f6b4b-414e-efe7-475d-e6cbb87f61a8@kaod.org>
	<20181129012355.GP2251@umbus.fritz.box>
	<898d49bd-e430-fd07-e1ee-10d5822e3757@kaod.org>
	<20181130012315.GH30479@umbus.fritz.box>
	<35df014a-1876-1fa2-291c-880d15222a58@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="phbq2bkSb+hZnunM"
Content-Disposition: inline
In-Reply-To: <35df014a-1876-1fa2-291c-880d15222a58@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 16/36] spapr: add hcalls support for the
 XIVE exploitation interrupt mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--phbq2bkSb+hZnunM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 30, 2018 at 09:07:19AM +0100, C=E9dric Le Goater wrote:
> On 11/30/18 2:23 AM, David Gibson wrote:
> > On Thu, Nov 29, 2018 at 05:04:50PM +0100, C=E9dric Le Goater wrote:
> >> On 11/29/18 2:23 AM, David Gibson wrote:
> >>> On Wed, Nov 28, 2018 at 11:21:37PM +0100, C=E9dric Le Goater wrote:
> >>>> On 11/28/18 5:25 AM, David Gibson wrote:
> >>>>> On Fri, Nov 16, 2018 at 11:57:09AM +0100, C=E9dric Le Goater wrote:
> >>>>>> The different XIVE virtualization structures (sources and event qu=
eues)
> >>>>>> are configured with a set of Hypervisor calls :
> >>>>>>
> >>>>>>  - H_INT_GET_SOURCE_INFO
> >>>>>>
> >>>>>>    used to obtain the address of the MMIO page of the Event State
> >>>>>>    Buffer (ESB) entry associated with the source.
> >>>>>>
> >>>>>>  - H_INT_SET_SOURCE_CONFIG
> >>>>>>
> >>>>>>    assigns a source to a "target".
> >>>>>>
> >>>>>>  - H_INT_GET_SOURCE_CONFIG
> >>>>>>
> >>>>>>    determines which "target" and "priority" is assigned to a source
> >>>>>>
> >>>>>>  - H_INT_GET_QUEUE_INFO
> >>>>>>
> >>>>>>    returns the address of the notification management page associa=
ted
> >>>>>>    with the specified "target" and "priority".
> >>>>>>
> >>>>>>  - H_INT_SET_QUEUE_CONFIG
> >>>>>>
> >>>>>>    sets or resets the event queue for a given "target" and "priori=
ty".
> >>>>>>    It is also used to set the notification configuration associated
> >>>>>>    with the queue, only unconditional notification is supported for
> >>>>>>    the moment. Reset is performed with a queue size of 0 and queue=
ing
> >>>>>>    is disabled in that case.
> >>>>>>
> >>>>>>  - H_INT_GET_QUEUE_CONFIG
> >>>>>>
> >>>>>>    returns the queue settings for a given "target" and "priority".
> >>>>>>
> >>>>>>  - H_INT_RESET
> >>>>>>
> >>>>>>    resets all of the guest's internal interrupt structures to their
> >>>>>>    initial state, losing all configuration set via the hcalls
> >>>>>>    H_INT_SET_SOURCE_CONFIG and H_INT_SET_QUEUE_CONFIG.
> >>>>>>
> >>>>>>  - H_INT_SYNC
> >>>>>>
> >>>>>>    issue a synchronisation on a source to make sure all notificati=
ons
> >>>>>>    have reached their queue.
> >>>>>>
> >>>>>> Calls that still need to be addressed :
> >>>>>>
> >>>>>>    H_INT_SET_OS_REPORTING_LINE
> >>>>>>    H_INT_GET_OS_REPORTING_LINE
> >>>>>>
> >>>>>> See the code for more documentation on each hcall.
> >>>>>>
> >>>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>>>>> ---
> >>>>>>  include/hw/ppc/spapr.h      |  15 +-
> >>>>>>  include/hw/ppc/spapr_xive.h |   6 +
> >>>>>>  hw/intc/spapr_xive_hcall.c  | 892 +++++++++++++++++++++++++++++++=
+++++
> >>>>>>  hw/ppc/spapr_irq.c          |   2 +
> >>>>>>  hw/intc/Makefile.objs       |   2 +-
> >>>>>>  5 files changed, 915 insertions(+), 2 deletions(-)
> >>>>>>  create mode 100644 hw/intc/spapr_xive_hcall.c
> >>>>>>
> >>>>>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> >>>>>> index 1fbc2663e06c..8415faea7b82 100644
> >>>>>> --- a/include/hw/ppc/spapr.h
> >>>>>> +++ b/include/hw/ppc/spapr.h
> >>>>>> @@ -452,7 +452,20 @@ struct sPAPRMachineState {
> >>>>>>  #define H_INVALIDATE_PID        0x378
> >>>>>>  #define H_REGISTER_PROC_TBL     0x37C
> >>>>>>  #define H_SIGNAL_SYS_RESET      0x380
> >>>>>> -#define MAX_HCALL_OPCODE        H_SIGNAL_SYS_RESET
> >>>>>> +
> >>>>>> +#define H_INT_GET_SOURCE_INFO   0x3A8
> >>>>>> +#define H_INT_SET_SOURCE_CONFIG 0x3AC
> >>>>>> +#define H_INT_GET_SOURCE_CONFIG 0x3B0
> >>>>>> +#define H_INT_GET_QUEUE_INFO    0x3B4
> >>>>>> +#define H_INT_SET_QUEUE_CONFIG  0x3B8
> >>>>>> +#define H_INT_GET_QUEUE_CONFIG  0x3BC
> >>>>>> +#define H_INT_SET_OS_REPORTING_LINE 0x3C0
> >>>>>> +#define H_INT_GET_OS_REPORTING_LINE 0x3C4
> >>>>>> +#define H_INT_ESB               0x3C8
> >>>>>> +#define H_INT_SYNC              0x3CC
> >>>>>> +#define H_INT_RESET             0x3D0
> >>>>>> +
> >>>>>> +#define MAX_HCALL_OPCODE        H_INT_RESET
> >>>>>> =20
> >>>>>>  /* The hcalls above are standardized in PAPR and implemented by p=
Hyp
> >>>>>>   * as well.
> >>>>>> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xi=
ve.h
> >>>>>> index 3f65b8f485fd..418511f3dc10 100644
> >>>>>> --- a/include/hw/ppc/spapr_xive.h
> >>>>>> +++ b/include/hw/ppc/spapr_xive.h
> >>>>>> @@ -60,4 +60,10 @@ int spapr_xive_target_to_end(sPAPRXive *xive, u=
int32_t target, uint8_t prio,
> >>>>>>  int spapr_xive_cpu_to_end(sPAPRXive *xive, PowerPCCPU *cpu, uint8=
_t prio,
> >>>>>>                            uint8_t *out_end_blk, uint32_t *out_end=
_idx);
> >>>>>> =20
> >>>>>> +bool spapr_xive_priority_is_valid(uint8_t priority);
> >>>>>
> >>>>> AFAICT this could be a local function.
> >>>>
> >>>> the KVM model uses it also, when collecting state from the KVM devic=
e=20
> >>>> to build the QEMU ENDT.
> >>>>
> >>>>>> +
> >>>>>> +typedef struct sPAPRMachineState sPAPRMachineState;
> >>>>>> +
> >>>>>> +void spapr_xive_hcall_init(sPAPRMachineState *spapr);
> >>>>>> +
> >>>>>>  #endif /* PPC_SPAPR_XIVE_H */
> >>>>>> diff --git a/hw/intc/spapr_xive_hcall.c b/hw/intc/spapr_xive_hcall=
=2Ec
> >>>>>> new file mode 100644
> >>>>>> index 000000000000..52e4e23995f5
> >>>>>> --- /dev/null
> >>>>>> +++ b/hw/intc/spapr_xive_hcall.c
> >>>>>> @@ -0,0 +1,892 @@
> >>>>>> +/*
> >>>>>> + * QEMU PowerPC sPAPR XIVE interrupt controller model
> >>>>>> + *
> >>>>>> + * Copyright (c) 2017-2018, IBM Corporation.
> >>>>>> + *
> >>>>>> + * This code is licensed under the GPL version 2 or later. See the
> >>>>>> + * COPYING file in the top-level directory.
> >>>>>> + */
> >>>>>> +
> >>>>>> +#include "qemu/osdep.h"
> >>>>>> +#include "qemu/log.h"
> >>>>>> +#include "qapi/error.h"
> >>>>>> +#include "cpu.h"
> >>>>>> +#include "hw/ppc/fdt.h"
> >>>>>> +#include "hw/ppc/spapr.h"
> >>>>>> +#include "hw/ppc/spapr_xive.h"
> >>>>>> +#include "hw/ppc/xive_regs.h"
> >>>>>> +#include "monitor/monitor.h"
> >>>>>
> >>>>> Fwiw, I don't think it's particularly necessary to split the hcall
> >>>>> handling out into a separate .c file.
> >>>>
> >>>> ok. let's move it to spapr_xive then ? It might help in reducing the=
=20
> >>>> exported funtions.=20
> >>>
> >>> Yes, I think so.
> >>>
> >>>>>> +/*
> >>>>>> + * OPAL uses the priority 7 EQ to automatically escalate interrup=
ts
> >>>>>> + * for all other queues (DD2.X POWER9). So only priorities [0..6]=
 are
> >>>>>> + * available for the guest.
> >>>>>
> >>>>> Referencing OPAL behaviour doesn't really make sense in the context=
 of
> >>>>> PAPR. =20
> >>>>
> >>>> It's an OPAL constraint which pHyp doesn't have. So its a QEMU/KVM=
=20
> >>>> constraint also.
> >>>
> >>> Right, I realized that a few patches on.  Maybe rephrase this to
> >>>
> >>>    Linux hosts under OPAL reserve priority 7 for their own escalation
> >>>    interrupts.  So we only allow the guest to use priorities [0..6].
> >>
> >> OK.
> >>
> >>> The point here is that we're emphasizing that this is a design
> >>> decision to make the host implementation easier, rather than a
> >>> fundamental constraint.
> >>>
> >>>>> What I think you're getting at is that the PAPR spec only
> >>>>> allows a PAPR guest to use priorities 0..6 (or at least it will if =
the
> >>>>> XIVE updated spec ever gets published). =20
> >>>>
> >>>> It's not in the spec. the XIVE sPAPR spec should be frozen soon btw.=
=20
> >>>> =20
> >>>>> The fact that this allows the
> >>>>> host use 7 for escalations is a design rationale=20
> >>>>> but not really relevant to the guest device itself.=20
> >>>>
> >>>> The guest should be aware of which priorities are reserved for
> >>>> the hypervisor though.
> >>>>
> >>>>>> + */
> >>>>>> +bool spapr_xive_priority_is_valid(uint8_t priority)
> >>>>>> +{
> >>>>>> +    switch (priority) {
> >>>>>> +    case 0 ... 6:
> >>>>>> +        return true;
> >>>>>> +    case 7: /* OPAL escalation queue */
> >>>>>> +    default:
> >>>>>> +        return false;
> >>>>>> +    }
> >>>>>> +}
> >>>>>> +
> >>>>>> +/*
> >>>>>> + * The H_INT_GET_SOURCE_INFO hcall() is used to obtain the logical
> >>>>>> + * real address of the MMIO page through which the Event State Bu=
ffer
> >>>>>> + * entry associated with the value of the "lisn" parameter is man=
aged.
> >>>>>> + *
> >>>>>> + * Parameters:
> >>>>>> + * Input
> >>>>>> + * - "flags"
> >>>>>> + *       Bits 0-63 reserved
> >>>>>> + * - "lisn" is per "interrupts", "interrupt-map", or
> >>>>>> + *       "ibm,xive-lisn-ranges" properties, or as returned by the
> >>>>>> + *       ibm,query-interrupt-source-number RTAS call, or as retur=
ned
> >>>>>> + *       by the H_ALLOCATE_VAS_WINDOW hcall
> >>>>>
> >>>>> I've not heard of H_ALLOCATE_VAS_WINDOW.  Is that something we inte=
nd
> >>>>> to implement in kvm/qemu, or is it only of interest for PowerVM?
> >>>>
> >>>> The hcall is part of the PAPR NX Interfaces and it returns interrupt
> >>>> numbers. I don't know if any work has been done on the topic. =20
> >>>
> >>> What's a "PAPR NX"?
> >>
> >> A way for the PAPR guests to access the POWER coprocessors doing=20
> >> compression and encryption. I really don't know much about this.
> >=20
> > Ah, ok.
> >=20
> > [snip]
> >>>> I think not, but the specs are not very clear on that topic. I will
> >>>> ask for clarification and use a -1 for now. We can not do loads on
> >>>> the trigger page so it can not be used by the H_INT_ESB hcall.
> >>>>
> >>>>>
> >>>>>> +    args[3] =3D TARGET_PAGE_SIZE;
> >>>>>
> >>>>> That seems wrong. =20
> >>>>
> >>>> This is utterly wrong. it should be a power of 2 number ... I got
> >>>> it right under KVM though. I guess that ioremap() under Linux rounds=
=20
> >>>> up the size to the page size in use, so, that's why it didn't blow
> >>>> up under TCG.
> >>>>
> >>>>> TARGET_PAGE_SIZE is generally 4kiB, but won't these usually
> >>>>> actually be 64kiB?
> >>>>
> >>>> yes. So what should I use to get a PAGE_SHIFT instead ?=20
> >>>
> >>> Erm, that gets a bit tricky, since qemu in a sense doesn't know the
> >>> guest's page size.
> >>>
> >>> But.. don't you actually want the esb_shift here, not PAGE_SHIFT - it
> >>> could matter for the 2 page * 64kiB variant, yes?
> >>
> >> Yes. we just want the page_shift of the ESB page, whether it's one or
> >> two pages. The other registers inform the guest if there are one or=20
> >> two ESB page in use.=20
> >=20
> > Ok, still sounds like you should base it on esb_shift, just adjust for
> > the two page case.
>=20
> yes.
>=20
>=20
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    switch (qsize) {
> >>>>>> +    case 12:
> >>>>>> +    case 16:
> >>>>>> +    case 21:
> >>>>>> +    case 24:
> >>>>>> +        end.w3 =3D ((uint64_t)qpage) & 0xffffffff;
> >>>>>
> >>>>> It just occurred to me that I haven't been looking for this across =
any
> >>>>> of these reviews.  Don't you need byteswaps when accessing these
> >>>>> in-memory structures?
> >>>>
> >>>> yes this is done when some event data is enqueued in the EQ.
> >>>
> >>> I'm not talking about the data in the EQ itself, but the fields in the
> >>> END (and the NVT).
> >>
> >> XIVE is all BE.
> >=20
> > Yes... the qemu host might not be, which is why you need byteswaps.
>=20
> ok. I understand.
>=20
> > I realized eventually you have the swaps in your pnv get/set
> > accessors. =20
>=20
> Yes. because skiboot is BE, like the XIVE structures.

skiboot's endiannness isn't really relevant, because we're modelling
below that level.

> > I don't like that at all for a couple of reasons:
> >=20
> > 1) Although the END structure is made up of word-sized fields because
> > that's convenient, the END really is made of a bunch of subfields of
> > different sizes.  Knowing that it wouldn't be unreasonable for people
> > to expect they can look into the XIVE by byte offsets;=20
>=20
> These structures should be accessed with GETFIELD and SETFIELD macros
> using the XIVE definitions in the xive_regs.h header file. I would want=
=20
> to keep that common with skiboot  for sure.

Right.  It might make sense to make some helper macros or inlines that
include both the GETFIELD/SETFIELD and the byteswap.

> Are you suggesting we should define each field of the XIVE structures=20
> with C attributes ? That would be very unfortunate.

Oh no, bitfields are a complete mess.

> > that will break
> > if you're working with a copy that has already been byte-swapped on
> > word-sized units.
>=20
> I am not sure I understand the last sentence.

I mean that GETFIELD/SETFIELD only work on values that are already
native endian, but using byte offsets would only work on values that
are still in BE.

> the code working with a copy would necessarily know that the structure=20
> has been byteswapped and use correct offsets for the expected endianess.=
=20
> no ? why would it break ? =20
>=20
> > 2) At different points in the code you're storing both BE and
> > native-endian data in the same struct.=20
>=20
> on sPAPR, it's all native (which is a violation I agree).

Don't do that.  Having the same structure be BE in some situations and
native endian in other situations is a sure path to madness.

> TIMA is BE.
>=20
> > That's both confusing to
> > someone reading the code (if they see that struct they don't know if
> > it's byteswapped already) and also means you can't use sparse
> > annotations to make sure you have it right.
>=20
> XIVE structures are architected to be BE. That's immutable.

Yes, absolutely.  So don't represent them in C structs that are in
native endian.  Ever, even temporarily.

> It's a not problem for skiboot which is BE. The PnvXIVE model for the=20
> QEMU PowerNV machine reads these VSTs (Virtual Structure Tables) from=20
> the guest RAM and byteswaps the structure before using it. I think
> that's fine. Isn't it ?

Byteswapping structures - rather than individual fields as you use
them - is almost always a bad idea.  It's insanely easy to lose track
of whether this particular instance of the structure is swapped yet or
not, and you can't use sparse (or whatever) to check it for you.

Stick to one endianness for a struct, and do the byteswaps when you
access the fields (using helpers if that's, well, helpful).

> It becomes a problem with the sPAPR model which is using the XIVE structu=
res=20
> in native endianess and not BE anymore. But the guest OS never manipulate=
s=20
> these structures, so under the hood, I think we are free to use them in=
=20
> native and keep the common definitions.

Free to in the sense that it can theoretically work, yes.  But there's
no upside (byteswaps are essentially free on POWER, and of trivial
cost compared to memory access basically everywhere).  The downside is
that having the same variables / structures have data in different
endianness in different situations makes it exceedingly easy to forget
which one you're dealing with right now and therefore forget some
swaps or put in extra ones.

> Except that the event data entries in the OS EQs are BE. So the only plac=
e=20
> where we convert is when an event data is enqueued.=20
>=20
> What would you put in place if you think this is a too strong violation=
=20
> of the architecture ? I am afraid of something too complex to manipulate
> to be honest. May be we can drop the map/unmap access methods only keep=
=20
> the very basic ones.

THe complexity of having extra swaps is almost always less than having
the complexity of having those swaps not be in a consistent place.
Especially if you use helpers (including the swaps) to access your
structure.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--phbq2bkSb+hZnunM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwEiKMACgkQbDjKyiDZ
s5IXgBAAsrDzLTSakBZ9i7qOhsAJai2o6NXtZv/XO2tVK7t1KobAkNMKZ75ss/7G
pfIrWlEhjySzasmiahZHWN0Xt/murliV3H5X46qGF4yfFbKC/12atPcSzZ4Im/nn
NzYzyYIrpDyoBmLGdmfPst+nli+T9Drha8VfMuIG8HYRpAtbrHGkhlFFr0JK33wx
5PXtunW6OhZ1PBJm+pOaMqwZ3DKLoQMGVvsJt+vWbbnBUygZD+aMHLeFebtSGpHA
FIfP+rwktZyMDcI6oEe1dUvkh2lfaJEd+DJkto9c8JnW2wav+pjBLwXW22rk5bqN
/OIme1rzD3bjwrolb5WdkCPExypnyrDEwMJltYqa4scTSe35trMJSyuThtFgXd5o
o4jz9mnUnD+IX60opOJwBqvbTeoQnRy0z7IXYRrKS0eMerJyVAoLfyInHAX93haq
eNKWsbbt/sawdHCVeCljMak9Irr+r7oQ/ChH9LbLR4kfPjb3Oq+r5kGc7jP3plRT
WRrMxI1Yr8hwLyxZrYFnDMyzezOKXwvVluRpF/VTdSX/MriLxU3JGg8zswFy5Nhi
Z4cDfxzz5R+9dGgRyIR1IKWlW/CxyW/wkwtnhf+K/efp+M8l9PMww8LtasWw0MEl
M6As89yRQBBjMVsDDHCUpKIvQ0fmoFk/xmNMRIXI5OWSTbKTqXA=
=SHYg
-----END PGP SIGNATURE-----

--phbq2bkSb+hZnunM--
