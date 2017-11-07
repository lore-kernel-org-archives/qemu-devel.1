Received: from eggs.gnu.org ([2001:4830:134:3::10]:59611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eC5HU-0001AO-Qd
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 09:55:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eC5HR-0002CT-1d
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 09:55:12 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171103202624.5956-1-laurent@vivier.eu>
	<20171103202624.5956-2-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <68dc78bb-3a86-b200-1c45-b60d0a2a2578@amsat.org>
Date: Tue, 7 Nov 2017 11:54:57 -0300
MIME-Version: 1.0
In-Reply-To: <20171103202624.5956-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/4] arm: fix float64 helper
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

Hi Laurent,

On 11/03/2017 05:26 PM, Laurent Vivier wrote:
> neon_ceq_f64(), neon_cge_f64() and neon_cgt_f64()
> take float64 as parameter, fix the definition in
> helper-a64.h
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/arm/helper-a64.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
> index 85d86741db..b5e9ba03c0 100644
> --- a/target/arm/helper-a64.h
> +++ b/target/arm/helper-a64.h
> @@ -26,9 +26,9 @@ DEF_HELPER_3(vfp_cmped_a64, i64, f64, f64, ptr)
>  DEF_HELPER_FLAGS_5(simd_tbl, TCG_CALL_NO_RWG_SE, i64, env, i64, i64, i32, i32)
>  DEF_HELPER_FLAGS_3(vfp_mulxs, TCG_CALL_NO_RWG, f32, f32, f32, ptr)
>  DEF_HELPER_FLAGS_3(vfp_mulxd, TCG_CALL_NO_RWG, f64, f64, f64, ptr)
> -DEF_HELPER_FLAGS_3(neon_ceq_f64, TCG_CALL_NO_RWG, i64, i64, i64, ptr)
> -DEF_HELPER_FLAGS_3(neon_cge_f64, TCG_CALL_NO_RWG, i64, i64, i64, ptr)
> -DEF_HELPER_FLAGS_3(neon_cgt_f64, TCG_CALL_NO_RWG, i64, i64, i64, ptr)
> +DEF_HELPER_FLAGS_3(neon_ceq_f64, TCG_CALL_NO_RWG, i64, f64, f64, ptr)
> +DEF_HELPER_FLAGS_3(neon_cge_f64, TCG_CALL_NO_RWG, i64, f64, f64, ptr)
> +DEF_HELPER_FLAGS_3(neon_cgt_f64, TCG_CALL_NO_RWG, i64, f64, f64, ptr)
>  DEF_HELPER_FLAGS_3(recpsf_f32, TCG_CALL_NO_RWG, f32, f32, f32, ptr)
>  DEF_HELPER_FLAGS_3(recpsf_f64, TCG_CALL_NO_RWG, f64, f64, f64, ptr)
>  DEF_HELPER_FLAGS_3(rsqrtsf_f32, TCG_CALL_NO_RWG, f32, f32, f32, ptr)

As commented replying to your series cover, this patch seems missing:

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
@@ -159,8 +159,8 @@ uint64_t HELPER(simd_tbl)(CPUARMState *env, uint64_t
result, uint64_t indices,
              */
             int elt = (rn * 2 + (index >> 3)) % 64;
             int bitidx = (index & 7) * 8;
-            uint64_t val = extract64(env->vfp.regs[elt], bitidx, 8);
-
+            uint64_t val = extract64(float64_val(env->vfp.regs[elt]),
+                                     bitidx, 8);
             result = deposit64(result, shift, 8, val);
         }
     }

Regards,

Phil.
