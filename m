Received: from eggs.gnu.org ([2001:4830:134:3::10]:43473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVGPa-0005oT-AX
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVGPY-0007wb-Ic
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:11:06 -0400
Date: Tue, 19 Jun 2018 21:22:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180619112243.GB3546@umbus.fritz.box>
References: <20180618063606.2513-1-david@gibson.dropbear.id.au>
	<20180618063606.2513-6-david@gibson.dropbear.id.au>
	<05ff6923-cfcb-5fb8-8cb2-bef118161e15@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
In-Reply-To: <05ff6923-cfcb-5fb8-8cb2-bef118161e15@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 5/9] spapr: Maximum (HPT) pagesize property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: groug@kaod.org, abologna@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 19, 2018 at 11:23:04AM +0200, C=E9dric Le Goater wrote:
> On 06/18/2018 08:36 AM, David Gibson wrote:
> > The way the POWER Hash Page Table (HPT) MMU is virtualized by KVM HV me=
ans
> > that every page that the guest puts in the pagetables must be truly
> > physically contiguous, not just GPA-contiguous.  In effect this means t=
hat
> > an HPT guest can't use any pagesizes greater than the host page size us=
ed
> > to back its memory.
> >=20
> > At present we handle this by changing what we advertise to the guest ba=
sed
> > on the backing pagesizes.  This is pretty bad, because it means the gue=
st
> > sees a different environment depending on what should be host configura=
tion
> > details.
> >=20
> > As a start on fixing this, we add a new capability parameter to the pse=
ries
> > machine type which gives the maximum allowed pagesizes for an HPT guest=
 (as
> > a shift).  For now we just create and validate the parameter without ma=
king
> > it do anything.
> >=20
> > For backwards compatibility, on older machine types we set it to the max
> > available page size for the host.  For the 3.0 machine type, we fix it =
to
> > 16, the intention being to only allow HPT pagesizes up to 64kiB by defa=
ult
> > in future.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr.c         | 12 +++++++++
> >  hw/ppc/spapr_caps.c    | 56 ++++++++++++++++++++++++++++++++++++++++++
> >  include/hw/ppc/spapr.h |  4 ++-
> >  3 files changed, 71 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 40858d047c..74a76e7e09 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -63,6 +63,7 @@
> >  #include "hw/virtio/vhost-scsi-common.h"
> > =20
> >  #include "exec/address-spaces.h"
> > +#include "exec/ram_addr.h"
> >  #include "hw/usb.h"
> >  #include "qemu/config-file.h"
> >  #include "qemu/error-report.h"
> > @@ -4043,6 +4044,7 @@ static void spapr_machine_class_init(ObjectClass =
*oc, void *data)
> >      smc->default_caps.caps[SPAPR_CAP_CFPC] =3D SPAPR_CAP_BROKEN;
> >      smc->default_caps.caps[SPAPR_CAP_SBBC] =3D SPAPR_CAP_BROKEN;
> >      smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
> > +    smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D 16; /* 64kiB=
 */
> >      spapr_caps_add_properties(smc, &error_abort);
> >  }
> > =20
> > @@ -4126,8 +4128,18 @@ static void spapr_machine_2_12_instance_options(=
MachineState *machine)
> > =20
> >  static void spapr_machine_2_12_class_options(MachineClass *mc)
> >  {
> > +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> > +    uint8_t mps;
> > +
> >      spapr_machine_3_0_class_options(mc);
> >      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_12);
> > +
> > +    if (kvmppc_hpt_needs_host_contiguous_pages()) {
> > +        mps =3D ctz64(qemu_getrampagesize());
> > +    } else {
> > +        mps =3D 34; /* allow everything up to 16GiB, i.e. everything */
> > +    }
> > +    smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D mps;
> >  }
> > =20
> >  DEFINE_SPAPR_MACHINE(2_12, "2.12", false);
> > diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> > index 68a4243efc..6cdc0c94e7 100644
> > --- a/hw/ppc/spapr_caps.c
> > +++ b/hw/ppc/spapr_caps.c
> > @@ -27,6 +27,7 @@
> >  #include "qapi/visitor.h"
> >  #include "sysemu/hw_accel.h"
> >  #include "target/ppc/cpu.h"
> > +#include "target/ppc/mmu-hash64.h"
> >  #include "cpu-models.h"
> >  #include "kvm_ppc.h"
> > =20
> > @@ -144,6 +145,42 @@ out:
> >      g_free(val);
> >  }
> > =20
> > +static void spapr_cap_get_pagesize(Object *obj, Visitor *v, const char=
 *name,
> > +                                   void *opaque, Error **errp)
> > +{
> > +    sPAPRCapabilityInfo *cap =3D opaque;
> > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> > +    uint8_t val =3D spapr_get_cap(spapr, cap->index);
> > +    uint64_t pagesize =3D (1ULL << val);
> > +
> > +    visit_type_size(v, name, &pagesize, errp);
> > +}
> > +
> > +static void spapr_cap_set_pagesize(Object *obj, Visitor *v, const char=
 *name,
> > +                                   void *opaque, Error **errp)
> > +{
> > +    sPAPRCapabilityInfo *cap =3D opaque;
> > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> > +    uint64_t pagesize;
> > +    uint8_t val;
> > +    Error *local_err =3D NULL;
> > +
> > +    visit_type_size(v, name, &pagesize, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +
> > +    if (!is_power_of_2(pagesize)) {
> > +        error_setg(errp, "cap-%s must be a power of 2", cap->name);
> > +        return;
> > +    }
> > +
> > +    val =3D ctz64(pagesize);
> > +    spapr->cmd_line_caps[cap->index] =3D true;
> > +    spapr->eff.caps[cap->index] =3D val;
> > +}
> > +
> >  static void cap_htm_apply(sPAPRMachineState *spapr, uint8_t val, Error=
 **errp)
> >  {
> >      if (!val) {
> > @@ -267,6 +304,16 @@ static void cap_safe_indirect_branch_apply(sPAPRMa=
chineState *spapr,
> > =20
> >  #define VALUE_DESC_TRISTATE     " (broken, workaround, fixed)"
> > =20
> > +static void cap_hpt_maxpagesize_apply(sPAPRMachineState *spapr,
> > +                                      uint8_t val, Error **errp)
> > +{
> > +    if (val < 12) {
> > +        error_setg(errp, "Require at least 4kiB hpt-max-page-size");
> > +    } else if (val < 16) {
> > +        warn_report("Many guests require at least 64kiB hpt-max-page-s=
ize");
> > +    }
> > +}
> > +
> >  sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
> >      [SPAPR_CAP_HTM] =3D {
> >          .name =3D "htm",
> > @@ -326,6 +373,15 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM=
] =3D {
> >          .possible =3D &cap_ibs_possible,
> >          .apply =3D cap_safe_indirect_branch_apply,
> >      },
> > +    [SPAPR_CAP_HPT_MAXPAGESIZE] =3D {
> > +        .name =3D "hpt-max-page-size",
> > +        .description =3D "Maximum page size for Hash Page Table guests=
",
> > +        .index =3D SPAPR_CAP_HPT_MAXPAGESIZE,
> > +        .get =3D spapr_cap_get_pagesize,
> > +        .set =3D spapr_cap_set_pagesize,
> > +        .type =3D "int",
> > +        .apply =3D cap_hpt_maxpagesize_apply,
> > +    },
> >  };
>=20
> Why not use a "PAGESHIFT" name instead ? and also simplify 'set_pagesize'=
=20
> by requiring a page shift and not a page size.

I had that in my previous version.  Andrew suggested this was a
friendlier interface, and on reflection, I agree.


>=20
> C.
>=20
>=20
> >  static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spap=
r,
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index 9dd46a72f6..c97593d032 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -66,8 +66,10 @@ typedef enum {
> >  #define SPAPR_CAP_SBBC                  0x04
> >  /* Indirect Branch Serialisation */
> >  #define SPAPR_CAP_IBS                   0x05
> > +/* HPT Maximum Page Size (encoded as a shift) */
> > +#define SPAPR_CAP_HPT_MAXPAGESIZE       0x06
> >  /* Num Caps */
> > -#define SPAPR_CAP_NUM                   (SPAPR_CAP_IBS + 1)
> > +#define SPAPR_CAP_NUM                   (SPAPR_CAP_HPT_MAXPAGESIZE + 1)
> > =20
> >  /*
> >   * Capability Values
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlso54MACgkQbDjKyiDZ
s5LHWg//QGTPolYRYzdn9R5ye8ewrH/UF9G3+ex8rf8rsaCMAEFB8by/YDb5yrSM
NESviaGfQPA0eQTk4b+ZvA5nuxSK/mQ1JYrMEBf8xCmr1/Lpp/xMH8oPhDdl26RJ
zqBJz6aa/eXM3ZAFq37wUTgShJAQtEY/XMNbEAzSz/cB+7a+hF1TmLjiJ/gfB1p9
A1kVXxvFBI3MSHYUai16eo9VUfvhALN/Ya22oB01Xjzaj68U4ERVXeluZZAgQH1h
g4kp7FX1NeP2sPGcY7tx7TtcByw9a5q0MzxIHsSmD7YxVLKWqZcWuzMiqrOaU1T8
LpGfK6krs975d9wZ5msI++FTJatqwvSmRwQGLM0PrR5f0r/MRBq7dmCrsd70lM4V
4wvhF9bZWZ6zLYGXY3uy/ktgS96wifp9SGtsJf67AtoACXGYPKDFfnf7XmOpstYM
BIYjZ01Ntrr4J48RV3gAA0/LE/Dt+KEYGyVyOCGk15bB3ndjY1mrFsXqAmOTGlM0
jTPJ1Yf4ECJRJgtoA2zhB1dzWTodFLKmEZlIAY2WNuIwoiC5n4C7nSwcpzlkYyc4
t4TvEW8r9RASSUxuXZndbSd90qJisBcX4Y4Zhl+StPw3sTppbbm6fCPIfkeEDjhA
kZx/rrXjFaqd3FEwvlf3xTVgcas/RiX+P+4w/Jd4VVA7QL1KQZ0=
=YPYr
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
