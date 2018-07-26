Received: from eggs.gnu.org ([2001:4830:134:3::10]:45091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fiYsH-0000F1-Ts
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 01:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fiYsE-0001Sa-7n
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 01:31:41 -0400
Date: Thu, 26 Jul 2018 15:31:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180726053127.GF12001@umbus.fritz.box>
References: <1513111443-22790-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1513111443-22790-3-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ULyIDA2m8JTe+TiX"
Content-Disposition: inline
In-Reply-To: <1513111443-22790-3-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 2/2] tpm_spapr: Support
 suspend and resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, lo1@us.ibm.com, James.Bottomley@hansenpartnership.com, qemu-ppc@nongnu.org, clg@kaod.org, marcandre.lureau@redhat.com


--ULyIDA2m8JTe+TiX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Tue, Dec 12, 2017 at 03:44:03PM -0500, Stefan Berger wrote:
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  hw/tpm/tpm_spapr.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++=
++----
>  1 file changed, 57 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
> index ef5e62d..0b8a424 100644
> --- a/hw/tpm/tpm_spapr.c
> +++ b/hw/tpm/tpm_spapr.c
> @@ -248,9 +248,8 @@ static int tpm_spapr_do_crq(struct VIOsPAPRDevice *de=
v, uint8_t *crq_data)
>      return H_SUCCESS;
>  }
> =20
> -static void tpm_spapr_request_completed(TPMIf *ti)
> +static void _tpm_spapr_request_completed(SPAPRvTPMState *s)

Don't start identifiers with _, please, they're reserved by the
standard library.

>  {
> -    SPAPRvTPMState *s =3D VIO_SPAPR_VTPM(ti);
>      TPMSpaprCRQ *crq =3D &s->crq;
>      uint32_t len;
>      int rc;
> @@ -281,6 +280,13 @@ static void tpm_spapr_request_completed(TPMIf *ti)
>      }
>  }
> =20
> +static void tpm_spapr_request_completed(TPMIf *ti)
> +{
> +    SPAPRvTPMState *s =3D VIO_SPAPR_VTPM(ti);
> +
> +    _tpm_spapr_request_completed(s);
> +}

I don't see much value in this wrapper - there's only one caller,
local to this code, so it can do the cast itself.

> +
>  static int tpm_spapr_do_startup_tpm(SPAPRvTPMState *s, size_t buffersize)
>  {
>      return tpm_backend_startup_tpm(s->be_driver, buffersize);
> @@ -313,9 +319,56 @@ static enum TPMVersion tpm_spapr_get_version(TPMIf *=
ti)
>      return tpm_backend_get_tpm_version(s->be_driver);
>  }
> =20
> +/* persistent state handling */
> +
> +static int tpm_spapr_pre_save(void *opaque)
> +{
> +    SPAPRvTPMState *s =3D opaque;
> +
> +    /*
> +     * Synchronize with backend completion.
> +     */
> +    tpm_backend_wait_cmd_completed(s->be_driver);
> +
> +    /*
> +     * we cannot deliver the results to the VM (in state
> +     * SPAPR_VTPM_STATE_EXECUTION) since DMA would touch VM memory
> +     */
> +
> +    return 0;
> +}
> +
> +static int tpm_spapr_post_load(void *opaque,
> +                               int version_id __attribute__((unused)))

Use the G_GNUC_UNUSED macro instead, please.

> +{
> +    SPAPRvTPMState *s =3D opaque;
> +
> +    if (s->state =3D=3D SPAPR_VTPM_STATE_EXECUTION) {
> +        /*
> +         * now we can deliver the results to the VM via DMA
> +         */
> +        _tpm_spapr_request_completed(s);
> +    }
> +
> +    return 0;
> +}
> +
>  static const VMStateDescription vmstate_spapr_vtpm =3D {
> -    .name =3D "tpm_spapr",
> -    .unmigratable =3D 1,
> +    .name =3D "tpm-spapr",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 0,
> +    .minimum_version_id_old =3D 0,
> +    .pre_save =3D tpm_spapr_pre_save,
> +    .post_load =3D tpm_spapr_post_load,
> +    .fields =3D (VMStateField[]) {

This should include VMSTATE_SPAPR_VIO(), which will cover several of
the fields you list explicitly below.

> +        VMSTATE_BUFFER(crq.raw, SPAPRvTPMState),
> +        VMSTATE_UINT64(vdev.crq.qladdr, SPAPRvTPMState),
> +        VMSTATE_UINT32(vdev.crq.qsize, SPAPRvTPMState),
> +        VMSTATE_UINT32(vdev.crq.qnext, SPAPRvTPMState),
> +        VMSTATE_UINT8(state, SPAPRvTPMState),
> +        VMSTATE_BUFFER(buffer, SPAPRvTPMState),
> +        VMSTATE_END_OF_LIST(),
> +    }
>  };
> =20
>  static Property tpm_spapr_properties[] =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ULyIDA2m8JTe+TiX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltZXK4ACgkQbDjKyiDZ
s5JiEhAAvkZpQ6JHvk7XCvOnQd+Kqpq0lkx1/sPzd+xmSf6fejzngb+XLpOPmKoV
JFXZ96uT3sM5hOdOtIX1SJLUbcBVDRw9GWzq0fRTSMO8VWxJQNMSlwV6CZF7Qcze
DhnEOpc1FAQ5h0Nh4s9nSxa+cKv53RDixpiEaB1LwL80LVlrx6kxDpt0Ysw6Vh9S
uKYPdtxoZKMfyjvfnw2uba9zSlglhAgKh1RftqlWHUi0e0wRj4c5ao0q/zroNCDs
ix2QFobbOXC9Xp5WU9esOvLJzXZym90xKZmwh6EvEconvR3aKGR6Mu1FKSznE5O4
vzDi0x9GF5S3csrG/GPm/htRCfyCgyeb6v+XF2osT1BLPMWu7iwDRGSGi5+Zjiea
TFjY4EXM7/GSJNeP8DkImrS7wguHsevpKb/Nw3gbuYf4dHgwBrkaMMbBGLvQrOsB
rhRcHa6bj8aQAPLTNGnw/4A9p1r6FTY39g7zCThK5+yVikU/aOM0vDYxHv+mnPHL
uHatpnVNegMIk3GIuPbRoisspoKqMBikKQ3wqisikZ4bnD2opc738q+HdvtqH6QW
iCwJ/t5WslLp4FmOrtcm1lSCww4VUCVa8oPjrygYPgj/5gePfx02DzzeinhYXL2f
BX/YPm3xO19FXRhNvqo5r9MgbdusWgM4hlshGYxfbC3d0ZiGzu0=
=Tg9Y
-----END PGP SIGNATURE-----

--ULyIDA2m8JTe+TiX--
