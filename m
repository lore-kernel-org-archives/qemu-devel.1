Received: from eggs.gnu.org ([2001:4830:134:3::10]:34742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gUl96-0007lt-Um
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 23:20:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gUl8z-0003BX-4A
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 23:20:15 -0500
Date: Thu, 6 Dec 2018 14:56:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181206035655.GN768@umbus.fritz.box>
References: <20181205232251.10446-1-clg@kaod.org>
	<20181205232251.10446-6-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dPW7zu3hTOhZvCDO"
Content-Disposition: inline
In-Reply-To: <20181205232251.10446-6-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v6 05/37] ppc/xive: introduce the XIVE
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


--dPW7zu3hTOhZvCDO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06, 2018 at 12:22:19AM +0100, C=E9dric Le Goater wrote:
> To complete the event routing, the IVRE sub-engine uses a second table
> containing Event Notification Descriptor (END) structures.
>=20
> An END specifies on which Event Queue (EQ) the event notification
> data, defined in the associated EAS, should be posted when an
> exception occurs. It also defines which Notification Virtual Target
> (NVT) should be notified.
>=20
> The Event Queue is a memory page provided by the O/S defining a
> circular buffer, one per server and priority couple, containing Event
> Queue entries. These are 4 bytes long, the first bit being a
> 'generation' bit and the 31 following bits the END Data field. They
> are pulled by the O/S when the exception occurs.
>=20
> The END Data field is a way to set an invariant logical event source
> number for an IRQ. On sPAPR machines, it is set with the
> H_INT_SET_SOURCE_CONFIG hcall when the EISN flag is used.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/ppc/xive.h      |  18 ++++
>  include/hw/ppc/xive_regs.h |  57 ++++++++++++
>  hw/intc/xive.c             | 174 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 249 insertions(+)
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 57ec9f84f527..d1b4c6c78ec5 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -321,11 +321,29 @@ typedef struct XiveRouterClass {
>      /* XIVE table accessors */
>      int (*get_eas)(XiveRouter *xrtr, uint8_t eas_blk, uint32_t eas_idx,
>                     XiveEAS *eas);
> +    int (*get_end)(XiveRouter *xrtr, uint8_t end_blk, uint32_t end_idx,
> +                   XiveEND *end);
> +    int (*write_end)(XiveRouter *xrtr, uint8_t end_blk, uint32_t end_idx,
> +                     XiveEND *end, uint8_t word_number);

I'm not sure if this is the best interface long term, but it doesn't
impact on public or migration interfaces, so I'm happy to run with it
for the time being.

>  } XiveRouterClass;
> =20
>  void xive_eas_pic_print_info(XiveEAS *eas, uint32_t lisn, Monitor *mon);
> =20
>  int xive_router_get_eas(XiveRouter *xrtr, uint8_t eas_blk, uint32_t eas_=
idx,
>                          XiveEAS *eas);
> +int xive_router_get_end(XiveRouter *xrtr, uint8_t end_blk, uint32_t end_=
idx,
> +                        XiveEND *end);
> +int xive_router_write_end(XiveRouter *xrtr, uint8_t end_blk, uint32_t en=
d_idx,
> +                          XiveEND *end, uint8_t word_number);
> +
> +/*
> + * For legacy compatibility, the exceptions define up to 256 different
> + * priorities. P9 implements only 9 levels : 8 active levels [0 - 7]
> + * and the least favored level 0xFF.
> + */
> +#define XIVE_PRIORITY_MAX  7
> +
> +void xive_end_pic_print_info(XiveEND *end, uint32_t end_idx, Monitor *mo=
n);
> +void xive_end_queue_pic_print_info(XiveEND *end, uint32_t width, Monitor=
 *mon);
> =20
>  #endif /* PPC_XIVE_H */
> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
> index 15f2470ed9cc..3c0ebad18b69 100644
> --- a/include/hw/ppc/xive_regs.h
> +++ b/include/hw/ppc/xive_regs.h
> @@ -47,4 +47,61 @@ typedef struct XiveEAS {
>  #define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
>  #define SETFIELD_BE64(m, v, val) cpu_to_be64(SETFIELD(m, be64_to_cpu(v),=
 val))
> =20
> +/* Event Notification Descriptor (END) */
> +typedef struct XiveEND {
> +        uint32_t        w0;
> +#define END_W0_VALID             PPC_BIT32(0) /* "v" bit */
> +#define END_W0_ENQUEUE           PPC_BIT32(1) /* "q" bit */
> +#define END_W0_UCOND_NOTIFY      PPC_BIT32(2) /* "n" bit */
> +#define END_W0_BACKLOG           PPC_BIT32(3) /* "b" bit */
> +#define END_W0_PRECL_ESC_CTL     PPC_BIT32(4) /* "p" bit */
> +#define END_W0_ESCALATE_CTL      PPC_BIT32(5) /* "e" bit */
> +#define END_W0_UNCOND_ESCALATE   PPC_BIT32(6) /* "u" bit - DD2.0 */
> +#define END_W0_SILENT_ESCALATE   PPC_BIT32(7) /* "s" bit - DD2.0 */
> +#define END_W0_QSIZE             PPC_BITMASK32(12, 15)
> +#define END_W0_SW0               PPC_BIT32(16)
> +#define END_W0_FIRMWARE          END_W0_SW0 /* Owned by FW */
> +#define END_QSIZE_4K             0
> +#define END_QSIZE_64K            4
> +#define END_W0_HWDEP             PPC_BITMASK32(24, 31)
> +        uint32_t        w1;
> +#define END_W1_ESn               PPC_BITMASK32(0, 1)
> +#define END_W1_ESn_P             PPC_BIT32(0)
> +#define END_W1_ESn_Q             PPC_BIT32(1)
> +#define END_W1_ESe               PPC_BITMASK32(2, 3)
> +#define END_W1_ESe_P             PPC_BIT32(2)
> +#define END_W1_ESe_Q             PPC_BIT32(3)
> +#define END_W1_GENERATION        PPC_BIT32(9)
> +#define END_W1_PAGE_OFF          PPC_BITMASK32(10, 31)
> +        uint32_t        w2;
> +#define END_W2_MIGRATION_REG     PPC_BITMASK32(0, 3)
> +#define END_W2_OP_DESC_HI        PPC_BITMASK32(4, 31)
> +        uint32_t        w3;
> +#define END_W3_OP_DESC_LO        PPC_BITMASK32(0, 31)
> +        uint32_t        w4;
> +#define END_W4_ESC_END_BLOCK     PPC_BITMASK32(4, 7)
> +#define END_W4_ESC_END_INDEX     PPC_BITMASK32(8, 31)
> +        uint32_t        w5;
> +#define END_W5_ESC_END_DATA      PPC_BITMASK32(1, 31)
> +        uint32_t        w6;
> +#define END_W6_FORMAT_BIT        PPC_BIT32(8)
> +#define END_W6_NVT_BLOCK         PPC_BITMASK32(9, 12)
> +#define END_W6_NVT_INDEX         PPC_BITMASK32(13, 31)
> +        uint32_t        w7;
> +#define END_W7_F0_IGNORE         PPC_BIT32(0)
> +#define END_W7_F0_BLK_GROUPING   PPC_BIT32(1)
> +#define END_W7_F0_PRIORITY       PPC_BITMASK32(8, 15)
> +#define END_W7_F1_WAKEZ          PPC_BIT32(0)
> +#define END_W7_F1_LOG_SERVER_ID  PPC_BITMASK32(1, 31)
> +} XiveEND;
> +
> +#define xive_end_is_valid(end)    (be32_to_cpu((end)->w0) & END_W0_VALID)
> +#define xive_end_is_enqueue(end)  (be32_to_cpu((end)->w0) & END_W0_ENQUE=
UE)
> +#define xive_end_is_notify(end)   (be32_to_cpu((end)->w0) & END_W0_UCOND=
_NOTIFY)
> +#define xive_end_is_backlog(end)  (be32_to_cpu((end)->w0) & END_W0_BACKL=
OG)
> +#define xive_end_is_escalate(end) (be32_to_cpu((end)->w0) & END_W0_ESCAL=
ATE_CTL)
> +
> +#define GETFIELD_BE32(m, v)       GETFIELD(m, be32_to_cpu(v))
> +#define SETFIELD_BE32(m, v, val)  cpu_to_be32(SETFIELD(m, be32_to_cpu(v)=
, val))
> +
>  #endif /* PPC_XIVE_REGS_H */
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index d21df6674d8c..41d8ba1540d0 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -443,6 +443,95 @@ static const TypeInfo xive_source_info =3D {
>      .class_init    =3D xive_source_class_init,
>  };
> =20
> +/*
> + * XiveEND helpers
> + */
> +
> +void xive_end_queue_pic_print_info(XiveEND *end, uint32_t width, Monitor=
 *mon)
> +{
> +    uint64_t qaddr_base =3D (uint64_t) be32_to_cpu(end->w2 & 0x0fffffff)=
 << 32
> +        | be32_to_cpu(end->w3);
> +    uint32_t qsize =3D GETFIELD_BE32(END_W0_QSIZE, end->w0);
> +    uint32_t qindex =3D GETFIELD_BE32(END_W1_PAGE_OFF, end->w1);
> +    uint32_t qentries =3D 1 << (qsize + 10);
> +    int i;
> +
> +    /*
> +     * print out the [ (qindex - (width - 1)) .. (qindex + 1)] window
> +     */
> +    monitor_printf(mon, " [ ");
> +    qindex =3D (qindex - (width - 1)) & (qentries - 1);
> +    for (i =3D 0; i < width; i++) {
> +        uint64_t qaddr =3D qaddr_base + (qindex << 2);
> +        uint32_t qdata =3D -1;
> +
> +        if (dma_memory_read(&address_space_memory, qaddr, &qdata,
> +                            sizeof(qdata))) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: failed to read EQ @0x%"
> +                          HWADDR_PRIx "\n", qaddr);
> +            return;
> +        }
> +        monitor_printf(mon, "%s%08x ", i =3D=3D width - 1 ? "^" : "",
> +                       be32_to_cpu(qdata));
> +        qindex =3D (qindex + 1) & (qentries - 1);
> +    }
> +}
> +
> +void xive_end_pic_print_info(XiveEND *end, uint32_t end_idx, Monitor *mo=
n)
> +{
> +    uint64_t qaddr_base =3D (uint64_t) be32_to_cpu(end->w2 & 0x0fffffff)=
 << 32
> +        | be32_to_cpu(end->w3);
> +    uint32_t qindex =3D GETFIELD_BE32(END_W1_PAGE_OFF, end->w1);
> +    uint32_t qgen =3D GETFIELD_BE32(END_W1_GENERATION, end->w1);
> +    uint32_t qsize =3D GETFIELD_BE32(END_W0_QSIZE, end->w0);
> +    uint32_t qentries =3D 1 << (qsize + 10);
> +
> +    uint32_t nvt =3D GETFIELD_BE32(END_W6_NVT_INDEX, end->w6);
> +    uint8_t priority =3D GETFIELD_BE32(END_W7_F0_PRIORITY, end->w7);
> +
> +    if (!xive_end_is_valid(end)) {
> +        return;
> +    }
> +
> +    monitor_printf(mon, "  %08x %c%c%c%c%c prio:%d nvt:%04x eq:@%08"PRIx=
64
> +                   "% 6d/%5d ^%d", end_idx,
> +                   xive_end_is_valid(end)    ? 'v' : '-',
> +                   xive_end_is_enqueue(end)  ? 'q' : '-',
> +                   xive_end_is_notify(end)   ? 'n' : '-',
> +                   xive_end_is_backlog(end)  ? 'b' : '-',
> +                   xive_end_is_escalate(end) ? 'e' : '-',
> +                   priority, nvt, qaddr_base, qindex, qentries, qgen);
> +
> +    xive_end_queue_pic_print_info(end, 6, mon);
> +    monitor_printf(mon, "]\n");
> +}
> +
> +static void xive_end_enqueue(XiveEND *end, uint32_t data)
> +{
> +    uint64_t qaddr_base =3D (uint64_t) be32_to_cpu(end->w2 & 0x0fffffff)=
 << 32
> +        | be32_to_cpu(end->w3);
> +    uint32_t qsize =3D GETFIELD_BE32(END_W0_QSIZE, end->w0);
> +    uint32_t qindex =3D GETFIELD_BE32(END_W1_PAGE_OFF, end->w1);
> +    uint32_t qgen =3D GETFIELD_BE32(END_W1_GENERATION, end->w1);
> +
> +    uint64_t qaddr =3D qaddr_base + (qindex << 2);
> +    uint32_t qdata =3D cpu_to_be32((qgen << 31) | (data & 0x7fffffff));
> +    uint32_t qentries =3D 1 << (qsize + 10);
> +
> +    if (dma_memory_write(&address_space_memory, qaddr, &qdata, sizeof(qd=
ata))) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: failed to write END data @=
0x%"
> +                      HWADDR_PRIx "\n", qaddr);
> +        return;
> +    }
> +
> +    qindex =3D (qindex + 1) & (qentries - 1);
> +    if (qindex =3D=3D 0) {
> +        qgen ^=3D 1;
> +        end->w1 =3D SETFIELD_BE32(END_W1_GENERATION, end->w1, qgen);
> +    }
> +    end->w1 =3D SETFIELD_BE32(END_W1_PAGE_OFF, end->w1, qindex);
> +}
> +
>  /*
>   * XIVE Router (aka. Virtualization Controller or IVRE)
>   */
> @@ -455,6 +544,83 @@ int xive_router_get_eas(XiveRouter *xrtr, uint8_t ea=
s_blk, uint32_t eas_idx,
>      return xrc->get_eas(xrtr, eas_blk, eas_idx, eas);
>  }
> =20
> +int xive_router_get_end(XiveRouter *xrtr, uint8_t end_blk, uint32_t end_=
idx,
> +                        XiveEND *end)
> +{
> +   XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
> +
> +   return xrc->get_end(xrtr, end_blk, end_idx, end);
> +}
> +
> +int xive_router_write_end(XiveRouter *xrtr, uint8_t end_blk, uint32_t en=
d_idx,
> +                          XiveEND *end, uint8_t word_number)
> +{
> +   XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
> +
> +   return xrc->write_end(xrtr, end_blk, end_idx, end, word_number);
> +}
> +
> +/*
> + * An END trigger can come from an event trigger (IPI or HW) or from
> + * another chip. We don't model the PowerBus but the END trigger
> + * message has the same parameters than in the function below.
> + */
> +static void xive_router_end_notify(XiveRouter *xrtr, uint8_t end_blk,
> +                                   uint32_t end_idx, uint32_t end_data)
> +{
> +    XiveEND end;
> +    uint8_t priority;
> +    uint8_t format;
> +
> +    /* END cache lookup */
> +    if (xive_router_get_end(xrtr, end_blk, end_idx, &end)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No END %x/%x\n", end_blk,
> +                      end_idx);
> +        return;
> +    }
> +
> +    if (!xive_end_is_valid(&end)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: END %x/%x is invalid\n",
> +                      end_blk, end_idx);
> +        return;
> +    }
> +
> +    if (xive_end_is_enqueue(&end)) {
> +        xive_end_enqueue(&end, end_data);
> +        /* Enqueuing event data modifies the EQ toggle and index */
> +        xive_router_write_end(xrtr, end_blk, end_idx, &end, 1);
> +    }
> +
> +    /*
> +     * The W7 format depends on the F bit in W6. It defines the type
> +     * of the notification :
> +     *
> +     *   F=3D0 : single or multiple NVT notification
> +     *   F=3D1 : User level Event-Based Branch (EBB) notification, no
> +     *         priority
> +     */
> +    format =3D GETFIELD_BE32(END_W6_FORMAT_BIT, end.w6);
> +    priority =3D GETFIELD_BE32(END_W7_F0_PRIORITY, end.w7);
> +
> +    /* The END is masked */
> +    if (format =3D=3D 0 && priority =3D=3D 0xff) {
> +        return;
> +    }
> +
> +    /*
> +     * Check the END ESn (Event State Buffer for notification) for
> +     * even futher coalescing in the Router
> +     */
> +    if (!xive_end_is_notify(&end)) {
> +        qemu_log_mask(LOG_UNIMP, "XIVE: !UCOND_NOTIFY not implemented\n"=
);
> +        return;
> +    }
> +
> +    /*
> +     * Follows IVPE notification
> +     */
> +}
> +
>  static void xive_router_notify(XiveNotifier *xn, uint32_t lisn)
>  {
>      XiveRouter *xrtr =3D XIVE_ROUTER(xn);
> @@ -482,6 +648,14 @@ static void xive_router_notify(XiveNotifier *xn, uin=
t32_t lisn)
>          /* Notification completed */
>          return;
>      }
> +
> +    /*
> +     * The event trigger becomes an END trigger
> +     */
> +    xive_router_end_notify(xrtr,
> +                           GETFIELD_BE64(EAS_END_BLOCK, eas.w),
> +                           GETFIELD_BE64(EAS_END_INDEX, eas.w),
> +                           GETFIELD_BE64(EAS_END_DATA,  eas.w));
>  }
> =20
>  static void xive_router_class_init(ObjectClass *klass, void *data)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dPW7zu3hTOhZvCDO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwIngQACgkQbDjKyiDZ
s5JwKRAAw8+/QIj+TjPfVeSGVqdcfuZqmiGUrN4hywJ2YVzStkIxAU30NGRpu2xl
ml8KTR/uS2D1IopEqXpxc6ZHTW8tPAFybpCKEmpwONkeFtGDoqbWShGb6mx44Q3C
frwr9eMC60qqKkwp6SRrtvGrnhkPQWqRu2lxhBihLZ5q9rRuDAIILrfHqDwpRvXG
d93ZmK0kcDQTL7bhBPPJikyjJOmGwJY8eqGc/jzK7m3KTpa87eQZ5EyxfD7s2NKP
qBSiVHXRgLoZEP8fjCwRvVgs1CGAVr5DJnxQgLOqbE/uNN5F9WouMGhIJ7pd8O05
D/YdivuHnpvQjnuV/DA7mQylwPaB/QdvlflL/ObUDbH/ivxl8UzqHSIY8PfyYb9w
D2GMsjw9To3IvzuCVAqkoGUDsQRH7G80+ZXridyThApZVEq37KKRCGqsG1+9k2e3
aef+4IXCkLAAH37AtJi7L4zqNCQSSSJuuasEzhW1J7647oqo1J6FKmSdpeOv43EU
g4E5UhpNGMrLvbtyTvvD45gTxUYUsTFS4kq3SMXNifbGLM05Jw6a68PBDhQOkyzd
YLBmoKADkeOuHy9fuXCd5B2xBmn+fAJUPhz8XEStf9dBBZ3JdTBJnpMYuNL7w79H
u/hpUI4IeVE5nR0ISn+lY9wzSEQ1eE8P72ETuRPxJVhMRJZa0jE=
=9S5B
-----END PGP SIGNATURE-----

--dPW7zu3hTOhZvCDO--
