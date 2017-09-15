Received: from eggs.gnu.org ([2001:4830:134:3::10]:59000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dslmY-0001SC-2h
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dslmU-0004Rf-MT
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:15:26 -0400
Date: Fri, 15 Sep 2017 16:34:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170915063439.GE5250@umbus.fritz.box>
References: <150541711102.1616.2690784964841960181.stgit@bahia.lan>
	<150541714343.1616.11893912014879112098.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qFgkTsE6LiHkLPZw"
Content-Disposition: inline
In-Reply-To: <150541714343.1616.11893912014879112098.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 3/3] ppc/kvm: check some capabilities with
 kvm_vm_check_extension()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, Sam Bobroff <sam.bobroff@au1.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>


--qFgkTsE6LiHkLPZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2017 at 09:25:43PM +0200, Greg Kurz wrote:
> The following capabilities are VM specific:
> - KVM_CAP_PPC_SMT_POSSIBLE
> - KVM_CAP_PPC_HTAB_FD
> - KVM_CAP_PPC_ALLOC_HTAB
>=20
> If both KVM HV and KVM PR are present, checking them always return
> the HV value, even if we explicitely requested to use PR.
>=20
> This has no visible effect for KVM_CAP_PPC_ALLOC_HTAB, because we also
> try the KVM_PPC_ALLOCATE_HTAB ioctl which is only suppored by HV. As
> a consequence, the spapr code doesn't even check KVM_CAP_PPC_HTAB_FD.
>=20
> However, this will cause kvmppc_hint_smt_possible(), introduced by
> commit fa98fbfcdfcb9, to report several VSMT modes (eg, Available
> VSMT modes: 8 4 2 1) whereas PR only support mode 1.
>=20
> This patch fixes all three anyway to use kvm_vm_check_extension(). It
> is okay since the VM is already created at the time kvm_arch_init() or
> kvmppc_reset_htab() is called.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.11.

> ---
>  target/ppc/kvm.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 1deaf106d2b9..208c70e81426 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -131,7 +131,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      cap_interrupt_level =3D kvm_check_extension(s, KVM_CAP_PPC_IRQ_LEVEL=
);
>      cap_segstate =3D kvm_check_extension(s, KVM_CAP_PPC_SEGSTATE);
>      cap_booke_sregs =3D kvm_check_extension(s, KVM_CAP_PPC_BOOKE_SREGS);
> -    cap_ppc_smt_possible =3D kvm_check_extension(s, KVM_CAP_PPC_SMT_POSS=
IBLE);
> +    cap_ppc_smt_possible =3D kvm_vm_check_extension(s, KVM_CAP_PPC_SMT_P=
OSSIBLE);
>      cap_ppc_rma =3D kvm_check_extension(s, KVM_CAP_PPC_RMA);
>      cap_spapr_tce =3D kvm_check_extension(s, KVM_CAP_SPAPR_TCE);
>      cap_spapr_tce_64 =3D kvm_check_extension(s, KVM_CAP_SPAPR_TCE_64);
> @@ -143,7 +143,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      cap_ppc_watchdog =3D kvm_check_extension(s, KVM_CAP_PPC_BOOKE_WATCHD=
OG);
>      /* Note: we don't set cap_papr here, because this capability is
>       * only activated after this by kvmppc_set_papr() */
> -    cap_htab_fd =3D kvm_check_extension(s, KVM_CAP_PPC_HTAB_FD);
> +    cap_htab_fd =3D kvm_vm_check_extension(s, KVM_CAP_PPC_HTAB_FD);
>      cap_fixup_hcalls =3D kvm_check_extension(s, KVM_CAP_PPC_FIXUP_HCALL);
>      cap_ppc_smt =3D kvm_vm_check_extension(s, KVM_CAP_PPC_SMT);
>      cap_htm =3D kvm_vm_check_extension(s, KVM_CAP_PPC_HTM);
> @@ -2353,7 +2353,7 @@ int kvmppc_reset_htab(int shift_hint)
>          /* Full emulation, tell caller to allocate htab itself */
>          return 0;
>      }
> -    if (kvm_check_extension(kvm_state, KVM_CAP_PPC_ALLOC_HTAB)) {
> +    if (kvm_vm_check_extension(kvm_state, KVM_CAP_PPC_ALLOC_HTAB)) {
>          int ret;
>          ret =3D kvm_vm_ioctl(kvm_state, KVM_PPC_ALLOCATE_HTAB, &shift);
>          if (ret =3D=3D -ENOTTY) {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qFgkTsE6LiHkLPZw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm7dH0ACgkQbDjKyiDZ
s5IczxAAvLtIdyfkyuRlyl3pLhrtHYyzhFtQIUgvL08L34enl9ln89UH0yiioTvE
4eTxN98rMJh1ZeO3pqH9j433WGIepGWe9pMbuoZaXWY1YviBTncwvfg4MVXKgIPZ
m0Ywhf16lldJVT/qBLL5i8gLI0Kz9CH7r/JXZ0LNHVsnUTqDiGZH9pWqGBXqQwC3
Fj/ugKIc+KfKQuwBzu1UDxE4mjYWGyMeKWdxYg+QF7neH7yWbQlG7bkEoyZoeLJQ
IoPlkD6LtWUqPJibspT6/R8hJUYh5TwUuMMu44SloYFnFIuBHzp5o+vQh2F3dThF
vkPP/8yeZDJvNgMcIzES3q5Avkibi38kgMO9Bcimfit+lVYYaOvKHGgoDDbGHC5Z
KJ17SgdNQUay2226oyOor8yOGLaDdUXGPGyfEM2oDnydeQbHMjdwBasXSurbQCkE
dVWnRj1OtOt/K3nQ6exZugv+cam1FidZHnuiUg6bK0owO1S5XIskCCcj2qu6zLI+
tlCoS/jbybNh7qcXqpPVnxILw+tVQbmNPfe19ptv4WnzaeD6ri7OzhLj+aaO48f3
pimQ/BAlM0KmNgHa30mQ+bxtsKMW1KmoLv4Aoa1K/RDvyPv8Q1dChJwcVAFm9ND1
XLH4WIE3n6SDVfJWYvTCrryKtRtP53o0G+ekUApUzpkmdBG3cG4=
=jWhI
-----END PGP SIGNATURE-----

--qFgkTsE6LiHkLPZw--
