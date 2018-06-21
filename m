Received: from eggs.gnu.org ([2001:4830:134:3::10]:46562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVsan-0002Lu-CY
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 01:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVsaj-0002xm-BT
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 01:57:13 -0400
Received: from 3.mo1.mail-out.ovh.net ([46.105.60.232]:60258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fVsaj-0002vY-3l
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 01:57:09 -0400
Received: from player796.ha.ovh.net (unknown [10.109.105.97])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 5DAD01082FE
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 07:57:07 +0200 (CEST)
References: <20180618063606.2513-1-david@gibson.dropbear.id.au>
	<20180618063606.2513-5-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d10c36f4-9e4b-0893-25d3-0786def1b463@kaod.org>
Date: Thu, 21 Jun 2018 07:56:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180618063606.2513-5-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/9] target/ppc: Add
 kvmppc_hpt_needs_host_contiguous_pages() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org, abologna@redhat.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru

On 06/18/2018 08:36 AM, David Gibson wrote:
> KVM HV has a restriction that for HPT mode guests, guest pages must be =
hpa
> contiguous as well as gpa contiguous.  We have to account for that in
> various places.  We determine whether we're subject to this restriction
> from the SMMU information exposed by KVM.
>=20
> Planned cleanups to the way we handle this will require knowing whether
> this restriction is in play in wider parts of the code.  So, expose a
> helper function which returns it.
>=20
> This does mean some redundant calls to kvm_get_smmu_info(), but they'll=
 go
> away again with future cleanups.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

but this patch is already committed it seems.

C.=20

> ---
>  target/ppc/kvm.c     | 17 +++++++++++++++--
>  target/ppc/kvm_ppc.h |  6 ++++++
>  2 files changed, 21 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 5c0e313ca6..50b5d01432 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -406,9 +406,22 @@ target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *c=
pu,
>      }
>  }
> =20
> +bool kvmppc_hpt_needs_host_contiguous_pages(void)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> +    static struct kvm_ppc_smmu_info smmu_info;
> +
> +    if (!kvm_enabled()) {
> +        return false;
> +    }
> +
> +    kvm_get_smmu_info(cpu, &smmu_info);
> +    return !!(smmu_info.flags & KVM_PPC_PAGE_SIZES_REAL);


> +}
> +
>  static bool kvm_valid_page_size(uint32_t flags, long rampgsize, uint32=
_t shift)
>  {
> -    if (!(flags & KVM_PPC_PAGE_SIZES_REAL)) {
> +    if (!kvmppc_hpt_needs_host_contiguous_pages()) {
>          return true;
>      }
> =20
> @@ -445,7 +458,7 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
>      /* If we have HV KVM, we need to forbid CI large pages if our
>       * host page size is smaller than 64K.
>       */
> -    if (smmu_info.flags & KVM_PPC_PAGE_SIZES_REAL) {
> +    if (kvmppc_hpt_needs_host_contiguous_pages()) {
>          if (getpagesize() >=3D 0x10000) {
>              cpu->hash64_opts->flags |=3D PPC_HASH64_CI_LARGEPAGE;
>          } else {
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index e2840e1d33..a7ddb8a5d6 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -70,6 +70,7 @@ int kvmppc_resize_hpt_prepare(PowerPCCPU *cpu, target=
_ulong flags, int shift);
>  int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, target_ulong flags, int =
shift);
>  bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu);
> =20
> +bool kvmppc_hpt_needs_host_contiguous_pages(void);
>  bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path);
> =20
>  #else
> @@ -222,6 +223,11 @@ static inline uint64_t kvmppc_rma_size(uint64_t cu=
rrent_size,
>      return ram_size;
>  }
> =20
> +static inline bool kvmppc_hpt_needs_host_contiguous_pages(void)
> +{
> +    return false;
> +}
> +
>  static inline bool kvmppc_is_mem_backend_page_size_ok(const char *obj_=
path)
>  {
>      return true;
>=20
