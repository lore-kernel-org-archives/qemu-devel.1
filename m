Received: from eggs.gnu.org ([2001:4830:134:3::10]:54398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gS1CS-0003tA-Uj
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:52:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gS13t-00005W-DV
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:43:36 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:42711)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gS13s-0008Vf-6L
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:43:33 -0500
Date: Wed, 28 Nov 2018 09:43:27 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181128144327.GA1763@flamenco>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-24-cota@braap.org>
	<87lg5f51sz.fsf@linaro.org>
	<e1160c9a-454d-5c55-1295-fb1ab977b2a5@linaro.org>
	<20181126190733.GC6688@flamenco>
	<7ff01881-3130-ef72-217d-511b4de0cd3c@linaro.org>
	<20181127013825.GE22108@flamenco> <20181128005402.GA1523@flamenco>
	<87a7lt4bpk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a7lt4bpk.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC 23/48] translator: add plugin_insn argument
 to translate_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>

On Wed, Nov 28, 2018 at 12:40:23 +0000, Alex Bennée wrote:
> I was envisioning something more like the following so all the plugin
> gubins could be kept in the core code:
(snip)
>  static inline uint32_t arm_ldl_code(CPUARMState *env, target_ulong addr,
>                                      bool sctlr_b)
>  {
> -    uint32_t insn = cpu_ldl_code(env, addr);
> -    if (bswap_code(sctlr_b)) {
> -        return bswap32(insn);
> -    }
> -    return insn;
> +    return translator_ld32(env, addr, bswap_code(sctlr_b));
>  }
> 
>  /* Ditto, for a halfword (Thumb) instruction */
>  static inline uint16_t arm_lduw_code(CPUARMState *env, target_ulong addr,
>                                       bool sctlr_b)
>  {
> -    uint16_t insn;
>  #ifndef CONFIG_USER_ONLY
>      /* In big-endian (BE32) mode, adjacent Thumb instructions have been swapped
>         within each word.  Undo that now.  */
> @@ -46,11 +40,7 @@ static inline uint16_t arm_lduw_code(CPUARMState *env, target_ulong addr,
>          addr ^= 2;
>      }
>  #endif
> -    insn = cpu_lduw_code(env, addr);
> -    if (bswap_code(sctlr_b)) {
> -        return bswap16(insn);
> -    }
> -    return insn;
> +    return translator_ld16(env, addr, bswap_code(sctlr_b));
>  }

I like this, thanks.

However, for Thumb I think we still need to call qemu_plugin_insn_append
directly:

@@ -13304,11 +13306,16 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     insn = arm_lduw_code(env, dc->pc, dc->sctlr_b);
     is_16bit = thumb_insn_is_16bit(dc, insn);
     dc->pc += 2;
-    if (!is_16bit) {
+    if (is_16bit) {
+        uint16_t insn16 = insn;
+
+        qemu_plugin_insn_append(tcg_ctx->plugin_insn, &insn16, sizeof(insn16));
+    } else {
         uint32_t insn2 = arm_lduw_code(env, dc->pc, dc->sctlr_b);

         insn = insn << 16 | insn2;
         dc->pc += 2;
+        qemu_plugin_insn_append(tcg_ctx->plugin_insn, &insn, sizeof(insn));
     }
 
Otherwise we might mess up the contents of 32-bit insns.

Thanks,

		E.
