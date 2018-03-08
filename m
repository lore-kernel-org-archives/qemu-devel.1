Received: from eggs.gnu.org ([2001:4830:134:3::10]:52289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1etsD8-00015x-8Q
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 04:51:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1etsD5-0000TR-6b
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 04:51:42 -0500
Date: Thu, 8 Mar 2018 17:17:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180308061707.GP3083@umbus.fritz.box>
References: <20180307205427.3A2877456C6@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0UhZIN3Sa23/ILEd"
Content-Disposition: inline
In-Reply-To: <20180307205427.3A2877456C6@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH] ppc440_pcix: Add dummy implementation of
 BRDGOPT registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>


--0UhZIN3Sa23/ILEd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 07, 2018 at 09:43:59PM +0100, BALATON Zoltan wrote:
> I don't know what should be the correct implementation for these so
> these are just stored and returned as is without doing anything for
> now only to silence warnings when u-boot accesses these registers.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

I'm a bit dubious about putting in a dummy register implementation.
Specifically, I think the case needs to be made that the dummy
implementation is preferable to just putting up with the test errors.

At the very least there should be a comment in the code indicating
that it's just a dummy stub implementation.

> ---
>  hw/ppc/ppc440_pcix.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
> index ab2626a..3f177d3 100644
> --- a/hw/ppc/ppc440_pcix.c
> +++ b/hw/ppc/ppc440_pcix.c
> @@ -55,6 +55,8 @@ typedef struct PPC440PCIXState {
>      PCIDevice *dev;
>      struct PLBOutMap pom[PPC440_PCIX_NR_POMS];
>      struct PLBInMap pim[PPC440_PCIX_NR_PIMS];
> +    uint32_t brdgopt1;
> +    uint32_t brdgopt2;
>      uint32_t sts;
>      qemu_irq irq[PCI_NUM_PINS];
>      AddressSpace bm_as;
> @@ -95,6 +97,8 @@ typedef struct PPC440PCIXState {
>  #define PCIX0_PIM0SAH       0xf8
>  #define PCIX0_PIM2SAH       0xfc
> =20
> +#define PCIX0_BRDGOPT1      0x40
> +#define PCIX0_BRDGOPT2      0x44
>  #define PCIX0_STS           0xe0
> =20
>  #define PCI_ALL_SIZE        (PPC440_REG_BASE + PPC440_REG_SIZE)
> @@ -270,6 +274,12 @@ static void ppc440_pcix_reg_write4(void *opaque, hwa=
ddr addr,
>          ppc440_pcix_update_pim(s, 2);
>          break;
> =20
> +    case PCIX0_BRDGOPT1:
> +        s->brdgopt1 =3D val;
> +        break;
> +    case PCIX0_BRDGOPT2:
> +        s->brdgopt2 =3D val;
> +        break;
>      case PCIX0_STS:
>          s->sts =3D val;
>          break;
> @@ -365,6 +375,12 @@ static uint64_t ppc440_pcix_reg_read4(void *opaque, =
hwaddr addr,
>          val =3D s->pim[2].la >> 32;
>          break;
> =20
> +    case PCIX0_BRDGOPT1:
> +        val =3D s->brdgopt1;
> +        break;
> +    case PCIX0_BRDGOPT2:
> +        val =3D s->brdgopt2;
> +        break;
>      case PCIX0_STS:
>          val =3D s->sts;
>          break;
> @@ -408,6 +424,8 @@ static void ppc440_pcix_reset(DeviceState *dev)
>      for (i =3D 0; i < PPC440_PCIX_NR_PIMS; i++) {
>          s->pim[i].sa =3D 0xffffffff00000000ULL;
>      }
> +    s->brdgopt1 =3D 0;
> +    s->brdgopt2 =3D 0;
>      s->sts =3D 0;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0UhZIN3Sa23/ILEd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqg1WMACgkQbDjKyiDZ
s5Jm3BAAp4yBWVGfQ6M5HkKWHJjeDheRS97CpOtLcjYmvFQ7uxZRWJBxVSokHMuu
81+wSOo2vRtC7B4virY7fFQ3uF0BniLQ0ZZNA7WhvlOIHi22M+vjn7aN+jVnoBQd
F5NQvIUpPUwVr+yhw3Z5RH2cKW1yveFXuCI12aUbAgPMo/NGH8K0czGr9YEPQzX7
ypKobbkTykXIRH8XSVKaw/3UJjfEG6xE+l9JCjFeygQLd24gLjlp8BFR+AmU38CW
BpGPeFgRRhUsIrJxy+0lKWidZMfMhn3jwqAFy3yQWJ87EUDuFR1MbVuASG95B8X/
QTN1MKzi9iHMSDdPKC01U7SDIa59qeq9nWDphkDYQTax4LgJr6XNjZ0FLVPjtLWo
TokE0dpXB1TnJAJKWxC57VPq3QXOcp8ehRfh/RMNAVcd64RyjyF+vbmm05WEfzAW
d36qloXJMMUzdOfdGLRLpvq5vOs7obA422mGCh7eOvi1CHes/Drl+QJqJP7hlFEg
76kNS8Lfti+65/Db3uwku8jyOp7v9/zVbPj4azwrCz9l+SViB5FyHFLOJcKZ23CL
k3cfrUlhI/gPCQZPEdIGunEpUigl4++W350CZxfhjBsztJQ75Jf2nE0s8/U2AfWQ
2QQJY4tUm7R8JdOq1ucYQcW1JJuNCmDRF6GOCPvkqrDS3prD4do=
=pg0s
-----END PGP SIGNATURE-----

--0UhZIN3Sa23/ILEd--
