Received: from eggs.gnu.org ([2001:4830:134:3::10]:56040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dexwA-0007Ov-V4
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 02:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dexw5-0007lW-Ta
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 02:24:18 -0400
Date: Tue, 8 Aug 2017 16:24:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170808062401.GD25081@umbus.fritz.box>
References: <cover.1502087564.git.sam.bobroff@au1.ibm.com>
	<2b5e13652c749b9ad2a519190396fe4160ac0dea.1502087564.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gE7i1rD7pdK0Ng3j"
Content-Disposition: inline
In-Reply-To: <2b5e13652c749b9ad2a519190396fe4160ac0dea.1502087564.git.sam.bobroff@au1.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] ppc: spapr: Make VCPU ID handling
 private to SPAPR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--gE7i1rD7pdK0Ng3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2017 at 04:33:29PM +1000, Sam Bobroff wrote:
> The concept of a VCPU ID that differs from the CPU's index
> (cpu->cpu_index) exists only within SPAPR machines so, move the
> functions ppc_get_vcpu_id() and ppc_get_cpu_by_vcpu_id() into spapr.c
> and rename them appropriately.
>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> ---
> Changes in v2:
>=20
> * Re-arranged so that spapr_vcpu_id() calls kvm_arch_vcpu_id() rather tha=
n the
> other way around.

Ah.. so close..

[snip]
> +int spapr_vcpu_id(PowerPCCPU *cpu)
> +{
> +    CPUState *cs =3D CPU(cpu);
> +
> +    if (kvm_enabled()) {
> +        return kvm_arch_vcpu_id(cs);
> +    } else {
> +        return cs->cpu_index;
> +    }
> +}
> +
> +PowerPCCPU *spapr_find_cpu(int vcpu_id)
> +{
> +    CPUState *cs;
> +
> +    CPU_FOREACH(cs) {
> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +
> +        if (cpu->vcpu_id =3D=3D vcpu_id) {

This is still reaching into vcpu_id which should really be cpu
private, not in spapr.  You can use spapr_vcpu_id() which you already
defined to avoid this.

With that done, I believe it should be possible to put cpu->vcpu_id in
an ifdef CONFIG_KVM and have things work.

> +            return cpu;
> +        }
> +    }
> +
> +    return NULL;
> +}

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gE7i1rD7pdK0Ng3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmJWQEACgkQbDjKyiDZ
s5Jp2Q/+OIOLIFSP7NhAbsftLhemS9/H/KeEETQpAuM6/G60F+OrKNNtYhS4q1EP
iWpzgWP7v+n/aZaHGDqwaaTsyML9uOc34Ox0gqR00y6i3BsS7MdNU4dBg5cEvaer
vFGmA8EwywM01QmbtBEf0Cke2bgX7B7rTDobx6JbcwuNXfBSmhad7X/aeO8DPt9w
ibOol7GmLMnUCDRDiW+zydJLi5rlLOBwvkYdc2HUhy2p1T6RDSeg5dFkPfcehcJe
r0BzPR+iJh4bv1/TaghuFDEBdJVm3VRl0XY5aFmIghtmfPw1MWYB3k5bczlRidnq
VQZnAxOnZdcHpbSkelBekiXLdyibSlmkHAkMQKK91l4+l1mHNdITSBL5bpi3D1gf
UPweyOY2EnvORZtgw4gI+bpNewyzvX83jR7APWQGTcPaBq3tb5XeymqadmaN3jlk
x1gno3BBjTDl6jVXFKhO8mGnOFh08tycgStYlUX7QdV0ACqRFArANpd8VRRFUJ8z
q96/0tf8twHeveK6fr+sPRlwz6PJB0FWHEMNf1cj8BlVjHtwkIHCfzGwZQzAOnE4
nstylG9JbMBzRyyM0k1UaexpDuNoyr3yObLkuipuDtyG1yqn5Ja76p8ZRvQtYPq2
2mg7CIHYTvXowd85k6kiojYPOKdJJWPTiRQ8Yisdst9+e+TAiDg=
=9tkA
-----END PGP SIGNATURE-----

--gE7i1rD7pdK0Ng3j--
