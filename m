Received: from eggs.gnu.org ([2001:4830:134:3::10]:41745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYr-0007UW-77
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYp-0005LI-TH
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:49 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:39730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxYp-0005IC-KP
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:47 -0500
Received: by mail-wm0-x243.google.com with SMTP id i11so11128319wmf.4
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:31:47 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:30:47 +0100
Message-Id: <1515756676-3860-24-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 23/52] ucontext: annotate coroutine stack for
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

It helps ASAN to detect more leaks on coroutine stacks, as found in
the following patch.

A similar work would need to be done for sigaltstack & windows fibers
to have similar coverage. Since ucontext is preferred, I didn't bother
checking the other coroutine implementations for now.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20180104160523.22995-16-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .travis.yml               |  3 ++-
 configure                 | 15 +++++++++++++++
 include/qemu/compiler.h   |  4 ++++
 util/coroutine-ucontext.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 1 deletion(-)

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
index d033286..c785dab 100755
--- a/configure
+++ b/configure
@@ -5186,6 +5186,13 @@ if compile_prog "" "" ; then
 fi
 
 ##########################################
+# check for asan header
+have_asan_iface_h=yes
+if ! check_include "sanitizer/asan_interface.h" ; then
+    have_asan_iface_h=no
+fi
+
+##########################################
 # End of CC checks
 # After here, no more $cc or $ld runs
 
@@ -5198,6 +5205,10 @@ elif test "$debug" = "yes"; then
   write_c_skeleton;
   if compile_prog "-fsanitize=address" ""; then
       CFLAGS="-fsanitize=address $CFLAGS"
+      if test "$have_asan_iface_h" = "no" ; then
+          print_error "ASAN build enabled, but ASAN header missing." \
+                      "Without code annotation, the report may be inferior."
+      fi
   fi
   if compile_prog "-fsanitize=undefined" ""; then
       CFLAGS="-fsanitize=undefined $CFLAGS"
@@ -6320,6 +6331,10 @@ if test "$have_utmpx" = "yes" ; then
   echo "HAVE_UTMPX=y" >> $config_host_mak
 fi
 
+if test "$have_asan_iface_h" = "yes" ; then
+    echo "HAVE_ASAN_IFACE_H=y" >> $config_host_mak
+fi
+
 if test "$ivshmem" = "yes" ; then
   echo "CONFIG_IVSHMEM=y" >> $config_host_mak
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
index 6621f3f..e53147f 100644
--- a/util/coroutine-ucontext.c
+++ b/util/coroutine-ucontext.c
@@ -31,6 +31,13 @@
 #include <valgrind/valgrind.h>
 #endif
 
+#if defined(__SANITIZE_ADDRESS__) || __has_feature(address_sanitizer)
+#ifdef HAVE_ASAN_IFACE_H
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
