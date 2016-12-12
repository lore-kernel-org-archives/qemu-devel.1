Received: from eggs.gnu.org ([2001:4830:134:3::10]:53969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cGGtx-0000gM-4p
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:03:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cGGtt-0002Hr-Vd
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:03:41 -0500
Date: Mon, 12 Dec 2016 12:06:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161212010630.GF12127@umbus.fritz.box>
References: <20161209022314.14399-1-david@gibson.dropbear.id.au>
	<20161209022314.14399-3-david@gibson.dropbear.id.au>
	<e8178564-d4a6-17a8-895d-a88147560cc0@redhat.com>
	<20161209090917.GA23035@umbus.fritz.box>
	<aecc4f5b-1265-13f0-2368-9ea7daad474c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cpvLTH7QU4gwfq3S"
Content-Disposition: inline
In-Reply-To: <aecc4f5b-1265-13f0-2368-9ea7daad474c@redhat.com>
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


--cpvLTH7QU4gwfq3S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 09, 2016 at 10:18:59AM +0100, Thomas Huth wrote:
> On 09.12.2016 10:09, David Gibson wrote:
> > On Fri, Dec 09, 2016 at 09:18:51AM +0100, Thomas Huth wrote:
> >> On 09.12.2016 03:23, David Gibson wrote:
> >>> This introduces stub implementations of the H_RESIZE_HPT_PREPARE and
> >>> H_RESIZE_HPT_COMMIT hypercalls which we hope to add in a PAPR
> >>> extension to allow run time resizing of a guest's hash page table.  It
> >>> also adds a new machine property for controlling whether this new
> >>> facility is available, and logic to check that against availability
> >>> with KVM (only supported with KVM PR for now).
> >>>
> >>> Finally, it adds a new string to the hypertas property in the device
> >>> tree, advertising to the guest the availability of the HPT resizing
> >>> hypercalls.  This is a tentative suggested value, and would need to be
> >>> standardized by PAPR before being merged.
> >>>
> >>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >>> ---
> >>>  hw/ppc/spapr.c         | 66 ++++++++++++++++++++++++++++++++++++++++=
++++++++++
> >>>  hw/ppc/spapr_hcall.c   | 36 +++++++++++++++++++++++++++
> >>>  hw/ppc/trace-events    |  2 ++
> >>>  include/hw/ppc/spapr.h | 11 +++++++++
> >>>  target-ppc/kvm.c       | 26 ++++++++++++++++++++
> >>>  target-ppc/kvm_ppc.h   |  5 ++++
> >>>  6 files changed, 146 insertions(+)
> >>>
> >>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>> index 0f25e83..ecb0822 100644
> >>> --- a/hw/ppc/spapr.c
> >>> +++ b/hw/ppc/spapr.c
> >>> @@ -760,6 +760,11 @@ static void spapr_dt_rtas(sPAPRMachineState *spa=
pr, void *fdt)
> >>>      if (!kvm_enabled() || kvmppc_spapr_use_multitce()) {
> >>>          add_str(hypertas, "hcall-multi-tce");
> >>>      }
> >>> +
> >>> +    if (spapr->resize_hpt !=3D SPAPR_RESIZE_HPT_DISABLED) {
> >>> +        add_str(hypertas, "hcall-hpt-resize");
> >>> +    }
> >>> +
> >>>      _FDT(fdt_setprop(fdt, rtas, "ibm,hypertas-functions",
> >>>                       hypertas->str, hypertas->len));
> >>>      g_string_free(hypertas, TRUE);
> >>> @@ -1839,11 +1844,31 @@ static void ppc_spapr_init(MachineState *mach=
ine)
> >>>      long load_limit, fw_size;
> >>>      char *filename;
> >>>      int smt =3D kvmppc_smt_threads();
> >>> +    Error *resize_hpt_err =3D NULL;
> >>> =20
> >>>      msi_nonbroken =3D true;
> >>> =20
> >>>      QLIST_INIT(&spapr->phbs);
> >>> =20
> >>> +    /* Check HPT resizing availability */
> >>> +    kvmppc_check_papr_resize_hpt(&resize_hpt_err);
> >>> +    if (spapr->resize_hpt =3D=3D SPAPR_RESIZE_HPT_DEFAULT) {
> >>> +        if (resize_hpt_err) {
> >>> +            spapr->resize_hpt =3D SPAPR_RESIZE_HPT_DISABLED;
> >>> +            error_free(resize_hpt_err);
> >>> +            resize_hpt_err =3D NULL;
> >>> +        } else {
> >>> +            spapr->resize_hpt =3D smc->resize_hpt_default;
> >>> +        }
> >>> +    }
> >>> +
> >>> +    assert(spapr->resize_hpt !=3D SPAPR_RESIZE_HPT_DEFAULT);
> >>> +
> >>> +    if ((spapr->resize_hpt !=3D SPAPR_RESIZE_HPT_DISABLED) && resize=
_hpt_err) {
> >>> +        error_report_err(resize_hpt_err);
> >>> +        exit(1);
> >>> +    }
> >>
> >> The logic here is IMHO a little bit hard to understand. Why do you need
> >> the SPAPR_RESIZE_HPT_DEFAULT state here at all? Wouldn't it be
> >> sufficient to start with SPAPR_RESIZE_HPT_DISABLED by default and to
> >> only enable it when the extension is available?
> >=20
> > Because if the user explicitly sets something, we should never
> > override itin the logic here.  In order to determine whether the user
> > has set something explicitly, we need another value that means "not
> > set explicitly".
>=20
> Hmm, ok, I think I slowly get it. Another question: Does this also take
> care of the handling if the user migrates from a machine that supports
> HPT resizing to a machine that does not support this feature?

Ok, so there are a fair few cases here.  The key point, though is that
even before now, we helpefully transferred the size of the HPT in the
migration stream before sending its contents (that was done so we
could update the sizing heuristics without breaking migration).

For TCG and KVM PR:

Here the ability to HPT resize depends purely on the qemu version.
Assuming this gets merged for qemu-2.9, pseries-2.9 TCG or PR guests
should always support resizing so that should be fine.

If you explicitly enabled HPT resizing for a pseries-2.8 guest running
under qemu-2.9 to an older qemu, then things could get odd.  The
destination guest would get an HPT of the size it had at the source at
the point of migration.  Any further attempts to resize would fail.
Given you have to explicitly set up this poor situation and the
failure mode isn't _that_ bad, I think that's ok.

For KVM HV:

Assuming we're migrating from a host kernel which can support resize
to one which can't:

If the resize-hpt is (explicitly) set differently on the the two ends
then, well, don't do that.  So assume it's the same on each end:

If resize-hpt=3Ddisabled, things are fine, obviously.

If resize=3Dhpt=3Denabled|required, then qemu will fail to start on the
destination because the host kernel doesn't support it.  So you should
know something's wrong before even attempting migration, which is the
best we can do.

If resize-hpt=3Ddefault is the messiest case.  In theory we could get a
failure case to the one mentioned above for TCG guests.  In practice,
however, the migration will fail before completing: kernels without
the HPT resizing support in fact don't even allow the guest HPT to be
resized at reset time.  The initial setup of the destination will
initialize the in-kernel HPT based on maxmem size (because resize is
unavailable on this end).  When the migration stream comes in, we'll
try to reallocate the in-kernel HPT to the incoming size and fail
because the host kernel won't allow us to.


I think this behaviour is as good as we can reasonably get.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cpvLTH7QU4gwfq3S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYTfgQAAoJEGw4ysog2bOS/fIQAKQJh9ymBH5WK9tgPDKRUcuS
bpySPaUACAgK9uJYxJSPDTOcVwo7Kyqrs18ULyb6d5m+33Rq1VX3UXgIpOQxxm6F
xy+i7dFnoT5wmkzGyy2QD7mCxNXUQR7qTpOdmIcdgzIlF08H/QcLWvbg+PS5Wo/6
tX4GuWjBrIuyROgMrX4ldX2COnsQIXrL0uuVjTj/instECkA1LVa0rivmyHhIYG/
NMoVgLhQErhTBKc00xFftVhy9gmVgGxpEBq4N6FlmGsJ3TgTxwSqz3/6uLtx4IvO
Bfk+bxJBtjLSqQKanyVn15O3ycjgx1TGeJ5jsud+LDHWXq6LO1A+uNliMsPkfH4x
tPQc1yQpnsyCCMZvILtqVHjrGYjSsqm9eWo+rVb7hEAzXJNXpJvQyh2+hdvB9qgh
mB3wk46cOoNlqutQGAigJj98tQL5bzNTg6Fa6dMPNpiybySwVFK50v66lmzKjXwn
tIjyR48PPPrIei+w/9FY60yp2/oWHT/HPkWpiNnn3GddeSQ9lKFZTiCOVphbcxD8
Bf1yviej+1KVVDmzT340oxcbDjsG5Af+UtFgjSB9D2tI0Wc5ljpTVHwurcQvLEFE
OugViiYLlq2FjqIrltVzbkj/V1DYCvRzY8hwQbIPtO2Elzs8Wkm1ZO+DeiNfbAcI
PzKa9QlAy8AIGW0RJO1p
=qG7d
-----END PGP SIGNATURE-----

--cpvLTH7QU4gwfq3S--
