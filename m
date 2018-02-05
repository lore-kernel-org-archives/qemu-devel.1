Received: from eggs.gnu.org ([2001:4830:134:3::10]:44749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSJ-0004UI-MW
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSI-00050f-8j
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:31 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:37745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimSH-00050Q-V2
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:30 -0500
Received: by mail-wm0-x242.google.com with SMTP id v71so28090748wmv.2
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:29 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:34 +0100
Message-Id: <1517858941-5538-21-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/47] ucontext: annotate coroutine stack for
 ASAN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

It helps ASAN to detect more leaks on coroutine stacks, and to get rid
of some extra warnings.

Before:

tests/test-coroutine -p
/basic/lifecycle
/basic/lifecycle: ==20781==WARNING: ASan doesn't fully support
makecontext/swapcontext functions and may produce false positives in
some cases!
==20781==WARNING: ASan is ignoring requested __asan_handle_no_return:
stack top: 0x7ffcb184d000; bottom 0x7ff6c4cfd000; size: 0x0005ecb50000
(25446121472)
False positive error reports may follow
For details see https://github.com/google/sanitizers/issues/189
OK

After:

tests/test-coroutine -p /basic/lifecycle
/basic/lifecycle: ==21110==WARNING: ASan doesn't fully support
makecontext/swapcontext functions and may produce false positives in
some cases!
OK

A similar work would need to be done for sigaltstack & windows fibers
to have similar coverage. Since ucontext is preferred, I didn't bother
checking the other coroutine implementations for now.

Update travis to fix the build with ASAN annotations.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180116151152.4040-4-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .travis.yml               |  3 ++-
 configure                 | 30 +++++++++++++++++++++++++++++
 include/qemu/compiler.h   |  4 ++++
 util/coroutine-ucontext.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index f583839..f2291e8 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -13,12 +13,13 @@ addons:
       - libattr1-dev
       - libbrlapi-dev
       - libcap-ng-dev
+      - libgcc-6-dev
       - libgnutls-dev
       - libgtk-3-dev
       - libiscsi-dev
       - liblttng-ust-dev
-      - libnfs-dev
       - libncurses5-dev
+      - libnfs-dev
       - libnss3-dev
       - libpixman-1-dev
       - libpng12-dev
diff --git a/configure b/configure
index bbfcd9f..0b5c812 100755
--- a/configure
+++ b/configure
@@ -5213,6 +5213,8 @@ write_c_skeleton
 
 have_asan=no
 have_ubsan=no
+have_asan_iface_h=no
+have_asan_iface_fiber=no
 
 # enable sanitizers by default if --enable-debug
 if test "$sanitizers" = "" -a "$debug" = "yes"; then
@@ -5226,12 +5228,29 @@ if test "$sanitizers" = "yes" ; then
   if compile_prog "$CPU_CFLAGS -Werror -fsanitize=undefined" ""; then
       have_ubsan=yes
   fi
+
+  if check_include "sanitizer/asan_interface.h" ; then
+      have_asan_iface_h=yes
+  fi
+
+  cat > $TMPC << EOF
+#include <sanitizer/asan_interface.h>
+int main(void) {
+  __sanitizer_start_switch_fiber(0, 0, 0);
+  return 0;
+}
+EOF
+  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=address" "" ; then
+      have_asan_iface_fiber=yes
+  fi
 fi
 
 ##########################################
 # End of CC checks
 # After here, no more $cc or $ld runs
 
+write_c_skeleton
+
 if test "$gcov" = "yes" ; then
   CFLAGS="-fprofile-arcs -ftest-coverage -g $CFLAGS"
   LDFLAGS="-fprofile-arcs -ftest-coverage $LDFLAGS"
@@ -5254,6 +5273,13 @@ fi
 
 if test "$have_asan" = "yes"; then
   CFLAGS="-fsanitize=address $CFLAGS"
+  if test "$have_asan_iface_h" = "no" ; then
+      echo "ASAN build enabled, but ASAN header missing." \
+           "Without code annotation, the report may be inferior."
+  elif test "$have_asan_iface_fiber" = "no" ; then
+      echo "ASAN build enabled, but ASAN header is too old." \
+           "Without code annotation, the report may be inferior."
+  fi
 fi
 if test "$have_ubsan" = "yes"; then
   CFLAGS="-fsanitize=undefined $CFLAGS"
@@ -6242,6 +6268,10 @@ if test "$valgrind_h" = "yes" ; then
   echo "CONFIG_VALGRIND_H=y" >> $config_host_mak
 fi
 
+if test "$have_asan_iface_fiber" = "yes" ; then
+    echo "CONFIG_ASAN_IFACE_FIBER=y" >> $config_host_mak
+fi
+
 if test "$has_environ" = "yes" ; then
   echo "CONFIG_HAS_ENVIRON=y" >> $config_host_mak
 fi
diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 340e5fd..5fcc4f7 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -111,4 +111,8 @@
 #define GCC_FMT_ATTR(n, m)
 #endif
 
+#ifndef __has_feature
+#define __has_feature(x) 0 /* compatibility with non-clang compilers */
+#endif
+
 #endif /* COMPILER_H */
diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
index 6621f3f..926d340 100644
--- a/util/coroutine-ucontext.c
+++ b/util/coroutine-ucontext.c
@@ -31,6 +31,13 @@
 #include <valgrind/valgrind.h>
 #endif
 
+#if defined(__SANITIZE_ADDRESS__) || __has_feature(address_sanitizer)
+#ifdef CONFIG_ASAN_IFACE_FIBER
+#define CONFIG_ASAN 1
+#include <sanitizer/asan_interface.h>
+#endif
+#endif
+
 typedef struct {
     Coroutine base;
     void *stack;
@@ -59,11 +66,37 @@ union cc_arg {
     int i[2];
 };
 
+static void finish_switch_fiber(void *fake_stack_save)
+{
+#ifdef CONFIG_ASAN
+    const void *bottom_old;
+    size_t size_old;
+
+    __sanitizer_finish_switch_fiber(fake_stack_save, &bottom_old, &size_old);
+
+    if (!leader.stack) {
+        leader.stack = (void *)bottom_old;
+        leader.stack_size = size_old;
+    }
+#endif
+}
+
+static void start_switch_fiber(void **fake_stack_save,
+                               const void *bottom, size_t size)
+{
+#ifdef CONFIG_ASAN
+    __sanitizer_start_switch_fiber(fake_stack_save, bottom, size);
+#endif
+}
+
 static void coroutine_trampoline(int i0, int i1)
 {
     union cc_arg arg;
     CoroutineUContext *self;
     Coroutine *co;
+    void *fake_stack_save = NULL;
+
+    finish_switch_fiber(NULL);
 
     arg.i[0] = i0;
     arg.i[1] = i1;
@@ -72,9 +105,13 @@ static void coroutine_trampoline(int i0, int i1)
 
     /* Initialize longjmp environment and switch back the caller */
     if (!sigsetjmp(self->env, 0)) {
+        start_switch_fiber(&fake_stack_save,
+                           leader.stack, leader.stack_size);
         siglongjmp(*(sigjmp_buf *)co->entry_arg, 1);
     }
 
+    finish_switch_fiber(fake_stack_save);
+
     while (true) {
         co->entry(co->entry_arg);
         qemu_coroutine_switch(co, co->caller, COROUTINE_TERMINATE);
@@ -87,6 +124,7 @@ Coroutine *qemu_coroutine_new(void)
     ucontext_t old_uc, uc;
     sigjmp_buf old_env;
     union cc_arg arg = {0};
+    void *fake_stack_save = NULL;
 
     /* The ucontext functions preserve signal masks which incurs a
      * system call overhead.  sigsetjmp(buf, 0)/siglongjmp() does not
@@ -122,8 +160,12 @@ Coroutine *qemu_coroutine_new(void)
 
     /* swapcontext() in, siglongjmp() back out */
     if (!sigsetjmp(old_env, 0)) {
+        start_switch_fiber(&fake_stack_save, co->stack, co->stack_size);
         swapcontext(&old_uc, &uc);
     }
+
+    finish_switch_fiber(fake_stack_save);
+
     return &co->base;
 }
 
@@ -169,13 +211,19 @@ qemu_coroutine_switch(Coroutine *from_, Coroutine *to_,
     CoroutineUContext *from = DO_UPCAST(CoroutineUContext, base, from_);
     CoroutineUContext *to = DO_UPCAST(CoroutineUContext, base, to_);
     int ret;
+    void *fake_stack_save = NULL;
 
     current = to_;
 
     ret = sigsetjmp(from->env, 0);
     if (ret == 0) {
+        start_switch_fiber(action == COROUTINE_TERMINATE ?
+                           NULL : &fake_stack_save, to->stack, to->stack_size);
         siglongjmp(to->env, action);
     }
+
+    finish_switch_fiber(fake_stack_save);
+
     return ret;
 }
 
-- 
1.8.3.1
