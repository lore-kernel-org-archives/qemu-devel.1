Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80358C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 12:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AB3120DD4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 12:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FcKuDdtU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB3120DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlB73-0005VY-Hm
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 08:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlB5t-0003mW-10
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:53:37 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:35114)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlB5p-00005n-HY
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:53:36 -0400
Received: by mail-wr1-x435.google.com with SMTP id x14so20663712wrp.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 05:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sGemBWBm0fmeh7RoAKYkj/g+ANckYM+dEWn/3fEQMoQ=;
 b=FcKuDdtUG21wDcXYkdvQ/6KjeDYpifphMhtGCI2Kpn8mN8Kp2j2IPsLhCfP6Opfzoh
 lqXlqewUxUMrF54LyBRfjsZu6SqpinVQr/qHZEztyCf7dqo5JAb6JuYzAn3W+ITfHIfK
 cNpEZy8BlU/h2ZZpzccQkdWoW1QD5JgYjfYRg2ExBS1pNDnrVnsDQGcemD7Trhlz3C6i
 reKHkN17Ij0JfJeW3cchtBLI99/BrxnFkw3sFKwrN06lUs4PXcOHo9bjbmXDKdt9ZYb8
 LKC+ax2+GFOQAby9dUPJfzNd8SYrzfOLeCiga5UN1dsgZ0NdeI37TRxa3SB9EqjAW66a
 NYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sGemBWBm0fmeh7RoAKYkj/g+ANckYM+dEWn/3fEQMoQ=;
 b=ZKp5lf0UXie/ctF0X+zccpuKWvgrLWI4H/ihlByi/n4sXAfT7h+YnXbFiZybDxXiFc
 noUxqwCRgy1RLTh/9r7pPfiomUCkh94MQftwyPfMlyxXRTcNOO/q9dLSoS4feAaFtrQw
 VZDQGY4srG621W6OlAX6k1ySXfUCd3njwpgSfzVQuss89k0V3NWvFUDI80CKfflW87PD
 vB0FFzjqCEKP3nB0MCh5DpHHK7mv8B45YOk3VdU0rkHmrMKnLXWkCBXKfhNlASD67ONl
 TaWTiRPDbxtuckVyEAJZZuGT/bWHoMyOw1qVs4+E3D3zt8s/ynor+Z2pALo/QSsJ0FnH
 vy5g==
X-Gm-Message-State: AOAM533Eyl/zTI6E/RVBu0RkodERxle2JqMmBf1WkwMvrm33jxyJAVQB
 wSpfWchyGXsCpwYScE94do2glA==
X-Google-Smtp-Source: ABdhPJzlnwdiCTaoghcjO6TIe6HRQSh6WjN4reyM4rj6sFA057hNQzSfiWdT7ZjaJ9kQJ4bl7Pw59A==
X-Received: by 2002:adf:9304:: with SMTP id 4mr3073914wro.280.1592312012004;
 Tue, 16 Jun 2020 05:53:32 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f185sm4001403wmf.43.2020.06.16.05.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 05:53:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A5E391FF90;
 Tue, 16 Jun 2020 13:53:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 04/21] configure: add --enable-tsan flag + fiber annotations
 for coroutine-ucontext
Date: Tue, 16 Jun 2020 13:53:07 +0100
Message-Id: <20200616125324.19045-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616125324.19045-1-alex.bennee@linaro.org>
References: <20200616125324.19045-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Robert Foley <robert.foley@linaro.org>,
 qemu-devel@nongnu.org, "Emilio G . Cota" <cota@braap.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Lingfeng Yang <lfy@google.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Lingfeng Yang <lfy@google.com>

We tried running QEMU under tsan in 2016, but tsan's lack of support for
longjmp-based fibers was a blocker:
  https://groups.google.com/forum/#!topic/thread-sanitizer/se0YuzfWazw

Fortunately, thread sanitizer gained fiber support in early 2019:
  https://reviews.llvm.org/D54889

This patch brings tsan support upstream by importing the patch that annotated
QEMU's coroutines as tsan fibers in Android's QEMU fork:
  https://android-review.googlesource.com/c/platform/external/qemu/+/844675

Tested with '--enable-tsan --cc=clang-9 --cxx=clang++-9 --disable-werror'
configure flags.

Signed-off-by: Lingfeng Yang <lfy@google.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
[cota: minor modifications + configure changes]
Signed-off-by: Robert Foley <robert.foley@linaro.org>
[RF: configure changes, coroutine fix + minor modifications]
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200609200738.445-2-robert.foley@linaro.org>
Message-Id: <20200612190237.30436-5-alex.bennee@linaro.org>

diff --git a/configure b/configure
index 8a9f544b0b7..b01b5e3bed0 100755
--- a/configure
+++ b/configure
@@ -395,6 +395,7 @@ gprof="no"
 debug_tcg="no"
 debug="no"
 sanitizers="no"
+tsan="no"
 fortify_source=""
 strip_opt="yes"
 tcg_interpreter="no"
@@ -1152,6 +1153,10 @@ for opt do
   ;;
   --disable-sanitizers) sanitizers="no"
   ;;
+  --enable-tsan) tsan="yes"
+  ;;
+  --disable-tsan) tsan="no"
+  ;;
   --enable-sparse) sparse="yes"
   ;;
   --disable-sparse) sparse="no"
@@ -1764,6 +1769,7 @@ Advanced options (experts only):
   --with-pkgversion=VERS   use specified string as sub-version of the package
   --enable-debug           enable common debug build options
   --enable-sanitizers      enable default sanitizers
+  --enable-tsan            enable thread sanitizer
   --disable-strip          disable stripping binaries
   --disable-werror         disable compilation abort on warning
   --disable-stack-protector disable compiler-provided stack protection
@@ -6220,6 +6226,30 @@ if test "$fuzzing" = "yes" ; then
   fi
 fi
 
+# Thread sanitizer is, for now, much noisier than the other sanitizers;
+# keep it separate until that is not the case.
+if test "$tsan" = "yes" && test "$sanitizers" = "yes"; then
+  error_exit "TSAN is not supported with other sanitiziers."
+fi
+have_tsan=no
+have_tsan_iface_fiber=no
+if test "$tsan" = "yes" ; then
+  write_c_skeleton
+  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=thread" "" ; then
+      have_tsan=yes
+  fi
+  cat > $TMPC << EOF
+#include <sanitizer/tsan_interface.h>
+int main(void) {
+  __tsan_create_fiber(0);
+  return 0;
+}
+EOF
+  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=thread" "" ; then
+      have_tsan_iface_fiber=yes
+  fi
+fi
+
 ##########################################
 # check for libpmem
 
@@ -6377,6 +6407,16 @@ if test "$have_asan" = "yes"; then
            "Without code annotation, the report may be inferior."
   fi
 fi
+if test "$have_tsan" = "yes" ; then
+  if test "$have_tsan_iface_fiber" = "yes" ; then
+    QEMU_CFLAGS="-fsanitize=thread $QEMU_CFLAGS"
+    QEMU_LDFLAGS="-fsanitize=thread $QEMU_LDFLAGS"
+  else
+    error_exit "Cannot enable TSAN due to missing fiber annotation interface."
+  fi
+elif test "$tsan" = "yes" ; then
+  error_exit "Cannot enable TSAN due to missing sanitize thread interface."
+fi
 if test "$have_ubsan" = "yes"; then
   QEMU_CFLAGS="-fsanitize=undefined $QEMU_CFLAGS"
   QEMU_LDFLAGS="-fsanitize=undefined $QEMU_LDFLAGS"
@@ -6412,7 +6452,8 @@ if test "$werror" = "yes"; then
     QEMU_CFLAGS="-Werror $QEMU_CFLAGS"
 fi
 
-if test "$solaris" = "no" ; then
+# Exclude --warn-common with TSan to suppress warnings from the TSan libraries.
+if test "$solaris" = "no" && test "$tsan" = "no"; then
     if $ld --version 2>/dev/null | grep "GNU ld" >/dev/null 2>/dev/null ; then
         QEMU_LDFLAGS="-Wl,--warn-common $QEMU_LDFLAGS"
     fi
@@ -7476,6 +7517,10 @@ if test "$have_asan_iface_fiber" = "yes" ; then
     echo "CONFIG_ASAN_IFACE_FIBER=y" >> $config_host_mak
 fi
 
+if test "$have_tsan" = "yes" && test "$have_tsan_iface_fiber" = "yes" ; then
+    echo "CONFIG_TSAN=y" >> $config_host_mak
+fi
+
 if test "$has_environ" = "yes" ; then
   echo "CONFIG_HAS_ENVIRON=y" >> $config_host_mak
 fi
diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
index bd593e61bc0..613f4c118e4 100644
--- a/util/coroutine-ucontext.c
+++ b/util/coroutine-ucontext.c
@@ -37,12 +37,19 @@
 #endif
 #endif
 
+#ifdef CONFIG_TSAN
+#include <sanitizer/tsan_interface.h>
+#endif
+
 typedef struct {
     Coroutine base;
     void *stack;
     size_t stack_size;
     sigjmp_buf env;
 
+    void *tsan_co_fiber;
+    void *tsan_caller_fiber;
+
 #ifdef CONFIG_VALGRIND_H
     unsigned int valgrind_stack_id;
 #endif
@@ -65,7 +72,18 @@ union cc_arg {
     int i[2];
 };
 
-static void finish_switch_fiber(void *fake_stack_save)
+/* QEMU_ALWAYS_INLINE only does so if __OPTIMIZE__, so we cannot use it. */
+static inline __attribute__((always_inline))
+void on_new_fiber(CoroutineUContext *co)
+{
+#ifdef CONFIG_TSAN
+    co->tsan_co_fiber = __tsan_create_fiber(0); /* flags: sync on switch */
+    co->tsan_caller_fiber = __tsan_get_current_fiber();
+#endif
+}
+
+static inline __attribute__((always_inline))
+void finish_switch_fiber(void *fake_stack_save)
 {
 #ifdef CONFIG_ASAN
     const void *bottom_old;
@@ -78,13 +96,30 @@ static void finish_switch_fiber(void *fake_stack_save)
         leader.stack_size = size_old;
     }
 #endif
+#ifdef CONFIG_TSAN
+    if (fake_stack_save) {
+        __tsan_release(fake_stack_save);
+        __tsan_switch_to_fiber(fake_stack_save, 0);  /* 0=synchronize */
+    }
+#endif
 }
 
-static void start_switch_fiber(void **fake_stack_save,
-                               const void *bottom, size_t size)
+static inline __attribute__((always_inline)) void start_switch_fiber(
+    CoroutineAction action, void **fake_stack_save,
+    const void *bottom, size_t size, void *new_fiber)
 {
 #ifdef CONFIG_ASAN
-    __sanitizer_start_switch_fiber(fake_stack_save, bottom, size);
+    __sanitizer_start_switch_fiber(
+            action == COROUTINE_TERMINATE ? NULL : fake_stack_save,
+            bottom, size);
+#endif
+#ifdef CONFIG_TSAN
+    void *curr_fiber =
+        __tsan_get_current_fiber();
+    __tsan_acquire(curr_fiber);
+
+    *fake_stack_save = curr_fiber;
+    __tsan_switch_to_fiber(new_fiber, 0);  /* 0=synchronize */
 #endif
 }
 
@@ -104,8 +139,12 @@ static void coroutine_trampoline(int i0, int i1)
 
     /* Initialize longjmp environment and switch back the caller */
     if (!sigsetjmp(self->env, 0)) {
-        start_switch_fiber(&fake_stack_save,
-                           leader.stack, leader.stack_size);
+        start_switch_fiber(
+            COROUTINE_YIELD,
+            &fake_stack_save,
+            leader.stack,
+            leader.stack_size,
+            self->tsan_caller_fiber);
         siglongjmp(*(sigjmp_buf *)co->entry_arg, 1);
     }
 
@@ -154,12 +193,16 @@ Coroutine *qemu_coroutine_new(void)
 
     arg.p = co;
 
+    on_new_fiber(co);
     makecontext(&uc, (void (*)(void))coroutine_trampoline,
                 2, arg.i[0], arg.i[1]);
 
     /* swapcontext() in, siglongjmp() back out */
     if (!sigsetjmp(old_env, 0)) {
-        start_switch_fiber(&fake_stack_save, co->stack, co->stack_size);
+        start_switch_fiber(
+            COROUTINE_YIELD,
+            &fake_stack_save,
+            co->stack, co->stack_size, co->tsan_co_fiber);
         swapcontext(&old_uc, &uc);
     }
 
@@ -216,8 +259,8 @@ qemu_coroutine_switch(Coroutine *from_, Coroutine *to_,
 
     ret = sigsetjmp(from->env, 0);
     if (ret == 0) {
-        start_switch_fiber(action == COROUTINE_TERMINATE ?
-                           NULL : &fake_stack_save, to->stack, to->stack_size);
+        start_switch_fiber(action, &fake_stack_save,
+                           to->stack, to->stack_size, to->tsan_co_fiber);
         siglongjmp(to->env, action);
     }
 
@@ -231,6 +274,11 @@ Coroutine *qemu_coroutine_self(void)
     if (!current) {
         current = &leader.base;
     }
+#ifdef CONFIG_TSAN
+    if (!leader.tsan_co_fiber) {
+        leader.tsan_co_fiber = __tsan_get_current_fiber();
+    }
+#endif
     return current;
 }
 
-- 
2.20.1


