Received: from eggs.gnu.org ([2001:4830:134:3::10]:58608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fUw9V-0007HD-62
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fUw9Q-0006In-5c
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:33:09 -0400
Received: from 10.mo68.mail-out.ovh.net ([46.105.79.203]:41628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fUw9P-0006GV-U0
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:33:04 -0400
Received: from player730.ha.ovh.net (unknown [10.109.120.78])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 7095EE75CE
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 17:33:02 +0200 (CEST)
Date: Mon, 18 Jun 2018 17:32:34 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180618173234.5a307f45@bahia.lan>
In-Reply-To: <20180618063606.2513-5-david@gibson.dropbear.id.au>
References: <20180618063606.2513-1-david@gibson.dropbear.id.au>
	<20180618063606.2513-5-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: abologna@redhat.com, clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru

On Mon, 18 Jun 2018 16:36:01 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> KVM HV has a restriction that for HPT mode guests, guest pages must be hpa
> contiguous as well as gpa contiguous.  We have to account for that in
> various places.  We determine whether we're subject to this restriction
> from the SMMU information exposed by KVM.
> 
> Planned cleanups to the way we handle this will require knowing whether
> this restriction is in play in wider parts of the code.  So, expose a
> helper function which returns it.
> 
> This does mean some redundant calls to kvm_get_smmu_info(), but they'll go
> away again with future cleanups.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  target/ppc/kvm.c     | 17 +++++++++++++++--
>  target/ppc/kvm_ppc.h |  6 ++++++
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 5c0e313ca6..50b5d01432 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -406,9 +406,22 @@ target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
>      }
>  }
>  
> +bool kvmppc_hpt_needs_host_contiguous_pages(void)
> +{
> +    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
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
>  static bool kvm_valid_page_size(uint32_t flags, long rampgsize, uint32_t shift)
>  {
> -    if (!(flags & KVM_PPC_PAGE_SIZES_REAL)) {
> +    if (!kvmppc_hpt_needs_host_contiguous_pages()) {
>          return true;
>      }
>  
> @@ -445,7 +458,7 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
>      /* If we have HV KVM, we need to forbid CI large pages if our
>       * host page size is smaller than 64K.
>       */
> -    if (smmu_info.flags & KVM_PPC_PAGE_SIZES_REAL) {
> +    if (kvmppc_hpt_needs_host_contiguous_pages()) {
>          if (getpagesize() >= 0x10000) {
>              cpu->hash64_opts->flags |= PPC_HASH64_CI_LARGEPAGE;
>          } else {
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index e2840e1d33..a7ddb8a5d6 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -70,6 +70,7 @@ int kvmppc_resize_hpt_prepare(PowerPCCPU *cpu, target_ulong flags, int shift);
>  int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, target_ulong flags, int shift);
>  bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu);
>  
> +bool kvmppc_hpt_needs_host_contiguous_pages(void);
>  bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path);
>  
>  #else
> @@ -222,6 +223,11 @@ static inline uint64_t kvmppc_rma_size(uint64_t current_size,
>      return ram_size;
>  }
>  
> +static inline bool kvmppc_hpt_needs_host_contiguous_pages(void)
> +{
> +    return false;
> +}
> +
>  static inline bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
>  {
>      return true;
