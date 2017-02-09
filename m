Received: from eggs.gnu.org ([2001:4830:134:3::10]:46654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbepl-0007Vz-JT
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:51:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbepk-0006x0-Fs
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:51:45 -0500
Date: Thu, 9 Feb 2017 13:16:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170209021629.GR17644@umbus.fritz.box>
References: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
	<a8621842537496c91b6d021ad329e6fa6404cc17.1486436186.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hCenlVgnDQUGHXTR"
Content-Disposition: inline
In-Reply-To: <a8621842537496c91b6d021ad329e6fa6404cc17.1486436186.git.sam.bobroff@au1.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 4/9] target-ppc: support
 KVM_CAP_PPC_MMU_RADIX, KVM_CAP_PPC_MMU_HASH_V3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--hCenlVgnDQUGHXTR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 01:56:47PM +1100, Sam Bobroff wrote:
> Query and cache the value of two new KVM capabilities that indicate
> KVM's support for new radix and hash modes of the MMU.
>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> ---
>  target/ppc/kvm.c     | 14 ++++++++++++++
>  target/ppc/kvm_ppc.h | 12 ++++++++++++
>  2 files changed, 26 insertions(+)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 390d6342cc..8d6fd1b067 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -81,6 +81,8 @@ static int cap_papr;
>  static int cap_htab_fd;
>  static int cap_fixup_hcalls;
>  static int cap_htm;             /* Hardware transactional memory support=
 */
> +static int cap_mmu_radix;
> +static int cap_mmu_hash;

Please rename this cap_mmu_hashv3 to avoid confusion.

Apart from that,

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> =20
>  static uint32_t debug_inst_opcode;
> =20
> @@ -134,6 +136,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      cap_htab_fd =3D kvm_check_extension(s, KVM_CAP_PPC_HTAB_FD);
>      cap_fixup_hcalls =3D kvm_check_extension(s, KVM_CAP_PPC_FIXUP_HCALL);
>      cap_htm =3D kvm_vm_check_extension(s, KVM_CAP_PPC_HTM);
> +    cap_mmu_radix =3D kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_RADIX);
> +    cap_mmu_hash =3D kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_HASH_V3);
> =20
>      if (!cap_interrupt_level) {
>          fprintf(stderr, "KVM: Couldn't find level irq capability. Expect=
 the "
> @@ -2408,6 +2412,16 @@ bool kvmppc_has_cap_htm(void)
>      return cap_htm;
>  }
> =20
> +bool kvmppc_has_cap_mmu_radix(void)
> +{
> +    return cap_mmu_radix;
> +}
> +
> +bool kvmppc_has_cap_mmu_hash(void)
> +{
> +    return cap_mmu_hash;
> +}
> +
>  static PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc)
>  {
>      ObjectClass *oc =3D OBJECT_CLASS(pcc);
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 4b43283913..1c1b94847c 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -56,6 +56,8 @@ void kvmppc_hash64_write_pte(CPUPPCState *env, target_u=
long pte_index,
>                               target_ulong pte0, target_ulong pte1);
>  bool kvmppc_has_cap_fixup_hcalls(void);
>  bool kvmppc_has_cap_htm(void);
> +bool kvmppc_has_cap_mmu_radix(void);
> +bool kvmppc_has_cap_mmu_hash(void);
>  int kvmppc_enable_hwrng(void);
>  int kvmppc_put_books_sregs(PowerPCCPU *cpu);
>  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
> @@ -255,6 +257,16 @@ static inline bool kvmppc_has_cap_htm(void)
>      return false;
>  }
> =20
> +static inline bool kvmppc_has_cap_mmu_radix(void)
> +{
> +    return false;
> +}
> +
> +static inline bool kvmppc_has_cap_mmu_hash(void)
> +{
> +    return false;
> +}
> +
>  static inline int kvmppc_enable_hwrng(void)
>  {
>      return -1;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hCenlVgnDQUGHXTR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYm9D9AAoJEGw4ysog2bOSqwQQALql8k93CrUOZlT87VoGbiyD
0bS+XH7eD8JpTty5yAPDUFXg+UuyIZI9GALLaSh24s6mAbPfjEnwikzhXCjnzEv2
fVgkJnRfs3hJ/9zPN28plqy2GW6bhnD4skYE+wpHR9Kfeg1slh5Eit1kYyqL9P4E
SdqVpYtwO084r330qVqrh1i4tu7VO/o2qf1Xly/vYQ8qR52QSbxyRuPvcQjccsyz
wh2FDaXPlCwXRvDJf4pBf0HrpDkBhKimIQ6zxDQaiKm8+un9ijghQZujwB8T0WFi
Zu8BmdtJIKZQRyQ1KmRYBlf64OyVykxZhSgVwKdSXIQB/lrP6K7i1ohEWTKs2tCE
EvbVtTvw+9E0SjM7ScsUMeUw3qWDdFuw8gAyR+iLqQdHd1tDuU5kqfQFL8cyJNz+
kpwd/kZQdo/+2op6fQ+X3jhZl5n4ipDa1MkWQIYvUkPkrXxAenDZyrlgXzrlDAMT
ZRDuTNELq0UwSRB0kh8MXLerNZBPxhRv2SvnFL/1ejQMK8inphhu5aD3TnUKSy4v
7ngS4cr3a2T7LI3bXxE+JoEuyVEDDlJK4WF6fuSjF2U6gisWoWxtZsKvVf9qKVte
m1tXr0y1rMlxd/7a2tSplbweYusQ8Y+rdzR8Sem2gc1ah3slx6jn5MjxMiMnbOBQ
8vsr+jiwdjUjCTHETAQc
=Yaxw
-----END PGP SIGNATURE-----

--hCenlVgnDQUGHXTR--
