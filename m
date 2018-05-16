Received: from eggs.gnu.org ([2001:4830:134:3::10]:55017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fJ64D-00011i-99
	for qemu-devel@nongnu.org; Wed, 16 May 2018 19:42:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fJ64C-0007ro-6w
	for qemu-devel@nongnu.org; Wed, 16 May 2018 19:42:45 -0400
Received: from mail-lf0-x236.google.com ([2a00:1450:4010:c07::236]:45661)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fJ64B-0007rK-Rl
	for qemu-devel@nongnu.org; Wed, 16 May 2018 19:42:44 -0400
Received: by mail-lf0-x236.google.com with SMTP id w202-v6so5949086lff.12
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 16:42:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180516185146.30708-33-edgar.iglesias@gmail.com>
References: <20180516185146.30708-1-edgar.iglesias@gmail.com>
	<20180516185146.30708-33-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 16 May 2018 16:42:11 -0700
Message-ID: <CAKmqyKOoAi2NaRoS4vA08i0yndrKhSOGdCLvryLe6r6b1y7N5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 32/38] target-microblaze: mmu: Cleanup
 debug log messages
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
> Cleanup debug log messages:
> * Avoid long 80+ character lines.
> * Remove D() macro and use qemu_log_mask.
> * Remove logs that are not very useful
>
> Suggested-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/microblaze/mmu.c | 39 +++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 20 deletions(-)
>
> diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
> index 9ecffb2c9c..f4ceaea520 100644
> --- a/target/microblaze/mmu.c
> +++ b/target/microblaze/mmu.c
> @@ -22,8 +22,6 @@
>  #include "cpu.h"
>  #include "exec/exec-all.h"
>
> -#define D(x)
> -
>  static unsigned int tlb_decode_size(unsigned int f)
>  {
>      static const unsigned int sizes[] = {
> @@ -90,25 +88,20 @@ unsigned int mmu_translate(struct microblaze_mmu *mmu,
>
>          /* Lookup and decode.  */
>          t = mmu->rams[RAM_TAG][i];
> -        D(qemu_log("TLB %d valid=%" PRId64 "\n", i, t & TLB_VALID));
>          if (t & TLB_VALID) {
>              tlb_size = tlb_decode_size((t & TLB_PAGESZ_MASK) >> 7);
>              if (tlb_size < TARGET_PAGE_SIZE) {
> -                qemu_log("%d pages not supported\n", tlb_size);
> +                qemu_log_mask(LOG_UNIMP, "%d pages not supported\n", tlb_size);
>                  abort();
>              }
>
>              mask = ~((uint64_t)tlb_size - 1);
>              tlb_tag = t & TLB_EPN_MASK;
>              if ((vaddr & mask) != (tlb_tag & mask)) {
> -                D(qemu_log("TLB %d vaddr=%" PRIx64 " != tag=%" PRIx64 "\n",
> -                           i, vaddr & mask, tlb_tag & mask));
>                  continue;
>              }
>              if (mmu->tids[i]
>                  && ((mmu->regs[MMU_R_PID] & 0xff) != mmu->tids[i])) {
> -                D(qemu_log("TLB %d pid=%x != tid=%x\n",
> -                           i, mmu->regs[MMU_R_PID], mmu->tids[i]));
>                  continue;
>              }
>
> @@ -123,7 +116,8 @@ unsigned int mmu_translate(struct microblaze_mmu *mmu,
>              t0 &= 0x3;
>
>              if (tlb_zsel > mmu->c_mmu_zones) {
> -                qemu_log_mask(LOG_GUEST_ERROR, "tlb zone select out of range! %d\n", tlb_zsel);
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "tlb zone select out of range! %d\n", tlb_zsel);
>                  t0 = 1; /* Ignore.  */
>              }
>
> @@ -174,8 +168,9 @@ unsigned int mmu_translate(struct microblaze_mmu *mmu,
>          }
>      }
>  done:
> -    D(qemu_log("MMU vaddr=%" PRIx64 " rw=%d tlb_wr=%d tlb_ex=%d hit=%d\n",
> -              vaddr, rw, tlb_wr, tlb_ex, hit));
> +    qemu_log_mask(CPU_LOG_MMU,
> +                  "MMU vaddr=%" PRIx64 " rw=%d tlb_wr=%d tlb_ex=%d hit=%d\n",
> +                  vaddr, rw, tlb_wr, tlb_ex, hit);
>      return hit;
>  }
>
> @@ -199,7 +194,8 @@ uint32_t mmu_read(CPUMBState *env, bool ext, uint32_t rn)
>          case MMU_R_TLBLO:
>          case MMU_R_TLBHI:
>              if (!(env->mmu.c_mmu_tlb_access & 1)) {
> -                qemu_log_mask(LOG_GUEST_ERROR, "Invalid access to MMU reg %d\n", rn);
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "Invalid access to MMU reg %d\n", rn);
>                  return 0;
>              }
>
> @@ -211,7 +207,8 @@ uint32_t mmu_read(CPUMBState *env, bool ext, uint32_t rn)
>          case MMU_R_PID:
>          case MMU_R_ZPR:
>              if (!(env->mmu.c_mmu_tlb_access & 1)) {
> -                qemu_log_mask(LOG_GUEST_ERROR, "Invalid access to MMU reg %d\n", rn);
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "Invalid access to MMU reg %d\n", rn);
>                  return 0;
>              }
>              r = env->mmu.regs[rn];
> @@ -226,7 +223,7 @@ uint32_t mmu_read(CPUMBState *env, bool ext, uint32_t rn)
>              qemu_log_mask(LOG_GUEST_ERROR, "Invalid MMU register %d.\n", rn);
>              break;
>      }
> -    D(qemu_log("%s rn=%d=%x\n", __func__, rn, r));
> +    qemu_log_mask(CPU_LOG_MMU, "%s rn=%d=%x\n", __func__, rn, r);
>      return r;
>  }
>
> @@ -235,7 +232,8 @@ void mmu_write(CPUMBState *env, bool ext, uint32_t rn, uint32_t v)
>      MicroBlazeCPU *cpu = mb_env_get_cpu(env);
>      uint64_t tmp64;
>      unsigned int i;
> -    D(qemu_log("%s rn=%d=%x old=%x\n", __func__, rn, v, env->mmu.regs[rn]));
> +    qemu_log_mask(CPU_LOG_MMU,
> +                  "%s rn=%d=%x old=%x\n", __func__, rn, v, env->mmu.regs[rn]);
>
>      if (env->mmu.c_mmu < 2 || !env->mmu.c_mmu_tlb_access) {
>          qemu_log_mask(LOG_GUEST_ERROR, "MMU access on MMU-less system\n");
> @@ -261,12 +259,11 @@ void mmu_write(CPUMBState *env, bool ext, uint32_t rn, uint32_t v)
>              }
>              tmp64 = env->mmu.rams[rn & 1][i];
>              env->mmu.rams[rn & 1][i] = deposit64(tmp64, ext * 32, 32, v);
> -
> -            D(qemu_log("%s ram[%d][%d]=%x\n", __func__, rn & 1, i, v));
>              break;
>          case MMU_R_ZPR:
>              if (env->mmu.c_mmu_tlb_access <= 1) {
> -                qemu_log_mask(LOG_GUEST_ERROR, "Invalid access to MMU reg %d\n", rn);
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "Invalid access to MMU reg %d\n", rn);
>                  return;
>              }
>
> @@ -279,7 +276,8 @@ void mmu_write(CPUMBState *env, bool ext, uint32_t rn, uint32_t v)
>              break;
>          case MMU_R_PID:
>              if (env->mmu.c_mmu_tlb_access <= 1) {
> -                qemu_log_mask(LOG_GUEST_ERROR, "Invalid access to MMU reg %d\n", rn);
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "Invalid access to MMU reg %d\n", rn);
>                  return;
>              }
>
> @@ -298,7 +296,8 @@ void mmu_write(CPUMBState *env, bool ext, uint32_t rn, uint32_t v)
>              int hit;
>
>              if (env->mmu.c_mmu_tlb_access <= 1) {
> -                qemu_log_mask(LOG_GUEST_ERROR, "Invalid access to MMU reg %d\n", rn);
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "Invalid access to MMU reg %d\n", rn);
>                  return;
>              }
>
> --
> 2.14.1
>
>
