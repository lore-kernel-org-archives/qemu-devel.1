Received: from eggs.gnu.org ([2001:4830:134:3::10]:44177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJKcd-00023Y-52
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:15:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJKcZ-0003EW-Q7
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:15:15 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJKcZ-0003DX-Mu
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:15:11 -0400
Received: by mail-qt0-x243.google.com with SMTP id e8-v6so6229269qth.0
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 08:15:11 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180516185146.30708-1-edgar.iglesias@gmail.com>
	<20180516185146.30708-26-edgar.iglesias@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8f75bf77-e36e-9958-35c9-094aab2d4a10@amsat.org>
Date: Thu, 17 May 2018 12:15:06 -0300
MIME-Version: 1.0
In-Reply-To: <20180516185146.30708-26-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 25/38] target-microblaze: mmu: Remove
 unused register state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, frasse.iglesias@gmail.com, alistair@alistair23.me, richard.henderson@linaro.org, frederic.konrad@adacore.com

On 05/16/2018 03:51 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Add explicit handling for MMU_R_TLBX and log accesses to
> invalid MMU registers. We can now remove the state for
> all regs but PID, ZPR and TLBX (0 - 2).
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/mmu.c | 7 +++++--
>  target/microblaze/mmu.h | 2 +-
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
> index f4a4c339c9..231803ceea 100644
> --- a/target/microblaze/mmu.c
> +++ b/target/microblaze/mmu.c
> @@ -211,11 +211,14 @@ uint32_t mmu_read(CPUMBState *env, uint32_t rn)
>              }
>              r = env->mmu.regs[rn];
>              break;
> +        case MMU_R_TLBX:
> +            r = env->mmu.regs[rn];
> +            break;
>          case MMU_R_TLBSX:
>              qemu_log_mask(LOG_GUEST_ERROR, "TLBSX is write-only.\n");
>              break;
>          default:
> -            r = env->mmu.regs[rn];
> +            qemu_log_mask(LOG_GUEST_ERROR, "Invalid MMU register %d.\n", rn);
>              break;
>      }
>      D(qemu_log("%s rn=%d=%x\n", __func__, rn, r));
> @@ -298,7 +301,7 @@ void mmu_write(CPUMBState *env, uint32_t rn, uint32_t v)
>              break;
>          }
>          default:
> -            env->mmu.regs[rn] = v;

I was afraid of an overflow but the only way to reach this function is
via dec_msr() which calls with rn &= 7, whew. Lot of magic numbers...

> +            qemu_log_mask(LOG_GUEST_ERROR, "Invalid MMU register %d.\n", rn);
>              break;
>     }
>  }
> diff --git a/target/microblaze/mmu.h b/target/microblaze/mmu.h
> index 113539c6e9..624becfded 100644
> --- a/target/microblaze/mmu.h
> +++ b/target/microblaze/mmu.h
> @@ -67,7 +67,7 @@ struct microblaze_mmu
>      /* We keep a separate ram for the tids to avoid the 48 bit tag width.  */
>      uint8_t tids[TLB_ENTRIES];
>      /* Control flops.  */
> -    uint32_t regs[8];
> +    uint32_t regs[3];
>  
>      int c_mmu;
>      int c_mmu_tlb_access;
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
