Received: from eggs.gnu.org ([209.51.188.92]:41511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyTFa-00075G-3k
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 22:17:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyTFY-0006oy-8V
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 22:17:46 -0500
Date: Tue, 26 Feb 2019 10:22:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190225232216.GA6872@umbus.fritz.box>
References: <20190222131322.26079-1-clg@kaod.org>
	<20190222131322.26079-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <20190222131322.26079-3-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 02/13] spapr/xive: add hcall support
 when under KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 02:13:11PM +0100, C=E9dric Le Goater wrote:
> XIVE hcalls are all redirected to QEMU as none are on a fast path.
> When necessary, QEMU invokes KVM through specific ioctls to perform
> host operations. QEMU should have done the necessary checks before
> calling KVM and, in case of failure, H_HARDWARE is simply returned.
>=20
> H_INT_ESB is a special case that could have been handled under KVM
> but the impact on performance was low when under QEMU. Here are some
> figures :
>=20
>     kernel irqchip      OFF          ON
>     H_INT_ESB                    KVM   QEMU
>=20
>     rtl8139 (LSI )      1.19     1.24  1.23  Gbits/sec
>     virtio             31.80    42.30   --   Gbits/sec
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/spapr_xive.h |  15 +++
>  hw/intc/spapr_xive.c        |  87 +++++++++++++++--
>  hw/intc/spapr_xive_kvm.c    | 184 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 278 insertions(+), 8 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index ab6732b14a02..749c6cbc2c56 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -55,9 +55,24 @@ void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);
>  void spapr_xive_mmio_set_enabled(sPAPRXive *xive, bool enable);
>  void spapr_xive_map_mmio(sPAPRXive *xive);
> =20
> +int spapr_xive_end_to_target(uint8_t end_blk, uint32_t end_idx,
> +                             uint32_t *out_server, uint8_t *out_prio);
> +
>  /*
>   * KVM XIVE device helpers
>   */
>  void kvmppc_xive_connect(sPAPRXive *xive, Error **errp);
> +void kvmppc_xive_reset(sPAPRXive *xive, Error **errp);
> +void kvmppc_xive_set_source_config(sPAPRXive *xive, uint32_t lisn, XiveE=
AS *eas,
> +                                   Error **errp);
> +void kvmppc_xive_sync_source(sPAPRXive *xive, uint32_t lisn, Error **err=
p);
> +uint64_t kvmppc_xive_esb_rw(XiveSource *xsrc, int srcno, uint32_t offset,
> +                            uint64_t data, bool write);
> +void kvmppc_xive_set_queue_config(sPAPRXive *xive, uint8_t end_blk,
> +                                 uint32_t end_idx, XiveEND *end,
> +                                 Error **errp);
> +void kvmppc_xive_get_queue_config(sPAPRXive *xive, uint8_t end_blk,
> +                                 uint32_t end_idx, XiveEND *end,
> +                                 Error **errp);
> =20
>  #endif /* PPC_SPAPR_XIVE_H */
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index c24d649e3668..3db24391e31c 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -86,6 +86,19 @@ static int spapr_xive_target_to_nvt(uint32_t target,
>   * sPAPR END indexing uses a simple mapping of the CPU vcpu_id, 8
>   * priorities per CPU
>   */
> +int spapr_xive_end_to_target(uint8_t end_blk, uint32_t end_idx,
> +                             uint32_t *out_server, uint8_t *out_prio)
> +{

Since you don't support irq blocks as yet, should this error out
rather than ignoring if end_blk !=3D 0?

> +    if (out_server) {
> +        *out_server =3D end_idx >> 3;
> +    }
> +
> +    if (out_prio) {
> +        *out_prio =3D end_idx & 0x7;
> +    }
> +    return 0;
> +}
> +
>  static void spapr_xive_cpu_to_end(PowerPCCPU *cpu, uint8_t prio,
>                                    uint8_t *out_end_blk, uint32_t *out_en=
d_idx)
>  {
> @@ -792,6 +805,16 @@ static target_ulong h_int_set_source_config(PowerPCC=
PU *cpu,
>          new_eas.w =3D xive_set_field64(EAS_END_DATA, new_eas.w, eisn);
>      }
> =20
> +    if (kvm_irqchip_in_kernel()) {
> +        Error *local_err =3D NULL;
> +
> +        kvmppc_xive_set_source_config(xive, lisn, &new_eas, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            return H_HARDWARE;
> +        }
> +    }
> +
>  out:
>      xive->eat[lisn] =3D new_eas;
>      return H_SUCCESS;
> @@ -1097,6 +1120,16 @@ static target_ulong h_int_set_queue_config(PowerPC=
CPU *cpu,
>       */
> =20
>  out:
> +    if (kvm_irqchip_in_kernel()) {
> +        Error *local_err =3D NULL;
> +
> +        kvmppc_xive_set_queue_config(xive, end_blk, end_idx, &end, &loca=
l_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            return H_HARDWARE;
> +        }
> +    }
> +
>      /* Update END */
>      memcpy(&xive->endt[end_idx], &end, sizeof(XiveEND));
>      return H_SUCCESS;
> @@ -1189,6 +1222,16 @@ static target_ulong h_int_get_queue_config(PowerPC=
CPU *cpu,
>          args[2] =3D 0;
>      }
> =20
> +    if (kvm_irqchip_in_kernel()) {
> +        Error *local_err =3D NULL;
> +
> +        kvmppc_xive_get_queue_config(xive, end_blk, end_idx, end, &local=
_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            return H_HARDWARE;
> +        }
> +    }
> +
>      /* TODO: do we need any locking on the END ? */
>      if (flags & SPAPR_XIVE_END_DEBUG) {
>          /* Load the event queue generation number into the return flags =
*/
> @@ -1341,15 +1384,20 @@ static target_ulong h_int_esb(PowerPCCPU *cpu,
>          return H_P3;
>      }
> =20
> -    mmio_addr =3D xive->vc_base + xive_source_esb_mgmt(xsrc, lisn) + off=
set;
> +    if (kvm_irqchip_in_kernel()) {
> +        args[0] =3D kvmppc_xive_esb_rw(xsrc, lisn, offset, data,
> +                                     flags & SPAPR_XIVE_ESB_STORE);
> +    } else {
> +        mmio_addr =3D xive->vc_base + xive_source_esb_mgmt(xsrc, lisn) +=
 offset;
> =20
> -    if (dma_memory_rw(&address_space_memory, mmio_addr, &data, 8,
> -                      (flags & SPAPR_XIVE_ESB_STORE))) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: failed to access ESB @0x%"
> -                      HWADDR_PRIx "\n", mmio_addr);
> -        return H_HARDWARE;
> +        if (dma_memory_rw(&address_space_memory, mmio_addr, &data, 8,
> +                          (flags & SPAPR_XIVE_ESB_STORE))) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: failed to access ESB @=
0x%"
> +                          HWADDR_PRIx "\n", mmio_addr);
> +            return H_HARDWARE;
> +        }
> +        args[0] =3D (flags & SPAPR_XIVE_ESB_STORE) ? -1 : data;
>      }
> -    args[0] =3D (flags & SPAPR_XIVE_ESB_STORE) ? -1 : data;
>      return H_SUCCESS;
>  }
> =20
> @@ -1406,7 +1454,20 @@ static target_ulong h_int_sync(PowerPCCPU *cpu,
>       * This is not needed when running the emulation under QEMU
>       */
> =20
> -    /* This is not real hardware. Nothing to be done */
> +    /*
> +     * This is not real hardware. Nothing to be done unless when
> +     * under KVM
> +     */
> +
> +    if (kvm_irqchip_in_kernel()) {
> +        Error *local_err =3D NULL;
> +
> +        kvmppc_xive_sync_source(xive, lisn, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            return H_HARDWARE;
> +        }
> +    }
>      return H_SUCCESS;
>  }
> =20
> @@ -1441,6 +1502,16 @@ static target_ulong h_int_reset(PowerPCCPU *cpu,
>      }
> =20
>      device_reset(DEVICE(xive));
> +
> +    if (kvm_irqchip_in_kernel()) {
> +        Error *local_err =3D NULL;
> +
> +        kvmppc_xive_reset(xive, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            return H_HARDWARE;
> +        }
> +    }
>      return H_SUCCESS;
>  }
> =20
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 623fbf74f23e..6b50451b4f85 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -89,6 +89,52 @@ void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **e=
rrp)
>   * XIVE Interrupt Source (KVM)
>   */
> =20
> +void kvmppc_xive_set_source_config(sPAPRXive *xive, uint32_t lisn, XiveE=
AS *eas,
> +                                   Error **errp)
> +{
> +    uint32_t end_idx;
> +    uint32_t end_blk;
> +    uint32_t eisn;
> +    uint8_t priority;
> +    uint32_t server;
> +    uint64_t kvm_src;
> +    Error *local_err =3D NULL;
> +
> +    /*
> +     * No need to set a MASKED source, this is the default state after
> +     * reset.

I don't quite follow this comment, why is there no need to call a
MASKED source?

> +     */
> +    if (!xive_eas_is_valid(eas) || xive_eas_is_masked(eas)) {
> +        return;
> +    }
> +
> +    end_idx =3D xive_get_field64(EAS_END_INDEX, eas->w);
> +    end_blk =3D xive_get_field64(EAS_END_BLOCK, eas->w);
> +    eisn =3D xive_get_field64(EAS_END_DATA, eas->w);
> +
> +    spapr_xive_end_to_target(end_blk, end_idx, &server, &priority);
> +
> +    kvm_src =3D priority << KVM_XIVE_SOURCE_PRIORITY_SHIFT &
> +        KVM_XIVE_SOURCE_PRIORITY_MASK;
> +    kvm_src |=3D server << KVM_XIVE_SOURCE_SERVER_SHIFT &
> +        KVM_XIVE_SOURCE_SERVER_MASK;
> +    kvm_src |=3D ((uint64_t)eisn << KVM_XIVE_SOURCE_EISN_SHIFT) &
> +        KVM_XIVE_SOURCE_EISN_MASK;
> +
> +    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SOURCE_CONFIG, lisn,
> +                      &kvm_src, true, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +}
> +
> +void kvmppc_xive_sync_source(sPAPRXive *xive, uint32_t lisn, Error **err=
p)
> +{
> +    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SOURCE_SYNC, lisn,
> +                      NULL, true, errp);
> +}
> +
>  /*
>   * At reset, the interrupt sources are simply created and MASKED. We
>   * only need to inform the KVM XIVE device about their type: LSI or
> @@ -125,6 +171,64 @@ void kvmppc_xive_source_reset(XiveSource *xsrc, Erro=
r **errp)
>      }
>  }
> =20
> +/*
> + * This is used to perform the magic loads on the ESB pages, described
> + * in xive.h.
> + */
> +static uint64_t xive_esb_rw(XiveSource *xsrc, int srcno, uint32_t offset,
> +                            uint64_t data, bool write)
> +{
> +    unsigned long addr =3D (unsigned long) xsrc->esb_mmap +
> +        xive_source_esb_mgmt(xsrc, srcno) + offset;

Casting the esb_mmap into unsigned long then back to a pointer looks
unnecessary.  You should be able to do this with pointer arithmetic.

> +    if (write) {
> +        *((uint64_t *) addr) =3D data;
> +        return -1;
> +    } else {
> +        return *((uint64_t *) addr);
> +    }

Since this is always dealing with 64-bit values, couldn't you put the
byteswaps in here rather than in all the callers?

> +}
> +
> +static uint8_t xive_esb_read(XiveSource *xsrc, int srcno, uint32_t offse=
t)
> +{
> +    /* Prevent the compiler from optimizing away the load */
> +    volatile uint64_t value =3D xive_esb_rw(xsrc, srcno, offset, 0, 0);

Wouldn't the volatile magic be better inside xive_esb_rw()?

> +    return be64_to_cpu(value) & 0x3;
> +}
> +
> +static void xive_esb_trigger(XiveSource *xsrc, int srcno)
> +{
> +    unsigned long addr =3D (unsigned long) xsrc->esb_mmap +
> +        xive_source_esb_page(xsrc, srcno);
> +
> +    *((uint64_t *) addr) =3D 0x0;
> +}

Also.. aren't some of these register accesses likely to need memory
barriers?

> +
> +uint64_t kvmppc_xive_esb_rw(XiveSource *xsrc, int srcno, uint32_t offset,
> +                            uint64_t data, bool write)
> +{
> +    if (write) {
> +        return xive_esb_rw(xsrc, srcno, offset, data, 1);
> +    }
> +
> +    /*
> +     * Special Load EOI handling for LSI sources. Q bit is never set
> +     * and the interrupt should be re-triggered if the level is still
> +     * asserted.
> +     */
> +    if (xive_source_irq_is_lsi(xsrc, srcno) &&
> +        offset =3D=3D XIVE_ESB_LOAD_EOI) {
> +        xive_esb_read(xsrc, srcno, XIVE_ESB_SET_PQ_00);
> +        if (xsrc->status[srcno] & XIVE_STATUS_ASSERTED) {
> +            xive_esb_trigger(xsrc, srcno);
> +        }
> +        return 0;
> +    } else {
> +        return xive_esb_rw(xsrc, srcno, offset, 0, 0);
> +    }
> +}
> +
>  void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val)
>  {
>      XiveSource *xsrc =3D opaque;
> @@ -155,6 +259,86 @@ void kvmppc_xive_source_set_irq(void *opaque, int sr=
cno, int val)
>  /*
>   * sPAPR XIVE interrupt controller (KVM)
>   */
> +void kvmppc_xive_get_queue_config(sPAPRXive *xive, uint8_t end_blk,
> +                                  uint32_t end_idx, XiveEND *end,
> +                                  Error **errp)
> +{
> +    struct kvm_ppc_xive_eq kvm_eq =3D { 0 };
> +    uint64_t kvm_eq_idx;
> +    uint8_t priority;
> +    uint32_t server;
> +    Error *local_err =3D NULL;
> +
> +    if (!xive_end_is_valid(end)) {

This should set an error, shouldn't it?

> +        return;
> +    }
> +
> +    /* Encode the tuple (server, prio) as a KVM EQ index */
> +    spapr_xive_end_to_target(end_blk, end_idx, &server, &priority);
> +
> +    kvm_eq_idx =3D priority << KVM_XIVE_EQ_PRIORITY_SHIFT &
> +            KVM_XIVE_EQ_PRIORITY_MASK;
> +    kvm_eq_idx |=3D server << KVM_XIVE_EQ_SERVER_SHIFT &
> +        KVM_XIVE_EQ_SERVER_MASK;
> +
> +    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_EQ_CONFIG, kvm_eq_idx,
> +                      &kvm_eq, false, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    /*
> +     * The EQ index and toggle bit are updated by HW. These are the
> +     * only fields we want to return.
> +     */
> +    end->w1 =3D xive_set_field32(END_W1_GENERATION, 0ul, kvm_eq.qtoggle)=
 |
> +        xive_set_field32(END_W1_PAGE_OFF, 0ul, kvm_eq.qindex);
> +}
> +
> +void kvmppc_xive_set_queue_config(sPAPRXive *xive, uint8_t end_blk,
> +                                  uint32_t end_idx, XiveEND *end,
> +                                  Error **errp)
> +{
> +    struct kvm_ppc_xive_eq kvm_eq =3D { 0 };
> +    uint64_t kvm_eq_idx;
> +    uint8_t priority;
> +    uint32_t server;
> +    Error *local_err =3D NULL;
> +
> +    if (!xive_end_is_valid(end)) {
> +        return;
> +    }
> +
> +    /* Build the KVM state from the local END structure */
> +    kvm_eq.flags   =3D KVM_XIVE_EQ_FLAG_ALWAYS_NOTIFY;
> +    kvm_eq.qsize   =3D xive_get_field32(END_W0_QSIZE, end->w0) + 12;
> +    kvm_eq.qpage   =3D (uint64_t) be32_to_cpu(end->w2 & 0x0fffffff) << 3=
2 |
> +        be32_to_cpu(end->w3);
> +    kvm_eq.qtoggle =3D xive_get_field32(END_W1_GENERATION, end->w1);
> +    kvm_eq.qindex  =3D xive_get_field32(END_W1_PAGE_OFF, end->w1);
> +
> +    /* Encode the tuple (server, prio) as a KVM EQ index */
> +    spapr_xive_end_to_target(end_blk, end_idx, &server, &priority);
> +
> +    kvm_eq_idx =3D priority << KVM_XIVE_EQ_PRIORITY_SHIFT &
> +            KVM_XIVE_EQ_PRIORITY_MASK;
> +    kvm_eq_idx |=3D server << KVM_XIVE_EQ_SERVER_SHIFT &
> +        KVM_XIVE_EQ_SERVER_MASK;
> +
> +    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_EQ_CONFIG, kvm_eq_idx,
> +                      &kvm_eq, true, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +}
> +
> +void kvmppc_xive_reset(sPAPRXive *xive, Error **errp)
> +{
> +    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_CTRL, KVM_DEV_XIVE_RESE=
T,
> +                      NULL, true, errp);
> +}
> =20
>  static void *kvmppc_xive_mmap(sPAPRXive *xive, int pgoff, size_t len,
>                                Error **errp)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx0eKYACgkQbDjKyiDZ
s5L5+g/+LM6Vw79E+Ht6mbXRYnzoNRjhfv31CiTgTguriOjxh5JdO5502i2H/EN+
yk9TfqKFS9PlpYpb/Tc4o0l2HvlWS1IRnmgwURvwdjQCWa9EZ34E1ms/BI+331qh
VT8Qw8d5Uh6Ejeuwicb5VCTtw1o9tpugXLzv0lfPqPggbzjWG3nRu/gk1bfHwF3J
lz1TYQ0mzuhP8V9IcGGc6+3yh29CpSloSNyBXHHW13fZtvQWrp7yIfT1HSjunQK1
a1BSb7kUHt3WH1hipRbC/GBu09UL2cOPXLlQXSkeqSifFkehBVscckc/R+zBs/Od
EyIXD071FQTJIjJR7zFP7WztBH/Jvhw1tteYtap/7k4spQCD7F5OsxzG+MlIqDra
7Clxr6uSP92ONjSLCUx/l7zjovH9+v/gRopZT9pBdMQlc5+oDhp0ujdmvCWG6k9P
z5yvsDUiXtYrl5xj0XXB7NriA0/BVpiGayg+XzTnHRdGjnLkdgPvkIX3mN/gJKW4
Rsxd6/Nyo8FGlk4LZHsJ5TYTyll8/Fvj762Twzia9Rzbyr4KICKn2QFVv357rE7y
mwQHBGCqNMJrf91d14UG9a4sP+Na9hqYgBLJTnDxHQ4159ozlERO1eJibkfHnH4D
RnjFXTKwNLbyOrR5p5GGOBWTdHw/hOuL8PDRDxdL0HDtc0NeZ8g=
=s7BP
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
