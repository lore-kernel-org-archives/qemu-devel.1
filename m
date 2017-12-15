Received: from eggs.gnu.org ([2001:4830:134:3::10]:42643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ePrap-0004ot-VY
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:08:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ePrak-0001n9-65
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:08:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ePraj-0001mi-TQ
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:08:02 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 26A0C83F3D
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 15:08:01 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 15 Dec 2017 16:06:58 +0100
Message-Id: <20171215150659.1811-13-marcandre.lureau@redhat.com>
In-Reply-To: <20171215150659.1811-1-marcandre.lureau@redhat.com>
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 12/13] ucontext: annotate coroutine stack
 for ASAN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

It helps ASAN to detect more leaks on coroutine stacks, as found in
the following patch.

A similar work would need to be done for sigaltstack & windows fibers
to have similar coverage. Since ucontext is prefered, I didn't bother
checking the other coroutine implementations for now.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/compiler.h   |  4 ++++
 util/coroutine-ucontext.c | 46 +++++++++++++++++++++++++++++++++++++++++=
+++++
 2 files changed, 50 insertions(+)

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
index 6621f3f692..e78eae8766 100644
--- a/util/coroutine-ucontext.c
+++ b/util/coroutine-ucontext.c
@@ -31,6 +31,11 @@
 #include <valgrind/valgrind.h>
 #endif
=20
+#if defined(__SANITIZE_ADDRESS__) || __has_feature(address_sanitizer)
+#define CONFIG_ASAN 1
+#include <sanitizer/asan_interface.h>
+#endif
+
 typedef struct {
     Coroutine base;
     void *stack;
@@ -59,11 +64,37 @@ union cc_arg {
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
@@ -72,9 +103,13 @@ static void coroutine_trampoline(int i0, int i1)
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
@@ -87,6 +122,7 @@ Coroutine *qemu_coroutine_new(void)
     ucontext_t old_uc, uc;
     sigjmp_buf old_env;
     union cc_arg arg =3D {0};
+    void *fake_stack_save =3D NULL;
=20
     /* The ucontext functions preserve signal masks which incurs a
      * system call overhead.  sigsetjmp(buf, 0)/siglongjmp() does not
@@ -122,8 +158,12 @@ Coroutine *qemu_coroutine_new(void)
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
@@ -169,13 +209,19 @@ qemu_coroutine_switch(Coroutine *from_, Coroutine *=
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
--=20
2.15.1.355.g36791d7216
