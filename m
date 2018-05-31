Received: from eggs.gnu.org ([2001:4830:134:3::10]:56780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fOLkM-0000Ta-TF
	for qemu-devel@nongnu.org; Thu, 31 May 2018 07:28:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fOLkJ-00056S-Nj
	for qemu-devel@nongnu.org; Thu, 31 May 2018 07:27:58 -0400
Received: from 2.mo4.mail-out.ovh.net ([46.105.72.36]:39086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fOLkJ-0004zD-F4
	for qemu-devel@nongnu.org; Thu, 31 May 2018 07:27:55 -0400
Received: from player692.ha.ovh.net (unknown [10.109.122.84])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id B3B5A17C210
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 13:27:44 +0200 (CEST)
Date: Thu, 31 May 2018 13:27:33 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180531132733.5e3eca33@bahia.lan>
In-Reply-To: <1a47f19a-1791-da8a-d9ad-abe4c1e8e1ce@kaod.org>
References: <20180530144217.8959-1-joel@jms.id.au>
	<1a47f19a-1791-da8a-d9ad-abe4c1e8e1ce@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Neuling <mikey@neuling.org>, Michael Ellerman <mpe@ellerman.id.au>

On Thu, 31 May 2018 09:38:10 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 05/30/2018 04:42 PM, Joel Stanley wrote:
> > The powerpc Linux kernel[1] and skiboot firmware[2] recently gained cha=
nges
> > that cause the Processor Compatibility Register (PCR) SPR to be cleared.
> >=20
> > These changes cause Linux to fail to boot on the Qemu powernv machine
> > with an error:
> >=20
> >  Trying to write privileged spr 338 (0x152) at 0000000030017f0c
> >=20
> > With this patch Qemu makes this register available as a hypervisor
> > privileged register.
> >=20
> > Note that bits set in this register disable features of the processor.
> > Currently the only register state that is supported is when the register
> > is zeroed (enable all features). This is sufficient for guests to
> > once again boot.
> >=20
> > [1] https://lkml.kernel.org/r/20180518013742.24095-1-mikey@neuling.org
> > [2] https://patchwork.ozlabs.org/patch/915932/
> >=20
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> >  target/ppc/helper.h             |  1 +
> >  target/ppc/misc_helper.c        | 10 ++++++++++
> >  target/ppc/translate_init.inc.c |  9 +++++++--
> >  3 files changed, 18 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> > index 19453c68138a..d751f0e21909 100644
> > --- a/target/ppc/helper.h
> > +++ b/target/ppc/helper.h
> > @@ -17,6 +17,7 @@ DEF_HELPER_2(pminsn, void, env, i32)
> >  DEF_HELPER_1(rfid, void, env)
> >  DEF_HELPER_1(hrfid, void, env)
> >  DEF_HELPER_2(store_lpcr, void, env, tl)
> > +DEF_HELPER_2(store_pcr, void, env, tl)
> >  #endif
> >  DEF_HELPER_1(check_tlb_flush_local, void, env)
> >  DEF_HELPER_1(check_tlb_flush_global, void, env)
> > diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> > index 8c8cba5cc6f1..40c39d08ad14 100644
> > --- a/target/ppc/misc_helper.c
> > +++ b/target/ppc/misc_helper.c
> > @@ -20,6 +20,7 @@
> >  #include "cpu.h"
> >  #include "exec/exec-all.h"
> >  #include "exec/helper-proto.h"
> > +#include "qemu/error-report.h"
> > =20
> >  #include "helper_regs.h"
> > =20
> > @@ -186,6 +187,15 @@ void ppc_store_msr(CPUPPCState *env, target_ulong =
value)
> >      hreg_store_msr(env, value, 0);
> >  }
> > =20
> > +void helper_store_pcr(CPUPPCState *env, target_ulong value)
> > +{
> > +    if (value !=3D 0) {
> > +        error_report("Unimplemented PCR value 0x"TARGET_FMT_lx, value);
> > +        return;
> > +    }
> > +    env->spr[SPR_PCR] =3D value; =20
>=20
> shouldn't we use pcc->pcr_mask ? and check pcc->pcr_supported also ?=20
>=20

pcc->pcr_mask and ppc->pcr_supported only make sense for pseries machine
types (ie, when the spapr machine code call ppc_*_compat() functions).

The case here is different: we're running a fully emulated pnv machine,
ie, PCR can only be set by mtspr() called within the pnv guest. But TCG
doesn't implement the compatibility mode logic, ie, the CPU always run
in "raw" mode, ie, we only support PCR =3D=3D 0, actually.

So, this patch looks good for me. I'm just not sure about what is
causing the build break with patchew though...

> C.
>=20
> > +}
> > +
> >  /* This code is lifted from MacOnLinux. It is called whenever
> >   * THRM1,2 or 3 is read an fixes up the values in such a way
> >   * that will make MacOS not hang. These registers exist on some
> > diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_ini=
t.inc.c
> > index ab782cb32aaa..bebe6ec5333c 100644
> > --- a/target/ppc/translate_init.inc.c
> > +++ b/target/ppc/translate_init.inc.c
> > @@ -456,6 +456,10 @@ static void spr_write_hid0_601(DisasContext *ctx, =
int sprn, int gprn)
> >      /* Must stop the translation as endianness may have changed */
> >      gen_stop_exception(ctx);
> >  }
> > +static void spr_write_pcr(DisasContext *ctx, int sprn, int gprn)
> > +{
> > +    gen_helper_store_pcr(cpu_env, cpu_gpr[gprn]);
> > +}
> >  #endif
> > =20
> >  /* Unified bats */
> > @@ -7957,11 +7961,12 @@ static void gen_spr_power6_common(CPUPPCState *=
env)
> >  #endif
> >      /*
> >       * Register PCR to report POWERPC_EXCP_PRIV_REG instead of
> > -     * POWERPC_EXCP_INVAL_SPR.
> > +     * POWERPC_EXCP_INVAL_SPR in userspace. Permit hypervisor access.
> >       */
> > -    spr_register(env, SPR_PCR, "PCR",
> > +    spr_register_hv(env, SPR_PCR, "PCR",
> >                   SPR_NOACCESS, SPR_NOACCESS,
> >                   SPR_NOACCESS, SPR_NOACCESS,
> > +                 &spr_read_generic, &spr_write_pcr,
> >                   0x00000000);
> >  }
> > =20
> >  =20
>=20
>=20
