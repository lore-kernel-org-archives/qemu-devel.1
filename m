Received: from eggs.gnu.org ([2001:4830:134:3::10]:50805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fPkPH-0001Sm-Aq
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:00:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fPkPF-0008DZ-MM
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 03:59:59 -0400
Date: Mon, 4 Jun 2018 17:59:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180604075945.GL4251@umbus>
References: <20180530144217.8959-1-joel@jms.id.au>
	<1a47f19a-1791-da8a-d9ad-abe4c1e8e1ce@kaod.org>
	<20180531132733.5e3eca33@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HBg0C3yr6HVa1ZCc"
Content-Disposition: inline
In-Reply-To: <20180531132733.5e3eca33@bahia.lan>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc: Allow privileged
 access to SPR_PCR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Joel Stanley <joel@jms.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Neuling <mikey@neuling.org>, Michael Ellerman <mpe@ellerman.id.au>


--HBg0C3yr6HVa1ZCc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 31, 2018 at 01:27:33PM +0200, Greg Kurz wrote:
> On Thu, 31 May 2018 09:38:10 +0200
> C=E9dric Le Goater <clg@kaod.org> wrote:
>=20
> > On 05/30/2018 04:42 PM, Joel Stanley wrote:
> > > The powerpc Linux kernel[1] and skiboot firmware[2] recently gained c=
hanges
> > > that cause the Processor Compatibility Register (PCR) SPR to be clear=
ed.
> > >=20
> > > These changes cause Linux to fail to boot on the Qemu powernv machine
> > > with an error:
> > >=20
> > >  Trying to write privileged spr 338 (0x152) at 0000000030017f0c
> > >=20
> > > With this patch Qemu makes this register available as a hypervisor
> > > privileged register.
> > >=20
> > > Note that bits set in this register disable features of the processor.
> > > Currently the only register state that is supported is when the regis=
ter
> > > is zeroed (enable all features). This is sufficient for guests to
> > > once again boot.
> > >=20
> > > [1] https://lkml.kernel.org/r/20180518013742.24095-1-mikey@neuling.org
> > > [2] https://patchwork.ozlabs.org/patch/915932/
> > >=20
> > > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > > ---
> > >  target/ppc/helper.h             |  1 +
> > >  target/ppc/misc_helper.c        | 10 ++++++++++
> > >  target/ppc/translate_init.inc.c |  9 +++++++--
> > >  3 files changed, 18 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> > > index 19453c68138a..d751f0e21909 100644
> > > --- a/target/ppc/helper.h
> > > +++ b/target/ppc/helper.h
> > > @@ -17,6 +17,7 @@ DEF_HELPER_2(pminsn, void, env, i32)
> > >  DEF_HELPER_1(rfid, void, env)
> > >  DEF_HELPER_1(hrfid, void, env)
> > >  DEF_HELPER_2(store_lpcr, void, env, tl)
> > > +DEF_HELPER_2(store_pcr, void, env, tl)
> > >  #endif
> > >  DEF_HELPER_1(check_tlb_flush_local, void, env)
> > >  DEF_HELPER_1(check_tlb_flush_global, void, env)
> > > diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> > > index 8c8cba5cc6f1..40c39d08ad14 100644
> > > --- a/target/ppc/misc_helper.c
> > > +++ b/target/ppc/misc_helper.c
> > > @@ -20,6 +20,7 @@
> > >  #include "cpu.h"
> > >  #include "exec/exec-all.h"
> > >  #include "exec/helper-proto.h"
> > > +#include "qemu/error-report.h"
> > > =20
> > >  #include "helper_regs.h"
> > > =20
> > > @@ -186,6 +187,15 @@ void ppc_store_msr(CPUPPCState *env, target_ulon=
g value)
> > >      hreg_store_msr(env, value, 0);
> > >  }
> > > =20
> > > +void helper_store_pcr(CPUPPCState *env, target_ulong value)
> > > +{
> > > +    if (value !=3D 0) {
> > > +        error_report("Unimplemented PCR value 0x"TARGET_FMT_lx, valu=
e);
> > > +        return;
> > > +    }
> > > +    env->spr[SPR_PCR] =3D value; =20
> >=20
> > shouldn't we use pcc->pcr_mask ? and check pcc->pcr_supported also ?=20
> >=20
>=20
> pcc->pcr_mask and ppc->pcr_supported only make sense for pseries machine
> types (ie, when the spapr machine code call ppc_*_compat() functions).

That's really not true.  pcr_mask is relevant at the hardware level,
not just for pseries.  It's the mask of bits that are implemented in
the PCR for this CPU.

pcr_supported isn't really relevant here regardless of whether we're
talking about pseries or pnv.  It's basically just a kind of weird
encoding of which compat modes are supported by the cpu.

> The case here is different: we're running a fully emulated pnv machine,
> ie, PCR can only be set by mtspr() called within the pnv guest. But TCG
> doesn't implement the compatibility mode logic, ie, the CPU always run
> in "raw" mode, ie, we only support PCR =3D=3D 0, actually.
>=20
> So, this patch looks good for me. I'm just not sure about what is
> causing the build break with patchew though...
>=20
> > C.
> >=20
> > > +}
> > > +
> > >  /* This code is lifted from MacOnLinux. It is called whenever
> > >   * THRM1,2 or 3 is read an fixes up the values in such a way
> > >   * that will make MacOS not hang. These registers exist on some
> > > diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_i=
nit.inc.c
> > > index ab782cb32aaa..bebe6ec5333c 100644
> > > --- a/target/ppc/translate_init.inc.c
> > > +++ b/target/ppc/translate_init.inc.c
> > > @@ -456,6 +456,10 @@ static void spr_write_hid0_601(DisasContext *ctx=
, int sprn, int gprn)
> > >      /* Must stop the translation as endianness may have changed */
> > >      gen_stop_exception(ctx);
> > >  }
> > > +static void spr_write_pcr(DisasContext *ctx, int sprn, int gprn)
> > > +{
> > > +    gen_helper_store_pcr(cpu_env, cpu_gpr[gprn]);
> > > +}
> > >  #endif
> > > =20
> > >  /* Unified bats */
> > > @@ -7957,11 +7961,12 @@ static void gen_spr_power6_common(CPUPPCState=
 *env)
> > >  #endif
> > >      /*
> > >       * Register PCR to report POWERPC_EXCP_PRIV_REG instead of
> > > -     * POWERPC_EXCP_INVAL_SPR.
> > > +     * POWERPC_EXCP_INVAL_SPR in userspace. Permit hypervisor access.
> > >       */
> > > -    spr_register(env, SPR_PCR, "PCR",
> > > +    spr_register_hv(env, SPR_PCR, "PCR",
> > >                   SPR_NOACCESS, SPR_NOACCESS,
> > >                   SPR_NOACCESS, SPR_NOACCESS,
> > > +                 &spr_read_generic, &spr_write_pcr,
> > >                   0x00000000);
> > >  }
> > > =20
> > >  =20
> >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HBg0C3yr6HVa1ZCc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsU8W4ACgkQbDjKyiDZ
s5JE0xAAxOtO/2VWanxqx+583CNoYxo99imcOKGIcEzbS52w1imOsrG0RV2HYt97
hxwsc526WgaJF5FKKRb31Nak7IwCjbi0AK78b5AOiGqmPU25k73Bc+wZ5bTC/RJw
io/ALOD10ulvIzH9EWlRcXCLa6t5DIsZomyzRmNaD5C24DQWHCg68dOxbfYSnGh6
gALuJUy9nxDnAErSeaeelL8WqsQ5G4eeipzJgc3O73YrvsKteTZuoXNHqHTQgwLV
BPOb39r7ClgPg1Ie6sd+OKBoe1oZjdmHrjmiB4vUe3VmE8ow7DbR7zBqSYUVgXX8
c+J/IuTQOOImj5cd6GhSkl2LUE/x3ItxT/Dzn5f+EDojmTlJlbAYeIlCYFntlTkH
ec18BNPkCVHSAEXCv9ovZiuUF1pbs86eqVx+Ac98IBZNd/wMssoYaxNR+3Ncx2yk
VYm2ULUzQegBq/HOsu+fylUkpzn6AlqGpoctjiLszAg556x1qtVMXFf3S4JYLryJ
BQrxUa7CZ6+1ENDO7ec4hbhc/OKBT6j/Y7jxf5bYGvU15uLXB3CZwlr5Vysv/W/y
4CfzUahdU5ONg1XgV1eKIA2TzCGudRxwoPqY68WEcvuc/jR/ydBXgYYgB2uJ04y3
VZNV5lMTS1C1uNJH5YMvfla8ODHFKmcAkVKXdrtNqo8FJCinL9w=
=AjAA
-----END PGP SIGNATURE-----

--HBg0C3yr6HVa1ZCc--
