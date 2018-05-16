Received: from eggs.gnu.org ([2001:4830:134:3::10]:57007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fJ6Ct-0004Zq-Uv
	for qemu-devel@nongnu.org; Wed, 16 May 2018 19:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fJ6Ct-0002aA-2N
	for qemu-devel@nongnu.org; Wed, 16 May 2018 19:51:44 -0400
Received: from mail-lf0-x22b.google.com ([2a00:1450:4010:c07::22b]:33456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fJ6Cs-0002Zy-Qu
	for qemu-devel@nongnu.org; Wed, 16 May 2018 19:51:42 -0400
Received: by mail-lf0-x22b.google.com with SMTP id h9-v6so6033227lfi.0
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 16:51:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180516185146.30708-39-edgar.iglesias@gmail.com>
References: <20180516185146.30708-1-edgar.iglesias@gmail.com>
	<20180516185146.30708-39-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 16 May 2018 16:51:10 -0700
Message-ID: <CAKmqyKNnuseotDG=-CouCEcYSq806JKcQkMHDLLn3F9+=8KyRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 38/38] target-microblaze: Consolidate
 MMU enabled checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, Richard Henderson <richard.henderson@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>

On Wed, May 16, 2018 at 11:51 AM, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Consolidate MMU enabled checks to cpu_mmu_index().
> No functional changes.
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/microblaze/cpu.h    | 4 +++-
>  target/microblaze/helper.c | 6 +++---
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index c77ca2d8f9..3c4e0ba80a 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -360,8 +360,10 @@ int cpu_mb_signal_handler(int host_signum, void *pinfo,
>
>  static inline int cpu_mmu_index (CPUMBState *env, bool ifetch)
>  {
> +    MicroBlazeCPU *cpu = mb_env_get_cpu(env);
> +
>      /* Are we in nommu mode?.  */
> -    if (!(env->sregs[SR_MSR] & MSR_VM)) {
> +    if (!(env->sregs[SR_MSR] & MSR_VM) || !cpu->cfg.use_mmu) {
>          return MMU_NOMMU_IDX;
>      }
>
> diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
> index 985bdae8d1..bc753793ec 100644
> --- a/target/microblaze/helper.c
> +++ b/target/microblaze/helper.c
> @@ -58,8 +58,7 @@ int mb_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
>      int prot;
>
>      /* Translate if the MMU is available and enabled.  */
> -    if (cpu->cfg.use_mmu && (env->sregs[SR_MSR] & MSR_VM)
> -        && mmu_idx != MMU_NOMMU_IDX) {
> +    if (mmu_idx != MMU_NOMMU_IDX) {
>          uint32_t vaddr, paddr;
>          struct microblaze_mmu_lookup lu;
>
> @@ -270,9 +269,10 @@ hwaddr mb_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>      CPUMBState *env = &cpu->env;
>      target_ulong vaddr, paddr = 0;
>      struct microblaze_mmu_lookup lu;
> +    int mmu_idx = cpu_mmu_index(env, false);
>      unsigned int hit;
>
> -    if (env->sregs[SR_MSR] & MSR_VM) {
> +    if (mmu_idx != MMU_NOMMU_IDX) {
>          hit = mmu_translate(&env->mmu, &lu, addr, 0, 0);
>          if (hit) {
>              vaddr = addr & TARGET_PAGE_MASK;
> --
> 2.14.1
>
>
