Received: from eggs.gnu.org ([2001:4830:134:3::10]:57639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ea0B5-0006eE-Ei
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:19:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ea0B0-0001Me-TL
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:19:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ea0B0-0001Lv-JK
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:19:22 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 12 Jan 2018 15:17:45 +0100
Message-Id: <20180112141745.28389-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4] ucontext: annotate coroutine stack for ASAN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

It helps ASAN to detect more leaks on coroutine stacks, as found in
the following patch.

A similar work would need to be done for sigaltstack & windows fibers
to have similar coverage. Since ucontext is preferred, I didn't bother
checking the other coroutine implementations for now.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/compiler.h   |  4 ++++
 util/coroutine-ucontext.c | 48 +++++++++++++++++++++++++++++++++++++++++=
++++++
 .travis.yml               |  3 ++-
 configure                 | 41 ++++++++++++++++++++++++++++++++++++++--
 4 files changed, 93 insertions(+), 3 deletions(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 340e5fdc09..5fcc4f7ec7 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -111,4 +111,8 @@
 #define GCC_FMT_ATTR(n, m)
 #endif
=20
+#ifndef __has_feature
+#define __has_feature(x) 0 /* compatibility with non-clang compilers */
+#endif
+
 #endif /* COMPILER_H */
diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
index 6621f3f692..96af7f5aad 100644
--- a/util/coroutine-ucontext.c
+++ b/util/coroutine-ucontext.c
@@ -31,6 +31,13 @@
 #include <valgrind/valgrind.h>
 #endif
=20
+#if defined(__SANITIZE_ADDRESS__) || __has_feature(address_sanitizer)
+#ifdef HAVE_ASAN_IFACE_FIBER
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
=20
+static void finish_switch_fiber(void *fake_stack_save)
+{
+#ifdef CONFIG_ASAN
+    const void *bottom_old;
+    size_t size_old;
+
+    __sanitizer_finish_switch_fiber(fake_stack_save, &bottom_old, &size_=
old);
+
+    if (!leader.stack) {
+        leader.stack =3D (void *)bottom_old;
+        leader.stack_size =3D size_old;
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
+    void *fake_stack_save =3D NULL;
+
+    finish_switch_fiber(NULL);
=20
     arg.i[0] =3D i0;
     arg.i[1] =3D i1;
@@ -72,9 +105,13 @@ static void coroutine_trampoline(int i0, int i1)
=20
     /* Initialize longjmp environment and switch back the caller */
     if (!sigsetjmp(self->env, 0)) {
+        start_switch_fiber(&fake_stack_save,
+                           leader.stack, leader.stack_size);
         siglongjmp(*(sigjmp_buf *)co->entry_arg, 1);
     }
=20
+    finish_switch_fiber(fake_stack_save);
+
     while (true) {
         co->entry(co->entry_arg);
         qemu_coroutine_switch(co, co->caller, COROUTINE_TERMINATE);
@@ -87,6 +124,7 @@ Coroutine *qemu_coroutine_new(void)
     ucontext_t old_uc, uc;
     sigjmp_buf old_env;
     union cc_arg arg =3D {0};
+    void *fake_stack_save =3D NULL;
=20
     /* The ucontext functions preserve signal masks which incurs a
      * system call overhead.  sigsetjmp(buf, 0)/siglongjmp() does not
@@ -122,8 +160,12 @@ Coroutine *qemu_coroutine_new(void)
=20
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
=20
@@ -169,13 +211,19 @@ qemu_coroutine_switch(Coroutine *from_, Coroutine *=
to_,
     CoroutineUContext *from =3D DO_UPCAST(CoroutineUContext, base, from_=
);
     CoroutineUContext *to =3D DO_UPCAST(CoroutineUContext, base, to_);
     int ret;
+    void *fake_stack_save =3D NULL;
=20
     current =3D to_;
=20
     ret =3D sigsetjmp(from->env, 0);
     if (ret =3D=3D 0) {
+        start_switch_fiber(action =3D=3D COROUTINE_TERMINATE ?
+                           NULL : &fake_stack_save, to->stack, to->stack=
_size);
         siglongjmp(to->env, action);
     }
+
+    finish_switch_fiber(fake_stack_save);
+
     return ret;
 }
=20
diff --git a/.travis.yml b/.travis.yml
index f583839755..f2291e87a6 100644
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
index d033286b48..3007a2cec4 100755
--- a/configure
+++ b/configure
@@ -5185,19 +5185,52 @@ if compile_prog "" "" ; then
     have_utmpx=3Dyes
 fi
=20
+##########################################
+# checks for ASAN
+
+have_asan=3Dno
+write_c_skeleton
+if compile_prog "-fsanitize=3Daddress" ""; then
+    have_asan=3Dyes
+fi
+
+have_asan_iface_h=3Dno
+if check_include "sanitizer/asan_interface.h" ; then
+    have_asan_iface_h=3Dyes
+fi
+
+have_asan_iface_fiber=3Dno
+cat > $TMPC << EOF
+#include <sanitizer/asan_interface.h>
+int main(void) {
+  __sanitizer_start_switch_fiber(0, 0, 0);
+  return 0;
+}
+EOF
+if compile_prog "-fsanitize=3Daddress" "" ; then
+    have_asan_iface_fiber=3Dyes
+fi
+
 ##########################################
 # End of CC checks
 # After here, no more $cc or $ld runs
=20
+write_c_skeleton
 if test "$gcov" =3D "yes" ; then
   CFLAGS=3D"-fprofile-arcs -ftest-coverage -g $CFLAGS"
   LDFLAGS=3D"-fprofile-arcs -ftest-coverage $LDFLAGS"
 elif test "$fortify_source" =3D "yes" ; then
   CFLAGS=3D"-O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 $CFLAGS"
 elif test "$debug" =3D "yes"; then
-  write_c_skeleton;
-  if compile_prog "-fsanitize=3Daddress" ""; then
+  if test "$have_asan" =3D "yes"; then
       CFLAGS=3D"-fsanitize=3Daddress $CFLAGS"
+      if test "$have_asan_iface_h" =3D "no" ; then
+          print_error "ASAN build enabled, but ASAN header missing." \
+                      "Without code annotation, the report may be inferi=
or."
+      elif test "$have_asan_iface_fiber" =3D "no" ; then
+          print_error "ASAN build enabled, but ASAN header is too old." =
\
+                      "Without code annotation, the report may be inferi=
or."
+      fi
   fi
   if compile_prog "-fsanitize=3Dundefined" ""; then
       CFLAGS=3D"-fsanitize=3Dundefined $CFLAGS"
@@ -6320,6 +6353,10 @@ if test "$have_utmpx" =3D "yes" ; then
   echo "HAVE_UTMPX=3Dy" >> $config_host_mak
 fi
=20
+if test "$have_asan_iface_fiber" =3D "yes" ; then
+    echo "HAVE_ASAN_IFACE_FIBER=3Dy" >> $config_host_mak
+fi
+
 if test "$ivshmem" =3D "yes" ; then
   echo "CONFIG_IVSHMEM=3Dy" >> $config_host_mak
 fi
--=20
2.16.0.rc1.1.gef27df75a1
