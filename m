Received: from eggs.gnu.org ([2001:4830:134:3::10]:48709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dsSJW-0001T8-GK
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dsSJV-00035s-6A
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:28:10 -0400
Date: Thu, 14 Sep 2017 21:00:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170914110003.GM3972@umbus.fritz.box>
References: <150538608438.12346.9391407971434352383.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2YJj5f1P6Th4nBRw"
Content-Disposition: inline
In-Reply-To: <150538608438.12346.9391407971434352383.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] ppc/kvm: use kvm_vm_check_extension() in
 kvmppc_is_pr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>


--2YJj5f1P6Th4nBRw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2017 at 12:48:04PM +0200, Greg Kurz wrote:
> If the host has both KVM PR and KVM HV loaded and we pass:
>=20
> 	-machine pseries,accel=3Dkvm,kvm-type=3DPR
>=20
> the kvmppc_is_pr() returns false instead of true. Since the helper
> is mostly used as fallback, it doesn't have any real impact with
> recent kernels. A notable exception is the workaround to allow
> migration between compatible hosts with different PVRs (eg, POWER8
> and POWER8E), since KVM still doesn't provide a way to check if a
> specific PVR is supported (see commit c363a37a450f for details).
>=20
> According to the official KVM API documentation [1], KVM_PPC_GET_PVINFO
> is "vm ioctl", but we check it as a global ioctl. The following function
> in KVM is hence called with kvm =3D=3D NULL and considers we're in HV mod=
e.
>=20
> int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> {
> 	int r;
> 	/* Assume we're using HV mode when the HV module is loaded */
> 	int hv_enabled =3D kvmppc_hv_ops ? 1 : 0;
>=20
> 	if (kvm) {
> 		/*
> 		 * Hooray - we know which VM type we're running on. Depend on
> 		 * that rather than the guess above.
> 		 */
> 		hv_enabled =3D is_kvmppc_hv_enabled(kvm);
> 	}
>=20
> Let's use kvm_vm_check_extension() to fix the issue.
>=20
> [1] https://www.kernel.org/doc/Documentation/virtual/kvm/api.txt
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.11, good catch.

> ---
>  target/ppc/kvm.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 6442dfcb95b3..1deaf106d2b9 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -120,7 +120,7 @@ static void kvm_kick_cpu(void *opaque)
>  static bool kvmppc_is_pr(KVMState *ks)
>  {
>      /* Assume KVM-PR if the GET_PVINFO capability is available */
> -    return kvm_check_extension(ks, KVM_CAP_PPC_GET_PVINFO) !=3D 0;
> +    return kvm_vm_check_extension(ks, KVM_CAP_PPC_GET_PVINFO) !=3D 0;
>  }
> =20
>  static int kvm_ppc_register_host_cpu_type(void);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2YJj5f1P6Th4nBRw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm6YTEACgkQbDjKyiDZ
s5LDzA//do01pfigzTdO3qPGnTrX0z8VADoP4zwehlcO/YjXCp+r2J2gnMiparCV
h7w2nvu91E0StiQ6k9DOCiHUyVq9GhASY0g9Mt5hTZ7cWRjVdhVxvMyd4XrqTFhk
Cb1R9YcqwhbS1Z7XtY99qqrUNmY57YR6TrzL9eoYxeV6bsMhf3Sk6GJDHm/rLlyg
nlRSnfcw1jS4EsB4XZ36frbSKmQCUO/GA7M9r3BAxFyyLl1Yc6PbYF08GyyKi9kS
Zq802PKlBwAz4YocypVniEF3o0Byy1uIbJ5bjiBQ72vkDPSPmPC+KPJdt7xZpqk2
r1GjDsiRRnmWK35u3DX8H85q9ZzOc2/Qd0BZOFXMJICT2h529Ob1cP9PnQ5QF+M3
I78NJv+YBBVrKbxx4hV2Xoxg8jSZpfmtlRqp9IAgdwuoiQBVGDqHSnj2Axv7MPIB
uYEYXhKsWbto+wzjwZo82TTd7p6GahQjkjwNDoJ2ZB6V315jB++X4rK+iKhdEXdJ
CET7VuDp5QScHG/da+FH+jYS7DMzMOVPfm+OTwAs+ClWRkgTmZz4Y4Isrb7DTCZE
ivy/HYT2/QXtliKwJs/Pcpqln27XFV+imrdX20o+NDyQhIrLbsU6y+MX3msFbuTG
jmfO1EJgYYAk7omGzr+9GK0j32w0Zq58TARxrLpNKQ0kgLYDG9M=
=yunS
-----END PGP SIGNATURE-----

--2YJj5f1P6Th4nBRw--
