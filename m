Received: from eggs.gnu.org ([2001:4830:134:3::10]:52571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gQ4re-0003G9-0g
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 01:22:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gQ4ra-0002oz-4H
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 01:22:53 -0500
Date: Fri, 23 Nov 2018 15:35:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181123043508.GY10448@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-6-clg@kaod.org>
	<20181122044127.GE10448@umbus.fritz.box>
	<3095c0b4-ebcd-907b-360d-d5e7cdfd3b7d@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6AmSH+YAqnsWd9jO"
Content-Disposition: inline
In-Reply-To: <3095c0b4-ebcd-907b-360d-d5e7cdfd3b7d@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 05/36] ppc/xive: introduce the XIVE
 Event Notification Descriptors
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


--6AmSH+YAqnsWd9jO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 22, 2018 at 10:47:44PM +0100, C=E9dric Le Goater wrote:
> On 11/22/18 5:41 AM, David Gibson wrote:
> > On Fri, Nov 16, 2018 at 11:56:58AM +0100, C=E9dric Le Goater wrote:
> >> To complete the event routing, the IVRE sub-engine uses an internal
> >> table containing Event Notification Descriptor (END) structures.
> >>
> >> An END specifies on which Event Queue (EQ) the event notification
> >> data, defined in the associated EAS, should be posted when an
> >> exception occurs. It also defines which Notification Virtual Target
> >> (NVT) should be notified.
> >>
> >> The Event Queue is a memory page provided by the O/S defining a
> >> circular buffer, one per server and priority couple, containing Event
> >> Queue entries. These are 4 bytes long, the first bit being a
> >> 'generation' bit and the 31 following bits the END Data field. They
> >> are pulled by the O/S when the exception occurs.
> >>
> >> The END Data field is a way to set an invariant logical event source
> >> number for an IRQ. It is set with the H_INT_SET_SOURCE_CONFIG hcall
> >> when the EISN flag is used.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  include/hw/ppc/xive.h      |  18 ++++
> >>  include/hw/ppc/xive_regs.h |  48 ++++++++++
> >>  hw/intc/xive.c             | 185 ++++++++++++++++++++++++++++++++++++-
> >>  3 files changed, 248 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> >> index 5a0696366577..ce62aaf28343 100644
> >> --- a/include/hw/ppc/xive.h
> >> +++ b/include/hw/ppc/xive.h
> >> @@ -193,11 +193,29 @@ typedef struct XiveRouterClass {
> >>      /* XIVE table accessors */
> >>      int (*get_eas)(XiveRouter *xrtr, uint32_t lisn, XiveEAS *eas);
> >>      int (*set_eas)(XiveRouter *xrtr, uint32_t lisn, XiveEAS *eas);
> >> +    int (*get_end)(XiveRouter *xrtr, uint8_t end_blk, uint32_t end_id=
x,
> >> +                   XiveEND *end);
> >> +    int (*set_end)(XiveRouter *xrtr, uint8_t end_blk, uint32_t end_id=
x,
> >> +                   XiveEND *end);
> >=20
> > Hrm.  So unlike the EAS, which is basically just a word, the END is a
> > pretty large structure. =20
>=20
> yes. and so will be the NVT.
>=20
> > It's unclear here if get/set are expected to copy the whole thing out=
=20
> > and in,=20
>=20
> That's the plan.=20

Yeah, I don't think that's a good idea.  In some cases the updates are
on hot paths, so the extra copy isn't good, and more importantly it
makes it look like an atomic update, but it's not really.

Well... I guess it probably is because of the BQL, but I'd prefer not
to rely on that excessively.

> What I had in mind are memory accessors to the XIVE structures, which=20
> are local to QEMU for sPAPR and in the guest RAM for PowerNV (Please
> take a look at the XIVE PowerNV model).
>=20
> > or if get give you a pointer into a "live" structure=20
>=20
> no
>=20
> > and set just does any necessary barriers after an update.
> that would be too complex for the PowerNV model I think. There is a cache
> in between the software running on the (QEMU) machine and the XIVE HW but
> it would be hard to handle.=20
> =20
> > Really, for a non-atomic value like this, I'm not sure get/set is the
> > right model.
>=20
> ok. we need something to get them out and in.

I've thought about this a bit more.  What I think might work is
"end_read" and "end_write" callbacks, which take a word number in
addition to the parameters you have already

> > Also as I understand it nearly all the indices in XIVE are broken into
> > block/index.  Is there a reason those are folded together into lisn
> > for the EAS, but not for the END?
>=20
> The indexing of the EAT is global to the sytem and the index defines
> which blk to use. The IRQ source numbers on the powerbus are architected=
=20
> to be :
>=20
>     #define XIVE_SRCNO(blk, idx)      ((uint32_t)(blk) << 28 | (idx))
>=20
> and XIVE can use different strategies to identify the XIVE IC in charge=
=20
> of routing. It can be a one-to-one chip to block relation as skiboot does=
=2E=20
> Using a block scope table is possible also. Our model only supports one=
=20
> block per chip and some shortcuts are taken but not that much in fact.
> =20
> Remote access to the XIVE structures of another chip are done through=20
> MMIO (not modeled in PowerNV) and the blkid is used to partition the MMIO=
=20
> regions. Being local is better for performance because the END and NVT=20
> tables have a strong relation with the XIVE subengines using them=20
> (VC and PC).=20
>=20
> May be, Ben can clarified it this is badly explained.

Right.. I think I understand what the blocks are all about.

But my question is, why encode the block and index together for the
EAS, but separately for the END?

>=20
> >>  } XiveRouterClass;
> >> =20
> >>  void xive_eas_pic_print_info(XiveEAS *eas, uint32_t lisn, Monitor *mo=
n);
> >> =20
> >>  int xive_router_get_eas(XiveRouter *xrtr, uint32_t lisn, XiveEAS *eas=
);
> >>  int xive_router_set_eas(XiveRouter *xrtr, uint32_t lisn, XiveEAS *eas=
);
> >> +int xive_router_get_end(XiveRouter *xrtr, uint8_t end_blk, uint32_t e=
nd_idx,
> >> +                        XiveEND *end);
> >> +int xive_router_set_end(XiveRouter *xrtr, uint8_t end_blk, uint32_t e=
nd_idx,
> >> +                        XiveEND *end);
> >> +
> >> +/*
> >> + * For legacy compatibility, the exceptions define up to 256 different
> >> + * priorities. P9 implements only 9 levels : 8 active levels [0 - 7]
> >> + * and the least favored level 0xFF.
> >> + */
> >> +#define XIVE_PRIORITY_MAX  7
> >> +
> >> +void xive_end_reset(XiveEND *end);
> >> +void xive_end_pic_print_info(XiveEND *end, uint32_t end_idx, Monitor =
*mon);
> >> =20
> >>  #endif /* PPC_XIVE_H */
> >> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
> >> index 12499b33614c..f97fb2b90bee 100644
> >> --- a/include/hw/ppc/xive_regs.h
> >> +++ b/include/hw/ppc/xive_regs.h
> >> @@ -28,4 +28,52 @@ typedef struct XiveEAS {
> >>  #define EAS_END_DATA    PPC_BITMASK(33, 63)      /* Data written to t=
he END */
> >>  } XiveEAS;
> >> =20
> >> +/* Event Notification Descriptor (END) */
> >> +typedef struct XiveEND {
> >> +        uint32_t        w0;
> >> +#define END_W0_VALID             PPC_BIT32(0) /* "v" bit */
> >> +#define END_W0_ENQUEUE           PPC_BIT32(1) /* "q" bit */
> >> +#define END_W0_UCOND_NOTIFY      PPC_BIT32(2) /* "n" bit */
> >> +#define END_W0_BACKLOG           PPC_BIT32(3) /* "b" bit */
> >> +#define END_W0_PRECL_ESC_CTL     PPC_BIT32(4) /* "p" bit */
> >> +#define END_W0_ESCALATE_CTL      PPC_BIT32(5) /* "e" bit */
> >> +#define END_W0_UNCOND_ESCALATE   PPC_BIT32(6) /* "u" bit - DD2.0 */
> >> +#define END_W0_SILENT_ESCALATE   PPC_BIT32(7) /* "s" bit - DD2.0 */
> >> +#define END_W0_QSIZE             PPC_BITMASK32(12, 15)
> >> +#define END_W0_SW0               PPC_BIT32(16)
> >> +#define END_W0_FIRMWARE          END_W0_SW0 /* Owned by FW */
> >> +#define END_QSIZE_4K             0
> >> +#define END_QSIZE_64K            4
> >> +#define END_W0_HWDEP             PPC_BITMASK32(24, 31)
> >> +        uint32_t        w1;
> >> +#define END_W1_ESn               PPC_BITMASK32(0, 1)
> >> +#define END_W1_ESn_P             PPC_BIT32(0)
> >> +#define END_W1_ESn_Q             PPC_BIT32(1)
> >> +#define END_W1_ESe               PPC_BITMASK32(2, 3)
> >> +#define END_W1_ESe_P             PPC_BIT32(2)
> >> +#define END_W1_ESe_Q             PPC_BIT32(3)
> >> +#define END_W1_GENERATION        PPC_BIT32(9)
> >> +#define END_W1_PAGE_OFF          PPC_BITMASK32(10, 31)
> >> +        uint32_t        w2;
> >> +#define END_W2_MIGRATION_REG     PPC_BITMASK32(0, 3)
> >> +#define END_W2_OP_DESC_HI        PPC_BITMASK32(4, 31)
> >> +        uint32_t        w3;
> >> +#define END_W3_OP_DESC_LO        PPC_BITMASK32(0, 31)
> >> +        uint32_t        w4;
> >> +#define END_W4_ESC_END_BLOCK     PPC_BITMASK32(4, 7)
> >> +#define END_W4_ESC_END_INDEX     PPC_BITMASK32(8, 31)
> >> +        uint32_t        w5;
> >> +#define END_W5_ESC_END_DATA      PPC_BITMASK32(1, 31)
> >> +        uint32_t        w6;
> >> +#define END_W6_FORMAT_BIT        PPC_BIT32(8)
> >> +#define END_W6_NVT_BLOCK         PPC_BITMASK32(9, 12)
> >> +#define END_W6_NVT_INDEX         PPC_BITMASK32(13, 31)
> >> +        uint32_t        w7;
> >> +#define END_W7_F0_IGNORE         PPC_BIT32(0)
> >> +#define END_W7_F0_BLK_GROUPING   PPC_BIT32(1)
> >> +#define END_W7_F0_PRIORITY       PPC_BITMASK32(8, 15)
> >> +#define END_W7_F1_WAKEZ          PPC_BIT32(0)
> >> +#define END_W7_F1_LOG_SERVER_ID  PPC_BITMASK32(1, 31)
> >> +} XiveEND;
> >> +
> >>  #endif /* PPC_XIVE_REGS_H */
> >> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> >> index c4c90a25758e..9cb001e7b540 100644
> >> --- a/hw/intc/xive.c
> >> +++ b/hw/intc/xive.c
> >> @@ -442,6 +442,101 @@ static const TypeInfo xive_source_info =3D {
> >>      .class_init    =3D xive_source_class_init,
> >>  };
> >> =20
> >> +/*
> >> + * XiveEND helpers
> >> + */
> >> +
> >> +void xive_end_reset(XiveEND *end)
> >> +{
> >> +    memset(end, 0, sizeof(*end));
> >> +
> >> +    /* switch off the escalation and notification ESBs */
> >> +    end->w1 =3D END_W1_ESe_Q | END_W1_ESn_Q;
> >=20
> > It's not obvious to me what circumstances this would be called under.
> > Since the ENDs are in system memory, a memset() seems like an odd
> > thing for (virtual) hardware to be doing to it.
>=20
> It makes sense on sPAPR if one day some OS starts using the END ESBs for=
=20
> further coalescing of the events. None does for now but I have added the=
=20
> model though.

Hrm, I think that belongs in PAPR specific code.  It's not really part
of the router model - it's the PAPR stuff configuring the router at
reset time (much as firmware would configure it at reset time for bare
metal).

>=20
> >> +}
> >> +
> >> +static void xive_end_queue_pic_print_info(XiveEND *end, uint32_t widt=
h,
> >> +                                          Monitor *mon)
> >> +{
> >> +    uint64_t qaddr_base =3D (((uint64_t)(end->w2 & 0x0fffffff)) << 32=
) | end->w3;
> >> +    uint32_t qsize =3D GETFIELD(END_W0_QSIZE, end->w0);
> >> +    uint32_t qindex =3D GETFIELD(END_W1_PAGE_OFF, end->w1);
> >> +    uint32_t qentries =3D 1 << (qsize + 10);
> >> +    int i;
> >> +
> >> +    /*
> >> +     * print out the [ (qindex - (width - 1)) .. (qindex + 1)] window
> >> +     */
> >> +    monitor_printf(mon, " [ ");
> >> +    qindex =3D (qindex - (width - 1)) & (qentries - 1);
> >> +    for (i =3D 0; i < width; i++) {
> >> +        uint64_t qaddr =3D qaddr_base + (qindex << 2);
> >> +        uint32_t qdata =3D -1;
> >> +
> >> +        if (dma_memory_read(&address_space_memory, qaddr, &qdata,
> >> +                            sizeof(qdata))) {
> >> +            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: failed to read EQ @=
0x%"
> >> +                          HWADDR_PRIx "\n", qaddr);
> >> +            return;
> >> +        }
> >> +        monitor_printf(mon, "%s%08x ", i =3D=3D width - 1 ? "^" : "",
> >> +                       be32_to_cpu(qdata));
> >> +        qindex =3D (qindex + 1) & (qentries - 1);
> >> +    }
> >> +    monitor_printf(mon, "]\n");
> >> +}
> >> +
> >> +void xive_end_pic_print_info(XiveEND *end, uint32_t end_idx, Monitor =
*mon)
> >> +{
> >> +    uint64_t qaddr_base =3D (((uint64_t)(end->w2 & 0x0fffffff)) << 32=
) | end->w3;
> >> +    uint32_t qindex =3D GETFIELD(END_W1_PAGE_OFF, end->w1);
> >> +    uint32_t qgen =3D GETFIELD(END_W1_GENERATION, end->w1);
> >> +    uint32_t qsize =3D GETFIELD(END_W0_QSIZE, end->w0);
> >> +    uint32_t qentries =3D 1 << (qsize + 10);
> >> +
> >> +    uint32_t nvt =3D GETFIELD(END_W6_NVT_INDEX, end->w6);
> >> +    uint8_t priority =3D GETFIELD(END_W7_F0_PRIORITY, end->w7);
> >> +
> >> +    if (!(end->w0 & END_W0_VALID)) {
> >> +        return;
> >> +    }
> >> +
> >> +    monitor_printf(mon, "  %08x %c%c%c%c%c prio:%d nvt:%04x eq:@%08"P=
RIx64
> >> +                   "% 6d/%5d ^%d", end_idx,
> >> +                   end->w0 & END_W0_VALID ? 'v' : '-',
> >> +                   end->w0 & END_W0_ENQUEUE ? 'q' : '-',
> >> +                   end->w0 & END_W0_UCOND_NOTIFY ? 'n' : '-',
> >> +                   end->w0 & END_W0_BACKLOG ? 'b' : '-',
> >> +                   end->w0 & END_W0_ESCALATE_CTL ? 'e' : '-',
> >> +                   priority, nvt, qaddr_base, qindex, qentries, qgen);
> >> +
> >> +    xive_end_queue_pic_print_info(end, 6, mon);
> >> +}
> >> +
> >> +static void xive_end_push(XiveEND *end, uint32_t data)
> >=20
> > s/push/enqueue/ please, "push" suggests a stack.  (Not to mention that
> > "push" and "pull" are used as terms elsewhere in XIVE).
>=20
> yes. you are right. I will change.
>=20
> >> +{
> >> +    uint64_t qaddr_base =3D (((uint64_t)(end->w2 & 0x0fffffff)) << 32=
) | end->w3;
> >> +    uint32_t qsize =3D GETFIELD(END_W0_QSIZE, end->w0);
> >> +    uint32_t qindex =3D GETFIELD(END_W1_PAGE_OFF, end->w1);
> >> +    uint32_t qgen =3D GETFIELD(END_W1_GENERATION, end->w1);
> >> +
> >> +    uint64_t qaddr =3D qaddr_base + (qindex << 2);
> >> +    uint32_t qdata =3D cpu_to_be32((qgen << 31) | (data & 0x7fffffff)=
);
> >> +    uint32_t qentries =3D 1 << (qsize + 10);
> >> +
> >> +    if (dma_memory_write(&address_space_memory, qaddr, &qdata, sizeof=
(qdata))) {
> >> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: failed to write END dat=
a @0x%"
> >> +                      HWADDR_PRIx "\n", qaddr);
> >> +        return;
> >> +    }
> >> +
> >> +    qindex =3D (qindex + 1) & (qentries - 1);
> >> +    if (qindex =3D=3D 0) {
> >> +        qgen ^=3D 1;
> >> +        end->w1 =3D SETFIELD(END_W1_GENERATION, end->w1, qgen);
> >> +    }
> >> +    end->w1 =3D SETFIELD(END_W1_PAGE_OFF, end->w1, qindex);
> >> +}
> >> +
> >>  /*
> >>   * XIVE Router (aka. Virtualization Controller or IVRE)
> >>   */
> >> @@ -460,6 +555,82 @@ int xive_router_set_eas(XiveRouter *xrtr, uint32_=
t lisn, XiveEAS *eas)
> >>      return xrc->set_eas(xrtr, lisn, eas);
> >>  }
> >> =20
> >> +int xive_router_get_end(XiveRouter *xrtr, uint8_t end_blk, uint32_t e=
nd_idx,
> >> +                        XiveEND *end)
> >> +{
> >> +   XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
> >> +
> >> +   return xrc->get_end(xrtr, end_blk, end_idx, end);
> >> +}
> >> +
> >> +int xive_router_set_end(XiveRouter *xrtr, uint8_t end_blk, uint32_t e=
nd_idx,
> >> +                        XiveEND *end)
> >> +{
> >> +   XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
> >> +
> >> +   return xrc->set_end(xrtr, end_blk, end_idx, end);
> >> +}
> >> +
> >> +/*
> >> + * An END trigger can come from an event trigger (IPI or HW) or from
> >> + * another chip. We don't model the PowerBus but the END trigger
> >> + * message has the same parameters than in the function below.
> >> + */
> >> +static void xive_router_end_notify(XiveRouter *xrtr, uint8_t end_blk,
> >> +                                   uint32_t end_idx, uint32_t end_dat=
a)
> >> +{
> >> +    XiveEND end;
> >> +    uint8_t priority;
> >> +    uint8_t format;
> >> +
> >> +    /* END cache lookup */
> >> +    if (xive_router_get_end(xrtr, end_blk, end_idx, &end)) {
> >> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No END %x/%x\n", end_bl=
k,
> >> +                      end_idx);
> >> +        return;
> >> +    }
> >> +
> >> +    if (!(end.w0 & END_W0_VALID)) {
> >> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: END %x/%x is invalid\n",
> >> +                      end_blk, end_idx);
> >> +        return;
> >> +    }
> >> +
> >> +    if (end.w0 & END_W0_ENQUEUE) {
> >> +        xive_end_push(&end, end_data);
> >> +        xive_router_set_end(xrtr, end_blk, end_idx, &end);
> >> +    }
> >> +
> >> +    /*
> >> +     * The W7 format depends on the F bit in W6. It defines the type
> >> +     * of the notification :
> >> +     *
> >> +     *   F=3D0 : single or multiple NVT notification
> >> +     *   F=3D1 : User level Event-Based Branch (EBB) notification, no
> >> +     *         priority
> >> +     */
> >> +    format =3D GETFIELD(END_W6_FORMAT_BIT, end.w6);
> >> +    priority =3D GETFIELD(END_W7_F0_PRIORITY, end.w7);
> >> +
> >> +    /* The END is masked */
> >> +    if (format =3D=3D 0 && priority =3D=3D 0xff) {
> >> +        return;
> >> +    }
> >> +
> >> +    /*
> >> +     * Check the END ESn (Event State Buffer for notification) for
> >> +     * even futher coalescing in the Router
> >> +     */
> >> +    if (!(end.w0 & END_W0_UCOND_NOTIFY)) {
> >> +        qemu_log_mask(LOG_UNIMP, "XIVE: !UCOND_NOTIFY not implemented=
\n");
> >> +        return;
> >> +    }
> >> +
> >> +    /*
> >> +     * Follows IVPE notification
> >> +     */
> >> +}
> >> +
> >>  static void xive_router_notify(XiveFabric *xf, uint32_t lisn)
> >>  {
> >>      XiveRouter *xrtr =3D XIVE_ROUTER(xf);
> >> @@ -471,9 +642,9 @@ static void xive_router_notify(XiveFabric *xf, uin=
t32_t lisn)
> >>          return;
> >>      }
> >> =20
> >> -    /* The IVRE has a State Bit Cache for its internal sources which
> >> -     * is also involed at this point. We skip the SBC lookup because
> >> -     * the state bits of the sources are modeled internally in QEMU.
> >> +    /* The IVRE checks the State Bit Cache at this point. We skip the
> >> +     * SBC lookup because the state bits of the sources are modeled
> >> +     * internally in QEMU.
> >=20
> > Replacing a comment about something we're not doing with a different
> > comment about something we're not doing doesn't seem very useful.
> > Maybe fold these together into one patch or the other.
>=20
> That's me rephrasing. it should be indeed in the previous patch
>=20
> Thanks,
>=20
> C.
>=20
> >>       */
> >> =20
> >>      if (!(eas.w & EAS_VALID)) {
> >> @@ -485,6 +656,14 @@ static void xive_router_notify(XiveFabric *xf, ui=
nt32_t lisn)
> >>          /* Notification completed */
> >>          return;
> >>      }
> >> +
> >> +    /*
> >> +     * The event trigger becomes an END trigger
> >> +     */
> >> +    xive_router_end_notify(xrtr,
> >> +                           GETFIELD(EAS_END_BLOCK, eas.w),
> >> +                           GETFIELD(EAS_END_INDEX, eas.w),
> >> +                           GETFIELD(EAS_END_DATA,  eas.w));
> >>  }
> >> =20
> >>  static Property xive_router_properties[] =3D {
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6AmSH+YAqnsWd9jO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv3g3oACgkQbDjKyiDZ
s5KcgBAA5jLg3fkfHYtmA/pIZAxHGGc1/BVtpj8oMaazIiTRL7LsLbqc/h5DC6ng
f2xtb0WNb8hq1XSGs4dSpQCclqsBP+VRutFgiPvjkk4+2T1zsnB1t9YUxz2fD0ky
gDb2awj69NocdZEkgxPybeBNvyWRRc2tuLlXY2stmw8HfjXntYH3w6jqcvO042ZM
rYCOZ2ozrAunTCRo2ISzLzGE7vDaf3x3DfeoaSuwBFDOvpRl+BeR5Z2+n5j0pVFq
UUF1a3AwWtTzWktCYT52iz4aodvv7rkJ+76mPjKPX44yFWYGiFvi2BjvxazY6sJI
afmrf5CRUfBoKFxD6hrOcelGb+dEDlqqQkC6X4ojjsXX6O4xO718seViXjGtlagV
V0XeooWX5O26Ro/K1Sx8eQGrAXkTgYrR5e8mChybi+XQ+D/JGTxRBHLbpzfckWkG
HUwrHEBpHRzjOntGqJSAAitwB0eRWldNiJFSosDNr6VKMRXfMI2eOjAVhoxvtTSd
Rb1fPg8cCCAnrGocAwAtMtwyyw/uMQ34XcQXWcCBUGSmDy1iN2hzbR4/Z9c1iUXT
wGzOGQfhoLJuYweebQOdXJ2QVypTFiR8kePY1IaU6eNM21rkYhcLRNAnicQ29K9G
qu9CPY1+6Xp0dcT0joANfZYLDbUm3v0naV2wZ+MCyaWcVpsJQTk=
=da+k
-----END PGP SIGNATURE-----

--6AmSH+YAqnsWd9jO--
