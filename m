Received: from eggs.gnu.org ([2001:4830:134:3::10]:41249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1cy6uy-00084D-OK
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 21:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1cy6ux-0006Qp-0z
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 21:17:56 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 11 Apr 2017 21:17:28 -0400
Message-Id: <1491959850-30756-9-git-send-email-cota@braap.org>
In-Reply-To: <1491959850-30756-1-git-send-email-cota@braap.org>
References: <1491959850-30756-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 08/10] target/arm: optimize indirect branches
 with TCG's jr op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Claudio Fontana <claudio.fontana@huawei.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

Speed up indirect branches by adding a helper to look for the
TB in tb_jmp_cache. The helper returns either the corresponding
host address or NULL.

Measurements:

- Impact on Boot time

| setup   | ARM debian boot+shutdown time | stddev |
|---------+-------------------------------+--------|
| master  |                  10.050247057 | 0.0361 |
| +cross  |                  10.311265443 | 0.0721 |
| +jr     |                  10.216832579 | 0.0878 |
| +inline |                  10.405597879 | 0.0332 |

That is, a 3.5% slowdown. This is reasonable since booting
has low hit rates in tb_jmp_cache.

-                NBench, arm-linux-user. Host: Intel i7-4790K @ 4.00GHz
                            Y axis: speedup over 95b31d70

    1.25x+-+-------------------------------------------------------------+-+
         |                                                jr          $$$  |
         |                                                jr+inline   %%%  |
     1.2x+-+..................................$$$%%......................+-+
         |                                    $ $ %                        |
         |                                    $ $ %                        |
         |                          %%%       $ $ %   %%                   |
    1.15x+-+........................%.%.......$.$.%.$$$%.................+-+
         |                          % %       $ $ % $ $%                   |
         |                        $$$ %       $ $ % $ $%                   |
     1.1x+-+......................$.$.%.......$.$.%.$.$%.................+-+
         |                        $ $ %       $ $ % $ $%                   |
         |                        $ $ % $$$   $ $ % $ $%               %%% |
    1.05x+-+......................$.$.%.$.$%%.$.$.%.$.$%.............$$$.%-+
         |             $$$%% $$%% $ $ % $ $ % $ $ % $ $%             $ $ % |
         | $$$%%       $ $ % $$ % $ $ % $ $ % $ $ % $ $%             $ $ % |
         | $ $ %       $ $ % $$ % $ $ % $ $ % $ $ % $ $%   %%% $$$%% $ $ % |
       1x+-$.$B%R$$$%%G$A$H%T$$P%j$+$n%i$e$.%.$.$.%.$.$%.$$$.%.$.$.%.$.$.%-+
         +-$$$%%-$$$%%-$$$%%-$$%%-$$$%%-$$$%%-$$$%%-$$$%-$$$%%-$$$%%-$$$%%-+
        ASSIGNMBITFIELFOFP_EMULATHUFFMANLU_DECOMPNEURNUMERICSTRING_SOhmean
  png: http://imgur.com/ihqQj6l

That is, a 6.65% hmean improvement with jr+inline (5.92% w/o inlining).
Peak improvement is 21% for HUFFMAN.

-                NBench, arm-softmmu. Host: Intel i7-4790K @ 4.00GHz
                            Y axis: speedup over 95b31d70
        +------------------------------------------------------------------+
        |                                                                  |
    1.3x+-+........................................ cross+noinline    $$ +-+
        |                                           cross+inline      %%   |
        |                      &&              @@&& cross+jr+noinline @@   |
        |                   $$%@&              @@ & cross+jr+inline   &&   |
    1.2x+-+.................$$%@&......$$..&&..@@.&......................+-+
        |                   $$%@&      $$%%@&  @@ &  @@&                   |
        |                   $$%@&      $$ %@&  @@ &  @@&                   |
    1.1x+-+.................$$%@&...@@.$$.%@&..@@.&..@@&................&&-+
        |             $$%@& $$%@&   @@&$$ %@&  @@ &  @@&               @@& |
        |             $$%@& $$%@&   @@&$$ %@&$$%@ &  @@&       $$%@& $$%@& |
        | $$%&& $$%&& $$%@& $$%@&$$$%@&$$ %@&$$%@ & %%@&       $$%@& $$%@& |
      1x+-$$%@&A$$%@&A$$%@&A$$%@&$R$%@&$$T%@&$$%@s&+%%@&n$$%@&.$$%@&.$$%@&-+
        | $$%@& $$%@& $$%@& $$%@&$ $%@&$$ %@&$$%@ & %%@& $$%@& $$%@& $$%@& |
        | $$%@& $$%@& $$%@& $$%@&$ $%@&$$ %@&$$%@ & %%@& $$%@& $$%@& $$%@& |
    0.9x+-$$%@&.$$%@&.$$%@&.$$%@&$.$%@&$$.%@&$$%@.&.%%@&.$$%@&.$$%@&.$$%@&-+
        | $$%@& $$%@& $$%@& $$%@&$ $%@&$$ %@&$$%@ & %%@& $$%@& $$%@& $$%@& |
        | $$%@& $$%@& $$%@& $$%@&$ $%@&$$ %@&$$%@ &$$%@& $$%@& $$%@& $$%@& |
        | $$%@& $$%@& $$%@& $$%@&$ $%@&$$ %@&$$%@ &$$%@& $$%@& $$%@& $$%@& |
    0.8x+-$$%@&-$$%@&-$$%@&-$$%@&$$$%@&$$%%@&$$%@&&$$%@&-$$%@&-$$%@&-$$%@&-+
       ASSIGNMBITFIELFOUFP_EMULATHUFFMALU_DECOMPNEURANUMERICSTRING_SOhmean
   png: http://imgur.com/yWJivBl

That is, a 9.86% hmean improvement when combining cross+jr+inline (this commit)
over current master. Peak improvement is 25% for FP_EMULATION.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/arm/helper.c    | 11 +++++++++++
 target/arm/helper.h    |  1 +
 target/arm/translate.c | 23 +++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 10b8807..dfbc488 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9927,3 +9927,14 @@ uint32_t HELPER(cross_page_check)(CPUARMState *env, target_ulong vaddr)
 {
     return !!tb_from_jmp_cache(env, vaddr);
 }
+
+void *HELPER(get_hostptr)(CPUARMState *env, target_ulong vaddr)
+{
+    TranslationBlock *tb;
+
+    tb = tb_from_jmp_cache(env, vaddr);
+    if (unlikely(tb == NULL)) {
+        return NULL;
+    }
+    return tb->tc_ptr;
+}
diff --git a/target/arm/helper.h b/target/arm/helper.h
index d4b779b..0faacc1 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -2,6 +2,7 @@ DEF_HELPER_FLAGS_1(sxtb16, TCG_CALL_NO_RWG_SE, i32, i32)
 DEF_HELPER_FLAGS_1(uxtb16, TCG_CALL_NO_RWG_SE, i32, i32)
 
 DEF_HELPER_2(cross_page_check, i32, env, tl)
+DEF_HELPER_2(get_hostptr, ptr, env, tl)
 
 DEF_HELPER_3(add_setq, i32, env, i32, i32)
 DEF_HELPER_3(add_saturate, i32, env, i32, i32)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index ce97d0c..2510bb2 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -65,6 +65,14 @@ static TCGv_i32 cpu_R[16];
 TCGv_i32 cpu_CF, cpu_NF, cpu_VF, cpu_ZF;
 TCGv_i64 cpu_exclusive_addr;
 TCGv_i64 cpu_exclusive_val;
+static bool gen_jr;
+
+static inline void set_jr(void)
+{
+    if (TCG_TARGET_HAS_jr) {
+        gen_jr = true;
+    }
+}
 
 /* FIXME:  These should be removed.  */
 static TCGv_i32 cpu_F0s, cpu_F1s;
@@ -221,6 +229,7 @@ static void store_reg(DisasContext *s, int reg, TCGv_i32 var)
          */
         tcg_gen_andi_i32(var, var, s->thumb ? ~1 : ~3);
         s->is_jmp = DISAS_JUMP;
+        set_jr();
     }
     tcg_gen_mov_i32(cpu_R[reg], var);
     tcg_temp_free_i32(var);
@@ -893,6 +902,7 @@ static inline void gen_bx_im(DisasContext *s, uint32_t addr)
         tcg_temp_free_i32(tmp);
     }
     tcg_gen_movi_i32(cpu_R[15], addr & ~1);
+    set_jr();
 }
 
 /* Set PC and Thumb state from var.  var is marked as dead.  */
@@ -902,6 +912,7 @@ static inline void gen_bx(DisasContext *s, TCGv_i32 var)
     tcg_gen_andi_i32(cpu_R[15], var, ~1);
     tcg_gen_andi_i32(var, var, 1);
     store_cpu_field(var, thumb);
+    set_jr();
 }
 
 /* Variant of store_reg which uses branch&exchange logic when storing
@@ -12042,6 +12053,18 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
             gen_set_pc_im(dc, dc->pc);
             /* fall through */
         case DISAS_JUMP:
+            if (TCG_TARGET_HAS_jr && gen_jr) {
+                TCGv_ptr ptr = tcg_temp_local_new_ptr();
+                TCGLabel *label = gen_new_label();
+
+                gen_jr = false;
+                gen_helper_get_hostptr(ptr, cpu_env, cpu_R[15]);
+                tcg_gen_brcondi_ptr(TCG_COND_EQ, ptr, NULL, label);
+                tcg_gen_jr(ptr);
+                tcg_temp_free_ptr(ptr);
+                gen_set_label(label);
+                /* fall through */
+            }
         default:
             /* indicate that the hash table must be used to find the next TB */
             tcg_gen_exit_tb(0);
-- 
2.7.4
