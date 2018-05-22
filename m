Received: from eggs.gnu.org ([2001:4830:134:3::10]:40791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fL4s4-00083Q-30
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:50:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fL4s1-0001Ou-2b
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:50:24 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:39056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fL4s0-0001Nw-Ou
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:50:20 -0400
Received: by mail-wr0-x241.google.com with SMTP id w18-v6so15550129wrn.6
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 03:50:20 -0700 (PDT)
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-6-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180521140402.23318-6-peter.maydell@linaro.org>
Date: Tue, 22 May 2018 11:50:15 +0100
Message-ID: <87in7gufq0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/27] Make address_space_access_valid()
 take a MemTxAttrs argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>


Peter Maydell <peter.maydell@linaro.org> writes:

> As part of plumbing MemTxAttrs down to the IOMMU translate method,
> add MemTxAttrs as an argument to address_space_access_valid().
> Its callers either have an attrs value to hand, or don't care
> and can use MEMTXATTRS_UNSPECIFIED.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/exec/memory.h      | 4 +++-
>  include/sysemu/dma.h       | 3 ++-
>  exec.c                     | 3 ++-
>  target/s390x/diag.c        | 6 ++++--
>  target/s390x/excp_helper.c | 3 ++-
>  target/s390x/mmu_helper.c  | 3 ++-
>  target/s390x/sigp.c        | 3 ++-
>  7 files changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index b1bdb376d4..54263bd23b 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -1937,8 +1937,10 @@ static inline MemoryRegion *address_space_translat=
e(AddressSpace *as,
>   * @addr: address within that address space
>   * @len: length of the area to be checked
>   * @is_write: indicates the transfer direction
> + * @attrs: memory attributes
>   */
> -bool address_space_access_valid(AddressSpace *as, hwaddr addr, int len, =
bool is_write);
> +bool address_space_access_valid(AddressSpace *as, hwaddr addr, int len,
> +                                bool is_write, MemTxAttrs attrs);
>
>  /* address_space_map: map a physical memory region into a host virtual a=
ddress
>   *
> diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
> index 0d73902634..5da3c4e3c5 100644
> --- a/include/sysemu/dma.h
> +++ b/include/sysemu/dma.h
> @@ -77,7 +77,8 @@ static inline bool dma_memory_valid(AddressSpace *as,
>                                      DMADirection dir)
>  {
>      return address_space_access_valid(as, addr, len,
> -                                      dir =3D=3D DMA_DIRECTION_FROM_DEVI=
CE);
> +                                      dir =3D=3D DMA_DIRECTION_FROM_DEVI=
CE,
> +                                      MEMTXATTRS_UNSPECIFIED);
>  }
>
>  static inline int dma_memory_rw_relaxed(AddressSpace *as, dma_addr_t add=
r,
> diff --git a/exec.c b/exec.c
> index 1dc81cfe4a..22af4e8cb9 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3480,7 +3480,8 @@ static bool flatview_access_valid(FlatView *fv, hwa=
ddr addr, int len,
>  }
>
>  bool address_space_access_valid(AddressSpace *as, hwaddr addr,
> -                                int len, bool is_write)
> +                                int len, bool is_write,
> +                                MemTxAttrs attrs)
>  {
>      FlatView *fv;
>      bool result;
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index ac2c40f363..d1d3433aa7 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -87,7 +87,8 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, u=
int64_t r3, uintptr_t ra)
>              return;
>          }
>          if (!address_space_access_valid(&address_space_memory, addr,
> -                                        sizeof(IplParameterBlock), false=
)) {
> +                                        sizeof(IplParameterBlock), false,
> +                                        MEMTXATTRS_UNSPECIFIED)) {
>              s390_program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO, ra);
>              return;
>          }
> @@ -116,7 +117,8 @@ out:
>              return;
>          }
>          if (!address_space_access_valid(&address_space_memory, addr,
> -                                        sizeof(IplParameterBlock), true)=
) {
> +                                        sizeof(IplParameterBlock), true,
> +                                        MEMTXATTRS_UNSPECIFIED)) {
>              s390_program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO, ra);
>              return;
>          }
> diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
> index dfee221111..f0ce60cff2 100644
> --- a/target/s390x/excp_helper.c
> +++ b/target/s390x/excp_helper.c
> @@ -120,7 +120,8 @@ int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr ori=
g_vaddr, int size,
>
>      /* check out of RAM access */
>      if (!address_space_access_valid(&address_space_memory, raddr,
> -                                    TARGET_PAGE_SIZE, rw)) {
> +                                    TARGET_PAGE_SIZE, rw,
> +                                    MEMTXATTRS_UNSPECIFIED)) {
>          DPRINTF("%s: raddr %" PRIx64 " > ram_size %" PRIx64 "\n", __func=
__,
>                  (uint64_t)raddr, (uint64_t)ram_size);
>          trigger_pgm_exception(env, PGM_ADDRESSING, ILEN_AUTO);
> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
> index a25deef5dd..145b62a7ef 100644
> --- a/target/s390x/mmu_helper.c
> +++ b/target/s390x/mmu_helper.c
> @@ -461,7 +461,8 @@ static int translate_pages(S390CPU *cpu, vaddr addr, =
int nr_pages,
>              return ret;
>          }
>          if (!address_space_access_valid(&address_space_memory, pages[i],
> -                                        TARGET_PAGE_SIZE, is_write)) {
> +                                        TARGET_PAGE_SIZE, is_write,
> +                                        MEMTXATTRS_UNSPECIFIED)) {
>              trigger_access_exception(env, PGM_ADDRESSING, ILEN_AUTO, 0);
>              return -EFAULT;
>          }
> diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
> index aff1530c82..c1f9245797 100644
> --- a/target/s390x/sigp.c
> +++ b/target/s390x/sigp.c
> @@ -280,7 +280,8 @@ static void sigp_set_prefix(CPUState *cs, run_on_cpu_=
data arg)
>      cpu_synchronize_state(cs);
>
>      if (!address_space_access_valid(&address_space_memory, addr,
> -                                    sizeof(struct LowCore), false)) {
> +                                    sizeof(struct LowCore), false,
> +                                    MEMTXATTRS_UNSPECIFIED)) {
>          set_sigp_status(si, SIGP_STAT_INVALID_PARAMETER);
>          return;
>      }


--
Alex Benn=C3=A9e
