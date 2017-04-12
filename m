Received: from eggs.gnu.org ([2001:4830:134:3::10]:41236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1cy6uy-00083b-DH
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 21:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1cy6ux-0006Qu-1X
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 21:17:56 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 11 Apr 2017 21:17:23 -0400
Message-Id: <1491959850-30756-4-git-send-email-cota@braap.org>
In-Reply-To: <1491959850-30756-1-git-send-email-cota@braap.org>
References: <1491959850-30756-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 03/10] target/arm: optimize cross-page block
 chaining in softmmu
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

Instead of unconditionally exiting to the exec loop, add a helper to
check whether the target TB is valid. As long as the hit rate in
tb_jmp_cache remains high, this improves performance.

Measurements:

- Boot time of ARM debian jessie on Intel host:

| setup              | ARM debian boot+shutdown time | stddev |
|--------------------+-------------------------------+--------|
| master             |                  10.050247057 | 0.0361 |
| +cross             |                  10.311265443 | 0.0721 |

That is a 2.58% slowdown when booting. This is reasonable given that
tb_jmp_cache's hit rate when booting is expected to be low.

-                NBench, arm-softmmu. Host: Intel i7-4790K @ 4.00GHz
                        (y axis: Speedup over 95b31d70)

    1.3x+-+--------------------------------------------------------------+-+
        |                                           cross+noinline $$$     |
        |                                           cross+inline   %%%     |
        |                   $$$%%                                          |
    1.2x+-+.................$.$.%.......$$$..............................+-+
        |                   $ $ %       $ $%                               |
        |                   $ $ %       $ $%                               |
    1.1x+-+.................$.$.%.......$.$%.............................+-+
        |             $$$%% $ $ %       $ $%                               |
        |             $ $ % $ $ %       $ $% $$$%%             $$$%% $$$%% |
        | $$$%% $$$%% $ $ % $ $ % $$$%% $ $% $ $ %   %%%       $ $ % $ $ % |
      1x+-$.$B%R$R$A%G$A$H%T$M$_%P$L$i%l$n$%.$.$.%...%.%.$$$%%.$.$.%.$.$.%-+
        | $ $ % $ $ % $ $ % $ $ % $ $ % $ $% $ $ %   % % $ $ % $ $ % $ $ % |
        | $ $ % $ $ % $ $ % $ $ % $ $ % $ $% $ $ %   % % $ $ % $ $ % $ $ % |
    0.9x+-$.$.%.$.$.%.$.$.%.$.$.%.$.$.%.$.$%.$.$.%...%.%.$.$.%.$.$.%.$.$.%-+
        | $ $ % $ $ % $ $ % $ $ % $ $ % $ $% $ $ %   % % $ $ % $ $ % $ $ % |
        | $ $ % $ $ % $ $ % $ $ % $ $ % $ $% $ $ % $$$ % $ $ % $ $ % $ $ % |
        | $ $ % $ $ % $ $ % $ $ % $ $ % $ $% $ $ % $ $ % $ $ % $ $ % $ $ % |
    0.8x+-$$$%%-$$$%%-$$$%%-$$$%%-$$$%%-$$$%-$$$%%-$$$%%-$$$%%-$$$%%-$$$%%-+
       ASSIGNMBITFIELFOUFP_EMULATHUFFMALU_DECOMPNEURANUMERICSTRING_SOhmean

  png: http://imgur.com/1rmYSaF

That is, a 4.04% hmean perf improvement over master with tb_from_jmp_cache
not inlined, and a 5.82% hmean perf improvement over master with tb_from_jmp_cache
inlined (i.e. this commit). The largest improvement is 21% for the FP_EMULATION
benchmark.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/arm/helper.c    |  5 +++++
 target/arm/helper.h    |  2 ++
 target/arm/translate.c | 12 ++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8cb7a94..10b8807 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9922,3 +9922,8 @@ uint32_t HELPER(crc32c)(uint32_t acc, uint32_t val, uint32_t bytes)
     /* Linux crc32c converts the output to one's complement.  */
     return crc32c(acc, buf, bytes) ^ 0xffffffff;
 }
+
+uint32_t HELPER(cross_page_check)(CPUARMState *env, target_ulong vaddr)
+{
+    return !!tb_from_jmp_cache(env, vaddr);
+}
diff --git a/target/arm/helper.h b/target/arm/helper.h
index df86bf7..d4b779b 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -1,6 +1,8 @@
 DEF_HELPER_FLAGS_1(sxtb16, TCG_CALL_NO_RWG_SE, i32, i32)
 DEF_HELPER_FLAGS_1(uxtb16, TCG_CALL_NO_RWG_SE, i32, i32)
 
+DEF_HELPER_2(cross_page_check, i32, env, tl)
+
 DEF_HELPER_3(add_setq, i32, env, i32, i32)
 DEF_HELPER_3(add_saturate, i32, env, i32, i32)
 DEF_HELPER_3(sub_saturate, i32, env, i32, i32)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index e32e38c..ce97d0c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4085,6 +4085,18 @@ static inline void gen_goto_tb(DisasContext *s, int n, target_ulong dest)
         gen_set_pc_im(s, dest);
         tcg_gen_exit_tb((uintptr_t)s->tb + n);
     } else {
+        TCGv vaddr = tcg_const_tl(dest);
+        TCGv_i32 valid = tcg_temp_new_i32();
+        TCGLabel *label = gen_new_label();
+
+        gen_helper_cross_page_check(valid, cpu_env, vaddr);
+        tcg_temp_free(vaddr);
+        tcg_gen_brcondi_i32(TCG_COND_EQ, valid, 0, label);
+        tcg_temp_free_i32(valid);
+        tcg_gen_goto_tb(n);
+        gen_set_pc_im(s, dest);
+        tcg_gen_exit_tb((uintptr_t)s->tb + n);
+        gen_set_label(label);
         gen_set_pc_im(s, dest);
         tcg_gen_exit_tb(0);
     }
-- 
2.7.4
