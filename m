Received: from eggs.gnu.org ([2001:4830:134:3::10]:33063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d92xA-0000wl-DH
	for qemu-devel@nongnu.org; Fri, 12 May 2017 01:17:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d92x6-0000Ll-Bi
	for qemu-devel@nongnu.org; Fri, 12 May 2017 01:17:24 -0400
Date: Fri, 12 May 2017 15:16:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170512051610.GC12908@umbus.fritz.box>
References: <20170510200535.13268-1-f4bug@amsat.org>
	<20170510200535.13268-8-f4bug@amsat.org>
	<877f1oyov4.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<3109e990-3c5a-fb7d-515d-af3771ddfa50@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Content-Disposition: inline
In-Reply-To: <3109e990-3c5a-fb7d-515d-af3771ddfa50@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 7/8] target/ppc: optimize various functions
 using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <lvivier@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2017 at 10:48:42PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Hi Nikunj,
>=20
> On 05/11/2017 01:54 AM, Nikunj A Dadhania wrote:
> > Philippe Mathieu-Daud=E9 <f4bug@amsat.org> writes:
> >=20
> > > Applied using Coccinelle script.
> > >=20
> > > Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > > ---
> > >  target/ppc/translate.c              |  9 +++------
> > >  target/ppc/translate/vsx-impl.inc.c | 21 +++++++--------------
> > >  2 files changed, 10 insertions(+), 20 deletions(-)
> > >=20
> > > diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> > > index f40b5a1abf..64ab412bf3 100644
> > > --- a/target/ppc/translate.c
> > > +++ b/target/ppc/translate.c
> > > @@ -868,8 +868,7 @@ static inline void gen_op_arith_add(DisasContext =
*ctx, TCGv ret, TCGv arg1,
> > >              }
> > >              tcg_gen_xor_tl(cpu_ca, t0, t1);        /* bits changed w=
/ carry */
> > >              tcg_temp_free(t1);
> > > -            tcg_gen_shri_tl(cpu_ca, cpu_ca, 32);   /* extract bit 32=
 */
> > > -            tcg_gen_andi_tl(cpu_ca, cpu_ca, 1);
> > > +            tcg_gen_extract_tl(cpu_ca, cpu_ca, 32, 1);
> > >              if (is_isa300(ctx)) {
> > >                  tcg_gen_mov_tl(cpu_ca32, cpu_ca);
> > >              }
> > > @@ -1399,8 +1398,7 @@ static inline void gen_op_arith_subf(DisasConte=
xt *ctx, TCGv ret, TCGv arg1,
> > >              tcg_temp_free(inv1);
> > >              tcg_gen_xor_tl(cpu_ca, t0, t1);         /* bits changes =
w/ carry */
> > >              tcg_temp_free(t1);
> > > -            tcg_gen_shri_tl(cpu_ca, cpu_ca, 32);    /* extract bit 3=
2 */
> > > -            tcg_gen_andi_tl(cpu_ca, cpu_ca, 1);
> > > +            tcg_gen_extract_tl(cpu_ca, cpu_ca, 32, 1);
> > >              if (is_isa300(ctx)) {
> > >                  tcg_gen_mov_tl(cpu_ca32, cpu_ca);
> > >              }
> >=20
> > Above changes are correct.
> >=20
> > Rest of them are wrong as discussed above in the thread with Richard.
> >
>=20
> I tried to correct the cocci script and ran it again (will post in few min
> as v3) and got:
>=20
> $ docker run -it -v `pwd`:`pwd` -w `pwd` petersenna/coccinelle --sp-file
> scripts/coccinelle/tcg_gen_extract.cocci --macro-file
> scripts/cocci-macro-file.h --dir target/ppc
> init_defs_builtins: /usr/lib64/coccinelle/standard.h
> init_defs: scripts/cocci-macro-file.h
> HANDLING: target/ppc/mfrom_table_gen.c
> HANDLING: target/ppc/user_only_helper.c
> HANDLING: target/ppc/mmu-hash64.c
> HANDLING: target/ppc/timebase_helper.c
> HANDLING: target/ppc/gdbstub.c
> HANDLING: target/ppc/translate.c
> candidate at target/ppc/translate.c:5386
>   op_size: tl/tl (same)
>   low_bits: 4 (value: 0xf)
>   len: 0xf
>   len_bits =3D=3D low_bits
>   candidate IS optimizable
>=20
> candidate at target/ppc/translate.c:871
>   op_size: tl/tl (same)
>   low_bits: 1 (value: 0x1)
>   len: 0x1
>   len_bits =3D=3D low_bits
>   candidate IS optimizable
>=20
> candidate at target/ppc/translate.c:1402
>   op_size: tl/tl (same)
>   low_bits: 1 (value: 0x1)
>   len: 0x1
>   len_bits =3D=3D low_bits
>   candidate IS optimizable
>=20
> > > @@ -5383,8 +5381,7 @@ static void gen_mfsri(DisasContext *ctx)
> > >      CHK_SV;
> > >      t0 =3D tcg_temp_new();
> > >      gen_addr_reg_index(ctx, t0);
> > > -    tcg_gen_shri_tl(t0, t0, 28);
> > > -    tcg_gen_andi_tl(t0, t0, 0xF);
> > > +    tcg_gen_extract_tl(t0, t0, 28, 0xF);
> > >      gen_helper_load_sr(cpu_gpr[rd], cpu_env, t0);
> > >      tcg_temp_free(t0);
> > >      if (ra !=3D 0 && ra !=3D rd)
>=20
> 0xF =3D 0b1111 so this one seems correct to, right?

No, I don't think so.  AFAICT tcg_gen_extract_tl() takes a field
width, not a mask as the last parameter.  So this would need to be
	tcg_gen_extract_tl(t0, t0, 28, 4);

Your script needs to do essentially a log-base-2 of the mask.  I don't
know if Coccinelle can do that..

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZFUUaAAoJEGw4ysog2bOS69UP/R2rMG7aT4WSc3fH1pdlsTxw
qVsClpoE8FTz0adJP/F4c6m4Ls8XBQrW1HIQV9nbp3NmlQ3/xtZcIaJFKFzyZhES
N0gngeJbIEytm5caL3FZ0zhHQ2LRQJXZhZ1rnTGcOXjirFgPoXeAPoxZSK/J2r0T
5hI2alY6mYQV615Srmb31TvM4UwWWjeCcG6bFavCSTgXTUgKV9N6rjXUYvbs0jbj
7J9CTc89cU2r1o0Vxx/JwzRlIS+oUJmXr3lcyBxBHk/Hr+CHDrPm5iSIpyZO5xvi
4sqM4sxDYoW6K9RKAf01FAoXlpmQkf4yhw3eSGvOI2QElkGwXr+mnV/YctcIQZ3G
9GpzNqzUD+SfNHf6/iehLozs8cpjnMpgmfBZoznO/VLXdBmoHeqVYDWM/UkniwHy
jb2aTeEqXFTvXzztuwIU/sAFxrHz2wboKl9c3YAMSGyyDl/HaHc7gP0xgXtUF2Aa
eMIHy3DbUevAZ1BiBiDYB7UTiWFqftF2esWGNf/I3zR6TfnCWrR3/B+w1tPDGCfq
Rn8QxFPOi60Dsx23trJ3Mqz7mYCU3RnEPs0ANcYHa8kODq3ONXDSk3vHRomh6w6x
tH7H8+i6e1eGlqc6jaw7h6FxFO3a2u2oVSmSd/9sbEMKY6yXsL1T3IMrlrZj+d2N
APHiP7NOElsdgDjkaFMD
=91zd
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--
