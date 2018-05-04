Received: from eggs.gnu.org ([2001:4830:134:3::10]:55375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fEd8P-0003Wl-TC
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fEd8N-00020A-Sp
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53990 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fEd8N-0001z1-Gv
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:35 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri,  4 May 2018 17:00:25 +0100
Message-Id: <20180504160026.14017-3-berrange@redhat.com>
In-Reply-To: <20180504160026.14017-1-berrange@redhat.com>
References: <20180504160026.14017-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] glib: bump min required glib library
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Olaf Hering <olaf@aepfle.de>, Stefan Hajnoczi <stefanha@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

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

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 configure               |   6 +-
 include/glib-compat.h   | 319 ------------------------------------------=
------
 tests/test-qmp-event.c  |   2 +-
 tests/tpm-emu.h         |   4 +-
 tests/vhost-user-test.c |   4 +-
 trace/simple.c          |   6 +-
 6 files changed, 9 insertions(+), 332 deletions(-)

diff --git a/configure b/configure
index 1443422e83..e5d2f625a7 100755
--- a/configure
+++ b/configure
@@ -3392,11 +3392,7 @@ fi
 ##########################################
 # glib support probe
=20
-if test "$mingw32" =3D yes; then
-    glib_req_ver=3D2.30
-else
-    glib_req_ver=3D2.22
-fi
+glib_req_ver=3D2.42
 glib_modules=3Dgthread-2.0
 if test "$modules" =3D yes; then
     glib_modules=3D"$glib_modules gmodule-export-2.0"
diff --git a/include/glib-compat.h b/include/glib-compat.h
index c49cf87196..3b340ab33c 100644
--- a/include/glib-compat.h
+++ b/include/glib-compat.h
@@ -18,27 +18,6 @@
=20
 #include <glib.h>
=20
-/* GLIB version compatibility flags */
-#if !GLIB_CHECK_VERSION(2, 26, 0)
-#define G_TIME_SPAN_SECOND              (G_GINT64_CONSTANT(1000000))
-#endif
-
-#if !GLIB_CHECK_VERSION(2, 28, 0)
-static inline gint64 qemu_g_get_monotonic_time(void)
-{
-    /* g_get_monotonic_time() is best-effort so we can use the wall cloc=
k as a
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
=20
-#if !GLIB_CHECK_VERSION(2, 30, 0)
-/* Not a 100% compatible implementation, but good enough for most
- * cases. Placeholders are only supported at the end of the
- * template. */
-static inline gchar *qemu_g_dir_make_tmp(gchar const *tmpl, GError **err=
or)
-{
-    gchar *path =3D g_build_filename(g_get_tmp_dir(), tmpl ?: ".XXXXXX",=
 NULL);
-
-    if (mkdtemp(path) !=3D NULL) {
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
-/* before glib-2.31, GMutex and GCond was dynamic-only (there was a sepa=
rate
- * GStaticMutex, but it didn't work with condition variables).
- *
- * Our implementation uses GOnce to fake a static implementation that do=
es
- * not require separate initialization.
- * We need to rename the types to avoid passing our CompatGMutex/CompatG=
Cond
- * by mistake to a function that expects GMutex/GCond.  However, for eas=
e
- * of use we keep the GLib function names.  GLib uses macros for the
- * implementation, we use inline functions instead and undefine the macr=
os.
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
-    mutex->once =3D (GOnce) G_ONCE_INIT;
-}
-
-static inline void g_mutex_clear(CompatGMutex *mutex)
-{
-    g_assert(mutex->once.status !=3D G_ONCE_STATUS_PROGRESS);
-    if (mutex->once.retval) {
-        g_mutex_free((GMutex *) mutex->once.retval);
-    }
-    mutex->once =3D (GOnce) G_ONCE_INIT;
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
-    cond->once =3D (GOnce) G_ONCE_INIT;
-}
-
-static inline void g_cond_clear(CompatGCond *cond)
-{
-    g_assert(cond->once.status !=3D G_ONCE_STATUS_PROGRESS);
-    if (cond->once.retval) {
-        g_cond_free((GCond *) cond->once.retval);
-    }
-    cond->once =3D (GOnce) G_ONCE_INIT;
-}
-
-static inline void (g_cond_wait)(CompatGCond *cond, CompatGMutex *mutex)
-{
-    g_assert(mutex->once.status !=3D G_ONCE_STATUS_PROGRESS);
-    g_once(&cond->once, do_g_cond_new, NULL);
-    g_cond_wait((GCond *) cond->once.retval, (GMutex *) mutex->once.retv=
al);
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
-    g_assert(mutex->once.status !=3D G_ONCE_STATUS_PROGRESS);
-    g_once(&cond->once, do_g_cond_new, NULL);
-    return g_cond_timed_wait((GCond *) cond->once.retval,
-                             (GMutex *) mutex->once.retval, time);
-}
-#undef g_cond_timed_wait
-
-/* This is not a macro, because it didn't exist until 2.32.  */
-static inline gboolean g_cond_wait_until(CompatGCond *cond, CompatGMutex=
 *mutex,
-                                         gint64 end_time)
-{
-    GTimeVal time;
-
-    /* Convert from monotonic to CLOCK_REALTIME.  */
-    end_time -=3D g_get_monotonic_time();
-    g_get_current_time(&time);
-    end_time +=3D time.tv_sec * G_TIME_SPAN_SECOND + time.tv_usec;
-
-    time.tv_sec =3D end_time / G_TIME_SPAN_SECOND;
-    time.tv_usec =3D end_time % G_TIME_SPAN_SECOND;
-    return g_cond_timed_wait(cond, mutex, &time);
-}
-
-/* before 2.31 there was no g_thread_new() */
-static inline GThread *g_thread_new(const char *name,
-                                    GThreadFunc func, gpointer data)
-{
-    GThread *thread =3D g_thread_create(func, data, TRUE, NULL);
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
-/* Beware, function returns gboolean since 2.39.2, see GLib commit 91019=
15 */
-static inline void g_hash_table_add(GHashTable *hash_table, gpointer key=
)
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
-#define g_assert_true(expr)                                             =
       \
-    do {                                                                =
       \
-        if (G_LIKELY(expr)) {                                           =
       \
-        } else {                                                        =
       \
-            g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRF=
UNC,   \
-                                "'" #expr "' should be TRUE");          =
       \
-        }                                                               =
       \
-    } while (0)
-#endif
-
-#ifndef g_assert_false
-#define g_assert_false(expr)                                            =
       \
-    do {                                                                =
       \
-        if (G_LIKELY(!(expr))) {                                        =
       \
-        } else {                                                        =
       \
-            g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRF=
UNC,   \
-                                "'" #expr "' should be FALSE");         =
       \
-        }                                                               =
       \
-    } while (0)
-#endif
-
-#ifndef g_assert_null
-#define g_assert_null(expr)                                             =
       \
-    do {                                                                =
       \
-        if (G_LIKELY((expr) =3D=3D NULL)) {                             =
           \
-        } else {                                                        =
       \
-            g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRF=
UNC,   \
-                                "'" #expr "' should be NULL");          =
       \
-        }                                                               =
       \
-    } while (0)
-#endif
-
-#ifndef g_assert_nonnull
-#define g_assert_nonnull(expr)                                          =
       \
-    do {                                                                =
       \
-        if (G_LIKELY((expr) !=3D NULL)) {                               =
         \
-        } else {                                                        =
       \
-            g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRF=
UNC,   \
-                                "'" #expr "' should not be NULL");      =
       \
-        }                                                               =
       \
-    } while (0)
-#endif
=20
 #ifndef g_assert_cmpmem
 #define g_assert_cmpmem(m1, l1, m2, l2)                                 =
       \
@@ -288,80 +45,4 @@ static inline gboolean g_hash_table_contains(GHashTab=
le *hash_table,
     } while (0)
 #endif
=20
-#if !GLIB_CHECK_VERSION(2, 28, 0)
-static inline void g_list_free_full(GList *list, GDestroyNotify free_fun=
c)
-{
-    GList *l;
-
-    for (l =3D list; l; l =3D l->next) {
-        free_func(l->data);
-    }
-
-    g_list_free(list);
-}
-
-static inline void g_slist_free_full(GSList *list, GDestroyNotify free_f=
unc)
-{
-    GSList *l;
-
-    for (l =3D list; l; l =3D l->next) {
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
-/* Always fail.  This will not include error_report output in the test l=
og,
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
-    /* back-compat casts, remove this once we can require new-enough gli=
b */
-    g_test_add_vtable(path, 0, data, NULL,
-                      (GTestFixtureFunc)fn, (GTestFixtureFunc) data_free=
_func);
-#else
-    /* back-compat casts, remove this once we can require new-enough gli=
b */
-    g_test_add_vtable(path, 0, data, NULL,
-                      (void (*)(void)) fn, (void (*)(void)) data_free_fu=
nc);
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
diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index bb1036615f..963fe47ce3 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -32,7 +32,7 @@ typedef struct QDictCmpData {
 } QDictCmpData;
=20
 TestEventData *test_event_data;
-static CompatGMutex test_event_lock;
+static GMutex test_event_lock;
=20
 /* Only compares bool, int, string */
 static
diff --git a/tests/tpm-emu.h b/tests/tpm-emu.h
index ef4bfa8800..08f902485e 100644
--- a/tests/tpm-emu.h
+++ b/tests/tpm-emu.h
@@ -24,8 +24,8 @@ struct tpm_hdr {
 } QEMU_PACKED;
=20
 typedef struct TestState {
-    CompatGMutex data_mutex;
-    CompatGCond data_cond;
+    GMutex data_mutex;
+    GCond data_cond;
     SocketAddress *addr;
     QIOChannel *tpm_ioc;
     GThread *emu_tpm_thread;
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 61d997253c..b4bc38acc0 100644
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
index e82018d923..65e558126d 100644
--- a/trace/simple.c
+++ b/trace/simple.c
@@ -36,9 +36,9 @@
  * Trace records are written out by a dedicated thread.  The thread wait=
s for
  * records to become available, writes them out, and then waits again.
  */
-static CompatGMutex trace_lock;
-static CompatGCond trace_available_cond;
-static CompatGCond trace_empty_cond;
+static GMuttex trace_lock;
+static GCond trace_available_cond;
+static GCond trace_empty_cond;
=20
 static bool trace_available;
 static bool trace_writeout_enabled;
--=20
2.14.3
