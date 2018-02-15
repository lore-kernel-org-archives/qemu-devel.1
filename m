Received: from eggs.gnu.org ([2001:4830:134:3::10]:59329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emAiN-0001GB-S7
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:00:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emAiM-0004AT-T3
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:00:07 -0500
Date: Thu, 15 Feb 2018 14:40:54 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180215034054.GD5247@umbus.fritz.box>
References: <20180215004443.18013-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rz+pwK2yUstbofK6"
Content-Disposition: inline
In-Reply-To: <20180215004443.18013-1-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V3 1/3] ppc/spapr-caps: Change
 migration macro to take full spapr-cap name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2018 at 11:44:41AM +1100, Suraj Jitindar Singh wrote:
> Change the macro that generates the vmstate migration field and the needed
> function for the spapr-caps to take the full spapr-cap name. This has
> the benefit of meaning this instance will be picked up when greping
> for the spapr-caps and making it more obvious what this macro is doing.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Applied, thanks.

> ---
>  hw/ppc/spapr_caps.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 62efdaee38..e69d308560 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -350,34 +350,34 @@ int spapr_caps_post_migration(sPAPRMachineState *sp=
apr)
>  }
> =20
>  /* Used to generate the migration field and needed function for a spapr =
cap */
> -#define SPAPR_CAP_MIG_STATE(cap, ccap)                  \
> -static bool spapr_cap_##cap##_needed(void *opaque)      \
> +#define SPAPR_CAP_MIG_STATE(sname, cap)                 \
> +static bool spapr_cap_##sname##_needed(void *opaque)    \
>  {                                                       \
>      sPAPRMachineState *spapr =3D opaque;                  \
>                                                          \
> -    return spapr->cmd_line_caps[SPAPR_CAP_##ccap] &&    \
> -           (spapr->eff.caps[SPAPR_CAP_##ccap] !=3D        \
> -            spapr->def.caps[SPAPR_CAP_##ccap]);         \
> +    return spapr->cmd_line_caps[cap] &&                 \
> +           (spapr->eff.caps[cap] !=3D                     \
> +            spapr->def.caps[cap]);                      \
>  }                                                       \
>                                                          \
> -const VMStateDescription vmstate_spapr_cap_##cap =3D {    \
> -    .name =3D "spapr/cap/" #cap,                          \
> +const VMStateDescription vmstate_spapr_cap_##sname =3D {  \
> +    .name =3D "spapr/cap/" #sname,                        \
>      .version_id =3D 1,                                    \
>      .minimum_version_id =3D 1,                            \
> -    .needed =3D spapr_cap_##cap##_needed,                 \
> +    .needed =3D spapr_cap_##sname##_needed,               \
>      .fields =3D (VMStateField[]) {                        \
> -        VMSTATE_UINT8(mig.caps[SPAPR_CAP_##ccap],       \
> +        VMSTATE_UINT8(mig.caps[cap],                    \
>                        sPAPRMachineState),               \
>          VMSTATE_END_OF_LIST()                           \
>      },                                                  \
>  }
> =20
> -SPAPR_CAP_MIG_STATE(htm, HTM);
> -SPAPR_CAP_MIG_STATE(vsx, VSX);
> -SPAPR_CAP_MIG_STATE(dfp, DFP);
> -SPAPR_CAP_MIG_STATE(cfpc, CFPC);
> -SPAPR_CAP_MIG_STATE(sbbc, SBBC);
> -SPAPR_CAP_MIG_STATE(ibs, IBS);
> +SPAPR_CAP_MIG_STATE(htm, SPAPR_CAP_HTM);
> +SPAPR_CAP_MIG_STATE(vsx, SPAPR_CAP_VSX);
> +SPAPR_CAP_MIG_STATE(dfp, SPAPR_CAP_DFP);
> +SPAPR_CAP_MIG_STATE(cfpc, SPAPR_CAP_CFPC);
> +SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
> +SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
> =20
>  void spapr_caps_reset(sPAPRMachineState *spapr)
>  {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqFAUEACgkQbDjKyiDZ
s5I3fg/+MzsTxwOY7IMSB645zErmK1KYEbt9wetq2Q9ARt5Y5H4RS3v9LCtlio5g
0q7Z6YcCh+kco0Ng97RDcFQJ8XPjoOkyDdBAwNpKs9J3uzu8Mm2NK/J9HOBO41cS
3pKOATawUdMxFwkga/BL8/5baKoOr0Vu6srow7Fd/1mC9kYVNv4jiBmvsQa7wtsI
yWjT0uTQxGXv/3YadKWfEZfjhTaOmQCysqO1/fynLzUMgj33ScF/saDiMueNdp17
7W4bJhuRqmEBRDpu2gE5O4v0Md6fPrfZ2ZmBzFEENIHcz/R82HhCzKa4ZISCBFbb
svUEFimN1jNXSCO4gU+sqjyzHL1seDIgdShBBIgku6Don0sQiZpW6mmBUN2i61tR
ryc7VNisyseaS/HYqKl4yTJykFS9ug/wMe8ToOApUCk/e5e7ySa9tKOQqt5Rl/Lb
y4WEDxvT1aMMarzxZPGTLaNDidJVdB6wB+3XHdw1LtzTSsqDxak2bYSG7KYgd4LR
iYS9hKOKUy6p/mxioQe604I5KfifY/ddd7BtSr6hQAtA/8PXgrln7md3+cFYpWyk
U8muKxXlVMhYpiROg4XWl8Jq9KejJNTBydkiI4a6FVUAtk60p0hdohGAHtqu0ks6
TbLSt+67bBbCyiMAppTnft57/jeVAZplQOQewtbVwXixUURSwJc=
=CTd8
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--
