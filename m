Received: from eggs.gnu.org ([2001:4830:134:3::10]:48377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRXux-0003dZ-Bj
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 00:27:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRXuu-0008J0-86
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 00:27:19 -0500
Date: Thu, 12 Jan 2017 16:11:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170112051151.GP14026@umbus.fritz.box>
References: <1484038243-30314-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1484038243-30314-4-git-send-email-nikunj@linux.vnet.ibm.com>
	<20170112024743.GD14026@umbus.fritz.box>
	<8760lkvpz1.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZVOC9e0LfXEId8h2"
Content-Disposition: inline
In-Reply-To: <8760lkvpz1.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH 03/11] target-ppc: Add xsiexpdp instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com


--ZVOC9e0LfXEId8h2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2017 at 10:23:22AM +0530, Nikunj A Dadhania wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> > [ Unknown signature status ]
> > On Tue, Jan 10, 2017 at 02:20:35PM +0530, Nikunj A Dadhania wrote:
> >> xsiexpdp: VSX Scalar Insert Exponent Double Precision
> >>=20
> >> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> >> ---
> >>  target/ppc/translate/vsx-impl.inc.c | 20 ++++++++++++++++++++
> >>  target/ppc/translate/vsx-ops.inc.c  |  1 +
> >>  2 files changed, 21 insertions(+)
> >>=20
> >> diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translat=
e/vsx-impl.inc.c
> >> index 2d9fe50..2d09225 100644
> >> --- a/target/ppc/translate/vsx-impl.inc.c
> >> +++ b/target/ppc/translate/vsx-impl.inc.c
> >> @@ -1243,6 +1243,26 @@ static void gen_xsxexpqp(DisasContext *ctx)
> >>      tcg_gen_movi_i64(xtl, 0);
> >>  }
> >> =20
> >> +static void gen_xsiexpdp(DisasContext *ctx)
> >> +{
> >> +    TCGv_i64 xth =3D cpu_vsrh(xT(ctx->opcode));
> >> +    TCGv ra =3D cpu_gpr[rA(ctx->opcode)];
> >> +    TCGv rb =3D cpu_gpr[rB(ctx->opcode)];
> >> +    TCGv_i64 t0;
> >> +
> >> +    if (unlikely(!ctx->vsx_enabled)) {
> >> +        gen_exception(ctx, POWERPC_EXCP_VSXU);
> >> +        return;
> >> +    }
> >> +    t0 =3D tcg_temp_new_i64();
> >> +    tcg_gen_andi_i64(xth, ra, 0x800FFFFFFFFFFFFF);
> >> +    tcg_gen_andi_i64(t0, rb, 0x7FF);
> >> +    tcg_gen_shli_i64(t0, t0, 52);
> >> +    tcg_gen_or_i64(xth, xth, t0);
> >> +    /* dword[1] is undefined */
> >
> > According to the ISA doc I have, dword[1] is set to 0 rather than
> > being undefined.
>=20
> Referring to xsiexpdp on page 570:
>=20
> "The contents of doubleword element 1 of VSR[XT] are
> undefined."
>=20
> The revision that I have is dated November 30, 2015

Ah, sorry.  I think I just misread all those "U"s in the pseudo-code
as "0"s.  I'll blame the fact I'm using the little laptop screen,
since I've left my home office to escape the heat.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZVOC9e0LfXEId8h2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYdxAWAAoJEGw4ysog2bOSmsEP/ikYEEcJFlDDlPLNNXR1JnSP
877TsxI6JgMIGWFSQpYA2Hg1VxY0kUal351o23vYsYVZCs2UJMQRi8VtGDQSWzzx
oVJytoN5v6VLFpqWtcL2RbYD7eaY8unfP6nhyMU2OKorf6jQ4Esx9H6yHMVYxrsp
VKHRWGfwo0QDACTMfxp8WNoF6iQ+um6j+AYqcUHmroeuJ5FGL4CgvRdLktKmtVs/
oJEXtFIoCq2ekpW7ul8SdLPq6NVnEtqgHK/swwWYmfLyWh5i11uK8fp3uIO26yaw
rs77+IFZnre/bETeEVgqYfheZMrjGJhxO1QuPeNuSVnRtFCCI5dVN5uuOIhb/Jv1
MJcRkxlX/Wx1nT6wrixOfgce3A5P5P3cZcYd6SboYUyTEOp3DbU5Oi/HBq2pgnYf
2YqzKMLL/WI3iwnjjoc5/SOiHyRmzqH2lgxEHRF+HEpZLWHPbEG7qaVp69/qaLl/
9Ko3F1mdR5Dd0tHAEkhLLxrGR8oqjr59YfhZqYOxBDa9SuudmStdTeTX+HIIPWUR
pYSDxZeHoiXBy6TSnKraihJgGqFe6Yvmu+zGBVuAX/Q+EbLAwI5v10Dvla9lr2MA
xvH4N1nK0kSn4cqTy11pb4AGrNvAyFIXM/5HQkmJ+E0kK/8uK7WvoCgSJkRNRXi8
iq0m84QqlEVrxc2BpS+/
=/Sic
-----END PGP SIGNATURE-----

--ZVOC9e0LfXEId8h2--
