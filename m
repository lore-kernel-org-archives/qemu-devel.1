Received: from eggs.gnu.org ([2001:4830:134:3::10]:50013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dcFGP-0001oP-Jm
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dcFGL-00027u-Ku
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:17:57 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dcFGL-00027U-DU
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:17:53 -0400
Received: by mail-qk0-x243.google.com with SMTP id a77so10024172qkb.2
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 11:17:53 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.6535001d6b9cd2357109d19b1060e3f6a2b958a7.1501506432.git-series.james.hogan@imgtec.com>
	<e6cc2ce8c49b15a8e12d3db770da05971cb59e5d.1501506432.git-series.james.hogan@imgtec.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <06138da0-aa93-1cd6-786c-e9c647f0c770@amsat.org>
Date: Mon, 31 Jul 2017 15:17:48 -0300
MIME-Version: 1.0
In-Reply-To: <e6cc2ce8c49b15a8e12d3db770da05971cb59e5d.1501506432.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] mips: Improve segment defs for KVM T&E
 guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James Hogan <james.hogan@imgtec.com>, qemu-devel@nongnu.org
Cc: Yongbok Kim <yongbok.kim@imgtec.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Aurelien Jarno <aurelien@aurel32.net>

On 07/31/2017 10:09 AM, James Hogan wrote:
> Improve the segment definitions used by get_physical_address() to yield
> target_ulong types, e.g. 0xffffffff80000000 instead of 0x80000000. This
> is in preparation for enabling emulation of MIPS KVM T&E segments in TCG
> MIPS targets, which unlike KVM could potentially have 64-bit
> target_ulong. In such a case the offset guest KSEG0 address ends up at
> e.g. 0x000000008xxxxxxx instead of 0xffffffff8xxxxxxx.
> 
> This also allows the casts to int32_t that force sign extension to be
> removed, which removes any confusion due to relational comparison of
> unsigned (target_ulong) and signed (int32_t) types.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> Cc: Yongbok Kim <yongbok.kim@imgtec.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: kvm@vger.kernel.org
> ---
>   target/mips/helper.c | 23 +++++++++++------------
>   1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/target/mips/helper.c b/target/mips/helper.c
> index a2b79e8725a6..05883b9f4251 100644
> --- a/target/mips/helper.c
> +++ b/target/mips/helper.c
> @@ -216,14 +216,14 @@ static int get_physical_address (CPUMIPSState *env, hwaddr *physical,
>       /* effective address (modified for KVM T&E kernel segments) */
>       target_ulong address = real_address;
>   
> -#define USEG_LIMIT      0x7FFFFFFFUL
> -#define KSEG0_BASE      0x80000000UL
> -#define KSEG1_BASE      0xA0000000UL
> -#define KSEG2_BASE      0xC0000000UL
> -#define KSEG3_BASE      0xE0000000UL
> +#define USEG_LIMIT      ((target_ulong)(int32_t)0x7FFFFFFFUL)
> +#define KSEG0_BASE      ((target_ulong)(int32_t)0x80000000UL)
> +#define KSEG1_BASE      ((target_ulong)(int32_t)0xA0000000UL)
> +#define KSEG2_BASE      ((target_ulong)(int32_t)0xC0000000UL)
> +#define KSEG3_BASE      ((target_ulong)(int32_t)0xE0000000UL)
>   
> -#define KVM_KSEG0_BASE  0x40000000UL
> -#define KVM_KSEG2_BASE  0x60000000UL
> +#define KVM_KSEG0_BASE  ((target_ulong)(int32_t)0x40000000UL)
> +#define KVM_KSEG2_BASE  ((target_ulong)(int32_t)0x60000000UL)
>   
>       if (kvm_enabled()) {
>           /* KVM T&E adds guest kernel segments in useg */
> @@ -307,17 +307,17 @@ static int get_physical_address (CPUMIPSState *env, hwaddr *physical,
>               ret = TLBRET_BADADDR;
>           }
>   #endif
> -    } else if (address < (int32_t)KSEG1_BASE) {
> +    } else if (address < KSEG1_BASE) {
>           /* kseg0 */
>           ret = get_segctl_physical_address(env, physical, prot, real_address, rw,
>                                             access_type, mmu_idx,
>                                             env->CP0_SegCtl1 >> 16, 0x1FFFFFFF);
> -    } else if (address < (int32_t)KSEG2_BASE) {
> +    } else if (address < KSEG2_BASE) {
>           /* kseg1 */
>           ret = get_segctl_physical_address(env, physical, prot, real_address, rw,
>                                             access_type, mmu_idx,
>                                             env->CP0_SegCtl1, 0x1FFFFFFF);
> -    } else if (address < (int32_t)KSEG3_BASE) {
> +    } else if (address < KSEG3_BASE) {
>           /* sseg (kseg2) */
>           ret = get_segctl_physical_address(env, physical, prot, real_address, rw,
>                                             access_type, mmu_idx,
> @@ -974,8 +974,7 @@ void mips_cpu_do_interrupt(CPUState *cs)
>           } else if (cause == 30 && !(env->CP0_Config3 & (1 << CP0C3_SC) &&
>                                       env->CP0_Config5 & (1 << CP0C5_CV))) {
>               /* Force KSeg1 for cache errors */
> -            env->active_tc.PC = (int32_t)KSEG1_BASE |
> -                                (env->CP0_EBase & 0x1FFFF000);
> +            env->active_tc.PC = KSEG1_BASE | (env->CP0_EBase & 0x1FFFF000);
>           } else {
>               env->active_tc.PC = env->CP0_EBase & ~0xfff;
>           }
> 
