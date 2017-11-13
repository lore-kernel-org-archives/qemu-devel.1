Received: from eggs.gnu.org ([2001:4830:134:3::10]:51437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eEOHc-0000c6-A4
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 18:36:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eEOHa-0000Wm-RZ
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 18:36:52 -0500
Date: Tue, 14 Nov 2017 10:29:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171113232907.GA32308@umbus.fritz.box>
References: <151060215918.17804.5898929119312944124.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <151060215918.17804.5898929119312944124.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH for-2.11] xics/kvm: synchonize state before
 'info pic'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2017 at 08:42:39PM +0100, Greg Kurz wrote:
> When using the emulated XICS, the 'info pic' monitor command shows:
>=20
> CPU 0 XIRR=3Dff000000 ((nil)) PP=3Dff MFRR=3Dff
> ICS 1000..13ff 0x10040060340
>   1000 MSI 05 00
>   1001 MSI 05 00
>   1002 MSI 05 00
>   1003 MSI ff 00
>   1004 LSI ff 00
>   1005 LSI ff 00
>   1006 LSI ff 00
>   1007 LSI ff 00
>   1008 MSI 05 00
>   1009 MSI 05 00
>   100a MSI 05 00
>   100b MSI 05 00
>   100c MSI 05 00
>=20
> but when using the in-kernel XICS with the very same guest, we get:
>=20
> CPU 0 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> ICS 1000..13ff 0x10032e00340
>   1000 MSI ff 00
>   1001 MSI ff 00
>   1002 MSI ff 00
>   1003 MSI ff 00
>   1004 LSI ff 00
>   1005 LSI ff 00
>   1006 LSI ff 00
>   1007 LSI ff 00
>   1008 MSI ff 00
>   1009 MSI ff 00
>   100a MSI ff 00
>   100b MSI ff 00
>   100c MSI ff 00
>=20
> ie, all irqs are masked and XIRR is null, while we should get the
> same output as with the emulated XICS.
>=20
> If the guest is then migrated, 'info pic' shows the expected values
> on both source and destination.
>=20
> The problem is that QEMU doesn't synchronize with KVM before printing
> the XICS state. Migration happens to fix the output because it enforces
> synchronization with KVM.
>=20
> To fix the invalid output of 'info pic', this patch introduces a new
> synchronize_state operation for both ICPStateClass and ICSStateClass.
> The ICP operation relies on run_on_cpu() in order to kick the vCPU
> and avoid sleeping on KVM_GET_ONE_REG.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.11.

> ---
>  hw/intc/xics.c        |   11 +++++++++++
>  hw/intc/xics_kvm.c    |   19 +++++++++++++++++++
>  include/hw/ppc/xics.h |    2 ++
>  3 files changed, 32 insertions(+)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index cc9816e7f204..a1cc0e420c98 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -40,11 +40,17 @@
> =20
>  void icp_pic_print_info(ICPState *icp, Monitor *mon)
>  {
> +    ICPStateClass *icpc =3D ICP_GET_CLASS(icp);
>      int cpu_index =3D icp->cs ? icp->cs->cpu_index : -1;
> =20
>      if (!icp->output) {
>          return;
>      }
> +
> +    if (icpc->synchronize_state) {
> +        icpc->synchronize_state(icp);
> +    }
> +
>      monitor_printf(mon, "CPU %d XIRR=3D%08x (%p) PP=3D%02x MFRR=3D%02x\n=
",
>                     cpu_index, icp->xirr, icp->xirr_owner,
>                     icp->pending_priority, icp->mfrr);
> @@ -52,6 +58,7 @@ void icp_pic_print_info(ICPState *icp, Monitor *mon)
> =20
>  void ics_pic_print_info(ICSState *ics, Monitor *mon)
>  {
> +    ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(ics);
>      uint32_t i;
> =20
>      monitor_printf(mon, "ICS %4x..%4x %p\n",
> @@ -61,6 +68,10 @@ void ics_pic_print_info(ICSState *ics, Monitor *mon)
>          return;
>      }
> =20
> +    if (icsc->synchronize_state) {
> +        icsc->synchronize_state(ics);
> +    }
> +
>      for (i =3D 0; i < ics->nr_irqs; i++) {
>          ICSIRQState *irq =3D ics->irqs + i;
> =20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 3091ad3ac2c8..89fb20e2c55c 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -81,6 +81,18 @@ static void icp_get_kvm_state(ICPState *icp)
>          & KVM_REG_PPC_ICP_PPRI_MASK;
>  }
> =20
> +static void do_icp_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
> +{
> +    icp_get_kvm_state(arg.host_ptr);
> +}
> +
> +static void icp_synchronize_state(ICPState *icp)
> +{
> +    if (icp->cs) {
> +        run_on_cpu(icp->cs, do_icp_synchronize_state, RUN_ON_CPU_HOST_PT=
R(icp));
> +    }
> +}
> +
>  static int icp_set_kvm_state(ICPState *icp, int version_id)
>  {
>      uint64_t state;
> @@ -156,6 +168,7 @@ static void icp_kvm_class_init(ObjectClass *klass, vo=
id *data)
>      icpc->post_load =3D icp_set_kvm_state;
>      icpc->realize =3D icp_kvm_realize;
>      icpc->reset =3D icp_kvm_reset;
> +    icpc->synchronize_state =3D icp_synchronize_state;
>  }
> =20
>  static const TypeInfo icp_kvm_info =3D {
> @@ -234,6 +247,11 @@ static void ics_get_kvm_state(ICSState *ics)
>      }
>  }
> =20
> +static void ics_synchronize_state(ICSState *ics)
> +{
> +    ics_get_kvm_state(ics);
> +}
> +
>  static int ics_set_kvm_state(ICSState *ics, int version_id)
>  {
>      uint64_t state;
> @@ -347,6 +365,7 @@ static void ics_kvm_class_init(ObjectClass *klass, vo=
id *data)
>      icsc->realize =3D ics_kvm_realize;
>      icsc->pre_save =3D ics_get_kvm_state;
>      icsc->post_load =3D ics_set_kvm_state;
> +    icsc->synchronize_state =3D ics_synchronize_state;
>  }
> =20
>  static const TypeInfo ics_kvm_info =3D {
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 28d248abad61..2df99be111ce 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -69,6 +69,7 @@ struct ICPStateClass {
>      void (*pre_save)(ICPState *icp);
>      int (*post_load)(ICPState *icp, int version_id);
>      void (*reset)(ICPState *icp);
> +    void (*synchronize_state)(ICPState *icp);
>  };
> =20
>  struct ICPState {
> @@ -119,6 +120,7 @@ struct ICSStateClass {
>      void (*reject)(ICSState *s, uint32_t irq);
>      void (*resend)(ICSState *s);
>      void (*eoi)(ICSState *s, uint32_t irq);
> +    void (*synchronize_state)(ICSState *s);
>  };
> =20
>  struct ICSState {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloKKsAACgkQbDjKyiDZ
s5Labg/+LEOI6IOTsMw3ejxonpQyUYdgwxE2WfT/ZCsrN2FTYdoa8r8PXi//zGZN
+1wvZxCb3IGgsgY4qONzQnzMv0etFQz/sHpjQrCblZ1oApd0D6zVMfRm6gKn29SW
x0IToGLD3Rf3nCyGGd+AiIxC0gZ6b0GSTUcBx+W7L2+diKvZUrwoxJFRV4tSoZ5H
ltQTVA2pLA4Joh+nBUtkWfJntvRjs8Y54DaWIaNDCiFxKo6MYSOG8nKq3B9ijItV
qWw2fJAkio9mGhjXEUyVivHY6CfZe5NiHwimgBHc5iDPT5EyOGE2RgWHgMbM9x12
mVNngSaDD02uK4oMcBN2rC6sGXGcWTITmGfdDSva8bnLG4vHrqf5X/5D1OM5yFwi
xlocHAizyKlWxjrv3TdsE0CYnnL3mgR3XmmIfP8i2Q7BrOfrsTLkhPep350dy7ep
ZWZuDbZhlPhIJr2UH4cmDSWMjDMfCD+mBGGoE9UCrfeula8qZnWpPdcl8CJDo7YL
ujteCe/DpcwehStknntWB5CSQirO7D3XzIKGXvZm+n4dYPc/lLEALF1dHlCZkxIO
47ol09NfeZnUI4MMYg8qt1IMA4r/tIu14pudZGFZpuesmnAJtNmrmVNO8kJCa10W
idJ1ABFdFH/t5fBRSOIqvCeyY1QzaH69vC2+Hso+bfzbwjSQipU=
=4UXa
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
