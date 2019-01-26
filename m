Received: from eggs.gnu.org ([209.51.188.92]:46519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gnZIp-0005aB-OB
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 20:32:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gnZIo-0001zr-LQ
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 20:32:03 -0500
Date: Sat, 26 Jan 2019 14:50:06 +1300
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190126015006.GB22942@umbus>
References: <20190122170112.8706-1-farosas@linux.ibm.com>
	<20190122170112.8706-3-farosas@linux.ibm.com>
	<30929550-4e18-6c43-1d8f-d4065ec70544@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
In-Reply-To: <30929550-4e18-6c43-1d8f-d4065ec70544@ozlabs.ru>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v4 2/3] target/ppc: Add GDB
 callbacks for SPRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Fabiano Rosas <farosas@linux.ibm.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, groug@kaod.org, Richard Henderson <richard.henderson@linaro.org>


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 24, 2019 at 06:20:02PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 23/01/2019 04:01, Fabiano Rosas wrote:
> > These will be used to let GDB know about PPC's Special Purpose
> > Registers (SPR).
> >=20
> > They take an index based on the order the registers appear in the XML
> > file sent by QEMU to GDB. This index does not match the actual
> > location of the registers in the env->spr array so the
> > gdb_find_spr_idx function does that conversion.
> >=20
> > Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
> > ---
> >  target/ppc/translate_init.inc.c | 54 ++++++++++++++++++++++++++++++++-
> >  1 file changed, 53 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_ini=
t.inc.c
> > index 710064a25d..f29ac3558a 100644
> > --- a/target/ppc/translate_init.inc.c
> > +++ b/target/ppc/translate_init.inc.c
> > @@ -9487,6 +9487,55 @@ static bool avr_need_swap(CPUPPCState *env)
> >  #endif
> >  }
> > =20
> > +#if !defined(CONFIG_USER_ONLY)
> > +static int gdb_find_spr_idx(CPUPPCState *env, int n)
> > +{
> > +    int i;
> > +
> > +    for (i =3D 0; i < ARRAY_SIZE(env->spr_cb); i++) {
> > +        ppc_spr_t *spr =3D &env->spr_cb[i];
> > +
> > +        if (spr->name && spr->gdb_id =3D=3D n) {
> > +            return i;
> > +        }
> > +    }
> > +    return -1;
> > +}
> > +
> > +static int gdb_get_spr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
> > +{
> > +    int reg;
> > +    int len;
> > +
> > +    reg =3D gdb_find_spr_idx(env, n);
> > +    if (reg < 0) {
> > +        return 0;
> > +    }
> > +
> > +    len =3D TARGET_LONG_SIZE;
> > +    stn_p(mem_buf, len, env->spr[reg]);
> > +    ppc_maybe_bswap_register(env, mem_buf, len);
>=20
>=20
> I am confused by this as it produces different results depending on the
> guest mode:


Hm, yeah, I thought the bswap here looked odd, but it wasn't obvious
to me if it was bogus here, or just a bogus gdb interface we have to
work around.

> (gdb) p $pvr
> $1 =3D 0x14c0000000000
> (gdb) c
> Continuing.
> Program received signal SIGINT, Interrupt.
> (gdb) p $pvr
> $2 =3D 0x4c0100

But that behaviour definitely looks wrong.

> First print is when I stopped the guest in the SLOF firmware (so it is
> big-endian) and then I continued and stopped gdb when the guest booted a
> little-endian system; the KVM host is little endian, the machine running
> gdb is LE too.
>=20
> QEMU monitor prints the same 0x4c0100 in both cases.
>=20
> I am adding the inventor of maybe_bswap_register() in cc: for
> assistance. Swapping happens:
> - once for BE: after stn_p()
> 	*(unsigned long *)mem_buf is 0x14c0000000000
> - twice for LE.
>=20
>=20
>=20
>=20
>=20
> > +    return len;
> > +}
> > +
> > +static int gdb_set_spr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
> > +{
> > +    int reg;
> > +    int len;
> > +
> > +    reg =3D gdb_find_spr_idx(env, n);
> > +    if (reg < 0) {
> > +        return 0;
> > +    }
> > +
> > +    len =3D TARGET_LONG_SIZE;
> > +    ppc_maybe_bswap_register(env, mem_buf, len);
> > +    env->spr[reg] =3D ldn_p(mem_buf, len);
> > +
> > +    return len;
> > +}
> > +#endif
> > +
> >  static int gdb_get_float_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
> >  {
> >      if (n < 32) {
> > @@ -9716,7 +9765,10 @@ static void ppc_cpu_realize(DeviceState *dev, Er=
ror **errp)
> >          gdb_register_coprocessor(cs, gdb_get_vsx_reg, gdb_set_vsx_reg,
> >                                   32, "power-vsx.xml", 0);
> >      }
> > -
> > +#ifndef CONFIG_USER_ONLY
> > +    gdb_register_coprocessor(cs, gdb_get_spr_reg, gdb_set_spr_reg,
> > +                             pcc->gdb_num_sprs, "power-spr.xml", 0);
> > +#endif
> >      qemu_init_vcpu(cs);
> > =20
> >      pcc->parent_realize(dev, errp);
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxLvM0ACgkQbDjKyiDZ
s5JuhQ//XcRTfnTG9TPDG0nQf5WFgulF4N2JX+S7ZZjIjKgYPeSb6ibeekT1AN/U
v3v2VFq/DdzAqA3BC8OuEyA2yQQz4S3xRdLgPGKhGNUDT4jqCgwrVCvgBKUlgyq+
kmuq5VqngoYKtJ/0tsO5pHWfWBIanljEmF2ux5R9eQudFlhQd5o78Q5o61V561+H
DHfjoK6wPkwoaZ89VoZ1GBfPv/XIyXtqxtvnClOpp0JUr0msLW63jpMd+nH2ivc7
anJzEfRoG100sxbvr0SkFgxzbeVeTp72iS4enT//yn5SdtCGD1UP6FNhuK7HCKkt
UuE+xIktECWPqtMhuWmttV1QkjTauwTkDL7L9if1Tf3j/OELJ8eb+8uVoR2Bq40L
2LafyldC1kQ/Bw/kMLVsx1CR94uu2XHLD88NnfAkcnFK3Qmv/5UdpXMGpNwVM0iO
UfjDx6lxkMdW5VHvOo4RzDKLhSS8vwj8fYiZb6x+rKw7zJFotGwKgTI3Y+Va9gFT
GeBdlI/DVe4LDvBCAQnt3js8Rr4ZwNSIitkLzfQ9AORBD+2KQCwcUeyRvYpENO1Y
42Bl5jXADuEQoxUY/VjdbMxn1FnWzCk3P+fBzazadAbzXRg+7YYuOV49zeH5reHj
NKfBGTyImZJNOckfFg6k9xicIZM+RzNJC4yTEctNMOwzMJBMEJA=
=snXt
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
