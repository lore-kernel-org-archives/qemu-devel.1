Received: from eggs.gnu.org ([2001:4830:134:3::10]:41290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1cy6v1-00088K-HV
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 21:18:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1cy6uz-0006T9-JN
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 21:17:59 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 11 Apr 2017 21:17:29 -0400
Message-Id: <1491959850-30756-10-git-send-email-cota@braap.org>
In-Reply-To: <1491959850-30756-1-git-send-email-cota@braap.org>
References: <1491959850-30756-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 09/10] target/i386: optimize indirect branches
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

-             NBench, x86_64-linux-user. Host: Intel i7-4790K @ 4.00GHz
                             Y axis: Speedup over 95b31d70

     1.1x+-+-------------------------------------------------------------+-+
         |          jr             $$                                      |
    1.08x+-+......  jr+inline      %%  ..................................+-+
         |                                                                 |
         | $$$                                                             |
    1.06x+-$.$............................%%%............................+-+
         | $ $%%                          % %                              |
    1.04x+-$.$.%..........................%.%............................+-+
         | $ $ %                        $$$ %                  $$$         |
         | $ $ %              %%%       $ $ %                  $ $%%       |
    1.02x+-$.$.%.........%%%.$$.%.......$.$.%...%%%...%%.......$.$.%.$$$%%-+
         | $ $ %         % % $$ % $$$   $ $ % $$$ %   %% $$$%% $ $ % $ $ % |
       1x+-$.$B%R$$$ARGRA%H%T$$P%j$+$%%i$e$.%.$.$.%.$$$%.$.$.%.$.$.%.$.$.%-+
         | $ $ % $ $%% $$$ % $$ % $ $ % $ $ % $ $ % $ $% $ $ % $ $ % $ $ % |
    0.98x+-$.$.%.$.$.%.$.$.%.$$.%.$.$.%.$.$.%.$.$.%.$.$%.$.$.%.$.$.%.$.$.%-+
         | $ $ % $ $ % $ $ % $$ % $ $ % $ $ % $ $ % $ $% $ $ % $ $ % $ $ % |
         | $ $ % $ $ % $ $ % $$ % $ $ % $ $ % $ $ % $ $% $ $ % $ $ % $ $ % |
    0.96x+-$.$.%.$.$.%.$.$.%.$$.%.$.$.%.$.$.%.$.$.%.$.$%.$.$.%.$.$.%.$.$.%-+
         +-$$$%%-$$$%%-$$$%%-$$%%-$$$%%-$$$%%-$$$%%-$$$%-$$$%%-$$$%%-$$$%%-+
        ASSIGNMBITFIELFOFP_EMULATHUFFMANLU_DECOMPNEURNUMERICSTRING_SOhmean
  png: http://imgur.com/Jxj4hBd

The fact that NBench is not very sensitive to changes here is a
little surprising, especially given the significant improvements for
ARM shown in the previous commit. I wonder whether the compiler is doing
a better job compiling the x86_64 version (I'm using gcc 5.4.0), or I'm simply
missing some i386 instructions to which the jr optimization should
be applied.

     specINT 2006 (test set), x86_64-linux-user. Host: Intel i7-4790K @ 4.00GHz
                             Y axis: Speedup over 95b31d70

     1.3x+-+-------------------------------------------------------------+-+
         |          jr+inline $$                                           |
    1.25x+-+.............................................................+-+
         |                                                                 |
     1.2x+-+.............................................................+-+
         |                                                                 |
         |                     +++                 +++                     |
    1.15x+-+...................$$$.................$$$...................+-+
         |                     $ $                 $:$                     |
     1.1x+-+...................$.$.................$.$...........$$$$....+-+
         |           +++       $ $                 $ $       +++ $++$      |
    1.05x+-+.........$$$$......$.$.................$.$...........$..$....+-+
         |           $  $      $ $  $$$            $ $ $$$$ $$$$ $  $ $$$$ |
         | $$$$  +++ $  $ +++  $ $  $ $  +++  $$$  $ $ $  $ $++$ $  $ $  $ |
       1x+-$BA$G$$$$_$EM$_$$$$.$.$..$.$..$$$..$.$..$.$.$..$.$..$.$..$.$..$-+
         | $  $ $  $ $  $ $  $ $ $  $ $  $ $  $ $  $ $ $  $ $  $ $  $ $  $ |
    0.95x+-$..$.$..$.$..$.$..$.$.$..$.$..$.$..$.$..$.$.$..$.$..$.$..$.$..$-+
         | $  $ $  $ $  $ $  $ $ $  $ $  $ $  $ $  $ $ $  $ $  $ $  $ $  $ |
     0.9x+-$$$$-$$$$-$$$$-$$$$-$$$--$$$--$$$--$$$--$$$-$$$$-$$$$-$$$$-$$$$-+
           astarbzip2gcc gobmh264rehmlibquantumcfomneperlbensjxalancbhmean
  png: http://imgur.com/63Ncmx8

That is a 4.4% hmean perf improvement.

-  specINT 2006 (train set), x86_64-linux-user. Host: Intel i7-4790K @ 4.00GHz
                             Y axis: Speedup over 95b31d70

    1.4x+-+--------------------------------------------------------------+-+
        |        jr  $$                                                    |
        |                                                                  |
    1.3x+-+..............................................................+-+
        |                                                                  |
        |                                                                  |
    1.2x+-+......................................................$$$$....+-+
        |                      +++                     $$$$  :   $++$      |
        |                     $$$$                $$$$ $  $  :   $  $      |
    1.1x+-+...................$..$................$..$.$..$.$$$$.$..$....+-+
        |                     $  $                $  $ $  $ $: $ $  $ +++  |
        |  +++       +++  +++ $  $ $$$$  +++      $  $ $  $ $: $ $  $ $$$$ |
      1x+-$$$$GRAPH_$$$$_$$$$.$..$.$..$.$$$$......$..$.$..$.$..$.$..$.$..$-+
        | $++$ $$$$ $  $ $++$ $  $ $  $ $  $      $  $ $  $ $  $ $  $ $  $ |
        | $  $ $  $ $  $ $  $ $  $ $  $ $  $      $  $ $  $ $  $ $  $ $  $ |
    0.9x+-$..$.$..$.$..$.$..$.$..$.$..$.$..$......$..$.$..$.$..$.$..$.$..$-+
        | $  $ $  $ $  $ $  $ $  $ $  $ $  $ $$$$ $  $ $  $ $  $ $  $ $  $ |
        | $  $ $  $ $  $ $  $ $  $ $  $ $  $ $  $ $  $ $  $ $  $ $  $ $  $ |
    0.8x+-$$$$-$$$$-$$$$-$$$$-$$$$-$$$$-$$$$-$$$$-$$$$-$$$$-$$$$-$$$$-$$$$-+
          astarbzip2 gcc gobmh264rehmlibquantmcfomneperlbensjexalancbhmean
  png: http://imgur.com/hd0BhU6

That is, a 4.39 % hmean improvement for jr+inline, i.e. this commit.
(4.5% for noinline). Peak improvement is 20% for xalancbmk.

-    specINT 2006 (test set), x86_64-softmmu. Host: Intel i7-4790K @ 4.00GHz
                             Y axis: Speedup over 95b31d70

     1.3x+-+-------------------------------------------------------------+-+
         |         cross    $$                                             |
    1.25x+-+.....  jr       %%  .........................................+-+
         |         cross+jr @@                                      :      |
     1.2x+-+.............................................................+-+
         |                                                       :  :      |
         |             +++                                       :  :      |
    1.15x+-+...........@@................................................+-+
         |           $$@@ $$++                    +++            : @@      |
     1.1x+-+.........$$@@.$$@@.....................................@@....+-+
         |           $$@@ $$@@                    $$ :   @@@  +++$$@@      |
    1.05x+-+.........$$@@.$$@@...@@...............$$...$$@.@.....$$@@....+-+
         |        +++$$%@ $$@@  %%@+++++++++++++++$$+: $$@ @++@@ $$%@+$$@@+|
         |  +@@+++@@+$$%@ $$@@++%%@$$$%  ::@@ ::@@$$@@@$$% @$$@@ $$%@+$$@@ |
       1x+-$$%@A$$%@R$$%@R$$%@$$$%@$_$%@s%%%@$$%%@$$@.@$$%.@$$@@.$$%@.$$%@-+
         |+$$%@ $$%@ $$%@ $$%@$ $%@$+$%@ %+%@$$+%@$$@+@$$% @$$@@ $$%@+$$%@ |
    0.95x+-$$%@.$$%@.$$%@.$$%@$.$%@$.$%@$$.%@$$.%@$$@.@$$%.@$$%@.$$%@.$$%@-+
         | $$%@ $$%@ $$%@ $$%@$ $%@$ $%@$$ %@$$ %@$$%+@$$% @$$%@ $$%@ $$%@ |
     0.9x+-$$%@-$$%@-$$%@-$$%@$$$%@$$$%@$$%%@$$%%@$$%@@$$%@@$$%@-$$%@-$$%@-+
           astabzip2 gcc gobmh264rehmlibquantumcfomneperlbensjexalanchmean
  png: http://imgur.com/IV9UtSa

Here we see how jr works best when combined with cross -- jr by itself is
disappointingly around baseline performance. I attribute this to the frequent
page invalidations and/or TLB flushes (I'm running Ubuntu 16.04 as the guest,
so there are many processes), which lowers the maximum attainable hit rate in
tb_jmp_cache.

Overall the greatest hmean improvement comes from cross+jr though.

-      specINT 2006 (train set), x86_64-softmmu. Host: Intel i7-4790K @ 4.00GHz
                             Y axis: Speedup over 95b31d70

    1.25x+-+-------------------------------------------------------------+-+
         |        cross+inline    $$                                       |
         |        cross+jr+inline %%                     +++      +++      |
     1.2x+-+.............................................................+-+
         |                                         :      :      +++       |
    1.15x+-+.......................................................%%....+-+
         |            ::   +++                    $$$  $$$%      $$$%      |
         |           $$%%++%%%                    $:$  $+$% +++  $:$%      |
     1.1x+-+.........$$.%.$$.%....................$.$..$.$%......$.$%....+-+
         |      +++  $$+%+$$ %+++++ :+++          $ $: $ $%  :%% $+$% +++  |
    1.05x+-+....$$...$$.%.$$.%......$$............$.$%.$.$%.$$$%.$.$%.$$%%-+
         |      $$%% $$ % $$ % $$%% $$:   +++     $ $% $ $% $:$% $ $% $$+% |
         |      $$+% $$ % $$ % $$:%+$$%%+++: +++  $ $%+$ $% $:$% $ $% $$ % |
       1x+-$$$AR$$A%G$$P%_$$M%_$$o%s$$r%$$$%%e....$.$%.$.$%.$.$%.$.$%.$$.%-+
         | $+$% $$ % $$ % $$ %+$$+% $$:%$:$+%$$$++$ $% $ $% $ $% $ $% $$ % |
    0.95x+-$.$%.$$.%.$$.%.$$.%.$$.%.$$.%$.$.%$.$..$.$%.$.$%.$.$%.$.$%.$$.%-+
         | $ $% $$ % $$ % $$ % $$ % $$ %$ $ %$+$% $ $% $ $% $ $% $ $% $$ % |
         | $ $% $$ % $$ % $$ % $$ % $$ %$ $ %$ $% $ $% $ $% $ $% $ $% $$ % |
     0.9x+-$$$%-$$%%-$$%%-$$%%-$$%%-$$%%$$$%%$$$%-$$$%-$$$%-$$$%-$$$%-$$%%-+
           astabzip2 gcc gobmh264rehmlibquantumcfomneperlbensjexalanchmean
  png: http://imgur.com/CBMxrBH

This is the larger "train" set of SPECint06. Here cross+jr comes slightly
below cross, but it's within the noise margins (I didn't run this many
times, since it takes several hours).

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/i386/helper.h      |  1 +
 target/i386/misc_helper.c | 11 +++++++++++
 target/i386/translate.c   | 42 +++++++++++++++++++++++++++++++++---------
 3 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/target/i386/helper.h b/target/i386/helper.h
index dceb343..f7e9f9c 100644
--- a/target/i386/helper.h
+++ b/target/i386/helper.h
@@ -2,6 +2,7 @@ DEF_HELPER_FLAGS_4(cc_compute_all, TCG_CALL_NO_RWG_SE, tl, tl, tl, tl, int)
 DEF_HELPER_FLAGS_4(cc_compute_c, TCG_CALL_NO_RWG_SE, tl, tl, tl, tl, int)
 
 DEF_HELPER_2(cross_page_check, i32, env, tl)
+DEF_HELPER_2(get_hostptr, ptr, env, tl)
 
 DEF_HELPER_3(write_eflags, void, env, tl, i32)
 DEF_HELPER_1(read_eflags, tl, env)
diff --git a/target/i386/misc_helper.c b/target/i386/misc_helper.c
index a41daed..5d50ab0 100644
--- a/target/i386/misc_helper.c
+++ b/target/i386/misc_helper.c
@@ -642,3 +642,14 @@ uint32_t helper_cross_page_check(CPUX86State *env, target_ulong vaddr)
 {
     return !!tb_from_jmp_cache(env, vaddr);
 }
+
+void *helper_get_hostptr(CPUX86State *env, target_ulong vaddr)
+{
+    TranslationBlock *tb;
+
+    tb = tb_from_jmp_cache(env, vaddr);
+    if (unlikely(tb == NULL)) {
+        return NULL;
+    }
+    return tb->tc_ptr;
+}
diff --git a/target/i386/translate.c b/target/i386/translate.c
index ffc8ccc..aab5c13 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -2521,7 +2521,8 @@ static void gen_bnd_jmp(DisasContext *s)
    If INHIBIT, set HF_INHIBIT_IRQ_MASK if it isn't already set.
    If RECHECK_TF, emit a rechecking helper for #DB, ignoring the state of
    S->TF.  This is used by the syscall/sysret insns.  */
-static void gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf)
+static void
+gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, TCGv jr)
 {
     gen_update_cc_op(s);
 
@@ -2542,6 +2543,22 @@ static void gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf)
         tcg_gen_exit_tb(0);
     } else if (s->tf) {
         gen_helper_single_step(cpu_env);
+    } else if (jr) {
+#ifdef TCG_TARGET_HAS_JR
+        TCGLabel *label = gen_new_label();
+        TCGv_ptr ptr = tcg_temp_local_new_ptr();
+        TCGv vaddr = tcg_temp_new();
+
+        tcg_gen_ld_tl(vaddr, cpu_env, offsetof(CPUX86State, segs[R_CS].base));
+        tcg_gen_add_tl(vaddr, vaddr, jr);
+        gen_helper_get_hostptr(ptr, cpu_env, vaddr);
+        tcg_temp_free(vaddr);
+        tcg_gen_brcondi_ptr(TCG_COND_EQ, ptr, NULL, label);
+        tcg_gen_jr(ptr);
+        tcg_temp_free_ptr(ptr);
+        gen_set_label(label);
+#endif
+        tcg_gen_exit_tb(0);
     } else {
         tcg_gen_exit_tb(0);
     }
@@ -2552,13 +2569,18 @@ static void gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf)
    If INHIBIT, set HF_INHIBIT_IRQ_MASK if it isn't already set.  */
 static void gen_eob_inhibit_irq(DisasContext *s, bool inhibit)
 {
-    gen_eob_worker(s, inhibit, false);
+    gen_eob_worker(s, inhibit, false, NULL);
 }
 
 /* End of block, resetting the inhibit irq flag.  */
 static void gen_eob(DisasContext *s)
 {
-    gen_eob_worker(s, false, false);
+    gen_eob_worker(s, false, false, NULL);
+}
+
+static void gen_jr(DisasContext *s, TCGv dest)
+{
+    gen_eob_worker(s, false, false, dest);
 }
 
 /* generate a jump to eip. No segment change must happen before as a
@@ -4985,7 +5007,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
             gen_push_v(s, cpu_T1);
             gen_op_jmp_v(cpu_T0);
             gen_bnd_jmp(s);
-            gen_eob(s);
+            gen_jr(s, cpu_T0);
             break;
         case 3: /* lcall Ev */
             gen_op_ld_v(s, ot, cpu_T1, cpu_A0);
@@ -5003,7 +5025,8 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
                                       tcg_const_i32(dflag - 1),
                                       tcg_const_i32(s->pc - s->cs_base));
             }
-            gen_eob(s);
+            tcg_gen_ld_tl(cpu_tmp4, cpu_env, offsetof(CPUX86State, eip));
+            gen_jr(s, cpu_tmp4);
             break;
         case 4: /* jmp Ev */
             if (dflag == MO_16) {
@@ -5011,7 +5034,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
             }
             gen_op_jmp_v(cpu_T0);
             gen_bnd_jmp(s);
-            gen_eob(s);
+            gen_jr(s, cpu_T0);
             break;
         case 5: /* ljmp Ev */
             gen_op_ld_v(s, ot, cpu_T1, cpu_A0);
@@ -5026,7 +5049,8 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
                 gen_op_movl_seg_T0_vm(R_CS);
                 gen_op_jmp_v(cpu_T1);
             }
-            gen_eob(s);
+            tcg_gen_ld_tl(cpu_tmp4, cpu_env, offsetof(CPUX86State, eip));
+            gen_jr(s, cpu_tmp4);
             break;
         case 6: /* push Ev */
             gen_push_v(s, cpu_T0);
@@ -7143,7 +7167,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
         /* TF handling for the syscall insn is different. The TF bit is  checked
            after the syscall insn completes. This allows #DB to not be
            generated after one has entered CPL0 if TF is set in FMASK.  */
-        gen_eob_worker(s, false, true);
+        gen_eob_worker(s, false, true, NULL);
         break;
     case 0x107: /* sysret */
         if (!s->pe) {
@@ -7158,7 +7182,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
                checked after the sysret insn completes. This allows #DB to be
                generated "as if" the syscall insn in userspace has just
                completed.  */
-            gen_eob_worker(s, false, true);
+            gen_eob_worker(s, false, true, NULL);
         }
         break;
 #endif
-- 
2.7.4
