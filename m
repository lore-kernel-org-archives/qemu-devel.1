Received: from eggs.gnu.org ([2001:4830:134:3::10]:50611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fT104-0001pa-Hj
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fT0zz-0003bP-T8
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:19:28 -0400
Received: from 4.mo5.mail-out.ovh.net ([178.33.111.247]:34606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fT0zz-0003a0-Hh
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:19:23 -0400
Received: from player728.ha.ovh.net (unknown [10.109.122.16])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id E84851C0E47
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 10:19:21 +0200 (CEST)
Date: Wed, 13 Jun 2018 10:19:15 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180613101915.4cc9485b@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20180613004506.GM30690@umbus.fritz.box>
References: <152882087494.112322.15549780953419438229.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<152882305541.114463.3137854902721347235.stgit@bahia.lan>
	<20180613004506.GM30690@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/p5Yo5Ytw/SRV/gsPkPSn258";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 3/3] target/ppc: filter out non-zero PCR
 values when using TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

--Sig_/p5Yo5Ytw/SRV/gsPkPSn258
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Jun 2018 10:45:06 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Jun 12, 2018 at 07:04:15PM +0200, Greg Kurz wrote:
> > Bits set in the PCR disable features of the processor. TCG currently
> > doesn't implement that, ie, we always act like if PCR is all zeros.
> >=20
> > But it is still possible for the PCR to have a non-null value. This may
> > confuse the guest.
> >=20
> > There are three distinct cases:
> >=20
> > 1) a powernv guest doing mtspr SPR_PCR
> >=20
> > 2) reset of a pseries guest if the max-cpu-compat machine property is s=
et
> >=20
> > 3) CAS of a pseries guest
> >=20
> > This patch adds a ppc_store_pcr() helper that ensures we cannot put
> > a non-null value in the PCR when using TCG. This helper also has
> > error propagation support, so that each case listed above can be
> > handled appropriately:
> >=20
> > 1) since the powernv machine is mostly used for OpenPOWER FW devel,
> >    we just print an error and let QEMU continue execution
> >=20
> > 2) an error is printed and QEMU exits, ie, same behaviour as when
> >    KVM doesn't support the requested compat mode
> >=20
> > 3) an error is printed and QEMU reports H_HARDWARE to the guest
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> I'm not really convinced this is a good idea.  Printing a (non fatal)
> error if the guest attempts to write a non-zero value to the PCR
> should be ok.  However, you're generating a fatal error if the machine
> tries to set the PCR in TCG mode.  That could easily happen using,
> e.g. the cap-htm flag on a TCG guest.  That would take TCG from mostly
> working, to refusing to run at all.
>=20

I'm confused... I don't see anything related to HTM in TCG. Also we have
the following in cap_htm_apply():

    if (tcg_enabled()) {
        error_setg(errp,
                   "No Transactional Memory support in TCG, try cap-htm=3Do=
ff");

I'm probably missing something... can you enlighten me ?

> > ---
> >  target/ppc/compat.c      |   26 ++++++++++++++++++++++++--
> >  target/ppc/cpu.h         |    3 +++
> >  target/ppc/misc_helper.c |    9 ++++++---
> >  3 files changed, 33 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/target/ppc/compat.c b/target/ppc/compat.c
> > index 807c906f6848..08aa99e6ad47 100644
> > --- a/target/ppc/compat.c
> > +++ b/target/ppc/compat.c
> > @@ -138,8 +138,8 @@ void ppc_set_compat(PowerPCCPU *cpu, uint32_t compa=
t_pvr, Error **errp)
> >  {
> >      const CompatInfo *compat =3D compat_by_pvr(compat_pvr);
> >      CPUPPCState *env =3D &cpu->env;
> > -    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> >      uint64_t pcr;
> > +    Error *local_err =3D NULL;
> > =20
> >      if (!compat_pvr) {
> >          pcr =3D 0;
> > @@ -165,8 +165,30 @@ void ppc_set_compat(PowerPCCPU *cpu, uint32_t comp=
at_pvr, Error **errp)
> >          }
> >      }
> > =20
> > +    ppc_store_pcr(env, pcr, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +
> >      cpu->compat_pvr =3D compat_pvr;
> > -    env->spr[SPR_PCR] =3D pcr & pcc->pcr_mask;
> > +}
> > +
> > +void ppc_store_pcr(CPUPPCState *env, target_ulong value, Error **errp)
> > +{
> > +    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> > +    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> > +
> > +    /* TODO: this check should go away once we actually put the proper=
 PCR
> > +     * checks in the various bits of TCG that should have them.
> > +     */
> > +    if (!kvm_enabled() && value !=3D 0) {
> > +        error_setg(errp, "TCG doesn't support PCR value 0x"TARGET_FMT_=
lx,
> > +                   value);
> > +        return;
> > +    }
> > +
> > +    env->spr[SPR_PCR] =3D value & pcc->pcr_mask;
> >  }
> > =20
> >  typedef struct {
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index a91f1a8777eb..fdaae34feffb 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -1296,6 +1296,9 @@ int ppc_cpu_handle_mmu_fault(CPUState *cpu, vaddr=
 address, int size, int rw,
> >  #if !defined(CONFIG_USER_ONLY)
> >  void ppc_store_sdr1 (CPUPPCState *env, target_ulong value);
> >  void ppc_store_ptcr(CPUPPCState *env, target_ulong value);
> > +#if defined(TARGET_PPC64)
> > +void ppc_store_pcr(CPUPPCState *env, target_ulong value, Error **errp);
> > +#endif
> >  #endif /* !defined(CONFIG_USER_ONLY) */
> >  void ppc_store_msr (CPUPPCState *env, target_ulong value);
> > =20
> > diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> > index b88493009609..7a9b45a01453 100644
> > --- a/target/ppc/misc_helper.c
> > +++ b/target/ppc/misc_helper.c
> > @@ -21,6 +21,7 @@
> >  #include "exec/exec-all.h"
> >  #include "exec/helper-proto.h"
> >  #include "qemu/error-report.h"
> > +#include "qapi/error.h"
> > =20
> >  #include "helper_regs.h"
> > =20
> > @@ -102,10 +103,12 @@ void helper_store_ptcr(CPUPPCState *env, target_u=
long val)
> > =20
> >  void helper_store_pcr(CPUPPCState *env, target_ulong value)
> >  {
> > -    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> > -    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> > +    Error *local_err =3D NULL;
> > =20
> > -    env->spr[SPR_PCR] =3D value & pcc->pcr_mask;
> > +    ppc_store_pcr(env, value, &local_err);
> > +    if (local_err) {
> > +        error_report_err(local_err);
> > +    }
> >  }
> >  #endif /* defined(TARGET_PPC64) */
> > =20
> >  =20
>=20


--Sig_/p5Yo5Ytw/SRV/gsPkPSn258
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlsg04MACgkQcdTV5YIv
c9aokA//T8JRV6WQxJrSv/iGJOcKsuW4kDh/x33fqpELU/3YiQUVI93HZkIQsjpT
qRYlp2dTsI08BDFCdvxtwwizH79+1Aq15S9hOFNNQJeciXiyy2ye9DOk34YMCvMP
gVPQ9n/7igIKeejTfnL+Au5a5TFpNqzCfk6Za7AOFAv5uvdW4f3C4fF4YW30IVWQ
9zgIdisESEuhpWCHY+S32uHEI+EAnRLkE8QVH8H7MBnzY6Pk4e4wZDe6AzmtFTfj
PgR0VX0C5OIfj7z9Jf1QlmGYcCVWIH0DpapV9QhUDoUCGMoOpzKr52tkNbN6Wwh7
2JkJ5XOY1sqB6mIJx2abLd1KLFSUZ6tCrEhTmue5hlY5i1+Pf6K/RYm0EA8PqAeb
luuxiQO0xMpbAZR366Mh6HaKiSfBhqTn0mX/4UEcvUTMEH65ey4sHB6XwNQZLnnt
aNQc940AXft/CH2jz76I0Ysh0LmiEiOQpf7HsbuCAaL99lkOY2H4BbothSl1fvqV
Yl/MBur7lL2hKQZzF8biiDyeba0kXyYpVe21NZtYXmtUW9XmBEEdkRr7AvVohBNt
hmog+PoZHDhfNRy8/n9AJHjaSq7ZjA0Cb/qXmTguZ9D7TiZ6ovg1yBD3Tmd/kMOj
YsUm/dZFmwSck0EFvBWOw2Cwnw0+Ipt1NL/44I2a/KBSEPZ05D8=
=FyDI
-----END PGP SIGNATURE-----

--Sig_/p5Yo5Ytw/SRV/gsPkPSn258--
