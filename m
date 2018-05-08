Received: from eggs.gnu.org ([2001:4830:134:3::10]:41574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAtF-0003Fv-3B
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAtC-0001Z7-NA
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:21 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:52628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fGAtC-0001YV-BM
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:18 -0400
Received: by mail-wm0-x235.google.com with SMTP id w194so21163870wmf.2
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 15:15:18 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 May 2018 00:14:40 +0200
Message-Id: <1525817687-34620-24-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 23/30] glib: bump min required glib library
 version to 2.42
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Daniel P. Berrangé <berrange@redhat.com>

Per supported platforms doc, the various min glib on relevant distros is:

  RHEL-7: 2.50.3
  Debian (Stretch): 2.50.3
  Debian (Jessie): 2.42.1
  OpenBSD (Ports): 2.54.3
  FreeBSD (Ports): 2.50.3
  OpenSUSE Leap 15: 2.54.3
  Ubuntu (Xenial): 2.48.0
  macOS (Homebrew): 2.56.0

This suggests that a minimum glib of 2.42 is a reasonable target

Signed-off-by: Daniel P. BerrangÃ© <berrange@redhat.com>
Message-Id: <20180504160026.14017-3-berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 configure                                |   6 +-
 docs/devel/testing.rst                   |   4 +-
 include/glib-compat.h                    | 319 -------------------------------
 tests/docker/dockerfiles/centos6.docker  |  30 ---
 tests/docker/dockerfiles/min-glib.docker |   8 -
 tests/test-qmp-event.c                   |   2 +-
 tests/tpm-emu.h                          |   4 +-
 tests/vhost-user-test.c                  |   4 +-
 trace/simple.c                           |   6 +-
 9 files changed, 11 insertions(+), 372 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/centos6.docker
 delete mode 100644 tests/docker/dockerfiles/min-glib.docker

diff --git a/configure b/configure
index 83a6080..3ff4d77 100755
--- a/configure
+++ b/configure
@@ -3394,11 +3394,7 @@ fi
 ##########################################
 # glib support probe
 
-if test "$mingw32" = yes; then
-    glib_req_ver=2.30
-else
-    glib_req_ver=2.22
-fi
+glib_req_ver=2.42
 glib_modules=gthread-2.0
 if test "$modules" = yes; then
     glib_modules="$glib_modules gmodule-export-2.0"
diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 0ca1a2d..f7b7552 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -297,9 +297,9 @@ the container, with parameters defined by the make target):
 
 .. code::
 
-  make docker-test-build@min-glib
+  make docker-test-build@centos7
 
-This will create a container instance using the ``min-glib`` image (the image
+This will create a container instance using the ``centos7`` image (the image
 is downloaded and initialized automatically), in which the ``test-build`` job
 is executed.
 
diff --git a/include/glib-compat.h b/include/glib-compat.h
index c49cf87..3b340ab 100644
--- a/include/glib-compat.h
+++ b/include/glib-compat.h
@@ -18,27 +18,6 @@
 
 #include <glib.h>
 
-/* GLIB version compatibility flags */
-#if !GLIB_CHECK_VERSION(2, 26, 0)
-#define G_TIME_SPAN_SECOND              (G_GINT64_CONSTANT(1000000))
-#endif
-
-#if !GLIB_CHECK_VERSION(2, 28, 0)
-static inline gint64 qemu_g_get_monotonic_time(void)
-{
-    /* g_get_monotonic_time() is best-effort so we can use the wall clock as a
-     * fallback.
-     */
-
-    GTimeVal time;
-    g_get_current_time(&time);
-
-    return time.tv_sec * G_TIME_SPAN_SECOND + time.tv_usec;
-}
-/* work around distro backports of this interface */
-#define g_get_monotonic_time() qemu_g_get_monotonic_time()
-#endif
-
 #if defined(_WIN32) && !GLIB_CHECK_VERSION(2, 50, 0)
 /*
  * g_poll has a problem on Windows when using
@@ -48,228 +27,6 @@ static inline gint64 qemu_g_get_monotonic_time(void)
 gint g_poll_fixed(GPollFD *fds, guint nfds, gint timeout);
 #endif
 
-#if !GLIB_CHECK_VERSION(2, 30, 0)
-/* Not a 100% compatible implementation, but good enough for most
- * cases. Placeholders are only supported at the end of the
- * template. */
-static inline gchar *qemu_g_dir_make_tmp(gchar const *tmpl, GError **error)
-{
-    gchar *path = g_build_filename(g_get_tmp_dir(), tmpl ?: ".XXXXXX", NULL);
-
-    if (mkdtemp(path) != NULL) {
-        return path;
-    }
-    /* Error occurred, clean up. */
-    g_set_error(error, G_FILE_ERROR, g_file_error_from_errno(errno),
-                "mkdtemp() failed");
-    g_free(path);
-    return NULL;
-}
-#define g_dir_make_tmp(tmpl, error) qemu_g_dir_make_tmp(tmpl, error)
-#endif /* glib 2.30 */
-
-#if !GLIB_CHECK_VERSION(2, 31, 0)
-/* before glib-2.31, GMutex and GCond was dynamic-only (there was a separate
- * GStaticMutex, but it didn't work with condition variables).
- *
- * Our implementation uses GOnce to fake a static implementation that does
- * not require separate initialization.
- * We need to rename the types to avoid passing our CompatGMutex/CompatGCond
- * by mistake to a function that expects GMutex/GCond.  However, for ease
- * of use we keep the GLib function names.  GLib uses macros for the
- * implementation, we use inline functions instead and undefine the macros.
- */
-
-typedef struct CompatGMutex {
-    GOnce once;
-} CompatGMutex;
-
-typedef struct CompatGCond {
-    GOnce once;
-} CompatGCond;
-
-static inline gpointer do_g_mutex_new(gpointer unused)
-{
-    return (gpointer) g_mutex_new();
-}
-
-static inline void g_mutex_init(CompatGMutex *mutex)
-{
-    mutex->once = (GOnce) G_ONCE_INIT;
-}
-
-static inline void g_mutex_clear(CompatGMutex *mutex)
-{
-    g_assert(mutex->once.status != G_ONCE_STATUS_PROGRESS);
-    if (mutex->once.retval) {
-        g_mutex_free((GMutex *) mutex->once.retval);
-    }
-    mutex->once = (GOnce) G_ONCE_INIT;
-}
-
-static inline void (g_mutex_lock)(CompatGMutex *mutex)
-{
-    g_once(&mutex->once, do_g_mutex_new, NULL);
-    g_mutex_lock((GMutex *) mutex->once.retval);
-}
-#undef g_mutex_lock
-
-static inline gboolean (g_mutex_trylock)(CompatGMutex *mutex)
-{
-    g_once(&mutex->once, do_g_mutex_new, NULL);
-    return g_mutex_trylock((GMutex *) mutex->once.retval);
-}
-#undef g_mutex_trylock
-
-
-static inline void (g_mutex_unlock)(CompatGMutex *mutex)
-{
-    g_mutex_unlock((GMutex *) mutex->once.retval);
-}
-#undef g_mutex_unlock
-
-static inline gpointer do_g_cond_new(gpointer unused)
-{
-    return (gpointer) g_cond_new();
-}
-
-static inline void g_cond_init(CompatGCond *cond)
-{
-    cond->once = (GOnce) G_ONCE_INIT;
-}
-
-static inline void g_cond_clear(CompatGCond *cond)
-{
-    g_assert(cond->once.status != G_ONCE_STATUS_PROGRESS);
-    if (cond->once.retval) {
-        g_cond_free((GCond *) cond->once.retval);
-    }
-    cond->once = (GOnce) G_ONCE_INIT;
-}
-
-static inline void (g_cond_wait)(CompatGCond *cond, CompatGMutex *mutex)
-{
-    g_assert(mutex->once.status != G_ONCE_STATUS_PROGRESS);
-    g_once(&cond->once, do_g_cond_new, NULL);
-    g_cond_wait((GCond *) cond->once.retval, (GMutex *) mutex->once.retval);
-}
-#undef g_cond_wait
-
-static inline void (g_cond_broadcast)(CompatGCond *cond)
-{
-    g_once(&cond->once, do_g_cond_new, NULL);
-    g_cond_broadcast((GCond *) cond->once.retval);
-}
-#undef g_cond_broadcast
-
-static inline void (g_cond_signal)(CompatGCond *cond)
-{
-    g_once(&cond->once, do_g_cond_new, NULL);
-    g_cond_signal((GCond *) cond->once.retval);
-}
-#undef g_cond_signal
-
-static inline gboolean (g_cond_timed_wait)(CompatGCond *cond,
-                                           CompatGMutex *mutex,
-                                           GTimeVal *time)
-{
-    g_assert(mutex->once.status != G_ONCE_STATUS_PROGRESS);
-    g_once(&cond->once, do_g_cond_new, NULL);
-    return g_cond_timed_wait((GCond *) cond->once.retval,
-                             (GMutex *) mutex->once.retval, time);
-}
-#undef g_cond_timed_wait
-
-/* This is not a macro, because it didn't exist until 2.32.  */
-static inline gboolean g_cond_wait_until(CompatGCond *cond, CompatGMutex *mutex,
-                                         gint64 end_time)
-{
-    GTimeVal time;
-
-    /* Convert from monotonic to CLOCK_REALTIME.  */
-    end_time -= g_get_monotonic_time();
-    g_get_current_time(&time);
-    end_time += time.tv_sec * G_TIME_SPAN_SECOND + time.tv_usec;
-
-    time.tv_sec = end_time / G_TIME_SPAN_SECOND;
-    time.tv_usec = end_time % G_TIME_SPAN_SECOND;
-    return g_cond_timed_wait(cond, mutex, &time);
-}
-
-/* before 2.31 there was no g_thread_new() */
-static inline GThread *g_thread_new(const char *name,
-                                    GThreadFunc func, gpointer data)
-{
-    GThread *thread = g_thread_create(func, data, TRUE, NULL);
-    if (!thread) {
-        g_error("creating thread");
-    }
-    return thread;
-}
-#else
-#define CompatGMutex GMutex
-#define CompatGCond GCond
-#endif /* glib 2.31 */
-
-#if !GLIB_CHECK_VERSION(2, 32, 0)
-/* Beware, function returns gboolean since 2.39.2, see GLib commit 9101915 */
-static inline void g_hash_table_add(GHashTable *hash_table, gpointer key)
-{
-    g_hash_table_replace(hash_table, key, key);
-}
-
-static inline gboolean g_hash_table_contains(GHashTable *hash_table,
-                                             gpointer key)
-{
-    return g_hash_table_lookup_extended(hash_table, key, NULL, NULL);
-}
-#define G_SOURCE_CONTINUE TRUE
-#define G_SOURCE_REMOVE FALSE
-#endif
-
-#ifndef g_assert_true
-#define g_assert_true(expr)                                                    \
-    do {                                                                       \
-        if (G_LIKELY(expr)) {                                                  \
-        } else {                                                               \
-            g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC,   \
-                                "'" #expr "' should be TRUE");                 \
-        }                                                                      \
-    } while (0)
-#endif
-
-#ifndef g_assert_false
-#define g_assert_false(expr)                                                   \
-    do {                                                                       \
-        if (G_LIKELY(!(expr))) {                                               \
-        } else {                                                               \
-            g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC,   \
-                                "'" #expr "' should be FALSE");                \
-        }                                                                      \
-    } while (0)
-#endif
-
-#ifndef g_assert_null
-#define g_assert_null(expr)                                                    \
-    do {                                                                       \
-        if (G_LIKELY((expr) == NULL)) {                                        \
-        } else {                                                               \
-            g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC,   \
-                                "'" #expr "' should be NULL");                 \
-        }                                                                      \
-    } while (0)
-#endif
-
-#ifndef g_assert_nonnull
-#define g_assert_nonnull(expr)                                                 \
-    do {                                                                       \
-        if (G_LIKELY((expr) != NULL)) {                                        \
-        } else {                                                               \
-            g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC,   \
-                                "'" #expr "' should not be NULL");             \
-        }                                                                      \
-    } while (0)
-#endif
 
 #ifndef g_assert_cmpmem
 #define g_assert_cmpmem(m1, l1, m2, l2)                                        \
@@ -288,80 +45,4 @@ static inline gboolean g_hash_table_contains(GHashTable *hash_table,
     } while (0)
 #endif
 
-#if !GLIB_CHECK_VERSION(2, 28, 0)
-static inline void g_list_free_full(GList *list, GDestroyNotify free_func)
-{
-    GList *l;
-
-    for (l = list; l; l = l->next) {
-        free_func(l->data);
-    }
-
-    g_list_free(list);
-}
-
-static inline void g_slist_free_full(GSList *list, GDestroyNotify free_func)
-{
-    GSList *l;
-
-    for (l = list; l; l = l->next) {
-        free_func(l->data);
-    }
-
-    g_slist_free(list);
-}
-#endif
-
-#if !GLIB_CHECK_VERSION(2, 26, 0)
-static inline void g_source_set_name(GSource *source, const char *name)
-{
-    /* This is just a debugging aid, so leaving it a no-op */
-}
-static inline void g_source_set_name_by_id(guint tag, const char *name)
-{
-    /* This is just a debugging aid, so leaving it a no-op */
-}
-#endif
-
-#if !GLIB_CHECK_VERSION(2, 36, 0)
-/* Always fail.  This will not include error_report output in the test log,
- * sending it instead to stderr.
- */
-#define g_test_initialized() (0)
-#endif
-#if !GLIB_CHECK_VERSION(2, 38, 0)
-#ifdef CONFIG_HAS_GLIB_SUBPROCESS_TESTS
-#error schizophrenic detection of glib subprocess testing
-#endif
-#define g_test_subprocess() (0)
-#endif
-
-
-#if !GLIB_CHECK_VERSION(2, 34, 0)
-static inline void
-g_test_add_data_func_full(const char *path,
-                          gpointer data,
-                          gpointer fn,
-                          gpointer data_free_func)
-{
-#if GLIB_CHECK_VERSION(2, 26, 0)
-    /* back-compat casts, remove this once we can require new-enough glib */
-    g_test_add_vtable(path, 0, data, NULL,
-                      (GTestFixtureFunc)fn, (GTestFixtureFunc) data_free_func);
-#else
-    /* back-compat casts, remove this once we can require new-enough glib */
-    g_test_add_vtable(path, 0, data, NULL,
-                      (void (*)(void)) fn, (void (*)(void)) data_free_func);
-#endif
-}
-#endif
-
-/* Small compat shim from glib 2.32 */
-#ifndef G_SOURCE_CONTINUE
-#define G_SOURCE_CONTINUE TRUE
-#endif
-#ifndef G_SOURCE_REMOVE
-#define G_SOURCE_REMOVE FALSE
-#endif
-
 #endif
diff --git a/tests/docker/dockerfiles/centos6.docker b/tests/docker/dockerfiles/centos6.docker
deleted file mode 100644
index ad24319..0000000
--- a/tests/docker/dockerfiles/centos6.docker
+++ /dev/null
@@ -1,30 +0,0 @@
-FROM centos:6
-RUN yum install -y epel-release centos-release-xen
-ENV PACKAGES \
-    bison \
-    bzip2-devel \
-    ccache \
-    csnappy-devel \
-    flex \
-    g++ \
-    gcc \
-    gettext \
-    git \
-    glib2-devel \
-    libepoxy-devel \
-    libfdt-devel \
-    librdmacm-devel \
-    lzo-devel \
-    make \
-    mesa-libEGL-devel \
-    mesa-libgbm-devel \
-    pixman-devel \
-    SDL-devel \
-    spice-glib-devel \
-    spice-server-devel \
-    tar \
-    vte-devel \
-    xen-devel \
-    zlib-devel
-RUN yum install -y $PACKAGES
-RUN rpm -q $PACKAGES | sort > /packages.txt
diff --git a/tests/docker/dockerfiles/min-glib.docker b/tests/docker/dockerfiles/min-glib.docker
deleted file mode 100644
index f2eed97..0000000
--- a/tests/docker/dockerfiles/min-glib.docker
+++ /dev/null
@@ -1,8 +0,0 @@
-FROM centos:6
-RUN yum install -y \
-    tar gettext git make gcc g++ \
-    zlib-devel SDL-devel pixman-devel \
-    epel-release
-RUN yum install -y libfdt-devel ccache
-RUN yum downgrade -y http://vault.centos.org/6.0/os/x86_64/Packages/glib2-2.22.5-5.el6.x86_64.rpm
-RUN yum install -y http://vault.centos.org/6.0/os/x86_64/Packages/glib2-devel-2.22.5-5.el6.x86_64.rpm
diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index 3a7c227..78a2942 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -32,7 +32,7 @@ typedef struct QDictCmpData {
 } QDictCmpData;
 
 TestEventData *test_event_data;
-static CompatGMutex test_event_lock;
+static GMutex test_event_lock;
 
 /* Only compares bool, int, string */
 static
diff --git a/tests/tpm-emu.h b/tests/tpm-emu.h
index ef4bfa8..08f9024 100644
--- a/tests/tpm-emu.h
+++ b/tests/tpm-emu.h
@@ -24,8 +24,8 @@ struct tpm_hdr {
 } QEMU_PACKED;
 
 typedef struct TestState {
-    CompatGMutex data_mutex;
-    CompatGCond data_cond;
+    GMutex data_mutex;
+    GCond data_cond;
     SocketAddress *addr;
     QIOChannel *tpm_ioc;
     GThread *emu_tpm_thread;
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index bbc8091..9f680f5 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -150,8 +150,8 @@ typedef struct TestServer {
     int fds_num;
     int fds[VHOST_MEMORY_MAX_NREGIONS];
     VhostUserMemory memory;
-    CompatGMutex data_mutex;
-    CompatGCond data_cond;
+    GMutex data_mutex;
+    GCond data_cond;
     int log_fd;
     uint64_t rings;
     bool test_fail;
diff --git a/trace/simple.c b/trace/simple.c
index e82018d..701dec6 100644
--- a/trace/simple.c
+++ b/trace/simple.c
@@ -36,9 +36,9 @@
  * Trace records are written out by a dedicated thread.  The thread waits for
  * records to become available, writes them out, and then waits again.
  */
-static CompatGMutex trace_lock;
-static CompatGCond trace_available_cond;
-static CompatGCond trace_empty_cond;
+static GMutex trace_lock;
+static GCond trace_available_cond;
+static GCond trace_empty_cond;
 
 static bool trace_available;
 static bool trace_writeout_enabled;
-- 
1.8.3.1
