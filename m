Received: from eggs.gnu.org ([2001:4830:134:3::10]:45788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fN74Q-0003Mo-NF
	for qemu-devel@nongnu.org; Sun, 27 May 2018 21:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fN74P-0004tg-C0
	for qemu-devel@nongnu.org; Sun, 27 May 2018 21:35:34 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:39079)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fN74P-0004sf-4i
	for qemu-devel@nongnu.org; Sun, 27 May 2018 21:35:33 -0400
Received: by mail-qt0-x244.google.com with SMTP id f1-v6so13225911qtj.6
	for <qemu-devel@nongnu.org>; Sun, 27 May 2018 18:35:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180527141324.11937-1-richard.henderson@linaro.org>
	<20180527141324.11937-15-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a334a9c9-13c1-da8a-94ce-ceab5e2d462d@amsat.org>
Date: Sun, 27 May 2018 22:35:29 -0300
MIME-Version: 1.0
In-Reply-To: <20180527141324.11937-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 14/20] target/openrisc: Use identical sizes
 for ITLB and DTLB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>

On 05/27/2018 11:13 AM, Richard Henderson wrote:
> The sizes are already the same, however, we can improve things
> if they are identical by design.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/openrisc/cpu.h        | 10 ++++------
>  target/openrisc/machine.c    |  4 ++--
>  target/openrisc/mmu.c        |  4 ++--
>  target/openrisc/sys_helper.c | 16 ++++++++--------
>  4 files changed, 16 insertions(+), 18 deletions(-)
> 
> diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
> index c48802ad8f..53abe965e8 100644
> --- a/target/openrisc/cpu.h
> +++ b/target/openrisc/cpu.h
> @@ -222,10 +222,8 @@ enum {
>  
>  /* TLB size */
>  enum {
> -    DTLB_SIZE = 64,
> -    DTLB_MASK = (DTLB_SIZE-1),
> -    ITLB_SIZE = 64,
> -    ITLB_MASK = (ITLB_SIZE-1),
> +    TLB_SIZE = 64,
> +    TLB_MASK = TLB_SIZE - 1,
>  };
>  
>  /* TLB prot */
> @@ -254,8 +252,8 @@ typedef struct OpenRISCTLBEntry {
>  
>  #ifndef CONFIG_USER_ONLY
>  typedef struct CPUOpenRISCTLBContext {
> -    OpenRISCTLBEntry itlb[ITLB_SIZE];
> -    OpenRISCTLBEntry dtlb[DTLB_SIZE];
> +    OpenRISCTLBEntry itlb[TLB_SIZE];
> +    OpenRISCTLBEntry dtlb[TLB_SIZE];
>  
>      int (*cpu_openrisc_map_address_code)(struct OpenRISCCPU *cpu,
>                                           hwaddr *physical,
> diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
> index b795b56dc6..3fc837b925 100644
> --- a/target/openrisc/machine.c
> +++ b/target/openrisc/machine.c
> @@ -42,9 +42,9 @@ static const VMStateDescription vmstate_cpu_tlb = {
>      .minimum_version_id = 1,
>      .minimum_version_id_old = 1,
>      .fields = (VMStateField[]) {
> -        VMSTATE_STRUCT_ARRAY(itlb, CPUOpenRISCTLBContext, ITLB_SIZE, 0,
> +        VMSTATE_STRUCT_ARRAY(itlb, CPUOpenRISCTLBContext, TLB_SIZE, 0,
>                               vmstate_tlb_entry, OpenRISCTLBEntry),
> -        VMSTATE_STRUCT_ARRAY(dtlb, CPUOpenRISCTLBContext, DTLB_SIZE, 0,
> +        VMSTATE_STRUCT_ARRAY(dtlb, CPUOpenRISCTLBContext, TLB_SIZE, 0,
>                               vmstate_tlb_entry, OpenRISCTLBEntry),
>          VMSTATE_END_OF_LIST()
>      }
> diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
> index 11b8187cda..ee3016a8b9 100644
> --- a/target/openrisc/mmu.c
> +++ b/target/openrisc/mmu.c
> @@ -41,7 +41,7 @@ static int get_phys_code(OpenRISCCPU *cpu, hwaddr *physical, int *prot,
>                           target_ulong address, int rw, bool supervisor)
>  {
>      int vpn = address >> TARGET_PAGE_BITS;
> -    int idx = vpn & ITLB_MASK;
> +    int idx = vpn & TLB_MASK;
>      int right = 0;
>      uint32_t mr = cpu->env.tlb.itlb[idx].mr;
>      uint32_t tr = cpu->env.tlb.itlb[idx].tr;
> @@ -74,7 +74,7 @@ static int get_phys_data(OpenRISCCPU *cpu, hwaddr *physical, int *prot,
>                           target_ulong address, int rw, bool supervisor)
>  {
>      int vpn = address >> TARGET_PAGE_BITS;
> -    int idx = vpn & DTLB_MASK;
> +    int idx = vpn & TLB_MASK;
>      int right = 0;
>      uint32_t mr = cpu->env.tlb.dtlb[idx].mr;
>      uint32_t tr = cpu->env.tlb.dtlb[idx].tr;
> diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
> index 0a74c9522f..7254aa9830 100644
> --- a/target/openrisc/sys_helper.c
> +++ b/target/openrisc/sys_helper.c
> @@ -79,7 +79,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
>          idx = (spr - 1024);
>          env->shadow_gpr[idx / 32][idx % 32] = rb;
>  
> -    case TO_SPR(1, 512) ... TO_SPR(1, 512+DTLB_SIZE-1): /* DTLBW0MR 0-127 */
> +    case TO_SPR(1, 512) ... TO_SPR(1, 512 + TLB_SIZE - 1): /* DTLBW0MR 0-127 */
>          idx = spr - TO_SPR(1, 512);
>          mr = env->tlb.dtlb[idx].mr;
>          if (mr & 1) {
> @@ -90,7 +90,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
>          }
>          env->tlb.dtlb[idx].mr = rb;
>          break;
> -    case TO_SPR(1, 640) ... TO_SPR(1, 640+DTLB_SIZE-1): /* DTLBW0TR 0-127 */
> +    case TO_SPR(1, 640) ... TO_SPR(1, 640 + TLB_SIZE - 1): /* DTLBW0TR 0-127 */
>          idx = spr - TO_SPR(1, 640);
>          env->tlb.dtlb[idx].tr = rb;
>          break;
> @@ -102,7 +102,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
>      case TO_SPR(1, 1408) ... TO_SPR(1, 1535): /* DTLBW3TR 0-127 */
>          break;
>  
> -    case TO_SPR(2, 512) ... TO_SPR(2, 512+ITLB_SIZE-1):   /* ITLBW0MR 0-127 */
> +    case TO_SPR(2, 512) ... TO_SPR(2, 512 + TLB_SIZE - 1): /* ITLBW0MR 0-127 */
>          idx = spr - TO_SPR(2, 512);
>          mr = env->tlb.itlb[idx].mr;
>          if (mr & 1) {
> @@ -113,7 +113,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
>          }
>          env->tlb.itlb[idx].mr = rb;
>          break;
> -    case TO_SPR(2, 640) ... TO_SPR(2, 640+ITLB_SIZE-1): /* ITLBW0TR 0-127 */
> +    case TO_SPR(2, 640) ... TO_SPR(2, 640 + TLB_SIZE - 1): /* ITLBW0TR 0-127 */
>          idx = spr - TO_SPR(2, 640);
>          env->tlb.itlb[idx].tr = rb;
>          break;
> @@ -246,11 +246,11 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
>          idx = (spr - 1024);
>          return env->shadow_gpr[idx / 32][idx % 32];
>  
> -    case TO_SPR(1, 512) ... TO_SPR(1, 512+DTLB_SIZE-1): /* DTLBW0MR 0-127 */
> +    case TO_SPR(1, 512) ... TO_SPR(1, 512 + TLB_SIZE - 1): /* DTLBW0MR 0-127 */
>          idx = spr - TO_SPR(1, 512);
>          return env->tlb.dtlb[idx].mr;
>  
> -    case TO_SPR(1, 640) ... TO_SPR(1, 640+DTLB_SIZE-1): /* DTLBW0TR 0-127 */
> +    case TO_SPR(1, 640) ... TO_SPR(1, 640 + TLB_SIZE - 1): /* DTLBW0TR 0-127 */
>          idx = spr - TO_SPR(1, 640);
>          return env->tlb.dtlb[idx].tr;
>  
> @@ -262,11 +262,11 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
>      case TO_SPR(1, 1408) ... TO_SPR(1, 1535): /* DTLBW3TR 0-127 */
>          break;
>  
> -    case TO_SPR(2, 512) ... TO_SPR(2, 512+ITLB_SIZE-1): /* ITLBW0MR 0-127 */
> +    case TO_SPR(2, 512) ... TO_SPR(2, 512 + TLB_SIZE - 1): /* ITLBW0MR 0-127 */
>          idx = spr - TO_SPR(2, 512);
>          return env->tlb.itlb[idx].mr;
>  
> -    case TO_SPR(2, 640) ... TO_SPR(2, 640+ITLB_SIZE-1): /* ITLBW0TR 0-127 */
> +    case TO_SPR(2, 640) ... TO_SPR(2, 640 + TLB_SIZE - 1): /* ITLBW0TR 0-127 */
>          idx = spr - TO_SPR(2, 640);
>          return env->tlb.itlb[idx].tr;
>  
> 
