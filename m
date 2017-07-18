Received: from eggs.gnu.org ([2001:4830:134:3::10]:41014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXHhE-00052D-Ao
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 21:53:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXHhB-00061O-A9
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 21:53:08 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51327)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dXHhB-000611-2r
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 21:53:05 -0400
Date: Mon, 17 Jul 2017 21:53:03 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170718015303.GA20247@flamenco>
References: <20170714001819.1660-1-rth@twiddle.net>
	<20170714001819.1660-4-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170714001819.1660-4-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 3/8] target/alpha: Merge several flag bytes
 into ENV->FLAGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On Thu, Jul 13, 2017 at 14:18:14 -1000, Richard Henderson wrote:
> The flags are arranged such that we can manipulate them either
> a whole, or as individual bytes.  The computation within
> cpu_get_tb_cpu_state is now reduced to a single load and mask.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/alpha/cpu.h       | 70 +++++++++++++++++--------------------
>  hw/alpha/dp264.c         |  1 -
>  linux-user/main.c        | 25 +++++++------
>  target/alpha/cpu.c       |  7 ++--
>  target/alpha/helper.c    | 12 +++----
>  target/alpha/machine.c   | 10 ++----
>  target/alpha/translate.c | 91 +++++++++++++++++++++++++++++++-----------------
>  7 files changed, 117 insertions(+), 99 deletions(-)
> 
> diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
> index aa83417..e95be2b 100644
> --- a/target/alpha/cpu.h
> +++ b/target/alpha/cpu.h
> @@ -242,13 +242,11 @@ struct CPUAlphaState {
>      uint8_t fpcr_dyn_round;
>      uint8_t fpcr_flush_to_zero;
>  
> -    /* The Internal Processor Registers.  Some of these we assume always
> -       exist for use in user-mode.  */
> -    uint8_t ps;
> -    uint8_t intr_flag;
> -    uint8_t pal_mode;
> -    uint8_t fen;
> +    /* Mask of PALmode, Processor State et al.  Most of this gets copied
> +       into the TranslatorBlock flags and controls code generation.  */
> +    uint32_t flags;

Did you consider doing something like the appended? I don't like it
because it messes with endianness, which is always a pain. But it
lets you preserve the code that only touches the u8's as-is; this
comes at the price of requiring a fast-path swap in big-endian hosts.

An alternative would be to store the u8's in an order dependent on
the endianness of the host -- but that would break vmstate saving,
I guess.

		Emilio

---8<---

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index aa83417..22c52ac 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -244,10 +244,15 @@ struct CPUAlphaState {
 
     /* The Internal Processor Registers.  Some of these we assume always
        exist for use in user-mode.  */
-    uint8_t ps;
-    uint8_t intr_flag;
-    uint8_t pal_mode;
-    uint8_t fen;
+    union {
+        struct {
+            uint8_t pal_mode;
+            uint8_t ps;
+            uint8_t intr_flag;
+            uint8_t fen;
+        };
+        uint32_t flags;
+    };
 
     uint32_t pcc_ofs;
 
@@ -397,15 +402,35 @@ enum {
     EXC_M_IOV = 64      /* Integer Overflow */
 };
 
-/* Processor status constants.  */
-enum {
-    /* Low 3 bits are interrupt mask level.  */
-    PS_INT_MASK = 7,
 
-    /* Bits 4 and 5 are the mmu mode.  The VMS PALcode uses all 4 modes;
-       The Unix PALcode only uses bit 4.  */
-    PS_USER_MODE = 8
-};
+/* Low 3 bits are interrupt mask level.  */
+#define PS_INT_MASK   7u
+/* Bits 4 and 5 are the mmu mode.  The VMS PALcode uses all 4 modes;
+   The Unix PALcode only uses bit 4.  */
+#define PS_USER_MODE  8u
+
+/* CPUAlphaState->flags constants.  These are layed out so that we
+   can set or reset the pieces individually by assigning to the byte,
+   or manipulated as a whole.  */
+
+#define ENV_FLAG_PAL_SHIFT    0
+#define ENV_FLAG_PS_SHIFT     8
+#define ENV_FLAG_RX_SHIFT     16
+#define ENV_FLAG_FEN_SHIFT    24
+
+#define ENV_FLAG_PAL_MODE     (1u << ENV_FLAG_PAL_SHIFT)
+#define ENV_FLAG_PS_USER      (PS_USER_MODE << ENV_FLAG_PS_SHIFT)
+#define ENV_FLAG_RX_FLAG      (1u << ENV_FLAG_RX_SHIFT)
+#define ENV_FLAG_FEN          (1u << ENV_FLAG_FEN_SHIFT)
+
+#define ENV_FLAG_TB_MASK \
+    (ENV_FLAG_PAL_MODE | ENV_FLAG_PS_USER | ENV_FLAG_FEN)
+
+#ifdef HOST_WORDS_BIGENDIAN
+#define ENV_FLAG_TB(flags) (bswap32(flags) & ENV_FLAG_TB_MASK)
+#else
+#define ENV_FLAG_TB(flags) ((flags) & ENV_FLAG_TB_MASK)
+#endif
 
 static inline int cpu_mmu_index(CPUAlphaState *env, bool ifetch)
 {
@@ -492,21 +517,10 @@ enum {
 static inline void cpu_get_tb_cpu_state(CPUAlphaState *env, target_ulong *pc,
                                         target_ulong *cs_base, uint32_t *pflags)
 {
-    int flags = 0;
-
     *pc = env->pc;
     *cs_base = 0;
 
-    if (env->pal_mode) {
-        flags = TB_FLAGS_PAL_MODE;
-    } else {
-        flags = env->ps & PS_USER_MODE;
-    }
-    if (env->fen) {
-        flags |= TB_FLAGS_FEN;
-    }
-
-    *pflags = flags;
+    *pflags = ENV_FLAG_TB(env->flags);
 }
 
 #endif /* ALPHA_CPU_H */
