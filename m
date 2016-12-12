Received: from eggs.gnu.org ([2001:4830:134:3::10]:37278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cGEgc-0006cf-Ka
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 19:41:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cGEgY-0008NX-GZ
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 19:41:46 -0500
Date: Mon, 12 Dec 2016 11:40:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161212004024.GE12127@umbus.fritz.box>
References: <20161209022314.14399-1-david@gibson.dropbear.id.au>
	<20161209022314.14399-3-david@gibson.dropbear.id.au>
	<20161209170802.3613.88250@loki>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZRyEpB+iJ+qUx0kp"
Content-Disposition: inline
In-Reply-To: <20161209170802.3613.88250@loki>
Subject: Re: [Qemu-devel] [for-2.9 2/5] pseries: Stubs for HPT resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: paulus@samba.org, sjitindarsingh@gmail.com, agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com


--ZRyEpB+iJ+qUx0kp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 09, 2016 at 11:08:02AM -0600, Michael Roth wrote:
> Quoting David Gibson (2016-12-08 20:23:11)
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
> >=20
> >      msi_nonbroken =3D true;
> >=20
> >      QLIST_INIT(&spapr->phbs);
> >=20
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
> I'm also a bit confused by this. Aren't semantics that HPT_ENABLED will a=
llow
> a fallback to non-resizable HPTs if the feature isn't available (whereas
> HPT_REQUIRED won't)? I don't understand how such a fallback can ever be r=
eached
> with this check in place.

We fall back if the _guest_ doesn't support HPT resizing.  This error
path is if the _host_ can't support HPT resizing.  Some extra
information about this in the reply I'll shortly send to Thomas.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZRyEpB+iJ+qUx0kp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYTfH4AAoJEGw4ysog2bOSfnYP/Rqwqsk/7RpF8Uit6Z0Py1kr
xRi2GRknXhYpQxJHQNM8mdtKIbElyllJoJX48Goc8rq5h2DnVrGltK/FV6CnoW/s
1QgdtXBNwom8QYWHJ3yfRHjotk9CUy+8UcNeHHLWAh5BXOyR3oaismM9Fqt6Fknv
Xa5Vvj1deV6xoY8lf5pUlBy941oLcmWk1jrH0HOcjcdtsyytG3DgohzGAsk3Ub2Q
Iv/YwldM2K0cxwnb8ZupdkN+/B56E3s/bbl5gLzB7BiHizhKOe3Z3MajszCU6EfK
6InI0i1jvzV4miZjBKx8+EeGQR0ymd4dzm8Jxk4rRdXuTujj+qgJRhqCD4CyCjKE
VPumCWv2FkveSygLH8fX+A8EBs8vb9FCtBVJ1xm6ONtwY1c1Stq090L1/NcEGX8x
xzXpd6gE6+uYEBV3ME3g1I8dUDUbuhSlTZc+bnFDIjhh8eVJJcVEHfbUraiJyTDd
RNTtN/8aeD2IXG2e3FIhZbPeQJylztkSx+5TkD0xCBk2eudcdc1km2LwXE5ZgbGq
HzYh3dAt6MFUv3Mnqdk2F4aOUeyWrcgCRsZB1eXo7IdSRCRW7fyLhtL3UNB+lWOM
oQRF6T3SKwP4JTiiidkjJvxjYUTH5ekh0IKfLxltXVniG4mY7t0SXnahO00yxmkY
SwuHNMFTomCg92fFfVrH
=0mMD
-----END PGP SIGNATURE-----

--ZRyEpB+iJ+qUx0kp--
