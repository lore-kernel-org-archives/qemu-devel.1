Received: from eggs.gnu.org ([2001:4830:134:3::10]:44693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d10XU-0006qY-Qf
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 21:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d10XR-0006uj-Lo
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 21:05:40 -0400
Received: from ozlabs.org ([103.22.144.67]:55709)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1d10XR-0006sg-8y
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 21:05:37 -0400
Date: Thu, 20 Apr 2017 10:51:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170420005112.GB13992@umbus.fritz.box>
References: <1492620502-71509-1-git-send-email-bernhard.kaindl@thalesgroup.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline
In-Reply-To: <1492620502-71509-1-git-send-email-bernhard.kaindl@thalesgroup.com>
Subject: Re: [Qemu-devel] [PATCH] e500,
 book3s: mfspr 259: Register mapped/aliased SPRG3 user read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bernhard Kaindl <bernhard.kaindl@thalesgroup.com>
Cc: qemu-devel@nongnu.org


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2017 at 06:48:22PM +0200, Bernhard Kaindl wrote:
> This patch registers mfspr 259 for Book3S and e500 family cores
> following this research:
>=20
> mfspr 259 provides read-only mapped user access to SPRG3(SPR 275) accordi=
ng to:
>=20
> - PowerISA 2.02, Book III (documents implementation starting with POWER4+=
 @ p20)
> - IBM PowerPC 970MP RISC Microprocessor User's Manual v2.1, page 48
> - Amit Singh: "Mac OS X Internals: A Systems Approach" on 970 and 970FX c=
ores:
>   He demonstrates mfspr 259 reading TLS data from Mac OS X on G5 on page =
588
> - NXP documents it in the Core Reference Manuals of: e500, e500mc and e55=
00
> - getcpu() of the 32 & 64-bit Book3S Linux vDSOs use it to read the core =
number
>=20
> mfspr 259 does not appear to be implemented in these cores according to:
>=20
> - 74xx series: MPC7410/MPC7400 and MPC7450 RISC Microprocessor Reference =
Manuals
> - 4xx series:  PPC440 Processor User's Manual, Revision 1.09 by AMCC
> - 750 series:  IBM PowerPC 750CL RISC Microprocessor User's Manual
> - e200 series: e200z4 Power Architecture=E2 Core Reference Manual
>=20
> Implementation: gen_spr_usprg3() is called from init_proc_book3s_common()
> (covers the 970 and POWER cores) and init_proc_e500() (covers the e500 fa=
mily)
> to register spr_read_ureg() in the same way which it already provides
> the mapped SPR access for SPR_USPRG4-7 in gen_spr_usprgh() for cores
> which have the same read-only mapped SPRG register access for SPRG4-7.
>=20
> Verified using Linux by pinning a thread to a core and checking sched_get=
cpu()
> using qemu-system-ppc64 -M pseries -cpu POWER8 using MTTCG on a x86_64 ho=
st.
>=20
> Signed-off-by: Bernhard Kaindl <bernhard.kaindl@thalesgroup.com>
> Reviewed-by: Stefan Resch <stefan.resch@thalesgroup.com>

Applied to ppc-for-2.10. thanks.

> ---
>  target/ppc/translate_init.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 77e5463..0ecf541 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -1640,6 +1640,14 @@ static void spr_write_booke_pid (DisasContext *ctx=
, int sprn, int gprn)
>  }
>  #endif
> =20
> +static void gen_spr_usprg3 (CPUPPCState *env)
> +{
> +    spr_register(env, SPR_USPRG3, "USPRG3",
> +                 &spr_read_ureg, SPR_NOACCESS,
> +                 &spr_read_ureg, SPR_NOACCESS,
> +                 0x00000000);
> +}
> +
>  static void gen_spr_usprgh (CPUPPCState *env)
>  {
>      spr_register(env, SPR_USPRG4, "USPRG4",
> @@ -4914,6 +4922,7 @@ static void init_proc_e500 (CPUPPCState *env, int v=
ersion)
>              break;
>      }
>      gen_spr_BookE(env, ivor_mask);
> +    gen_spr_usprg3(env);
>      /* Processor identification */
>      spr_register(env, SPR_BOOKE_PIR, "PIR",
>                   SPR_NOACCESS, SPR_NOACCESS,
> @@ -8245,6 +8254,7 @@ static void init_proc_book3s_common(CPUPPCState *en=
v)
>  {
>      gen_spr_ne_601(env);
>      gen_tbl(env);
> +    gen_spr_usprg3(env);
>      gen_spr_book3s_altivec(env);
>      gen_spr_book3s_pmu_sup(env);
>      gen_spr_book3s_pmu_user(env);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY+AX9AAoJEGw4ysog2bOSYzcQANndVPbvAVi32O3b/kvDz1Mk
q3vf6GsGzkx/fiPjq9j6uW4JNHLvUJ/abgLD/OeAmFWh2NoM51kcbblcpObkHqab
rnGeLaf/u5A3w28VHiJuGES7W642wUElZ19HFUJbXxOBbnE3S7Ut5HgFw/iawuBH
A+2x2kFw6nrPPE2C/XuCKMc3XiLDpJ7RBCXGYUkD0CBTdXgBD/UG//fwVmrTmEVN
oxZG0gXNLJm+SWKF3WBiJ5S4kqFDO5N3Np704hmT2NJBDfjImhaun7JYyJ6FQqxy
YGz/Ge+vEx6OT6liESHuNbUSvPwDaSJsSmoq58LZEdsUUbXxwgSD6kLEHjKXro+d
wH60FJiD3SezodCbP01A5MKLbExxQ5pHJT0ymiN7uqs9vWJ0UfzUsI/fqBZ+RlA+
skSJSKGoDaAr0KtqEgEdIn64rnz/0UffHC77U7WwiDQzzJK1ruNtwSJsGlKeXk95
Lgjn9kE6WriYB/s/Oysf2YIWZYom3RaqmPRqcTKPolIUPjOfbyqsFUyC8Fhcs0eA
lGRKb4Bu7Hsfa16aSAWGIGwv+fuimh35OKCfRODGsQA/cLG/1PH7HLyjhkyjCMKq
XID9OSXNOY0h23D0auR5ZbJMDIBNCFX5KZrUncPeCUsmTkSLMIn5Txsl61Yo9z6+
cjbBTaGP1qfreRyGtk0Q
=jFiz
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
