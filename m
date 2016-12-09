Received: from eggs.gnu.org ([2001:4830:134:3::10]:39044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cFHBV-0006RP-Uv
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 04:09:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cFHBS-0001Yi-Nb
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 04:09:41 -0500
Date: Fri, 9 Dec 2016 20:09:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161209090917.GA23035@umbus.fritz.box>
References: <20161209022314.14399-1-david@gibson.dropbear.id.au>
	<20161209022314.14399-3-david@gibson.dropbear.id.au>
	<e8178564-d4a6-17a8-895d-a88147560cc0@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <e8178564-d4a6-17a8-895d-a88147560cc0@redhat.com>
Subject: Re: [Qemu-devel] [for-2.9 2/5] pseries: Stubs for HPT resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: paulus@samba.org, sjitindarsingh@gmail.com, agraf@suse.de, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 09, 2016 at 09:18:51AM +0100, Thomas Huth wrote:
> On 09.12.2016 03:23, David Gibson wrote:
> > This introduces stub implementations of the H_RESIZE_HPT_PREPARE and
> > H_RESIZE_HPT_COMMIT hypercalls which we hope to add in a PAPR
> > extension to allow run time resizing of a guest's hash page table.  It
> > also adds a new machine property for controlling whether this new
> > facility is available, and logic to check that against availability
> > with KVM (only supported with KVM PR for now).
> >=20
> > Finally, it adds a new string to the hypertas property in the device
> > tree, advertising to the guest the availability of the HPT resizing
> > hypercalls.  This is a tentative suggested value, and would need to be
> > standardized by PAPR before being merged.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr.c         | 66 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  hw/ppc/spapr_hcall.c   | 36 +++++++++++++++++++++++++++
> >  hw/ppc/trace-events    |  2 ++
> >  include/hw/ppc/spapr.h | 11 +++++++++
> >  target-ppc/kvm.c       | 26 ++++++++++++++++++++
> >  target-ppc/kvm_ppc.h   |  5 ++++
> >  6 files changed, 146 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 0f25e83..ecb0822 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -760,6 +760,11 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr=
, void *fdt)
> >      if (!kvm_enabled() || kvmppc_spapr_use_multitce()) {
> >          add_str(hypertas, "hcall-multi-tce");
> >      }
> > +
> > +    if (spapr->resize_hpt !=3D SPAPR_RESIZE_HPT_DISABLED) {
> > +        add_str(hypertas, "hcall-hpt-resize");
> > +    }
> > +
> >      _FDT(fdt_setprop(fdt, rtas, "ibm,hypertas-functions",
> >                       hypertas->str, hypertas->len));
> >      g_string_free(hypertas, TRUE);
> > @@ -1839,11 +1844,31 @@ static void ppc_spapr_init(MachineState *machin=
e)
> >      long load_limit, fw_size;
> >      char *filename;
> >      int smt =3D kvmppc_smt_threads();
> > +    Error *resize_hpt_err =3D NULL;
> > =20
> >      msi_nonbroken =3D true;
> > =20
> >      QLIST_INIT(&spapr->phbs);
> > =20
> > +    /* Check HPT resizing availability */
> > +    kvmppc_check_papr_resize_hpt(&resize_hpt_err);
> > +    if (spapr->resize_hpt =3D=3D SPAPR_RESIZE_HPT_DEFAULT) {
> > +        if (resize_hpt_err) {
> > +            spapr->resize_hpt =3D SPAPR_RESIZE_HPT_DISABLED;
> > +            error_free(resize_hpt_err);
> > +            resize_hpt_err =3D NULL;
> > +        } else {
> > +            spapr->resize_hpt =3D smc->resize_hpt_default;
> > +        }
> > +    }
> > +
> > +    assert(spapr->resize_hpt !=3D SPAPR_RESIZE_HPT_DEFAULT);
> > +
> > +    if ((spapr->resize_hpt !=3D SPAPR_RESIZE_HPT_DISABLED) && resize_h=
pt_err) {
> > +        error_report_err(resize_hpt_err);
> > +        exit(1);
> > +    }
>=20
> The logic here is IMHO a little bit hard to understand. Why do you need
> the SPAPR_RESIZE_HPT_DEFAULT state here at all? Wouldn't it be
> sufficient to start with SPAPR_RESIZE_HPT_DISABLED by default and to
> only enable it when the extension is available?

Because if the user explicitly sets something, we should never
override itin the logic here.  In order to determine whether the user
has set something explicitly, we need another value that means "not
set explicitly".

> ... at least some
> explaining comments in the code about SPAPR_RESIZE_HPT_DEFAULT could
> help here.

Hm, maybe.

> > @@ -2236,6 +2261,40 @@ static void spapr_set_modern_hotplug_events(Obje=
ct *obj, bool value,
> >      spapr->use_hotplug_event_source =3D value;
> >  }
> > =20
> > +static char *spapr_get_resize_hpt(Object *obj, Error **errp)
> > +{
> > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> > +
> > +    switch (spapr->resize_hpt) {
> > +    case SPAPR_RESIZE_HPT_DEFAULT:
> > +        return g_strdup("default");
> > +    case SPAPR_RESIZE_HPT_DISABLED:
> > +        return g_strdup("disabled");
> > +    case SPAPR_RESIZE_HPT_ENABLED:
> > +        return g_strdup("enabled");
> > +    case SPAPR_RESIZE_HPT_REQUIRED:
> > +        return g_strdup("required");
> > +    }
> > +    assert(0);
> > +}
> > +
> > +static void spapr_set_resize_hpt(Object *obj, const char *value, Error=
 **errp)
> > +{
> > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> > +
> > +    if (strcmp(value, "default") =3D=3D 0) {
> > +        spapr->resize_hpt =3D SPAPR_RESIZE_HPT_DEFAULT;
> > +    } else if (strcmp(value, "disabled") =3D=3D 0) {
> > +        spapr->resize_hpt =3D SPAPR_RESIZE_HPT_DISABLED;
> > +    } else if (strcmp(value, "enabled") =3D=3D 0) {
> > +        spapr->resize_hpt =3D SPAPR_RESIZE_HPT_ENABLED;
> > +    } else if (strcmp(value, "required") =3D=3D 0) {
> > +        spapr->resize_hpt =3D SPAPR_RESIZE_HPT_REQUIRED;
> > +    } else {
> > +        error_setg(errp, "Bad value for \"resize-hpt\" property");
> > +    }
> > +}
> > +
> >  static void spapr_machine_initfn(Object *obj)
> >  {
> >      sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> > @@ -2256,6 +2315,12 @@ static void spapr_machine_initfn(Object *obj)
> >                                      " place of standard EPOW events wh=
en possible"
> >                                      " (required for memory hot-unplug =
support)",
> >                                      NULL);
> > +
> > +    object_property_add_str(obj, "resize-hpt",
> > +                            spapr_get_resize_hpt, spapr_set_resize_hpt=
, NULL);
> > +    object_property_set_description(obj, "resize-hpt",
> > +                                    "Resizing of the Hash Page Table (=
enabled, disabled, required)",
> > +                                    NULL);
>=20
> ... and "default" ?
>=20
> >  }
> > =20
> >  static void spapr_machine_finalizefn(Object *obj)
> > @@ -2707,6 +2772,7 @@ static void spapr_machine_class_init(ObjectClass =
*oc, void *data)
> > =20
> >      smc->dr_lmb_enabled =3D true;
> >      smc->tcg_default_cpu =3D "POWER8";
> > +    smc->resize_hpt_default =3D SPAPR_RESIZE_HPT_DISABLED;
> >      mc->query_hotpluggable_cpus =3D spapr_query_hotpluggable_cpus;
> >      fwc->get_dev_path =3D spapr_get_fw_dev_path;
> >      nc->nmi_monitor_handler =3D spapr_nmi;
> ...
> > diff --git a/target-ppc/kvm.c b/target-ppc/kvm.c
> > index 15e12f3..dcd8cef 100644
> > --- a/target-ppc/kvm.c
> > +++ b/target-ppc/kvm.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/kvm.h>
> > =20
> >  #include "qemu-common.h"
> > +#include "qapi/error.h"
> >  #include "qemu/error-report.h"
> >  #include "cpu.h"
> >  #include "qemu/timer.h"
> > @@ -2269,6 +2270,7 @@ int kvmppc_reset_htab(int shift_hint)
> >          /* Full emulation, tell caller to allocate htab itself */
> >          return 0;
> >      }
> > +
>=20
> Unnecessary white space change.
>=20
> >      if (kvm_check_extension(kvm_state, KVM_CAP_PPC_ALLOC_HTAB)) {
> >          int ret;
> >          ret =3D kvm_vm_ioctl(kvm_state, KVM_PPC_ALLOCATE_HTAB, &shift);
> > @@ -2672,3 +2674,27 @@ int kvmppc_enable_hwrng(void)
> > =20
> >      return kvmppc_enable_hcall(kvm_state, H_RANDOM);
> >  }
> > +
> > +void kvmppc_check_papr_resize_hpt(Error **errp)
> > +{
> > +    if (!kvm_enabled()) {
> > +        return;
> > +    }
> > +
> > +    /* TODO: Check specific capabilities for HPT resize aware host ker=
nels */
> > +
> > +    /*
> > +     * It's tempting to try to check directly if the HPT is under our
> > +     * control or KVM's, which is what's really relevant here.
> > +     * Unfortunately, in order to correctly size the HPT, we need to
> > +     * know if we can do resizing, _before_ we attempt to allocate it
> > +     * with KVM.  Before that point, we don't officially know whether
> > +     * we'll control the HPT or not.  So we have to use a fallback
> > +     * test for PR vs HV KVM to predict that.
> > +     */
> > +    if (kvmppc_is_pr(kvm_state)) {
> > +        return;
> > +    }
>=20
> Couldn't we get HPT resizing on KVM-PR one day, too?

I guess I need to reword that.  HPT resizing should work on PR right
now (but I haven't been able to test it yet) - because qemu still
allocates and manages the HPT on PR, the qemu side logic is
sufficient.

> > +    error_setg(errp, "Hash page table resizing not available with this=
 KVM version");
> > +}
> > diff --git a/target-ppc/kvm_ppc.h b/target-ppc/kvm_ppc.h
> > index 841a29b..3e852ba 100644
> > --- a/target-ppc/kvm_ppc.h
> > +++ b/target-ppc/kvm_ppc.h
> > @@ -59,6 +59,7 @@ bool kvmppc_has_cap_htm(void);
> >  int kvmppc_enable_hwrng(void);
> >  int kvmppc_put_books_sregs(PowerPCCPU *cpu);
> >  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
> > +void kvmppc_check_papr_resize_hpt(Error **errp);
> > =20
> >  #else
> > =20
> > @@ -270,6 +271,10 @@ static inline PowerPCCPUClass *kvm_ppc_get_host_cp=
u_class(void)
> >      return NULL;
> >  }
> > =20
> > +static inline void kvmppc_check_papr_resize_hpt(Error **errp)
> > +{
> > +    return;
> > +}
> >  #endif
>=20
>  Thomas
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYSnS7AAoJEGw4ysog2bOS97kQAMlW9Exz+1mjRoaQDI98ueWx
xUVf42xwoxQr7E8pDLAr2WxJ+7aNxAsSVGLDl232zF+qfoKE12n4hdrVML3K8RRu
/HLIW20oLcT1COiI1tN9occm8kc8zZx0hgROH7yDipBiLhSF7uyQ1KjdAxPMWPzw
2CyvtEHmnR8llBeWQTWTet4/9T12jt4oeFTtsXMiqsO/MP5x6/nwZ5MPXrnfxMtr
b+LYKVeY/gdpPKlotcRWCNMv/W3i0NbNuKAh8bhmYpyGjXcKH2diXbRG9jE4pA+3
SM21ws5qc7U4ftyAHykotcir93OeeTQkn2QoW1ASssM/+1JaP8e0oshNiGgHg/b3
2KtkPkiC8YU78byMrypK1f6f29o1wzG+8snol5z5xTDvKgm1S3rbWdZofElRX7bM
mqKkpbsxDZqMWImHWFJ4jQueC7C31mhvCzsUfNr9NzAMlYSWp1pPKW0YHrWhEKEY
ZNN3Sa85V8OanRLlbaC8fnb2pj4v/fkdgSGhiDhzQiaPQgqt7Wi/FB06V6J9VKdU
1/IKBjFEI9vsD8P8dmC79xS+XQL2THj0PIF9jsCY3Z1t9nuOEcv4IwN2ff4At0Tl
iQ2/0iHzOyszTMk0EgUtBjnUsFJVeuxJ3vm58OzlmQtioA++TS/UZh9P5xS1g3JU
ixuTq8O0CKWySymVIhKF
=8kY7
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
