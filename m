Received: from eggs.gnu.org ([2001:4830:134:3::10]:52367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f9DFG-0007Pk-MM
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:21:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f9DFB-0008OC-I3
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:21:18 -0400
Received: from 3.mo177.mail-out.ovh.net ([46.105.36.172]:32928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f9DFB-0008NP-7k
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:21:13 -0400
Received: from player791.ha.ovh.net (unknown [10.109.120.50])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id B0DF3AD358
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 19:21:11 +0200 (CEST)
Date: Thu, 19 Apr 2018 19:21:05 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180419192105.7eb51b26@bahia.lan>
In-Reply-To: <20180417071722.9399-3-david@gibson.dropbear.id.au>
References: <20180417071722.9399-1-david@gibson.dropbear.id.au>
	<20180417071722.9399-3-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.13 02/10] spapr: Remove support for
 PowerPC 970 with pseries machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: benh@kernel.crashing.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, 17 Apr 2018 17:17:14 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> Current POWER cpus allow for a VRMA, a special mapping which describes a
> guest's view of memory when in real mode (MMU off, from the guest's point
> of view).  Older cpus didn't have that which meant that to support a guest
> a special host-contiguous region of memory was needed to give the guest its
> Real Mode Area (RMA).
> 
> This was useful in the early days of KVM on Power to allow it to be tested
> on PowerPC 970 chips as used in Macintosh G5 machines.  Now, however, those
> machines are so old as to be irrelevant, and the host kernel has long since
> dropped support for this mode.  It hasn't been tested in ages either.
> 
> So, to simplify the code, drop the support from qemu as well.
> 

So this could possibly break TCG guests with 970, which happens to be
bootable with the current code ?

$ cat /etc/redhat-release
Red Hat Enterprise Linux Server release 6.9 (Santiago)
$ cat /proc/cpuinfo 
processor       : 0
cpu             : PPC970, altivec supported
clock           : 1000.000000MHz
revision        : 2.2 (pvr 0039 0202)

timebase        : 512000000
platform        : pSeries
model           : IBM pSeries (emulated by qemu)
machine         : CHRP IBM pSeries (emulated by qemu)

I guess nobody uses this setup, but my understanding is that some
rules must be followed when it comes to removing something that
works.

https://wiki.qemu.org/Features/LegacyRemoval#Rules_for_removing_an_interface

Maybe add a warning if 970 is used, and turn it into an error in two releases
along with this patch ?

> As well as the code for handling contiguous RMAs, we can remove some
> code to set the HIOR register, which existed on 970 but not on the
> current and supported CPUs.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c          | 61 +++++++++++++++----------------------------------
>  hw/ppc/spapr_cpu_core.c |  2 --
>  target/ppc/kvm.c        | 36 -----------------------------
>  target/ppc/kvm_ppc.h    |  6 -----
>  4 files changed, 19 insertions(+), 86 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 81b50af3b5..fbb2c6752c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2376,9 +2376,6 @@ static void spapr_machine_init(MachineState *machine)
>      int i;
>      MemoryRegion *sysmem = get_system_memory();
>      MemoryRegion *ram = g_new(MemoryRegion, 1);
> -    MemoryRegion *rma_region;
> -    void *rma = NULL;
> -    hwaddr rma_alloc_size;
>      hwaddr node0_size = spapr_node0_size(machine);
>      long load_limit, fw_size;
>      char *filename;
> @@ -2417,40 +2414,28 @@ static void spapr_machine_init(MachineState *machine)
>          exit(1);
>      }
>  
> -    /* Allocate RMA if necessary */
> -    rma_alloc_size = kvmppc_alloc_rma(&rma);
> +    spapr->rma_size = node0_size;
>  
> -    if (rma_alloc_size == -1) {
> -        error_report("Unable to create RMA");
> -        exit(1);
> +    /* With KVM, we don't actually know whether KVM supports an
> +     * unbounded RMA (PR KVM) or is limited by the hash table size (HV
> +     * KVM using VRMA), so we always assume the latter
> +     *
> +     * In that case, we also limit the initial allocations for RTAS
> +     * etc... to 256M since we have no way to know what the VRMA size
> +     * is going to be as it depends on the size of the hash table
> +     * isn't determined yet.
> +     */
> +    if (kvm_enabled()) {
> +        spapr->vrma_adjust = 1;
> +        spapr->rma_size = MIN(spapr->rma_size, 0x10000000);
>      }
>  
> -    if (rma_alloc_size && (rma_alloc_size < node0_size)) {
> -        spapr->rma_size = rma_alloc_size;
> -    } else {
> -        spapr->rma_size = node0_size;
> -
> -        /* With KVM, we don't actually know whether KVM supports an
> -         * unbounded RMA (PR KVM) or is limited by the hash table size
> -         * (HV KVM using VRMA), so we always assume the latter
> -         *
> -         * In that case, we also limit the initial allocations for RTAS
> -         * etc... to 256M since we have no way to know what the VRMA size
> -         * is going to be as it depends on the size of the hash table
> -         * isn't determined yet.
> -         */
> -        if (kvm_enabled()) {
> -            spapr->vrma_adjust = 1;
> -            spapr->rma_size = MIN(spapr->rma_size, 0x10000000);
> -        }
> -
> -        /* Actually we don't support unbounded RMA anymore since we
> -         * added proper emulation of HV mode. The max we can get is
> -         * 16G which also happens to be what we configure for PAPR
> -         * mode so make sure we don't do anything bigger than that
> -         */
> -        spapr->rma_size = MIN(spapr->rma_size, 0x400000000ull);
> -    }
> +    /* Actually we don't support unbounded RMA anymore since we
> +     * added proper emulation of HV mode. The max we can get is
> +     * 16G which also happens to be what we configure for PAPR
> +     * mode so make sure we don't do anything bigger than that
> +     */
> +    spapr->rma_size = MIN(spapr->rma_size, 0x400000000ull);
>  
>      if (spapr->rma_size > node0_size) {
>          error_report("Numa node 0 has to span the RMA (%#08"HWADDR_PRIx")",
> @@ -2508,14 +2493,6 @@ static void spapr_machine_init(MachineState *machine)
>                                           machine->ram_size);
>      memory_region_add_subregion(sysmem, 0, ram);
>  
> -    if (rma_alloc_size && rma) {
> -        rma_region = g_new(MemoryRegion, 1);
> -        memory_region_init_ram_ptr(rma_region, NULL, "ppc_spapr.rma",
> -                                   rma_alloc_size, rma);
> -        vmstate_register_ram_global(rma_region);
> -        memory_region_add_subregion(sysmem, 0, rma_region);
> -    }
> -
>      /* initialize hotplug memory address space */
>      if (machine->ram_size < machine->maxram_size) {
>          ram_addr_t hotplug_mem_size = machine->maxram_size - machine->ram_size;
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index aa17626cda..f39d99a8da 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -36,8 +36,6 @@ static void spapr_cpu_reset(void *opaque)
>       * using an RTAS call */
>      cs->halted = 1;
>  
> -    env->spr[SPR_HIOR] = 0;
> -
>      /* Disable Power-saving mode Exit Cause exceptions for the CPU.
>       * This can cause issues when rebooting the guest if a secondary
>       * is awaken */
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 6de59c5b21..51177a8e00 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2159,42 +2159,6 @@ void kvmppc_hint_smt_possible(Error **errp)
>  
>  
>  #ifdef TARGET_PPC64
> -off_t kvmppc_alloc_rma(void **rma)
> -{
> -    off_t size;
> -    int fd;
> -    struct kvm_allocate_rma ret;
> -
> -    /* If cap_ppc_rma == 0, contiguous RMA allocation is not supported
> -     * if cap_ppc_rma == 1, contiguous RMA allocation is supported, but
> -     *                      not necessary on this hardware
> -     * if cap_ppc_rma == 2, contiguous RMA allocation is needed on this hardware
> -     *
> -     * FIXME: We should allow the user to force contiguous RMA
> -     * allocation in the cap_ppc_rma==1 case.
> -     */
> -    if (cap_ppc_rma < 2) {
> -        return 0;
> -    }
> -
> -    fd = kvm_vm_ioctl(kvm_state, KVM_ALLOCATE_RMA, &ret);
> -    if (fd < 0) {
> -        fprintf(stderr, "KVM: Error on KVM_ALLOCATE_RMA: %s\n",
> -                strerror(errno));
> -        return -1;
> -    }
> -
> -    size = MIN(ret.rma_size, 256ul << 20);
> -
> -    *rma = mmap(NULL, size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
> -    if (*rma == MAP_FAILED) {
> -        fprintf(stderr, "KVM: Error mapping RMA: %s\n", strerror(errno));
> -        return -1;
> -    };
> -
> -    return size;
> -}
> -
>  uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shift)
>  {
>      struct kvm_ppc_smmu_info info;
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 4d2789eef6..e2840e1d33 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -37,7 +37,6 @@ target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
>                                       bool radix, bool gtse,
>                                       uint64_t proc_tbl);
>  #ifndef CONFIG_USER_ONLY
> -off_t kvmppc_alloc_rma(void **rma);
>  bool kvmppc_spapr_use_multitce(void);
>  int kvmppc_spapr_enable_inkernel_multitce(void);
>  void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t page_shift,
> @@ -188,11 +187,6 @@ static inline target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
>  }
>  
>  #ifndef CONFIG_USER_ONLY
> -static inline off_t kvmppc_alloc_rma(void **rma)
> -{
> -    return 0;
> -}
> -
>  static inline bool kvmppc_spapr_use_multitce(void)
>  {
>      return false;
