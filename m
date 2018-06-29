Received: from eggs.gnu.org ([2001:4830:134:3::10]:39001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYrWw-0007dg-1A
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:25:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYrWt-00015B-1G
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:25:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59264 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fYrWs-00013q-RU
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:25:30 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 29 Jun 2018 12:25:19 +0100
Message-Id: <20180629112520.31358-3-berrange@redhat.com>
In-Reply-To: <20180629112520.31358-1-berrange@redhat.com>
References: <20180629112520.31358-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/3] glib: bump min required glib library
 version to 2.40
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Olaf Hering <olaf@aepfle.de>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>

Per supported platforms doc[1], the various min glib on relevant distros =
is:

  RHEL-7: 2.50.3
  Debian (Stretch): 2.50.3
  Debian (Jessie): 2.42.1
  OpenBSD (Ports): 2.54.3
  FreeBSD (Ports): 2.50.3
  OpenSUSE Leap 15: 2.54.3
  SLE12-SP2: 2.48.2
  Ubuntu (Xenial): 2.48.0
  macOS (Homebrew): 2.56.0

This suggests that a minimum glib of 2.42 is a reasonable target.

The GLibC compile farm, however, uses Ubuntu 14.04 (Trusty) which only
has glib 2.40.0, and this is needed for testing during merge. Thus an
exception is made to the documented platform support policy to allow for
all three current LTS releases to be supported.

Docker jobs that not longer satisfy this new min version are removed.

[1] https://qemu.weilnetz.de/doc/qemu-doc.html#Supported-build-platforms

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 configure                                |   6 +-
 crypto/hash-glib.c                       |   4 -
 crypto/hmac-glib.c                       |  36 ---
 include/glib-compat.h                    | 319 -----------------------
 qga/commands.c                           |  11 +-
 tests/docker/dockerfiles/centos6.docker  |  30 ---
 tests/docker/dockerfiles/min-glib.docker |   8 -
 tests/ivshmem-test.c                     |   6 -
 tests/test-qmp-event.c                   |   8 +-
 tests/tpm-emu.h                          |   4 +-
 tests/vhost-user-test.c                  |  26 +-
 trace/simple.c                           |   6 +-
 util/osdep.c                             |  14 -
 13 files changed, 11 insertions(+), 467 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/centos6.docker
 delete mode 100644 tests/docker/dockerfiles/min-glib.docker

diff --git a/configure b/configure
index 4d12cfbe3f..109ed030fd 100755
--- a/configure
+++ b/configure
@@ -3433,11 +3433,7 @@ fi
 ##########################################
 # glib support probe
=20
-if test "$mingw32" =3D yes; then
-    glib_req_ver=3D2.30
-else
-    glib_req_ver=3D2.22
-fi
+glib_req_ver=3D2.40
 glib_modules=3Dgthread-2.0
 if test "$modules" =3D yes; then
     glib_modules=3D"$glib_modules gmodule-export-2.0"
diff --git a/crypto/hash-glib.c b/crypto/hash-glib.c
index a5871cc72f..a0096c7c47 100644
--- a/crypto/hash-glib.c
+++ b/crypto/hash-glib.c
@@ -30,11 +30,7 @@ static int qcrypto_hash_alg_map[QCRYPTO_HASH_ALG__MAX]=
 =3D {
     [QCRYPTO_HASH_ALG_SHA224] =3D -1,
     [QCRYPTO_HASH_ALG_SHA256] =3D G_CHECKSUM_SHA256,
     [QCRYPTO_HASH_ALG_SHA384] =3D -1,
-#if GLIB_CHECK_VERSION(2, 36, 0)
     [QCRYPTO_HASH_ALG_SHA512] =3D G_CHECKSUM_SHA512,
-#else
-    [QCRYPTO_HASH_ALG_SHA512] =3D -1,
-#endif
     [QCRYPTO_HASH_ALG_RIPEMD160] =3D -1,
 };
=20
diff --git a/crypto/hmac-glib.c b/crypto/hmac-glib.c
index a6c1730291..7df627329d 100644
--- a/crypto/hmac-glib.c
+++ b/crypto/hmac-glib.c
@@ -17,9 +17,6 @@
 #include "crypto/hmac.h"
 #include "hmacpriv.h"
=20
-/* Support for HMAC Algos has been added in GLib 2.30 */
-#if GLIB_CHECK_VERSION(2, 30, 0)
-
 static int qcrypto_hmac_alg_map[QCRYPTO_HASH_ALG__MAX] =3D {
     [QCRYPTO_HASH_ALG_MD5] =3D G_CHECKSUM_MD5,
     [QCRYPTO_HASH_ALG_SHA1] =3D G_CHECKSUM_SHA1,
@@ -126,39 +123,6 @@ qcrypto_glib_hmac_bytesv(QCryptoHmac *hmac,
     return 0;
 }
=20
-#else
-
-bool qcrypto_hmac_supports(QCryptoHashAlgorithm alg)
-{
-    return false;
-}
-
-void *qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
-                           const uint8_t *key, size_t nkey,
-                           Error **errp)
-{
-    return NULL;
-}
-
-static void
-qcrypto_glib_hmac_ctx_free(QCryptoHmac *hmac)
-{
-    return;
-}
-
-static int
-qcrypto_glib_hmac_bytesv(QCryptoHmac *hmac,
-                         const struct iovec *iov,
-                         size_t niov,
-                         uint8_t **result,
-                         size_t *resultlen,
-                         Error **errp)
-{
-    return -1;
-}
-
-#endif
-
 QCryptoHmacDriver qcrypto_hmac_lib_driver =3D {
     .hmac_bytesv =3D qcrypto_glib_hmac_bytesv,
     .hmac_free =3D qcrypto_glib_hmac_ctx_free,
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
diff --git a/qga/commands.c b/qga/commands.c
index cce3010f0f..0c7d1385c2 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -414,10 +414,8 @@ GuestExec *qmp_guest_exec(const char *path,
     argv =3D guest_exec_get_args(&arglist, true);
     envp =3D has_env ? guest_exec_get_args(env, false) : NULL;
=20
-    flags =3D G_SPAWN_SEARCH_PATH | G_SPAWN_DO_NOT_REAP_CHILD;
-#if GLIB_CHECK_VERSION(2, 33, 2)
-    flags |=3D G_SPAWN_SEARCH_PATH_FROM_ENVP;
-#endif
+    flags =3D G_SPAWN_SEARCH_PATH | G_SPAWN_DO_NOT_REAP_CHILD |
+        G_SPAWN_SEARCH_PATH_FROM_ENVP;
     if (!has_output) {
         flags |=3D G_SPAWN_STDOUT_TO_DEV_NULL | G_SPAWN_STDERR_TO_DEV_NU=
LL;
     }
@@ -514,7 +512,6 @@ GuestHostName *qmp_guest_get_host_name(Error **err)
=20
 GuestTimezone *qmp_guest_get_timezone(Error **errp)
 {
-#if GLIB_CHECK_VERSION(2, 28, 0)
     GuestTimezone *info =3D NULL;
     GTimeZone *tz =3D NULL;
     gint64 now =3D 0;
@@ -544,8 +541,4 @@ GuestTimezone *qmp_guest_get_timezone(Error **errp)
 error:
     g_free(info);
     return NULL;
-#else
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-#endif
 }
diff --git a/tests/docker/dockerfiles/centos6.docker b/tests/docker/docke=
rfiles/centos6.docker
deleted file mode 100644
index ad24319582..0000000000
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
diff --git a/tests/docker/dockerfiles/min-glib.docker b/tests/docker/dock=
erfiles/min-glib.docker
deleted file mode 100644
index f2eed97d35..0000000000
--- a/tests/docker/dockerfiles/min-glib.docker
+++ /dev/null
@@ -1,8 +0,0 @@
-FROM centos:6
-RUN yum install -y \
-    tar gettext git make gcc g++ \
-    zlib-devel SDL-devel pixman-devel \
-    epel-release
-RUN yum install -y libfdt-devel ccache
-RUN yum downgrade -y http://vault.centos.org/6.0/os/x86_64/Packages/glib=
2-2.22.5-5.el6.x86_64.rpm
-RUN yum install -y http://vault.centos.org/6.0/os/x86_64/Packages/glib2-=
devel-2.22.5-5.el6.x86_64.rpm
diff --git a/tests/ivshmem-test.c b/tests/ivshmem-test.c
index 8af16ee79a..9b407a3e42 100644
--- a/tests/ivshmem-test.c
+++ b/tests/ivshmem-test.c
@@ -504,12 +504,6 @@ int main(int argc, char **argv)
     const char *arch =3D qtest_get_arch();
     gchar dir[] =3D "/tmp/ivshmem-test.XXXXXX";
=20
-#if !GLIB_CHECK_VERSION(2, 31, 0)
-    if (!g_thread_supported()) {
-        g_thread_init(NULL);
-    }
-#endif
-
     g_test_init(&argc, &argv, NULL);
=20
     qtest_add_abrt_handler(abrt_handler, NULL);
diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index 3a7c227a1d..8677094ad1 100644
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
@@ -242,12 +242,6 @@ static void test_event_d(TestEventData *data,
=20
 int main(int argc, char **argv)
 {
-#if !GLIB_CHECK_VERSION(2, 31, 0)
-    if (!g_thread_supported()) {
-       g_thread_init(NULL);
-    }
-#endif
-
     qmp_event_set_func_emit(event_test_emit);
=20
     g_test_init(&argc, &argv, NULL);
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
index bbc8091286..8ff2106d32 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -32,14 +32,6 @@
 #include <linux/virtio_net.h>
 #include <sys/vfs.h>
=20
-/* GLIB version compatibility flags */
-#if !GLIB_CHECK_VERSION(2, 26, 0)
-#define G_TIME_SPAN_SECOND              (G_GINT64_CONSTANT(1000000))
-#endif
-
-#if GLIB_CHECK_VERSION(2, 28, 0)
-#define HAVE_MONOTONIC_TIME
-#endif
=20
 #define QEMU_CMD_MEM    " -m %d -object memory-backend-file,id=3Dmem,siz=
e=3D%dM," \
                         "mem-path=3D%s,share=3Don -numa node,memdev=3Dme=
m"
@@ -150,8 +142,8 @@ typedef struct TestServer {
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
@@ -642,21 +634,7 @@ test_migrate_source_check(GSource *source)
     return FALSE;
 }
=20
-#if !GLIB_CHECK_VERSION(2,36,0)
-/* this callback is unnecessary with glib >2.36, the default
- * prepare for the source does the same */
-static gboolean
-test_migrate_source_prepare(GSource *source, gint *timeout)
-{
-    *timeout =3D -1;
-    return FALSE;
-}
-#endif
-
 GSourceFuncs test_migrate_source_funcs =3D {
-#if !GLIB_CHECK_VERSION(2,36,0)
-    .prepare =3D test_migrate_source_prepare,
-#endif
     .check =3D test_migrate_source_check,
 };
=20
diff --git a/trace/simple.c b/trace/simple.c
index e82018d923..701dec639c 100644
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
+static GMutex trace_lock;
+static GCond trace_available_cond;
+static GCond trace_empty_cond;
=20
 static bool trace_available;
 static bool trace_writeout_enabled;
diff --git a/util/osdep.c b/util/osdep.c
index ea51d500b6..1c8d1e2ee0 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -504,20 +504,6 @@ int socket_init(void)
     return 0;
 }
=20
-#if !GLIB_CHECK_VERSION(2, 31, 0)
-/* Ensure that glib is running in multi-threaded mode
- * Old versions of glib require explicit initialization.  Failure to do
- * this results in the single-threaded code paths being taken inside
- * glib.  For example, the g_slice allocator will not be thread-safe
- * and cause crashes.
- */
-static void __attribute__((constructor)) thread_init(void)
-{
-    if (!g_thread_supported()) {
-       g_thread_init(NULL);
-    }
-}
-#endif
=20
 #ifndef CONFIG_IOVEC
 /* helper function for iov_send_recv() */
--=20
2.17.1
