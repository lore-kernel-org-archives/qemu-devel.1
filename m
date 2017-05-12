Received: from eggs.gnu.org ([2001:4830:134:3::10]:44171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d9BhA-0004XI-BM
	for qemu-devel@nongnu.org; Fri, 12 May 2017 10:37:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d9Bh8-0004iD-HV
	for qemu-devel@nongnu.org; Fri, 12 May 2017 10:37:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1d9Bh8-0004hC-7z
	for qemu-devel@nongnu.org; Fri, 12 May 2017 10:37:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 12 May 2017 10:37:15 -0400
Message-Id: <20170512143717.30391-2-stefanha@redhat.com>
In-Reply-To: <20170512143717.30391-1-stefanha@redhat.com>
References: <20170512143717.30391-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.9 1/3] coroutine: remove GThread
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

The GThread implementation is not functional enough to actually
run QEMU reliably. While it was potentially useful for debugging,
we have a scripts/qemugdb/coroutine.py to enable tracing of
ucontext coroutines in GDB, so that removes the only reason for
GThread to exist.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 configure                |  19 ++---
 util/coroutine-gthread.c | 198 -----------------------------------------=
------
 .travis.yml              |   5 +-
 3 files changed, 6 insertions(+), 216 deletions(-)
 delete mode 100644 util/coroutine-gthread.c

diff --git a/configure b/configure
index 7c020c0..39e727e 100755
--- a/configure
+++ b/configure
@@ -1334,7 +1334,7 @@ Advanced options (experts only):
   --oss-lib                path to OSS library
   --cpu=3DCPU                Build for host CPU [$cpu]
   --with-coroutine=3DBACKEND coroutine backend. Supported options:
-                           gthread, ucontext, sigaltstack, windows
+                           ucontext, sigaltstack, windows
   --enable-gcov            enable test coverage analysis with gcov
   --gcov=3DGCOV              use specified gcov [$gcov_tool]
   --disable-blobs          disable installing provided firmware blobs
@@ -4418,10 +4418,8 @@ fi
 # check and set a backend for coroutine
=20
 # We prefer ucontext, but it's not always possible. The fallback
-# is sigcontext. gthread is not selectable except explicitly, because
-# it is not functional enough to run QEMU proper. (It is occasionally
-# useful for debugging purposes.)  On Windows the only valid backend
-# is the Windows-specific one.
+# is sigcontext. On Windows the only valid backend is the Windows
+# specific one.
=20
 ucontext_works=3Dno
 if test "$darwin" !=3D "yes"; then
@@ -4460,7 +4458,7 @@ else
       feature_not_found "ucontext"
     fi
     ;;
-  gthread|sigaltstack)
+  sigaltstack)
     if test "$mingw32" =3D "yes"; then
       error_exit "only the 'windows' coroutine backend is valid for Wind=
ows"
     fi
@@ -4472,14 +4470,7 @@ else
 fi
=20
 if test "$coroutine_pool" =3D ""; then
-  if test "$coroutine" =3D "gthread"; then
-    coroutine_pool=3Dno
-  else
-    coroutine_pool=3Dyes
-  fi
-fi
-if test "$coroutine" =3D "gthread" -a "$coroutine_pool" =3D "yes"; then
-  error_exit "'gthread' coroutine backend does not support pool (use --d=
isable-coroutine-pool)"
+  coroutine_pool=3Dyes
 fi
=20
 if test "$debug_stack_usage" =3D "yes"; then
diff --git a/util/coroutine-gthread.c b/util/coroutine-gthread.c
deleted file mode 100644
index 62bfb40..0000000
--- a/util/coroutine-gthread.c
+++ /dev/null
@@ -1,198 +0,0 @@
-/*
- * GThread coroutine initialization code
- *
- * Copyright (C) 2006  Anthony Liguori <anthony@codemonkey.ws>
- * Copyright (C) 2011  Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com=
>
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.0 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
- */
-
-#include "qemu/osdep.h"
-#include "qemu-common.h"
-#include "qemu/coroutine_int.h"
-
-typedef struct {
-    Coroutine base;
-    GThread *thread;
-    bool runnable;
-    bool free_on_thread_exit;
-    CoroutineAction action;
-} CoroutineGThread;
-
-static CompatGMutex coroutine_lock;
-static CompatGCond coroutine_cond;
-
-/* GLib 2.31 and beyond deprecated various parts of the thread API,
- * but the new interfaces are not available in older GLib versions
- * so we have to cope with both.
- */
-#if GLIB_CHECK_VERSION(2, 31, 0)
-/* Awkwardly, the GPrivate API doesn't provide a way to update the
- * GDestroyNotify handler for the coroutine key dynamically. So instead
- * we track whether or not the CoroutineGThread should be freed on
- * thread exit / coroutine key update using the free_on_thread_exit
- * field.
- */
-static void coroutine_destroy_notify(gpointer data)
-{
-    CoroutineGThread *co =3D data;
-    if (co && co->free_on_thread_exit) {
-        g_free(co);
-    }
-}
-
-static GPrivate coroutine_key =3D G_PRIVATE_INIT(coroutine_destroy_notif=
y);
-
-static inline CoroutineGThread *get_coroutine_key(void)
-{
-    return g_private_get(&coroutine_key);
-}
-
-static inline void set_coroutine_key(CoroutineGThread *co,
-                                     bool free_on_thread_exit)
-{
-    /* Unlike g_static_private_set() this does not call the GDestroyNoti=
fy
-     * if the previous value of the key was NULL. Fortunately we only ne=
ed
-     * the GDestroyNotify in the non-NULL key case.
-     */
-    co->free_on_thread_exit =3D free_on_thread_exit;
-    g_private_replace(&coroutine_key, co);
-}
-
-static inline GThread *create_thread(GThreadFunc func, gpointer data)
-{
-    return g_thread_new("coroutine", func, data);
-}
-
-#else
-
-/* Handle older GLib versions */
-
-static GStaticPrivate coroutine_key =3D G_STATIC_PRIVATE_INIT;
-
-static inline CoroutineGThread *get_coroutine_key(void)
-{
-    return g_static_private_get(&coroutine_key);
-}
-
-static inline void set_coroutine_key(CoroutineGThread *co,
-                                     bool free_on_thread_exit)
-{
-    g_static_private_set(&coroutine_key, co,
-                         free_on_thread_exit ? (GDestroyNotify)g_free : =
NULL);
-}
-
-static inline GThread *create_thread(GThreadFunc func, gpointer data)
-{
-    return g_thread_create_full(func, data, 0, TRUE, TRUE,
-                                G_THREAD_PRIORITY_NORMAL, NULL);
-}
-
-#endif
-
-
-static void __attribute__((constructor)) coroutine_init(void)
-{
-#if !GLIB_CHECK_VERSION(2, 31, 0)
-    if (!g_thread_supported()) {
-        g_thread_init(NULL);
-    }
-#endif
-}
-
-static void coroutine_wait_runnable_locked(CoroutineGThread *co)
-{
-    while (!co->runnable) {
-        g_cond_wait(&coroutine_cond, &coroutine_lock);
-    }
-}
-
-static void coroutine_wait_runnable(CoroutineGThread *co)
-{
-    g_mutex_lock(&coroutine_lock);
-    coroutine_wait_runnable_locked(co);
-    g_mutex_unlock(&coroutine_lock);
-}
-
-static gpointer coroutine_thread(gpointer opaque)
-{
-    CoroutineGThread *co =3D opaque;
-
-    set_coroutine_key(co, false);
-    coroutine_wait_runnable(co);
-    co->base.entry(co->base.entry_arg);
-    qemu_coroutine_switch(&co->base, co->base.caller, COROUTINE_TERMINAT=
E);
-    return NULL;
-}
-
-Coroutine *qemu_coroutine_new(void)
-{
-    CoroutineGThread *co;
-
-    co =3D g_malloc0(sizeof(*co));
-    co->thread =3D create_thread(coroutine_thread, co);
-    if (!co->thread) {
-        g_free(co);
-        return NULL;
-    }
-    return &co->base;
-}
-
-void qemu_coroutine_delete(Coroutine *co_)
-{
-    CoroutineGThread *co =3D DO_UPCAST(CoroutineGThread, base, co_);
-
-    g_thread_join(co->thread);
-    g_free(co);
-}
-
-CoroutineAction qemu_coroutine_switch(Coroutine *from_,
-                                      Coroutine *to_,
-                                      CoroutineAction action)
-{
-    CoroutineGThread *from =3D DO_UPCAST(CoroutineGThread, base, from_);
-    CoroutineGThread *to =3D DO_UPCAST(CoroutineGThread, base, to_);
-
-    g_mutex_lock(&coroutine_lock);
-    from->runnable =3D false;
-    from->action =3D action;
-    to->runnable =3D true;
-    to->action =3D action;
-    g_cond_broadcast(&coroutine_cond);
-
-    if (action !=3D COROUTINE_TERMINATE) {
-        coroutine_wait_runnable_locked(from);
-    }
-    g_mutex_unlock(&coroutine_lock);
-    return from->action;
-}
-
-Coroutine *qemu_coroutine_self(void)
-{
-    CoroutineGThread *co =3D get_coroutine_key();
-    if (!co) {
-        co =3D g_malloc0(sizeof(*co));
-        co->runnable =3D true;
-        set_coroutine_key(co, true);
-    }
-
-    return &co->base;
-}
-
-bool qemu_in_coroutine(void)
-{
-    CoroutineGThread *co =3D get_coroutine_key();
-
-    return co && co->base.caller;
-}
diff --git a/.travis.yml b/.travis.yml
index 9008a79..27a2d9c 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -86,9 +86,6 @@ matrix:
     - env: CONFIG=3D"--enable-trace-backends=3Dust"
            TEST_CMD=3D""
       compiler: gcc
-    - env: CONFIG=3D"--with-coroutine=3Dgthread"
-           TEST_CMD=3D""
-      compiler: gcc
     - env: CONFIG=3D""
       os: osx
       compiler: clang
@@ -191,7 +188,7 @@ matrix:
       compiler: none
       env:
         - COMPILER_NAME=3Dgcc CXX=3Dg++-5 CC=3Dgcc-5
-        - CONFIG=3D"--cc=3Dgcc-5 --cxx=3Dg++-5 --disable-pie --disable-l=
inux-user --with-coroutine=3Dgthread"
+        - CONFIG=3D"--cc=3Dgcc-5 --cxx=3Dg++-5 --disable-pie --disable-l=
inux-user"
         - TEST_CMD=3D""
       before_script:
         - ./configure ${CONFIG} --extra-cflags=3D"-g3 -O0 -fsanitize=3Dt=
hread -fuse-ld=3Dgold" || cat config.log
--=20
2.9.3
