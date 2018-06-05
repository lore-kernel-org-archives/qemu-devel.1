Received: from eggs.gnu.org ([2001:4830:134:3::10]:51101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQ5mI-0001xX-1b
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 02:49:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQ5mE-0005GO-Sr
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 02:49:10 -0400
Received: from 11.mo7.mail-out.ovh.net ([87.98.173.157]:57146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fQ5mE-0005Cc-HZ
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 02:49:06 -0400
Received: from player761.ha.ovh.net (unknown [10.109.122.53])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id A2B11AFD13
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 08:48:56 +0200 (CEST)
Date: Tue, 5 Jun 2018 08:48:42 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180605084842.552faa17@bahia.lan>
In-Reply-To: <20180604075945.GL4251@umbus>
References: <20180530144217.8959-1-joel@jms.id.au>
	<1a47f19a-1791-da8a-d9ad-abe4c1e8e1ce@kaod.org>
	<20180531132733.5e3eca33@bahia.lan> <20180604075945.GL4251@umbus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/6VDYti0xwc6QHLn25=shnTy";
	protocol="application/pgp-signature"
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, Joel Stanley <joel@jms.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Neuling <mikey@neuling.org>, Michael Ellerman <mpe@ellerman.id.au>

--Sig_/6VDYti0xwc6QHLn25=shnTy
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Jun 2018 17:59:45 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, May 31, 2018 at 01:27:33PM +0200, Greg Kurz wrote:
> > On Thu, 31 May 2018 09:38:10 +0200
> > C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >  =20
> > > On 05/30/2018 04:42 PM, Joel Stanley wrote: =20
> > > > The powerpc Linux kernel[1] and skiboot firmware[2] recently gained=
 changes
> > > > that cause the Processor Compatibility Register (PCR) SPR to be cle=
ared.
> > > >=20
> > > > These changes cause Linux to fail to boot on the Qemu powernv machi=
ne
> > > > with an error:
> > > >=20
> > > >  Trying to write privileged spr 338 (0x152) at 0000000030017f0c
> > > >=20
> > > > With this patch Qemu makes this register available as a hypervisor
> > > > privileged register.
> > > >=20
> > > > Note that bits set in this register disable features of the process=
or.
> > > > Currently the only register state that is supported is when the reg=
ister
> > > > is zeroed (enable all features). This is sufficient for guests to
> > > > once again boot.
> > > >=20
> > > > [1] https://lkml.kernel.org/r/20180518013742.24095-1-mikey@neuling.=
org
> > > > [2] https://patchwork.ozlabs.org/patch/915932/
> > > >=20
> > > > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > > > ---
> > > >  target/ppc/helper.h             |  1 +
> > > >  target/ppc/misc_helper.c        | 10 ++++++++++
> > > >  target/ppc/translate_init.inc.c |  9 +++++++--
> > > >  3 files changed, 18 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> > > > index 19453c68138a..d751f0e21909 100644
> > > > --- a/target/ppc/helper.h
> > > > +++ b/target/ppc/helper.h
> > > > @@ -17,6 +17,7 @@ DEF_HELPER_2(pminsn, void, env, i32)
> > > >  DEF_HELPER_1(rfid, void, env)
> > > >  DEF_HELPER_1(hrfid, void, env)
> > > >  DEF_HELPER_2(store_lpcr, void, env, tl)
> > > > +DEF_HELPER_2(store_pcr, void, env, tl)
> > > >  #endif
> > > >  DEF_HELPER_1(check_tlb_flush_local, void, env)
> > > >  DEF_HELPER_1(check_tlb_flush_global, void, env)
> > > > diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> > > > index 8c8cba5cc6f1..40c39d08ad14 100644
> > > > --- a/target/ppc/misc_helper.c
> > > > +++ b/target/ppc/misc_helper.c
> > > > @@ -20,6 +20,7 @@
> > > >  #include "cpu.h"
> > > >  #include "exec/exec-all.h"
> > > >  #include "exec/helper-proto.h"
> > > > +#include "qemu/error-report.h"
> > > > =20
> > > >  #include "helper_regs.h"
> > > > =20
> > > > @@ -186,6 +187,15 @@ void ppc_store_msr(CPUPPCState *env, target_ul=
ong value)
> > > >      hreg_store_msr(env, value, 0);
> > > >  }
> > > > =20
> > > > +void helper_store_pcr(CPUPPCState *env, target_ulong value)
> > > > +{
> > > > +    if (value !=3D 0) {
> > > > +        error_report("Unimplemented PCR value 0x"TARGET_FMT_lx, va=
lue);
> > > > +        return;
> > > > +    }
> > > > +    env->spr[SPR_PCR] =3D value;   =20
> > >=20
> > > shouldn't we use pcc->pcr_mask ? and check pcc->pcr_supported also ?=
=20
> > >  =20
> >=20
> > pcc->pcr_mask and ppc->pcr_supported only make sense for pseries machine
> > types (ie, when the spapr machine code call ppc_*_compat() functions). =
=20
>=20
> That's really not true.  pcr_mask is relevant at the hardware level,
> not just for pseries.  It's the mask of bits that are implemented in
> the PCR for this CPU.
>=20

Oops... dumb me stroke again... So indeed, the pcr_mask should be applied
here, but the (value !=3D 0) check makes sense anyway since TCG currently
ignores the PCR.

> pcr_supported isn't really relevant here regardless of whether we're
> talking about pseries or pnv.  It's basically just a kind of weird
> encoding of which compat modes are supported by the cpu.
>=20
> > The case here is different: we're running a fully emulated pnv machine,
> > ie, PCR can only be set by mtspr() called within the pnv guest. But TCG
> > doesn't implement the compatibility mode logic, ie, the CPU always run
> > in "raw" mode, ie, we only support PCR =3D=3D 0, actually.
> >=20
> > So, this patch looks good for me. I'm just not sure about what is
> > causing the build break with patchew though...
> >  =20
> > > C.
> > >  =20
> > > > +}
> > > > +
> > > >  /* This code is lifted from MacOnLinux. It is called whenever
> > > >   * THRM1,2 or 3 is read an fixes up the values in such a way
> > > >   * that will make MacOS not hang. These registers exist on some
> > > > diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate=
_init.inc.c
> > > > index ab782cb32aaa..bebe6ec5333c 100644
> > > > --- a/target/ppc/translate_init.inc.c
> > > > +++ b/target/ppc/translate_init.inc.c
> > > > @@ -456,6 +456,10 @@ static void spr_write_hid0_601(DisasContext *c=
tx, int sprn, int gprn)
> > > >      /* Must stop the translation as endianness may have changed */
> > > >      gen_stop_exception(ctx);
> > > >  }
> > > > +static void spr_write_pcr(DisasContext *ctx, int sprn, int gprn)
> > > > +{
> > > > +    gen_helper_store_pcr(cpu_env, cpu_gpr[gprn]);
> > > > +}
> > > >  #endif
> > > > =20
> > > >  /* Unified bats */
> > > > @@ -7957,11 +7961,12 @@ static void gen_spr_power6_common(CPUPPCSta=
te *env)
> > > >  #endif
> > > >      /*
> > > >       * Register PCR to report POWERPC_EXCP_PRIV_REG instead of
> > > > -     * POWERPC_EXCP_INVAL_SPR.
> > > > +     * POWERPC_EXCP_INVAL_SPR in userspace. Permit hypervisor acce=
ss.
> > > >       */
> > > > -    spr_register(env, SPR_PCR, "PCR",
> > > > +    spr_register_hv(env, SPR_PCR, "PCR",
> > > >                   SPR_NOACCESS, SPR_NOACCESS,
> > > >                   SPR_NOACCESS, SPR_NOACCESS,
> > > > +                 &spr_read_generic, &spr_write_pcr,
> > > >                   0x00000000);
> > > >  }
> > > > =20
> > > >    =20
> > >=20
> > >  =20
> >  =20
>=20


--Sig_/6VDYti0xwc6QHLn25=shnTy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlsWMkoACgkQcdTV5YIv
c9aJjg/9FADCcZf1jxElymMrSc8QgM5FM4OZzDIEuXFC5k5u/NZQ+BLp1FC9Bfir
RRK6JfN3a/4ygab6IpGJYl/4iyPj8YIxWm6wmBSHAwrjkVTGeeaOMAgmt2VSyMBX
lymZqRp2HvunHmpfaaDR08tzc1mSLfEYQVzDOKFM+rrvfvFFaUPuoM2sxzH2E+o3
eEV57dux2uxZQ96CIU04tYoD69Kkugrjv4OA2J4F2JPfMv2kIVUG5j322aVsS41o
Nx09nZERZHqW8cpTyEeJD9oqkqH2UJC4mnm+E6km8iq6aa62jpZm+LFZOI7FTL0U
CAbsx1E/EHUdz9scWfMIa+9UNCpsmhKIVU2Rd82nseHXL2gGA5HeDxzNbFokv3ha
dgcmBAE9RW4pMZYzFC8LHGSUj+kndldPy0Y8xEn4xh72Ga0YSNO8XX6oZ2vPxGOt
ya/4oDKcYYzB+Yyb7AlP/JqmAh7q7bo8ypzMhjvxQiEZzVR3tVUFSL6onlUgS7Cb
1SHFEi20o2J7EFlPsdflnjBi3OytQNzMmTX20+2RLU8IHX7flQRdJniIZIg/6GdN
y51hL+WP09GXr8g1+J3OSLwoo4DoN0ZSBEzsKMWKRjGamVIfjNiGHxbtmNnPQ1v5
KOAnrzeUG0c+aVG9hKaHoDBQ1UBJj//eXc7wIylitXf6WMtzG+o=
=iRSP
-----END PGP SIGNATURE-----

--Sig_/6VDYti0xwc6QHLn25=shnTy--
