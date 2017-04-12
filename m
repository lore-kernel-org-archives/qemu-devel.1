Received: from eggs.gnu.org ([2001:4830:134:3::10]:41244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1cy6uy-00083y-Jr
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 21:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1cy6ux-0006R0-2u
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 21:17:56 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 11 Apr 2017 21:17:24 -0400
Message-Id: <1491959850-30756-5-git-send-email-cota@braap.org>
In-Reply-To: <1491959850-30756-1-git-send-email-cota@braap.org>
References: <1491959850-30756-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 04/10] target/i386: optimize cross-page block
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

-       specINT 2006 (test set), x86_64-softmmu. Host: Intel i7-4790K @ 4.00GHz
                          Y axis: Speedup over 95b31d70

     1.3x+-+-------------------------------------------------------------+-+
         |           cross $$                                              |
    1.25x+-+.............................................................+-+
         |                                                                 |
     1.2x+-+.............................................................+-+
         |                                                        :        |
         |                                                        :        |
    1.15x+-+.............................................................+-+
         |           $$$$ $$$$                     +++            :        |
     1.1x+-+.........$..$.$..$...........................................+-+
         |           $  $ $  $                     $$$           $$$$      |
    1.05x+-+.........$..$.$..$.....................$.$.$$$$......$..$....+-+
         |           $  $ $  $      +++  +++  +++  $+$ $++$  +++ $: $ $$$$ |
         |       +++ $  $ $  $ +++  $$$   :    :   $ $ $  $ $$$$ $: $ $++$ |
       1x+-$$$$G$$$$_$EM$_$ro$s$$$..$.$.......$$$..$.$.$..$.$..$.$..$.$..$-+
         | $++$ $ :$ $  $ $  $ $ $  $ $   :   $+$  $ $ $  $ $++$ $: $ $  $ |
    0.95x+-$..$.$..$.$..$.$..$.$.$..$.$..$$$..$.$..$.$.$..$.$..$.$..$.$..$-+
         | $  $ $  $ $  $ $  $ $ $  $ $  $:$  $ $  $ $ $  $ $  $ $  $ $  $ |
     0.9x+-$$$$-$$$$-$$$$-$$$$-$$$--$$$--$$$--$$$--$$$-$$$$-$$$$-$$$$-$$$$-+
           astarbzip2gcc gobmh264rehmlibquantumcfomneperlbensjxalancbhmean
  png: http://imgur.com/cwRnmCi

That is, a hmean gain of 2.6%.

-      specINT 2006 (train set), x86_64-softmmu. Host: Intel i7-4790K @ 4.00GHz
                          Y axis: Speedup over 95b31d70

    1.25x+-+-------------------------------------------------------------+-+
         |                cross $$                                         |
         |                                                                 |
     1.2x+-+.............................................................+-+
         |                                          :            +++       |
    1.15x+-+.............................................................+-+
         |            :                            $$$ $$$$      $$$$      |
         |           $$$$ +++                      $:$ $++$  +++ $: $      |
     1.1x+-+.........$..$.$$$$.....................$.$.$..$......$..$....+-+
         |       +++ $++$ $++$ +++   :             $ $ $  $   :  $++$ +++  |
    1.05x+-+....$$$$.$..$.$..$......$$$............$.$.$..$.$$$$.$..$.$$$$-+
         |      $++$ $  $ $  $ $$$  $:$            $ $ $  $ $ :$ $  $ $  $ |
         |      $  $ $  $ $  $ $:$  $+$  +++  +++  $ $ $  $ $ :$ $  $ $  $ |
       1x+-$$$$G$AP$_$EM$_$ro$s$i$li$e$..$$$.......$.$.$..$.$..$.$..$.$..$-+
         | $++$ $  $ $  $ $  $ $+$  $ $  $:$  $$$  $ $ $  $ $  $ $  $ $  $ |
    0.95x+-$..$.$..$.$..$.$..$.$.$..$.$..$.$..$.$..$.$.$..$.$..$.$..$.$..$-+
         | $  $ $  $ $  $ $  $ $ $  $ $  $ $  $+$  $ $ $  $ $  $ $  $ $  $ |
         | $  $ $  $ $  $ $  $ $ $  $ $  $ $  $ $  $ $ $  $ $  $ $  $ $  $ |
     0.9x+-$$$$-$$$$-$$$$-$$$$-$$$--$$$--$$$--$$$--$$$-$$$$-$$$$-$$$$-$$$$-+
           astarbzip2gcc gobmh264rehmlibquantumcfomneperlbensjxalancbhmean
  png: http://imgur.com/0CbG7dD

This is the larger "train" set. We get a hmean improvement of 6.1%.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/i386/helper.h      |  2 ++
 target/i386/misc_helper.c |  5 +++++
 target/i386/translate.c   | 14 +++++++++++++-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/target/i386/helper.h b/target/i386/helper.h
index 6fb8fb9..dceb343 100644
--- a/target/i386/helper.h
+++ b/target/i386/helper.h
@@ -1,6 +1,8 @@
 DEF_HELPER_FLAGS_4(cc_compute_all, TCG_CALL_NO_RWG_SE, tl, tl, tl, tl, int)
 DEF_HELPER_FLAGS_4(cc_compute_c, TCG_CALL_NO_RWG_SE, tl, tl, tl, tl, int)
 
+DEF_HELPER_2(cross_page_check, i32, env, tl)
+
 DEF_HELPER_3(write_eflags, void, env, tl, i32)
 DEF_HELPER_1(read_eflags, tl, env)
 DEF_HELPER_2(divb_AL, void, env, tl)
diff --git a/target/i386/misc_helper.c b/target/i386/misc_helper.c
index ca2ea09..a41daed 100644
--- a/target/i386/misc_helper.c
+++ b/target/i386/misc_helper.c
@@ -637,3 +637,8 @@ void helper_wrpkru(CPUX86State *env, uint32_t ecx, uint64_t val)
     env->pkru = val;
     tlb_flush(cs);
 }
+
+uint32_t helper_cross_page_check(CPUX86State *env, target_ulong vaddr)
+{
+    return !!tb_from_jmp_cache(env, vaddr);
+}
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 1d1372f..ffc8ccc 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -2153,7 +2153,19 @@ static inline void gen_goto_tb(DisasContext *s, int tb_num, target_ulong eip)
         gen_jmp_im(eip);
         tcg_gen_exit_tb((uintptr_t)s->tb + tb_num);
     } else {
-        /* jump to another page: currently not optimized */
+        /* jump to another page */
+        TCGv vaddr = tcg_const_tl(eip);
+        TCGv_i32 valid = tcg_temp_new_i32();
+        TCGLabel *label = gen_new_label();
+
+        gen_helper_cross_page_check(valid, cpu_env, vaddr);
+        tcg_temp_free(vaddr);
+        tcg_gen_brcondi_i32(TCG_COND_EQ, valid, 0, label);
+        tcg_temp_free_i32(valid);
+        tcg_gen_goto_tb(tb_num);
+        gen_jmp_im(eip);
+        tcg_gen_exit_tb((uintptr_t)s->tb + tb_num);
+        gen_set_label(label);
         gen_jmp_im(eip);
         gen_eob(s);
     }
-- 
2.7.4
