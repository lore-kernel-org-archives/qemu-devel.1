Received: from eggs.gnu.org ([2001:4830:134:3::10]:42911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSj2S-0000Tk-5I
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:41:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSj2R-0006f2-11
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:41:00 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gSj2Q-0006eq-Is
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:40:58 -0500
Received: by mail-oi1-x242.google.com with SMTP id t204so4725073oie.7
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 05:40:58 -0800 (PST)
MIME-Version: 1.0
References: <1542765966-20244-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1542765966-20244-2-git-send-email-lizhijian@cn.fujitsu.com>
In-Reply-To: <1542765966-20244-2-git-send-email-lizhijian@cn.fujitsu.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Nov 2018 13:40:46 +0000
Message-ID: <CAFEAcA8QsyoLbtjyMpcie0x3mQEzYifx7BiJpy8geQ5YvUw_zQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/5] unify len and addr type for
 memory/address APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Philip Li <philip.li@intel.com>, zhijianx.li@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, 21 Nov 2018 at 02:07, Li Zhijian <lizhijian@cn.fujitsu.com> wrote:
>
> Some address/memory APIs have different type between 'hwaddr addr' and
> 'int len'. It is very unsafety, espcially some APIs will be passed a non-int
> len by caller which might cause overflow quietly.
> Below is an potential overflow case:
>     dma_memory_read(uint32_t len)
>       -> dma_memory_rw(uint32_t len)
>         -> dma_memory_rw_relaxed(uint32_t len)
>           -> address_space_rw(int len) # len overflow
>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Peter Crosthwaite <crosthwaite.peter@gmail.com>
> CC: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>

Hi; this patch is almost all good -- there's just a couple of
functions here which either don't need a change or should
be using something other than hwaddr, which I've commented on
below.

> ---
>  exec.c                    | 49 ++++++++++++++++++++++++-----------------------
>  include/exec/cpu-all.h    |  2 +-
>  include/exec/cpu-common.h | 10 +++++-----
>  include/exec/memory.h     | 20 +++++++++----------
>  4 files changed, 41 insertions(+), 40 deletions(-)
>
> diff --git a/exec.c b/exec.c
> index bb6170d..05823ae 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2719,7 +2719,8 @@ static const MemoryRegionOps notdirty_mem_ops = {
>  };
>
>  /* Generate a debug exception if a watchpoint has been hit.  */
> -static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
> +static void check_watchpoint(hwaddr offset,  unsigned len,
> +                             MemTxAttrs attrs, int flags)

This one doesn't need to change -- the offset is the offset within
the page, so it is always going to fit easily within an "int".

>  {
>      CPUState *cpu = current_cpu;
>      CPUClass *cc = CPU_GET_CLASS(cpu);


> @@ -3099,9 +3100,10 @@ MemoryRegion *get_system_io(void)
>  /* physical memory access (slow version, mainly for debug) */
>  #if defined(CONFIG_USER_ONLY)
>  int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
> -                        uint8_t *buf, int len, int is_write)
> +                        uint8_t *buf, hwaddr len, int is_write)
>  {
> -    int l, flags;
> +    hwaddr l;
> +    int flags;
>      target_ulong page;
>      void * p;

This one is operating on guest virtual addresses, so len should
be a target_ulong, like the addr parameter, as should the "l" variable.

> @@ -3389,7 +3391,7 @@ enum write_rom_type {
>  };
>
>  static inline void cpu_physical_memory_write_rom_internal(AddressSpace *as,
> -    hwaddr addr, const uint8_t *buf, int len, enum write_rom_type type)
> +    hwaddr addr, const uint8_t *buf, hwaddr len, enum write_rom_type type)
>  {
>      hwaddr l;
>      uint8_t *ptr;

Just a note that I have a patchset on-list which renames this
function and cpu_physical_memory_write_rom(), so depending on
what order your patch and mine get into master one of us will
have to rebase (or Paolo might fix up the conflict for us). It's
not a difficult one to fix, so no big deal.

https://patchew.org/QEMU/20181122133507.30950-1-peter.maydell@linaro.org/

>  /* virtual memory access for debug (includes writing to ROM) */
>  int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
> -                        uint8_t *buf, int len, int is_write)
> +                        uint8_t *buf, hwaddr len, int is_write)
>  {
> -    int l;
> -    hwaddr phys_addr;
> +    hwaddr l, phys_addr;
>      target_ulong page;

Here again l and len should be target_ulong, as these are
virtual addresses.

>      cpu_synchronize_state(cpu);
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 117d2fb..4b56672 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -367,7 +367,7 @@ void dump_opcount_info(FILE *f, fprintf_function cpu_fprintf);
>  #endif /* !CONFIG_USER_ONLY */
>
>  int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
> -                        uint8_t *buf, int len, int is_write);
> +                        uint8_t *buf, hwaddr len, int is_write);

target_ulong.

thanks
-- PMM
