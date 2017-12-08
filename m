Received: from eggs.gnu.org ([2001:4830:134:3::10]:46821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eN70a-0007jN-Iw
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 19:59:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eN70W-0007x4-My
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 19:59:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eN70W-0007wL-EV
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 19:59:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 868B785546
	for <qemu-devel@nongnu.org>; Fri,  8 Dec 2017 00:59:15 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  8 Dec 2017 01:58:25 +0100
Message-Id: <20171208005825.14587-13-marcandre.lureau@redhat.com>
In-Reply-To: <20171208005825.14587-1-marcandre.lureau@redhat.com>
References: <20171208005825.14587-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 12/12] WIP ucontext: annotate coroutine stack
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

Not strictly necessary, but it may help ASAN and remove some false
positives.

Sadly, this annotation produces an ASAN error:

$ tests/test-coroutine -p /basic/lifecycle
/basic/lifecycle: =3D=3D27655=3D=3DWARNING: ASan doesn't fully support ma=
kecontext/swapcontext functions and may produce false positives in some c=
ases!
=3D=3D27655=3D=3DAddressSanitizer CHECK failed: /builddir/build/BUILD/com=
piler-rt-4.0.1.src/lib/asan/asan_poisoning.cc:38 "((AddrIsAlignedByGranul=
arity(addr + size))) !=3D (0)" (0x0, 0x0)
    #0 0x55d1e4e8a695 in __asan::AsanCheckFailed(char const*, int, char c=
onst*, unsigned long long, unsigned long long) (/home/elmarco/src/qq/buil=
d/tests/test-coroutine+0x1c0695)
    #1 0x55d1e4ea6235 in __sanitizer::CheckFailed(char const*, int, char =
const*, unsigned long long, unsigned long long) (/home/elmarco/src/qq/bui=
ld/tests/test-coroutine+0x1dc235)
    #2 0x55d1e4e82ea4 in __asan::PoisonShadow(unsigned long, unsigned lon=
g, unsigned char) (/home/elmarco/src/qq/build/tests/test-coroutine+0x1b8e=
a4)
    #3 0x55d1e4dde1e7 in __asan::FakeStack::Destroy(int) (/home/elmarco/s=
rc/qq/build/tests/test-coroutine+0x1141e7)
    #4 0x55d1e528b775 in qemu_coroutine_switch /home/elmarco/src/qq/util/=
coroutine-ucontext.c:219:9
    #5 0x55d1e528b18d in coroutine_trampoline /home/elmarco/src/qq/util/c=
oroutine-ucontext.c:114:9
    #6 0x7fb3e0087bef  (/lib64/libc.so.6+0x50bef)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 util/coroutine-ucontext.c | 47 +++++++++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 47 insertions(+)

diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
index 6621f3f692..d200498c38 100644
--- a/util/coroutine-ucontext.c
+++ b/util/coroutine-ucontext.c
@@ -31,6 +31,25 @@
 #include <valgrind/valgrind.h>
 #endif
=20
+#if (defined(__has_feature) && __has_feature(address_sanitizer)) || \
+    __SANITIZE_ADDRESS__
+#include <sanitizer/asan_interface.h>
+#else
+/* stub to check correct arguments */
+static inline void
+__sanitizer_start_switch_fiber(void **fake_stack_save,
+                               const void *bottom, size_t size)
+{
+}
+
+static inline void
+__sanitizer_finish_switch_fiber(void *fake_stack_save,
+                                const void **bottom_old,
+                                size_t *size_old)
+{
+}
+#endif
+
 typedef struct {
     Coroutine base;
     void *stack;
@@ -64,6 +83,15 @@ static void coroutine_trampoline(int i0, int i1)
     union cc_arg arg;
     CoroutineUContext *self;
     Coroutine *co;
+    const void *bottom_old;
+    size_t size_old;
+    void *fake_stack_save;
+
+    __sanitizer_finish_switch_fiber(NULL, &bottom_old, &size_old);
+    if (!leader.stack) {
+        leader.stack =3D (void *)bottom_old;
+        leader.stack_size =3D size_old;
+    }
=20
     arg.i[0] =3D i0;
     arg.i[1] =3D i1;
@@ -72,9 +100,14 @@ static void coroutine_trampoline(int i0, int i1)
=20
     /* Initialize longjmp environment and switch back the caller */
     if (!sigsetjmp(self->env, 0)) {
+        __sanitizer_start_switch_fiber(&fake_stack_save,
+                                       bottom_old, size_old);
         siglongjmp(*(sigjmp_buf *)co->entry_arg, 1);
     }
=20
+    __sanitizer_finish_switch_fiber(&fake_stack_save,
+                                    NULL, NULL);
+
     while (true) {
         co->entry(co->entry_arg);
         qemu_coroutine_switch(co, co->caller, COROUTINE_TERMINATE);
@@ -87,6 +120,7 @@ Coroutine *qemu_coroutine_new(void)
     ucontext_t old_uc, uc;
     sigjmp_buf old_env;
     union cc_arg arg =3D {0};
+    void *fake_stack_save;
=20
     /* The ucontext functions preserve signal masks which incurs a
      * system call overhead.  sigsetjmp(buf, 0)/siglongjmp() does not
@@ -122,8 +156,13 @@ Coroutine *qemu_coroutine_new(void)
=20
     /* swapcontext() in, siglongjmp() back out */
     if (!sigsetjmp(old_env, 0)) {
+        __sanitizer_start_switch_fiber(&fake_stack_save,
+                                       co->stack, co->stack_size);
         swapcontext(&old_uc, &uc);
     }
+
+    __sanitizer_finish_switch_fiber(&fake_stack_save, NULL, NULL);
+
     return &co->base;
 }
=20
@@ -169,13 +208,21 @@ qemu_coroutine_switch(Coroutine *from_, Coroutine *=
to_,
     CoroutineUContext *from =3D DO_UPCAST(CoroutineUContext, base, from_=
);
     CoroutineUContext *to =3D DO_UPCAST(CoroutineUContext, base, to_);
     int ret;
+    void *fake_stack_save;
=20
     current =3D to_;
=20
     ret =3D sigsetjmp(from->env, 0);
     if (ret =3D=3D 0) {
+
+        __sanitizer_start_switch_fiber(action =3D=3D COROUTINE_TERMINATE=
 ?
+                                       NULL : &fake_stack_save,
+                                       to->stack, to->stack_size);
         siglongjmp(to->env, action);
     }
+
+    __sanitizer_finish_switch_fiber(&fake_stack_save, NULL, NULL);
+
     return ret;
 }
=20
--=20
2.15.1.355.g36791d7216
