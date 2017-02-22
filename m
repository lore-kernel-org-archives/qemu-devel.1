Received: from eggs.gnu.org ([2001:4830:134:3::10]:38798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgNKW-0001gj-Qh
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:11:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgNKV-0001sL-IO
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:11:00 -0500
Date: Wed, 22 Feb 2017 13:27:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170222022717.GH12577@umbus.fritz.box>
References: <1487585521-19445-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487585521-19445-2-git-send-email-nikunj@linux.vnet.ibm.com>
	<3d0d83c5-0588-649d-5ed0-202a82031a1e@twiddle.net>
	<87bmtwkv7p.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xHbokkKX1kTiQeDC"
Content-Disposition: inline
In-Reply-To: <87bmtwkv7p.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v1 01/10] target/ppc: support for 32-bit
 carry and overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: Richard Henderson <rth@twiddle.net>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com


--xHbokkKX1kTiQeDC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2017 at 10:15:46AM +0530, Nikunj A Dadhania wrote:
> Richard Henderson <rth@twiddle.net> writes:
>=20
> > On 02/20/2017 09:11 PM, Nikunj A Dadhania wrote:
> >> +#ifndef TARGET_PPC64
> >>  static inline target_ulong cpu_read_xer(CPUPPCState *env)
> >>  {
> >>      return env->xer | (env->so << XER_SO) | (env->ov << XER_OV) | (en=
v->ca << XER_CA);
> >>  }
> >> +#else
> >> +static inline target_ulong cpu_read_xer(CPUPPCState *env)
> >> +{
> >> +    return env->xer | (env->so << XER_SO) |
> >> +        (env->ov << XER_OV) | (env->ca << XER_CA) |
> >> +        (env->ov32 << XER_OV32) | (env->ca32 << XER_CA32);
> >> +}
> >> +#endif
> >>
> >> +#ifndef TARGET_PPC64
> >>  static inline void cpu_write_xer(CPUPPCState *env, target_ulong xer)
> >>  {
> >>      env->so =3D (xer >> XER_SO) & 1;
> >> @@ -2355,6 +2371,20 @@ static inline void cpu_write_xer(CPUPPCState *e=
nv, target_ulong xer)
> >>      env->ca =3D (xer >> XER_CA) & 1;
> >>      env->xer =3D xer & ~((1u << XER_SO) | (1u << XER_OV) | (1u << XER=
_CA));
> >>  }
> >> +#else
> >> +static inline void cpu_write_xer(CPUPPCState *env, target_ulong xer)
> >> +{
> >> +    env->so =3D (xer >> XER_SO) & 1;
> >> +    env->ov =3D (xer >> XER_OV) & 1;
> >> +    env->ca =3D (xer >> XER_CA) & 1;
> >> +    env->ov32 =3D (xer >> XER_OV32) & 1;
> >> +    env->ca32 =3D (xer >> XER_CA32) & 1;
> >> +    env->xer =3D xer & ~((1ul << XER_SO) |
> >> +                       (1ul << XER_OV) | (1ul << XER_CA) |
> >> +                       (1ul << XER_OV32) | (1ul << XER_CA32));
> >> +}
> >> +#endif
> >
> > You should probably move both of these out of line now (perhaps cpu.c).
>=20
> Sure.
>=20
>=20
> > You probably don't want to set ov32/ca32 unless the cpu is power9.  I a=
ssume=20
> > that if you attempt to set these bits for power8 they are=20
> > read-as-zero/write-ignore?
>=20
> Sure, will make it CPU specific.

Right, and given you need a CPU model check anyway, I don't see that
there's any benefit to splitting out the 32-bit build version versus
the 64-bit build version.

> >> @@ -3715,6 +3719,12 @@ static void gen_read_xer(TCGv dst)
> >>      tcg_gen_or_tl(t0, t0, t1);
> >>      tcg_gen_or_tl(dst, dst, t2);
> >>      tcg_gen_or_tl(dst, dst, t0);
> >> +#ifdef TARGET_PPC64
> >> +    tcg_gen_shli_tl(t0, cpu_ov32, XER_OV32);
> >> +    tcg_gen_or_tl(dst, dst, t0);
> >> +    tcg_gen_shli_tl(t0, cpu_ca32, XER_CA32);
> >> +    tcg_gen_or_tl(dst, dst, t0);
> >> +#endif
> >>      tcg_temp_free(t0);
> >>      tcg_temp_free(t1);
> >>      tcg_temp_free(t2);
> >> @@ -3727,9 +3737,14 @@ static void gen_write_xer(TCGv src)
> >>      tcg_gen_shri_tl(cpu_so, src, XER_SO);
> >>      tcg_gen_shri_tl(cpu_ov, src, XER_OV);
> >>      tcg_gen_shri_tl(cpu_ca, src, XER_CA);
> >> +    tcg_gen_shri_tl(cpu_ov32, src, XER_OV32);
> >> +    tcg_gen_shri_tl(cpu_ca32, src, XER_CA32);
> >>      tcg_gen_andi_tl(cpu_so, cpu_so, 1);
> >>      tcg_gen_andi_tl(cpu_ov, cpu_ov, 1);
> >>      tcg_gen_andi_tl(cpu_ca, cpu_ca, 1);
> >> +    tcg_gen_andi_tl(cpu_ov32, cpu_ov32, 1);
> >> +    tcg_gen_andi_tl(cpu_ca32, cpu_ca32, 1);
> >> +
> >>  }
> >
> > Watch the blank lines.  No ifdef here on the write side?
>=20
> Right, will add.
>=20
> Regards
> Nikunj
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xHbokkKX1kTiQeDC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrPcFAAoJEGw4ysog2bOSToIP/j0kfpAYiq8xIQQRcFaRqo4t
MoOA9se/cN5F1mxz8weo28ap0SVqvPqg37AwvovnYCYEuwehg9saZIOxw5omqzs2
+QFAcNz4k0PktUTqJey3e6Btzf5IjwDeNUoI/jewur1G+Tivcsu96r2keFILjyhQ
mDkeDXIzyOUFVHDIrd1D46TrhIPmpu6yjo52zNF/uZolDUMIRknaqTAn6suWxZd7
+BOSz/Ks1TimgD+HE99jRawDMNz1pzwvisTtrc1aznVfE26KPZjjzdPG8Hu4PnrW
LW43RuW7D2hSoiKYEhaIRvE3W7uhRadCO2HAUaluDAroTSaKZTGDJiOrUbagR3uA
NVbWBy7Wxc9IZ8/xAtzSJyPy61f5c/NmwLR/mIg+YtmoJDww4xG/Kj3Dqe6vjuh6
YeT84x05vZK73kArLYbEDBd8tG4Gg7Gam21YJDOmPeaXLnvE+AVGAVAyYKa86sjC
FyrHUbyDV9vmSzwBdYNUM4n3pfYBo9rEi0Oi8wi6ME04sKa+RAfjIJu7DWuZ3laF
kG1rHXA1cXNIBfzJYHI+eO9t8UTvdajeh+eW/uTMoJ4ZiE2xI/Je1g33B2+kIVLw
uNwBBdoZgl2OtIX78ZnSlyP+l3VcAsmcMwZ0x69TrgWWF0gIdjQHo2lU7WsXpzFQ
QpyCemg46Ue+Btzb9SsT
=tCkX
-----END PGP SIGNATURE-----

--xHbokkKX1kTiQeDC--
