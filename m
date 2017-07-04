Received: from eggs.gnu.org ([2001:4830:134:3::10]:48214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVvM-0006up-Ra
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:04:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVvL-000877-Bv
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:04:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dSVvL-00086p-2m
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:03:59 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Jul 2017 00:03:12 +0200
Message-Id: <20170704220346.29244-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-1-marcandre.lureau@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 01/35] WIP: coroutine: annotate coroutine with
 clang thread safety attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Weil <sw@weilnetz.de>

It is possible to use clang -Wthread-safety to do some basic coroutine
checks:
http://lists.llvm.org/pipermail/cfe-dev/2017-June/054372.html
https://clang.llvm.org/docs/ThreadSafetyAnalysis.html

This will basically check that you don't call accidentally a coroutine
function from a non-coroutine, as this may crash at run time if the
coroutine function yields.

I had to modify clang to support annotations on typedef and function
pointers, and check some function assignments/arguments. The end
result is quire far from ready for upstream review, but could serve as
basis for more checks or work. (https://github.com/elmarco/clang
qemu-ta branch)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/coroutine.h     | 31 ++++++++++++++++++++++++++++++-
 util/coroutine-sigaltstack.c |  2 ++
 util/coroutine-ucontext.c    |  2 ++
 util/coroutine-win32.c       |  2 ++
 util/qemu-coroutine.c        |  2 ++
 5 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index a4509bd977..35ff394f51 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -28,6 +28,34 @@
  * These functions are re-entrant and may be used outside the global mut=
ex.
  */
=20
+/* clang thread-safety attributes, used for static analysis of the CFG *=
/
+#if defined(__clang__) && (!defined(SWIG))
+#define THREAD_ANNOTATION_ATTRIBUTE__(x)   __attribute__((x))
+#else
+#define THREAD_ANNOTATION_ATTRIBUTE__(x)
+#endif
+
+#define TAA_ROLE                                        \
+    THREAD_ANNOTATION_ATTRIBUTE__(capability("role"))
+
+#define TAA_REQUIRES(...)                                               =
\
+    THREAD_ANNOTATION_ATTRIBUTE__(requires_capability(__VA_ARGS__))
+
+#define TAA_ACQUIRE(R)                                          \
+    THREAD_ANNOTATION_ATTRIBUTE__(acquire_capability(R))
+
+#define TAA_RELEASE(R)                                          \
+    THREAD_ANNOTATION_ATTRIBUTE__(release_capability(R))
+
+#define TAA_NO_ANALYSYS                                         \
+    THREAD_ANNOTATION_ATTRIBUTE__(no_thread_safety_analysis)
+
+typedef int TAA_ROLE coroutine_role;
+extern coroutine_role _coroutine_fn;
+
+static inline void co_role_acquire(coroutine_role R) TAA_ACQUIRE(R) TAA_=
NO_ANALYSYS {}
+static inline void co_role_release(coroutine_role R) TAA_RELEASE(R) TAA_=
NO_ANALYSYS {}
+
 /**
  * Mark a function that executes in coroutine context
  *
@@ -42,7 +70,8 @@
  *       ....
  *   }
  */
-#define coroutine_fn
+
+#define coroutine_fn TAA_REQUIRES(_coroutine_fn)
=20
 typedef struct Coroutine Coroutine;
=20
diff --git a/util/coroutine-sigaltstack.c b/util/coroutine-sigaltstack.c
index f6fc49a0e5..05d1a378d1 100644
--- a/util/coroutine-sigaltstack.c
+++ b/util/coroutine-sigaltstack.c
@@ -98,7 +98,9 @@ static void coroutine_bootstrap(CoroutineSigAltStack *s=
elf, Coroutine *co)
     }
=20
     while (true) {
+        co_role_acquire(_coroutine_fn);
         co->entry(co->entry_arg);
+        co_role_release(_coroutine_fn);
         qemu_coroutine_switch(co, co->caller, COROUTINE_TERMINATE);
     }
 }
diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
index 6621f3f692..010fbaedf1 100644
--- a/util/coroutine-ucontext.c
+++ b/util/coroutine-ucontext.c
@@ -76,7 +76,9 @@ static void coroutine_trampoline(int i0, int i1)
     }
=20
     while (true) {
+        co_role_acquire(_coroutine_fn);
         co->entry(co->entry_arg);
+        co_role_release(_coroutine_fn);
         qemu_coroutine_switch(co, co->caller, COROUTINE_TERMINATE);
     }
 }
diff --git a/util/coroutine-win32.c b/util/coroutine-win32.c
index de6bd4fd3e..75a3bed543 100644
--- a/util/coroutine-win32.c
+++ b/util/coroutine-win32.c
@@ -64,7 +64,9 @@ static void CALLBACK coroutine_trampoline(void *co_)
     Coroutine *co =3D co_;
=20
     while (true) {
+        co_role_acquire(_coroutine_fn);
         co->entry(co->entry_arg);
+        co_role_release(_coroutine_fn);
         qemu_coroutine_switch(co, co->caller, COROUTINE_TERMINATE);
     }
 }
diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index d6095c1d5a..efa0f20e69 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -25,6 +25,8 @@ enum {
     POOL_BATCH_SIZE =3D 64,
 };
=20
+coroutine_role _coroutine_fn;
+
 /** Free list to speed up creation */
 static QSLIST_HEAD(, Coroutine) release_pool =3D QSLIST_HEAD_INITIALIZER=
(pool);
 static unsigned int release_pool_size;
--=20
2.13.1.395.gf7b71de06
