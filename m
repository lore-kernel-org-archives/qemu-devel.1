Received: from eggs.gnu.org ([2001:4830:134:3::10]:40676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d44xI-0003Vg-SB
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:25:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d44xF-0004oG-TP
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:25:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d44xF-0004nl-Jo
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:24:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 98D047F4A7
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 12:24:56 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 28 Apr 2017 13:24:44 +0100
Message-Id: <20170428122444.23361-2-berrange@redhat.com>
In-Reply-To: <20170428122444.23361-1-berrange@redhat.com>
References: <20170428122444.23361-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] coroutine: remove GThread implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The GThread implementation is not functional enough to actually
run QEMU reliably. While it was potentially useful for debugging,
we have a scripts/qemugdb/coroutine.py to enable tracing of
ucontext coroutines in GDB, so that removes the only reason for
GThread to exist.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 .travis.yml              |   5 +-
 configure                |  19 ++---
 util/coroutine-gthread.c | 198 -----------------------------------------------
 3 files changed, 6 insertions(+), 216 deletions(-)
 delete mode 100644 util/coroutine-gthread.c

diff --git a/.travis.yml b/.travis.yml
index 9008a79..27a2d9c 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -86,9 +86,6 @@ matrix:
     - env: CONFIG="--enable-trace-backends=ust"
            TEST_CMD=""
       compiler: gcc
-    - env: CONFIG="--with-coroutine=gthread"
-           TEST_CMD=""
-      compiler: gcc
     - env: CONFIG=""
       os: osx
       compiler: clang
@@ -191,7 +188,7 @@ matrix:
       compiler: none
       env:
         - COMPILER_NAME=gcc CXX=g++-5 CC=gcc-5
-        - CONFIG="--cc=gcc-5 --cxx=g++-5 --disable-pie --disable-linux-user --with-coroutine=gthread"
+        - CONFIG="--cc=gcc-5 --cxx=g++-5 --disable-pie --disable-linux-user"
         - TEST_CMD=""
       before_script:
         - ./configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread -fuse-ld=gold" || cat config.log
diff --git a/configure b/configure
index c35acf1..9da5c34 100755
--- a/configure
+++ b/configure
@@ -1334,7 +1334,7 @@ Advanced options (experts only):
   --oss-lib                path to OSS library
   --cpu=CPU                Build for host CPU [$cpu]
   --with-coroutine=BACKEND coroutine backend. Supported options:
-                           gthread, ucontext, sigaltstack, windows
+                           ucontext, sigaltstack, windows
   --enable-gcov            enable test coverage analysis with gcov
   --gcov=GCOV              use specified gcov [$gcov_tool]
   --disable-blobs          disable installing provided firmware blobs
@@ -4418,10 +4418,8 @@ fi
 # check and set a backend for coroutine
 
 # We prefer ucontext, but it's not always possible. The fallback
-# is sigcontext. gthread is not selectable except explicitly, because
-# it is not functional enough to run QEMU proper. (It is occasionally
-# useful for debugging purposes.)  On Windows the only valid backend
-# is the Windows-specific one.
+# is sigcontext. On Windows the only valid backend is the Windows
+# specific one.
 
 ucontext_works=no
 if test "$darwin" != "yes"; then
@@ -4460,7 +4458,7 @@ else
       feature_not_found "ucontext"
     fi
     ;;
-  gthread|sigaltstack)
+  sigaltstack)
     if test "$mingw32" = "yes"; then
       error_exit "only the 'windows' coroutine backend is valid for Windows"
     fi
@@ -4472,14 +4470,7 @@ else
 fi
 
 if test "$coroutine_pool" = ""; then
-  if test "$coroutine" = "gthread"; then
-    coroutine_pool=no
-  else
-    coroutine_pool=yes
-  fi
-fi
-if test "$coroutine" = "gthread" -a "$coroutine_pool" = "yes"; then
-  error_exit "'gthread' coroutine backend does not support pool (use --disable-coroutine-pool)"
+  coroutine_pool=yes
 fi
 
 if test "$debug_stack_usage" = "yes"; then
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
- * Copyright (C) 2011  Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
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
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
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
-    CoroutineGThread *co = data;
-    if (co && co->free_on_thread_exit) {
-        g_free(co);
-    }
-}
-
-static GPrivate coroutine_key = G_PRIVATE_INIT(coroutine_destroy_notify);
-
-static inline CoroutineGThread *get_coroutine_key(void)
-{
-    return g_private_get(&coroutine_key);
-}
-
-static inline void set_coroutine_key(CoroutineGThread *co,
-                                     bool free_on_thread_exit)
-{
-    /* Unlike g_static_private_set() this does not call the GDestroyNotify
-     * if the previous value of the key was NULL. Fortunately we only need
-     * the GDestroyNotify in the non-NULL key case.
-     */
-    co->free_on_thread_exit = free_on_thread_exit;
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
-static GStaticPrivate coroutine_key = G_STATIC_PRIVATE_INIT;
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
-                         free_on_thread_exit ? (GDestroyNotify)g_free : NULL);
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
-    CoroutineGThread *co = opaque;
-
-    set_coroutine_key(co, false);
-    coroutine_wait_runnable(co);
-    co->base.entry(co->base.entry_arg);
-    qemu_coroutine_switch(&co->base, co->base.caller, COROUTINE_TERMINATE);
-    return NULL;
-}
-
-Coroutine *qemu_coroutine_new(void)
-{
-    CoroutineGThread *co;
-
-    co = g_malloc0(sizeof(*co));
-    co->thread = create_thread(coroutine_thread, co);
-    if (!co->thread) {
-        g_free(co);
-        return NULL;
-    }
-    return &co->base;
-}
-
-void qemu_coroutine_delete(Coroutine *co_)
-{
-    CoroutineGThread *co = DO_UPCAST(CoroutineGThread, base, co_);
-
-    g_thread_join(co->thread);
-    g_free(co);
-}
-
-CoroutineAction qemu_coroutine_switch(Coroutine *from_,
-                                      Coroutine *to_,
-                                      CoroutineAction action)
-{
-    CoroutineGThread *from = DO_UPCAST(CoroutineGThread, base, from_);
-    CoroutineGThread *to = DO_UPCAST(CoroutineGThread, base, to_);
-
-    g_mutex_lock(&coroutine_lock);
-    from->runnable = false;
-    from->action = action;
-    to->runnable = true;
-    to->action = action;
-    g_cond_broadcast(&coroutine_cond);
-
-    if (action != COROUTINE_TERMINATE) {
-        coroutine_wait_runnable_locked(from);
-    }
-    g_mutex_unlock(&coroutine_lock);
-    return from->action;
-}
-
-Coroutine *qemu_coroutine_self(void)
-{
-    CoroutineGThread *co = get_coroutine_key();
-    if (!co) {
-        co = g_malloc0(sizeof(*co));
-        co->runnable = true;
-        set_coroutine_key(co, true);
-    }
-
-    return &co->base;
-}
-
-bool qemu_in_coroutine(void)
-{
-    CoroutineGThread *co = get_coroutine_key();
-
-    return co && co->base.caller;
-}
-- 
2.9.3
