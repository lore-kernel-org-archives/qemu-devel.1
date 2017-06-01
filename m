Received: from eggs.gnu.org ([2001:4830:134:3::10]:56217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGIMk-0005Kc-Qu
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 01:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGIMg-0002Xn-5z
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 01:09:46 -0400
Date: Thu, 1 Jun 2017 14:54:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170601045448.GB13397@umbus.fritz.box>
References: <1496230005-12265-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1496230005-12265-2-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline
In-Reply-To: <1496230005-12265-2-git-send-email-bharata@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/2] spapr: Add a "no HPT" encoding to
 HTAB migration stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com, sjitindarsingh@gmail.com


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2017 at 04:56:44PM +0530, Bharata B Rao wrote:
> Add a "no HPT" encoding (using value -1) to the HTAB migration
> stream (in the place of HPT size) when the guest doesn't allocate HPT.
> This will help the target side to match target HPT with the source HPT
> and thus enable successful migration.
>=20
> A few more fixes to enable TCG migration to work correctly are also
> included in this commit:
>=20
> - HTAB savevm handlers have a few asserts on kvm_enabled() when
>   spapr->htab !=3D 0. Convert these into conditional checks as it is now
>   possible to have no HTAB with TCG radix guests.
> - htab_save_setup() asserts for kvm_enabled() when spapr->htab !=3D 0.
>   Remove this as we can't assert this for TCG radix guests.
>=20
> Suggested-by: David Gibson <david@gibson.dropbear.id.au>
>               [no HPT encoding suggestion]
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>

Looks basically ok, but there are still some details to address.

> ---
>  hw/ppc/spapr.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ab3aab1..b589ed4 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1559,17 +1559,18 @@ static int htab_save_setup(QEMUFile *f, void *opa=
que)
>  {
>      sPAPRMachineState *spapr =3D opaque;
> =20
> -    /* "Iteration" header */
> -    qemu_put_be32(f, spapr->htab_shift);
> +    /* "Iteration" header: no-HPT or HPT size encoding */
> +    if (!spapr->htab_shift) {
> +        qemu_put_be32(f, -1);

We're already using htab_shift =3D=3D 0 to represent no HPT in the runtime
structure; we might as well do the same on the wire.  As a bonus it
slightly simplifies the logic here.

> +    } else {
> +        qemu_put_be32(f, spapr->htab_shift);
> +    }
> =20
>      if (spapr->htab) {
>          spapr->htab_save_index =3D 0;
>          spapr->htab_first_pass =3D true;
> -    } else {
> -        assert(kvm_enabled());

I think you've oversimplified the assert()s a little.  As above we're
using htab_shift !=3D 0 to canonically indicate the presence of an HPT,
whether it's qemu or kernel managed.  So really the new assert is
	if (spapr->htab_shift) {
		assert(spapr->htab || kvm_enabled());
	}
(which can be simplified depending on context, of course).

>      }
> =20
> -
>      return 0;
>  }
> =20
> @@ -1714,9 +1715,7 @@ static int htab_save_iterate(QEMUFile *f, void *opa=
que)
>      /* Iteration header */
>      qemu_put_be32(f, 0);
> =20
> -    if (!spapr->htab) {
> -        assert(kvm_enabled());
> -
> +    if (!spapr->htab && kvm_enabled()) {

This isn't quite right.  !spapr->htab means one of two things: there
is no HPT (radix mode) or the HPT is kernel-managed.  kvm_enabled() is
not enough to discern the latter.  In radix mode with KVM you'd
execute this block, which I don't think you want.

>          fd =3D get_htab_fd(spapr);
>          if (fd < 0) {
>              return fd;
> @@ -1748,7 +1747,7 @@ static int htab_save_complete(QEMUFile *f, void *op=
aque)
>      /* Iteration header */
>      qemu_put_be32(f, 0);
> =20
> -    if (!spapr->htab) {
> +    if (!spapr->htab && kvm_enabled()) {

Same here.

>          int rc;
> =20
>          assert(kvm_enabled());
> @@ -1793,6 +1792,12 @@ static int htab_load(QEMUFile *f, void *opaque, in=
t version_id)
>      if (section_hdr) {
>          Error *local_err =3D NULL;
> =20
> +        if (section_hdr =3D=3D -1) {
> +            spapr_free_hpt(spapr);
> +            unregister_savevm(NULL, "spapr/htab", spapr);

I don't think we want to register/unregister the htab handlers at
all.  This above would break if you migrated a radix guest, then
rebooted into a hash guest and tried to migrate again.

> +            return 0;
> +        }
> +
>          /* First section gives the htab size */
>          spapr_reallocate_hpt(spapr, section_hdr, &local_err);
>          if (local_err) {
> @@ -1802,9 +1807,7 @@ static int htab_load(QEMUFile *f, void *opaque, int=
 version_id)
>          return 0;
>      }
> =20
> -    if (!spapr->htab) {
> -        assert(kvm_enabled());
> -
> +    if (!spapr->htab && kvm_enabled()) {


Again, not quite right here.
>          fd =3D kvmppc_get_htab_fd(true);
>          if (fd < 0) {
>              error_report("Unable to open fd to restore KVM hash table: %=
s",
> @@ -1843,7 +1846,7 @@ static int htab_load(QEMUFile *f, void *opaque, int=
 version_id)
>                  memset(HPTE(spapr->htab, index + n_valid), 0,
>                         HASH_PTE_SIZE_64 * n_invalid);
>              }
> -        } else {
> +        } else if (kvm_enabled()) {
>              int rc;
> =20
>              assert(fd >=3D 0);
> @@ -1855,7 +1858,7 @@ static int htab_load(QEMUFile *f, void *opaque, int=
 version_id)
>          }
>      }
> =20
> -    if (!spapr->htab) {
> +    if (!spapr->htab && kvm_enabled()) {

Or here.

>          assert(fd >=3D 0);
>          close(fd);
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZL54VAAoJEGw4ysog2bOSmN8QALMQs2kn7jBAt3pgd97MOpjl
gPFEsT6JCuydl5p1bFVZ9lxq3XOz2H78mWGi29n1M1AkSU2oNFuhRCQZKprBCI70
hWHh9cL9axmE6yryZ86vybXs0xLycaJv2GebpwQzmYUeHnyIpkr05degt+ZNs4+P
13MyfOGQLqwXfPMBWQgPtJdoUC5BrggO9F8pBAcHHU63xUhAfOgXMmf5pyumu0F1
hmYEfG/Y8TzIgRW/0gd3UjcydeKf8u81Ui7TD/OtTyE6cU7r+IX7djlSJw4IdLsx
9a8b0RF4HNQNnaPOzCsGV7R7dHj1wQ+VAYa/KFHPt6nDbJUWCm26s7RStyaOr8PN
onE3WBEwxjn5Y28SWcopfHtZw9V/3DMagkhMIWIOch8EdI27uqQZznHqLN9VuYgW
jp9JyQrAlUOyVodetxUb7Ydldp1EkilcaQKDzOCZyHseqOulLV49qVJUQ8Vzbb7U
l87o/xC0VqhAf61QJtbBvDlOwapggjLG+BzeE8biTtcQbdxzyHDlyJc+JaGRvwKD
LuKsuanICpr3Wn6PrXyJdmi+SPO5jtkQ8+823dFzMGB2sRTGl9PLbpqsOHFY71Pq
tqA3tFAR248ekidqbV3UpFs7kPDgYMVExEH0Pjbz/bzW8ZpKr0p7jsakf0HpXM7j
NbVV1TQKk7HUa0BJE9Ul
=dAn8
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
