Received: from eggs.gnu.org ([2001:4830:134:3::10]:51354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKYrR-000795-I7
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 20:11:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKYrQ-0002lW-Dy
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 20:11:53 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:54161)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1gKYrP-0002id-H0
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 20:11:52 -0500
Date: Thu, 8 Nov 2018 12:09:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181108010951.GK5575@umbus.fritz.box>
References: <20181030122134.11055.15711.stgit@pasha-VirtualBox>
	<2024ff61-7744-3ea5-f017-a48340fd5c36@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mGCtrYeZ202LI9ZG"
Content-Disposition: inline
In-Reply-To: <2024ff61-7744-3ea5-f017-a48340fd5c36@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH] This patch fixes processing of rfi
 instructions in icount mode.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, agraf@suse.de


--mGCtrYeZ202LI9ZG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 07, 2018 at 06:25:19PM +0000, Mark Cave-Ayland wrote:
> On 30/10/2018 12:21, Pavel Dovgalyuk wrote:
>=20
> > From: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
> >=20
> > In this mode writing to interrupt/peripheral state is controlled
> > by can_do_io flag. This flag must be set explicitly before helper
> > function invocation.
> >=20
> > Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
> > Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> > ---
> >  target/ppc/translate.c |   12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >=20
> > diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> > index 987ce6e..980862c 100644
> > --- a/target/ppc/translate.c
> > +++ b/target/ppc/translate.c
> > @@ -3878,9 +3878,15 @@ static void gen_rfi(DisasContext *ctx)
> >      }
> >      /* Restore CPU state */
> >      CHK_SV;
> > +    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
> > +        gen_io_start();
> > +    }
> >      gen_update_cfar(ctx, ctx->base.pc_next - 4);
> >      gen_helper_rfi(cpu_env);
> >      gen_sync_exception(ctx);
> > +    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
> > +        gen_io_end();
> > +    }
> >  #endif
> >  }
> > =20
> > @@ -3892,9 +3898,15 @@ static void gen_rfid(DisasContext *ctx)
> >  #else
> >      /* Restore CPU state */
> >      CHK_SV;
> > +    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
> > +        gen_io_start();
> > +    }
> >      gen_update_cfar(ctx, ctx->base.pc_next - 4);
> >      gen_helper_rfid(cpu_env);
> >      gen_sync_exception(ctx);
> > +    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
> > +        gen_io_end();
> > +    }
> >  #endif
> >  }
>=20
> I've given this patch a spin on top of ppc-for-3.1 and it allows my test =
images to
> boot with icount enabled without asserting, so:
>=20
> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Good enough for me.  Applied to ppc-for-3.1.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mGCtrYeZ202LI9ZG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvjjN8ACgkQbDjKyiDZ
s5JA2xAAgP2BleAgMa5KRvELmt7aZdUc0lvjwgImb4EHuzq0/NlZHcRAB3vLhGy2
SHNcrkJlvPwl+DLiulzL2IvZslBL6QpRfbjb9EVdkk5LX3SuuzFQU0HFxBtrfvEX
nEIwP2QQrTocUP55F3YPd0cjny9rvlfhPh/1l4T58BWU5clRyoJYzfcYZBIaoNuy
E+BA+BlOzm152w1VyArrkZQdYN9w8IsO5QOC0Zh5bqCI2Ziu0rWXeJjLvX8a46rk
SrK3LxSla6FHdJKF41nNMlgtFqaOe1sNKDTx6lQNNK+a5VpQBXq3wJdMQj2gyR9M
cvUFtREkP5l2iLBKpSP5gb5jEyMptTza5DMls/BLtiQZR15ledgKmJCl87A8SuRa
/TAQDab9DV/uWxJO6+YeIJY53YIa3RIHXCxn65Czd+2sg4zcuhg2UjZ6b1C0YLse
BPqIrfeYFCjNO/P//4Jiu0w4TKcdQeHjEpjuDfeyvtAxkBb0yAekTTkgI2YDE3hs
B+IVAvCUJmnoJD2L1iVPhMfWax7tTFicB+Yq3uBkul2McGTYHer59+KKOFhlH/6f
sObnUhwePVcVTkAkFtSFofKOwLv/eNcxn/CroWq2qkVDZKHbq63Uli1manSSjUpW
/fg4wtP3l9SaTl8mTrPLoZAcIe/wo6h6/VhM44a9u3jRxfmKI3g=
=IwD9
-----END PGP SIGNATURE-----

--mGCtrYeZ202LI9ZG--
