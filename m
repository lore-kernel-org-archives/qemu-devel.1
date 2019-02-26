Received: from eggs.gnu.org ([209.51.188.92]:48849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyTtq-0003t2-OS
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 22:59:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyTto-0007jT-DS
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 22:59:22 -0500
Date: Tue, 26 Feb 2019 14:39:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190226033914.GK6872@umbus.fritz.box>
References: <20190226030531.9932-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hl1kWnBARzJiTscN"
Content-Disposition: inline
In-Reply-To: <20190226030531.9932-1-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 1/4] target/ppc/spapr: Add
 SPAPR_CAP_LARGE_DECREMENTER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, clg@kaod.org, qemu-devel@nongnu.org


--hl1kWnBARzJiTscN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2019 at 02:05:28PM +1100, Suraj Jitindar Singh wrote:
> Add spapr_cap SPAPR_CAP_LARGE_DECREMENTER to be used to control the
> availability and size of the large decrementer made available to the
> guest.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---
>  hw/ppc/spapr.c         |  2 ++
>  hw/ppc/spapr_caps.c    | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h |  5 ++++-
>  3 files changed, 51 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index b6a571b6f1..acf62a2b9f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2077,6 +2077,7 @@ static const VMStateDescription vmstate_spapr =3D {
>          &vmstate_spapr_irq_map,
>          &vmstate_spapr_cap_nested_kvm_hv,
>          &vmstate_spapr_dtb,
> +        &vmstate_spapr_cap_large_decr,
>          NULL
>      }
>  };
> @@ -4288,6 +4289,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
>      smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D 16; /* 64kiB */
>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
> +    smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D 0;

This looks basically fine, but the name kind of suggests it's a
boolean, whereas it's actually a number of bits.  I wonder if just
calling it "decrementer bits" would be clearer, with it defaulting to
32.

>      spapr_caps_add_properties(smc, &error_abort);
>      smc->irq =3D &spapr_irq_xics;
>      smc->dr_phb_enabled =3D true;
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 64f98ae68d..1545a02729 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -182,6 +182,34 @@ static void spapr_cap_set_pagesize(Object *obj, Visi=
tor *v, const char *name,
>      spapr->eff.caps[cap->index] =3D val;
>  }
> =20
> +static void spapr_cap_get_uint8(Object *obj, Visitor *v, const char *nam=
e,
> +                                void *opaque, Error **errp)
> +{
> +    sPAPRCapabilityInfo *cap =3D opaque;
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> +    uint8_t val =3D spapr_get_cap(spapr, cap->index);
> +
> +    visit_type_uint8(v, name, &val, errp);
> +}
> +
> +static void spapr_cap_set_uint8(Object *obj, Visitor *v, const char *nam=
e,
> +                                void *opaque, Error **errp)
> +{
> +    sPAPRCapabilityInfo *cap =3D opaque;
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> +    Error *local_err =3D NULL;
> +    uint8_t val;
> +
> +    visit_type_uint8(v, name, &val, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    spapr->cmd_line_caps[cap->index] =3D true;
> +    spapr->eff.caps[cap->index] =3D val;
> +}
> +
>  static void cap_htm_apply(sPAPRMachineState *spapr, uint8_t val, Error *=
*errp)
>  {
>      if (!val) {
> @@ -390,6 +418,13 @@ static void cap_nested_kvm_hv_apply(sPAPRMachineStat=
e *spapr,
>      }
>  }
> =20
> +static void cap_large_decr_apply(sPAPRMachineState *spapr,
> +                                 uint8_t val, Error **errp)
> +{
> +    if (val)
> +        error_setg(errp, "No large decrementer support, try cap-large-de=
cr=3D0");
> +}
> +
>  sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
>      [SPAPR_CAP_HTM] =3D {
>          .name =3D "htm",
> @@ -468,6 +503,15 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =
=3D {
>          .type =3D "bool",
>          .apply =3D cap_nested_kvm_hv_apply,
>      },
> +    [SPAPR_CAP_LARGE_DECREMENTER] =3D {
> +        .name =3D "large-decr",
> +        .description =3D "Size of Large Decrementer for the Guest (bits)=
 0=3Ddisabled",
> +        .index =3D SPAPR_CAP_LARGE_DECREMENTER,
> +        .get =3D spapr_cap_get_uint8,
> +        .set =3D spapr_cap_set_uint8,
> +        .type =3D "int",
> +        .apply =3D cap_large_decr_apply,
> +    },
>  };
> =20
>  static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
> @@ -596,6 +640,7 @@ SPAPR_CAP_MIG_STATE(cfpc, SPAPR_CAP_CFPC);
>  SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
>  SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
>  SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
> +SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
> =20
>  void spapr_caps_init(sPAPRMachineState *spapr)
>  {
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 59073a7579..8efc5e0779 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -74,8 +74,10 @@ typedef enum {
>  #define SPAPR_CAP_HPT_MAXPAGESIZE       0x06
>  /* Nested KVM-HV */
>  #define SPAPR_CAP_NESTED_KVM_HV         0x07
> +/* Large Decrementer */
> +#define SPAPR_CAP_LARGE_DECREMENTER     0x08
>  /* Num Caps */
> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_NESTED_KVM_HV + 1)
> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_LARGE_DECREMENTER + 1)
> =20
>  /*
>   * Capability Values
> @@ -828,6 +830,7 @@ extern const VMStateDescription vmstate_spapr_cap_cfp=
c;
>  extern const VMStateDescription vmstate_spapr_cap_sbbc;
>  extern const VMStateDescription vmstate_spapr_cap_ibs;
>  extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
> +extern const VMStateDescription vmstate_spapr_cap_large_decr;
> =20
>  static inline uint8_t spapr_get_cap(sPAPRMachineState *spapr, int cap)
>  {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hl1kWnBARzJiTscN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx0tOIACgkQbDjKyiDZ
s5IgLg/9HM1+ppN+q2RNif2K7TdqVRJlIZg24hjl5xfpllXKg3gSqYjmRoiWlQkJ
fS92/nrLZzmgplwSxIuUY2A+4zq+1sHkP7MaxsqrlauV5h10M+Im4eznSKTLyQMb
ep0mXWJAnVkqBP1HFWX8O8mCwdjgvawNZjZdbZO/KQLUkynllr1UvP+6G0ZbDJOp
Jwwzdsgaew7BXY9xkBuUgeAFVs+2V4Ud3IqTotYBOVvvoZTyBb+akE4PxpovMQ1o
+kv4iTacEg8+/UaOxBxRmquPrZa+44VuJyxGNNSOZqB3QIvVzzm880NuzTn7sfOV
+tnbFfHJ4JLCdH12Xggu2ThevvI9iu4JMNOFnu4Z0QAoAph8oT8Sb1vNnZ9CNS5J
g05ALP71ayejZjXadLlIdMPWDs7EQ72ZaAkv9Hr+buukla+XgBWDtfO2h9H45KKk
dbmTWKJIvP6836ZDEmfPOal8Alwc3EZyBjpFS66KbXWkzAyBTkiCVSQqxUK43atf
MAHawEznA6K0C69wqAn0CTmhwMQwPvFrTFQWn/Q/OcLco7YZ3JiX1TaMv3HQuhZI
OT7AVJZzx/3WLpFOtCTaXNhwb4GFDweZSqkyHdwHcDQMGUhs9pwEYMUDtHsoV/oh
hfQidyd7lstH8Inrx+XAgDSbg1Aw0vl1FShft06PtDjtEzHf0/s=
=F5Ps
-----END PGP SIGNATURE-----

--hl1kWnBARzJiTscN--
