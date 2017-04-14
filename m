Received: from eggs.gnu.org ([2001:4830:134:3::10]:57089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cz3jX-0006jl-00
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 12:06:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cz3jS-00035H-7p
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 12:06:02 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cz3jS-00034k-0z
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 12:05:58 -0400
Received: by mail-qt0-x241.google.com with SMTP id t52so239469qtb.3
	for <qemu-devel@nongnu.org>; Fri, 14 Apr 2017 09:05:57 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1492175840-5021-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170414131739eucas1p1ea9a6adcdbe8cfe45ac1ff582d28d873@eucas1p1.samsung.com>
	<1492175840-5021-3-git-send-email-a.perevalov@samsung.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c38e0275-2f7e-6063-3534-daa629b0d400@amsat.org>
Date: Fri, 14 Apr 2017 13:05:52 -0300
MIME-Version: 1.0
In-Reply-To: <1492175840-5021-3-git-send-email-a.perevalov@samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/6] util: introduce glib-helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>, dgilbert@redhat.com, qemu-devel@nongnu.org
Cc: i.maximets@samsung.com

Hi Alexey,

On 04/14/2017 10:17 AM, Alexey Perevalov wrote:
> There is a lack of g_int_cmp which compares pointers value in glib,
> xen_disk.c introduced its own, so the same function now requires
> in migration.c. So logically to move it into common place.
> Futher: maybe extend glib.
>
> Also this commit moves existing glib-compat.h into util/glib
> folder for consolidation purpose.

Can you do this in two commits? First one moving files only, second move 
the function?

I'm not sure naming it "g_int_cmp()" won't clash with future _extended_ 
glib, what do you think about naming it "qemu_g_int_cmp()"?

> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> ---
>  hw/block/xen_disk.c        |  10 +-
>  include/glib-compat.h      | 352 ---------------------------------------------
>  include/glib/glib-compat.h | 352 +++++++++++++++++++++++++++++++++++++++++++++
>  include/glib/glib-helper.h |  30 ++++
>  include/qemu/osdep.h       |   2 +-
>  linux-user/main.c          |   2 +-
>  scripts/clean-includes     |   2 +-
>  util/Makefile.objs         |   1 +
>  util/glib-helper.c         |  29 ++++
>  9 files changed, 417 insertions(+), 363 deletions(-)
>  delete mode 100644 include/glib-compat.h
>  create mode 100644 include/glib/glib-compat.h
>  create mode 100644 include/glib/glib-helper.h
>  create mode 100644 util/glib-helper.c
>
> diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
> index 456a2d5..36f6396 100644
> --- a/hw/block/xen_disk.c
> +++ b/hw/block/xen_disk.c
> @@ -20,6 +20,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "glib/glib-helper.h"
>  #include <sys/ioctl.h>
>  #include <sys/uio.h>
>
> @@ -154,13 +155,6 @@ static void ioreq_reset(struct ioreq *ioreq)
>      qemu_iovec_reset(&ioreq->v);
>  }
>
> -static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
> -{
> -    uint ua = GPOINTER_TO_UINT(a);
> -    uint ub = GPOINTER_TO_UINT(b);
> -    return (ua > ub) - (ua < ub);
> -}
> -
>  static void destroy_grant(gpointer pgnt)
>  {
>      PersistentGrant *grant = pgnt;
> @@ -1191,7 +1185,7 @@ static int blk_connect(struct XenDevice *xendev)
>      if (blkdev->feature_persistent) {
>          /* Init persistent grants */
>          blkdev->max_grants = max_requests * BLKIF_MAX_SEGMENTS_PER_REQUEST;
> -        blkdev->persistent_gnts = g_tree_new_full((GCompareDataFunc)int_cmp,
> +        blkdev->persistent_gnts = g_tree_new_full((GCompareDataFunc)g_int_cmp,
>                                               NULL, NULL,
>                                               batch_maps ?
>                                               (GDestroyNotify)g_free :
> diff --git a/include/glib-compat.h b/include/glib-compat.h
> deleted file mode 100644
> index 863c8cf..0000000
> --- a/include/glib-compat.h
> +++ /dev/null
> @@ -1,352 +0,0 @@
> -/*
> - * GLIB Compatibility Functions
> - *
> - * Copyright IBM, Corp. 2013
> - *
> - * Authors:
> - *  Anthony Liguori   <aliguori@us.ibm.com>
> - *  Michael Tokarev   <mjt@tls.msk.ru>
> - *  Paolo Bonzini     <pbonzini@redhat.com>
> - *
> - * This work is licensed under the terms of the GNU GPL, version 2 or later.
> - * See the COPYING file in the top-level directory.
> - *
> - */
> -
> -#ifndef QEMU_GLIB_COMPAT_H
> -#define QEMU_GLIB_COMPAT_H
> -
> -#include <glib.h>
> -
> -/* GLIB version compatibility flags */
> -#if !GLIB_CHECK_VERSION(2, 26, 0)
> -#define G_TIME_SPAN_SECOND              (G_GINT64_CONSTANT(1000000))
> -#endif
> -
> -#if !GLIB_CHECK_VERSION(2, 28, 0)
> -static inline gint64 qemu_g_get_monotonic_time(void)
> -{
> -    /* g_get_monotonic_time() is best-effort so we can use the wall clock as a
> -     * fallback.
> -     */
> -
> -    GTimeVal time;
> -    g_get_current_time(&time);
> -
> -    return time.tv_sec * G_TIME_SPAN_SECOND + time.tv_usec;
> -}
> -/* work around distro backports of this interface */
> -#define g_get_monotonic_time() qemu_g_get_monotonic_time()
> -#endif
> -
> -#if defined(_WIN32) && !GLIB_CHECK_VERSION(2, 50, 0)
> -/*
> - * g_poll has a problem on Windows when using
> - * timeouts < 10ms, so use wrapper.
> - */
> -#define g_poll(fds, nfds, timeout) g_poll_fixed(fds, nfds, timeout)
> -gint g_poll_fixed(GPollFD *fds, guint nfds, gint timeout);
> -#endif
> -
> -#if !GLIB_CHECK_VERSION(2, 30, 0)
> -/* Not a 100% compatible implementation, but good enough for most
> - * cases. Placeholders are only supported at the end of the
> - * template. */
> -static inline gchar *qemu_g_dir_make_tmp(gchar const *tmpl, GError **error)
> -{
> -    gchar *path = g_build_filename(g_get_tmp_dir(), tmpl ?: ".XXXXXX", NULL);
> -
> -    if (mkdtemp(path) != NULL) {
> -        return path;
> -    }
> -    /* Error occurred, clean up. */
> -    g_set_error(error, G_FILE_ERROR, g_file_error_from_errno(errno),
> -                "mkdtemp() failed");
> -    g_free(path);
> -    return NULL;
> -}
> -#define g_dir_make_tmp(tmpl, error) qemu_g_dir_make_tmp(tmpl, error)
> -#endif /* glib 2.30 */
> -
> -#if !GLIB_CHECK_VERSION(2, 31, 0)
> -/* before glib-2.31, GMutex and GCond was dynamic-only (there was a separate
> - * GStaticMutex, but it didn't work with condition variables).
> - *
> - * Our implementation uses GOnce to fake a static implementation that does
> - * not require separate initialization.
> - * We need to rename the types to avoid passing our CompatGMutex/CompatGCond
> - * by mistake to a function that expects GMutex/GCond.  However, for ease
> - * of use we keep the GLib function names.  GLib uses macros for the
> - * implementation, we use inline functions instead and undefine the macros.
> - */
> -
> -typedef struct CompatGMutex {
> -    GOnce once;
> -} CompatGMutex;
> -
> -typedef struct CompatGCond {
> -    GOnce once;
> -} CompatGCond;
> -
> -static inline gpointer do_g_mutex_new(gpointer unused)
> -{
> -    return (gpointer) g_mutex_new();
> -}
> -
> -static inline void g_mutex_init(CompatGMutex *mutex)
> -{
> -    mutex->once = (GOnce) G_ONCE_INIT;
> -}
> -
> -static inline void g_mutex_clear(CompatGMutex *mutex)
> -{
> -    g_assert(mutex->once.status != G_ONCE_STATUS_PROGRESS);
> -    if (mutex->once.retval) {
> -        g_mutex_free((GMutex *) mutex->once.retval);
> -    }
> -    mutex->once = (GOnce) G_ONCE_INIT;
> -}
> -
> -static inline void (g_mutex_lock)(CompatGMutex *mutex)
> -{
> -    g_once(&mutex->once, do_g_mutex_new, NULL);
> -    g_mutex_lock((GMutex *) mutex->once.retval);
> -}
> -#undef g_mutex_lock
> -
> -static inline gboolean (g_mutex_trylock)(CompatGMutex *mutex)
> -{
> -    g_once(&mutex->once, do_g_mutex_new, NULL);
> -    return g_mutex_trylock((GMutex *) mutex->once.retval);
> -}
> -#undef g_mutex_trylock
> -
> -
> -static inline void (g_mutex_unlock)(CompatGMutex *mutex)
> -{
> -    g_mutex_unlock((GMutex *) mutex->once.retval);
> -}
> -#undef g_mutex_unlock
> -
> -static inline gpointer do_g_cond_new(gpointer unused)
> -{
> -    return (gpointer) g_cond_new();
> -}
> -
> -static inline void g_cond_init(CompatGCond *cond)
> -{
> -    cond->once = (GOnce) G_ONCE_INIT;
> -}
> -
> -static inline void g_cond_clear(CompatGCond *cond)
> -{
> -    g_assert(cond->once.status != G_ONCE_STATUS_PROGRESS);
> -    if (cond->once.retval) {
> -        g_cond_free((GCond *) cond->once.retval);
> -    }
> -    cond->once = (GOnce) G_ONCE_INIT;
> -}
> -
> -static inline void (g_cond_wait)(CompatGCond *cond, CompatGMutex *mutex)
> -{
> -    g_assert(mutex->once.status != G_ONCE_STATUS_PROGRESS);
> -    g_once(&cond->once, do_g_cond_new, NULL);
> -    g_cond_wait((GCond *) cond->once.retval, (GMutex *) mutex->once.retval);
> -}
> -#undef g_cond_wait
> -
> -static inline void (g_cond_broadcast)(CompatGCond *cond)
> -{
> -    g_once(&cond->once, do_g_cond_new, NULL);
> -    g_cond_broadcast((GCond *) cond->once.retval);
> -}
> -#undef g_cond_broadcast
> -
> -static inline void (g_cond_signal)(CompatGCond *cond)
> -{
> -    g_once(&cond->once, do_g_cond_new, NULL);
> -    g_cond_signal((GCond *) cond->once.retval);
> -}
> -#undef g_cond_signal
> -
> -static inline gboolean (g_cond_timed_wait)(CompatGCond *cond,
> -                                           CompatGMutex *mutex,
> -                                           GTimeVal *time)
> -{
> -    g_assert(mutex->once.status != G_ONCE_STATUS_PROGRESS);
> -    g_once(&cond->once, do_g_cond_new, NULL);
> -    return g_cond_timed_wait((GCond *) cond->once.retval,
> -                             (GMutex *) mutex->once.retval, time);
> -}
> -#undef g_cond_timed_wait
> -
> -/* This is not a macro, because it didn't exist until 2.32.  */
> -static inline gboolean g_cond_wait_until(CompatGCond *cond, CompatGMutex *mutex,
> -                                         gint64 end_time)
> -{
> -    GTimeVal time;
> -
> -    /* Convert from monotonic to CLOCK_REALTIME.  */
> -    end_time -= g_get_monotonic_time();
> -    g_get_current_time(&time);
> -    end_time += time.tv_sec * G_TIME_SPAN_SECOND + time.tv_usec;
> -
> -    time.tv_sec = end_time / G_TIME_SPAN_SECOND;
> -    time.tv_usec = end_time % G_TIME_SPAN_SECOND;
> -    return g_cond_timed_wait(cond, mutex, &time);
> -}
> -
> -/* before 2.31 there was no g_thread_new() */
> -static inline GThread *g_thread_new(const char *name,
> -                                    GThreadFunc func, gpointer data)
> -{
> -    GThread *thread = g_thread_create(func, data, TRUE, NULL);
> -    if (!thread) {
> -        g_error("creating thread");
> -    }
> -    return thread;
> -}
> -#else
> -#define CompatGMutex GMutex
> -#define CompatGCond GCond
> -#endif /* glib 2.31 */
> -
> -#if !GLIB_CHECK_VERSION(2, 32, 0)
> -/* Beware, function returns gboolean since 2.39.2, see GLib commit 9101915 */
> -static inline void g_hash_table_add(GHashTable *hash_table, gpointer key)
> -{
> -    g_hash_table_replace(hash_table, key, key);
> -}
> -#endif
> -
> -#ifndef g_assert_true
> -#define g_assert_true(expr)                                                    \
> -    do {                                                                       \
> -        if (G_LIKELY(expr)) {                                                  \
> -        } else {                                                               \
> -            g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC,   \
> -                                "'" #expr "' should be TRUE");                 \
> -        }                                                                      \
> -    } while (0)
> -#endif
> -
> -#ifndef g_assert_false
> -#define g_assert_false(expr)                                                   \
> -    do {                                                                       \
> -        if (G_LIKELY(!(expr))) {                                               \
> -        } else {                                                               \
> -            g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC,   \
> -                                "'" #expr "' should be FALSE");                \
> -        }                                                                      \
> -    } while (0)
> -#endif
> -
> -#ifndef g_assert_null
> -#define g_assert_null(expr)                                                    \
> -    do {                                                                       \
> -        if (G_LIKELY((expr) == NULL)) {                                        \
> -        } else {                                                               \
> -            g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC,   \
> -                                "'" #expr "' should be NULL");                 \
> -        }                                                                      \
> -    } while (0)
> -#endif
> -
> -#ifndef g_assert_nonnull
> -#define g_assert_nonnull(expr)                                                 \
> -    do {                                                                       \
> -        if (G_LIKELY((expr) != NULL)) {                                        \
> -        } else {                                                               \
> -            g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC,   \
> -                                "'" #expr "' should not be NULL");             \
> -        }                                                                      \
> -    } while (0)
> -#endif
> -
> -#ifndef g_assert_cmpmem
> -#define g_assert_cmpmem(m1, l1, m2, l2)                                        \
> -    do {                                                                       \
> -        gconstpointer __m1 = m1, __m2 = m2;                                    \
> -        int __l1 = l1, __l2 = l2;                                              \
> -        if (__l1 != __l2) {                                                    \
> -            g_assertion_message_cmpnum(                                        \
> -                G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC,                   \
> -                #l1 " (len(" #m1 ")) == " #l2 " (len(" #m2 "))", __l1, "==",   \
> -                __l2, 'i');                                                    \
> -        } else if (memcmp(__m1, __m2, __l1) != 0) {                            \
> -            g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC,   \
> -                                "assertion failed (" #m1 " == " #m2 ")");      \
> -        }                                                                      \
> -    } while (0)
> -#endif
> -
> -#if !GLIB_CHECK_VERSION(2, 28, 0)
> -static inline void g_list_free_full(GList *list, GDestroyNotify free_func)
> -{
> -    GList *l;
> -
> -    for (l = list; l; l = l->next) {
> -        free_func(l->data);
> -    }
> -
> -    g_list_free(list);
> -}
> -
> -static inline void g_slist_free_full(GSList *list, GDestroyNotify free_func)
> -{
> -    GSList *l;
> -
> -    for (l = list; l; l = l->next) {
> -        free_func(l->data);
> -    }
> -
> -    g_slist_free(list);
> -}
> -#endif
> -
> -#if !GLIB_CHECK_VERSION(2, 26, 0)
> -static inline void g_source_set_name(GSource *source, const char *name)
> -{
> -    /* This is just a debugging aid, so leaving it a no-op */
> -}
> -static inline void g_source_set_name_by_id(guint tag, const char *name)
> -{
> -    /* This is just a debugging aid, so leaving it a no-op */
> -}
> -#endif
> -
> -#if !GLIB_CHECK_VERSION(2, 36, 0)
> -/* Always fail.  This will not include error_report output in the test log,
> - * sending it instead to stderr.
> - */
> -#define g_test_initialized() (0)
> -#endif
> -#if !GLIB_CHECK_VERSION(2, 38, 0)
> -#ifdef CONFIG_HAS_GLIB_SUBPROCESS_TESTS
> -#error schizophrenic detection of glib subprocess testing
> -#endif
> -#define g_test_subprocess() (0)
> -#endif
> -
> -
> -#if !GLIB_CHECK_VERSION(2, 34, 0)
> -static inline void
> -g_test_add_data_func_full(const char *path,
> -                          gpointer data,
> -                          gpointer fn,
> -                          gpointer data_free_func)
> -{
> -#if GLIB_CHECK_VERSION(2, 26, 0)
> -    /* back-compat casts, remove this once we can require new-enough glib */
> -    g_test_add_vtable(path, 0, data, NULL,
> -                      (GTestFixtureFunc)fn, (GTestFixtureFunc) data_free_func);
> -#else
> -    /* back-compat casts, remove this once we can require new-enough glib */
> -    g_test_add_vtable(path, 0, data, NULL,
> -                      (void (*)(void)) fn, (void (*)(void)) data_free_func);
> -#endif
> -}
> -#endif
> -
> -
> -#endif
> diff --git a/include/glib/glib-compat.h b/include/glib/glib-compat.h
> new file mode 100644
> index 0000000..863c8cf
> --- /dev/null
> +++ b/include/glib/glib-compat.h
> @@ -0,0 +1,352 @@
> +/*
> + * GLIB Compatibility Functions
> + *
> + * Copyright IBM, Corp. 2013
> + *
> + * Authors:
> + *  Anthony Liguori   <aliguori@us.ibm.com>
> + *  Michael Tokarev   <mjt@tls.msk.ru>
> + *  Paolo Bonzini     <pbonzini@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef QEMU_GLIB_COMPAT_H
> +#define QEMU_GLIB_COMPAT_H
> +
> +#include <glib.h>
> +
> +/* GLIB version compatibility flags */
> +#if !GLIB_CHECK_VERSION(2, 26, 0)
> +#define G_TIME_SPAN_SECOND              (G_GINT64_CONSTANT(1000000))
> +#endif
> +
> +#if !GLIB_CHECK_VERSION(2, 28, 0)
> +static inline gint64 qemu_g_get_monotonic_time(void)
> +{
> +    /* g_get_monotonic_time() is best-effort so we can use the wall clock as a
> +     * fallback.
> +     */
> +
> +    GTimeVal time;
> +    g_get_current_time(&time);
> +
> +    return time.tv_sec * G_TIME_SPAN_SECOND + time.tv_usec;
> +}
> +/* work around distro backports of this interface */
> +#define g_get_monotonic_time() qemu_g_get_monotonic_time()
> +#endif
> +
> +#if defined(_WIN32) && !GLIB_CHECK_VERSION(2, 50, 0)
> +/*
> + * g_poll has a problem on Windows when using
> + * timeouts < 10ms, so use wrapper.
> + */
> +#define g_poll(fds, nfds, timeout) g_poll_fixed(fds, nfds, timeout)
> +gint g_poll_fixed(GPollFD *fds, guint nfds, gint timeout);
> +#endif
> +
> +#if !GLIB_CHECK_VERSION(2, 30, 0)
> +/* Not a 100% compatible implementation, but good enough for most
> + * cases. Placeholders are only supported at the end of the
> + * template. */
> +static inline gchar *qemu_g_dir_make_tmp(gchar const *tmpl, GError **error)
> +{
> +    gchar *path = g_build_filename(g_get_tmp_dir(), tmpl ?: ".XXXXXX", NULL);
> +
> +    if (mkdtemp(path) != NULL) {
> +        return path;
> +    }
> +    /* Error occurred, clean up. */
> +    g_set_error(error, G_FILE_ERROR, g_file_error_from_errno(errno),
> +                "mkdtemp() failed");
> +    g_free(path);
> +    return NULL;
> +}
> +#define g_dir_make_tmp(tmpl, error) qemu_g_dir_make_tmp(tmpl, error)
> +#endif /* glib 2.30 */
> +
> +#if !GLIB_CHECK_VERSION(2, 31, 0)
> +/* before glib-2.31, GMutex and GCond was dynamic-only (there was a separate
> + * GStaticMutex, but it didn't work with condition variables).
> + *
> + * Our implementation uses GOnce to fake a static implementation that does
> + * not require separate initialization.
> + * We need to rename the types to avoid passing our CompatGMutex/CompatGCond
> + * by mistake to a function that expects GMutex/GCond.  However, for ease
> + * of use we keep the GLib function names.  GLib uses macros for the
> + * implementation, we use inline functions instead and undefine the macros.
> + */
> +
> +typedef struct CompatGMutex {
> +    GOnce once;
> +} CompatGMutex;
> +
> +typedef struct CompatGCond {
> +    GOnce once;
> +} CompatGCond;
> +
> +static inline gpointer do_g_mutex_new(gpointer unused)
> +{
> +    return (gpointer) g_mutex_new();
> +}
> +
> +static inline void g_mutex_init(CompatGMutex *mutex)
> +{
> +    mutex->once = (GOnce) G_ONCE_INIT;
> +}
> +
> +static inline void g_mutex_clear(CompatGMutex *mutex)
> +{
> +    g_assert(mutex->once.status != G_ONCE_STATUS_PROGRESS);
> +    if (mutex->once.retval) {
> +        g_mutex_free((GMutex *) mutex->once.retval);
> +    }
> +    mutex->once = (GOnce) G_ONCE_INIT;
> +}
> +
> +static inline void (g_mutex_lock)(CompatGMutex *mutex)
> +{
> +    g_once(&mutex->once, do_g_mutex_new, NULL);
> +    g_mutex_lock((GMutex *) mutex->once.retval);
> +}
> +#undef g_mutex_lock
> +
> +static inline gboolean (g_mutex_trylock)(CompatGMutex *mutex)
> +{
> +    g_once(&mutex->once, do_g_mutex_new, NULL);
> +    return g_mutex_trylock((GMutex *) mutex->once.retval);
> +}
> +#undef g_mutex_trylock
> +
> +
> +static inline void (g_mutex_unlock)(CompatGMutex *mutex)
> +{
> +    g_mutex_unlock((GMutex *) mutex->once.retval);
> +}
> +#undef g_mutex_unlock
> +
> +static inline gpointer do_g_cond_new(gpointer unused)
> +{
> +    return (gpointer) g_cond_new();
> +}
> +
> +static inline void g_cond_init(CompatGCond *cond)
> +{
> +    cond->once = (GOnce) G_ONCE_INIT;
> +}
> +
> +static inline void g_cond_clear(CompatGCond *cond)
> +{
> +    g_assert(cond->once.status != G_ONCE_STATUS_PROGRESS);
> +    if (cond->once.retval) {
> +        g_cond_free((GCond *) cond->once.retval);
> +    }
> +    cond->once = (GOnce) G_ONCE_INIT;
> +}
> +
> +static inline void (g_cond_wait)(CompatGCond *cond, CompatGMutex *mutex)
> +{
> +    g_assert(mutex->once.status != G_ONCE_STATUS_PROGRESS);
> +    g_once(&cond->once, do_g_cond_new, NULL);
> +    g_cond_wait((GCond *) cond->once.retval, (GMutex *) mutex->once.retval);
> +}
> +#undef g_cond_wait
> +
> +static inline void (g_cond_broadcast)(CompatGCond *cond)
> +{
> +    g_once(&cond->once, do_g_cond_new, NULL);
> +    g_cond_broadcast((GCond *) cond->once.retval);
> +}
> +#undef g_cond_broadcast
> +
> +static inline void (g_cond_signal)(CompatGCond *cond)
> +{
> +    g_once(&cond->once, do_g_cond_new, NULL);
> +    g_cond_signal((GCond *) cond->once.retval);
> +}
> +#undef g_cond_signal
> +
> +static inline gboolean (g_cond_timed_wait)(CompatGCond *cond,
> +                                           CompatGMutex *mutex,
> +                                           GTimeVal *time)
> +{
> +    g_assert(mutex->once.status != G_ONCE_STATUS_PROGRESS);
> +    g_once(&cond->once, do_g_cond_new, NULL);
> +    return g_cond_timed_wait((GCond *) cond->once.retval,
> +                             (GMutex *) mutex->once.retval, time);
> +}
> +#undef g_cond_timed_wait
> +
> +/* This is not a macro, because it didn't exist until 2.32.  */
> +static inline gboolean g_cond_wait_until(CompatGCond *cond, CompatGMutex *mutex,
> +                                         gint64 end_time)
> +{
> +    GTimeVal time;
> +
> +    /* Convert from monotonic to CLOCK_REALTIME.  */
> +    end_time -= g_get_monotonic_time();
> +    g_get_current_time(&time);
> +    end_time += time.tv_sec * G_TIME_SPAN_SECOND + time.tv_usec;
> +
> +    time.tv_sec = end_time / G_TIME_SPAN_SECOND;
> +    time.tv_usec = end_time % G_TIME_SPAN_SECOND;
> +    return g_cond_timed_wait(cond, mutex, &time);
> +}
> +
> +/* before 2.31 there was no g_thread_new() */
> +static inline GThread *g_thread_new(const char *name,
> +                                    GThreadFunc func, gpointer data)
> +{
> +    GThread *thread = g_thread_create(func, data, TRUE, NULL);
> +    if (!thread) {
> +        g_error("creating thread");
> +    }
> +    return thread;
> +}
> +#else
> +#define CompatGMutex GMutex
> +#define CompatGCond GCond
> +#endif /* glib 2.31 */
> +
> +#if !GLIB_CHECK_VERSION(2, 32, 0)
> +/* Beware, function returns gboolean since 2.39.2, see GLib commit 9101915 */
> +static inline void g_hash_table_add(GHashTable *hash_table, gpointer key)
> +{
> +    g_hash_table_replace(hash_table, key, key);
> +}
> +#endif
> +
> +#ifndef g_assert_true
> +#define g_assert_true(expr)                                                    \
> +    do {                                                                       \
> +        if (G_LIKELY(expr)) {                                                  \
> +        } else {                                                               \
> +            g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC,   \
> +                                "'" #expr "' should be TRUE");                 \
> +        }                                                                      \
> +    } while (0)
> +#endif
> +
> +#ifndef g_assert_false
> +#define g_assert_false(expr)                                                   \
> +    do {                                                                       \
> +        if (G_LIKELY(!(expr))) {                                               \
> +        } else {                                                               \
> +            g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC,   \
> +                                "'" #expr "' should be FALSE");                \
> +        }                                                                      \
> +    } while (0)
> +#endif
> +
> +#ifndef g_assert_null
> +#define g_assert_null(expr)                                                    \
> +    do {                                                                       \
> +        if (G_LIKELY((expr) == NULL)) {                                        \
> +        } else {                                                               \
> +            g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC,   \
> +                                "'" #expr "' should be NULL");                 \
> +        }                                                                      \
> +    } while (0)
> +#endif
> +
> +#ifndef g_assert_nonnull
> +#define g_assert_nonnull(expr)                                                 \
> +    do {                                                                       \
> +        if (G_LIKELY((expr) != NULL)) {                                        \
> +        } else {                                                               \
> +            g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC,   \
> +                                "'" #expr "' should not be NULL");             \
> +        }                                                                      \
> +    } while (0)
> +#endif
> +
> +#ifndef g_assert_cmpmem
> +#define g_assert_cmpmem(m1, l1, m2, l2)                                        \
> +    do {                                                                       \
> +        gconstpointer __m1 = m1, __m2 = m2;                                    \
> +        int __l1 = l1, __l2 = l2;                                              \
> +        if (__l1 != __l2) {                                                    \
> +            g_assertion_message_cmpnum(                                        \
> +                G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC,                   \
> +                #l1 " (len(" #m1 ")) == " #l2 " (len(" #m2 "))", __l1, "==",   \
> +                __l2, 'i');                                                    \
> +        } else if (memcmp(__m1, __m2, __l1) != 0) {                            \
> +            g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC,   \
> +                                "assertion failed (" #m1 " == " #m2 ")");      \
> +        }                                                                      \
> +    } while (0)
> +#endif
> +
> +#if !GLIB_CHECK_VERSION(2, 28, 0)
> +static inline void g_list_free_full(GList *list, GDestroyNotify free_func)
> +{
> +    GList *l;
> +
> +    for (l = list; l; l = l->next) {
> +        free_func(l->data);
> +    }
> +
> +    g_list_free(list);
> +}
> +
> +static inline void g_slist_free_full(GSList *list, GDestroyNotify free_func)
> +{
> +    GSList *l;
> +
> +    for (l = list; l; l = l->next) {
> +        free_func(l->data);
> +    }
> +
> +    g_slist_free(list);
> +}
> +#endif
> +
> +#if !GLIB_CHECK_VERSION(2, 26, 0)
> +static inline void g_source_set_name(GSource *source, const char *name)
> +{
> +    /* This is just a debugging aid, so leaving it a no-op */
> +}
> +static inline void g_source_set_name_by_id(guint tag, const char *name)
> +{
> +    /* This is just a debugging aid, so leaving it a no-op */
> +}
> +#endif
> +
> +#if !GLIB_CHECK_VERSION(2, 36, 0)
> +/* Always fail.  This will not include error_report output in the test log,
> + * sending it instead to stderr.
> + */
> +#define g_test_initialized() (0)
> +#endif
> +#if !GLIB_CHECK_VERSION(2, 38, 0)
> +#ifdef CONFIG_HAS_GLIB_SUBPROCESS_TESTS
> +#error schizophrenic detection of glib subprocess testing
> +#endif
> +#define g_test_subprocess() (0)
> +#endif
> +
> +
> +#if !GLIB_CHECK_VERSION(2, 34, 0)
> +static inline void
> +g_test_add_data_func_full(const char *path,
> +                          gpointer data,
> +                          gpointer fn,
> +                          gpointer data_free_func)
> +{
> +#if GLIB_CHECK_VERSION(2, 26, 0)
> +    /* back-compat casts, remove this once we can require new-enough glib */
> +    g_test_add_vtable(path, 0, data, NULL,
> +                      (GTestFixtureFunc)fn, (GTestFixtureFunc) data_free_func);
> +#else
> +    /* back-compat casts, remove this once we can require new-enough glib */
> +    g_test_add_vtable(path, 0, data, NULL,
> +                      (void (*)(void)) fn, (void (*)(void)) data_free_func);
> +#endif
> +}
> +#endif
> +
> +
> +#endif
> diff --git a/include/glib/glib-helper.h b/include/glib/glib-helper.h
> new file mode 100644
> index 0000000..db740fb
> --- /dev/null
> +++ b/include/glib/glib-helper.h
> @@ -0,0 +1,30 @@
> +/*
> + * Helpers for GLIB
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef QEMU_GLIB_HELPER_H
> +#define QEMU_GLIB_HELPER_H
> +
> +
> +#include "glib/glib-compat.h"
> +
> +#define GPOINTER_TO_UINT64(a) ((guint64) (a))
> +
> +/*
> + * return 1 in case of a > b, -1 otherwise and 0 if equeal
> + */
> +gint g_int_cmp64(gconstpointer a, gconstpointer b,
> +        gpointer __attribute__((unused)) user_data);
> +
> +/*
> + * return 1 in case of a > b, -1 otherwise and 0 if equeal
> + */
> +int g_int_cmp(gconstpointer a, gconstpointer b,
> +        gpointer __attribute__((unused)) user_data);
> +
> +#endif /* QEMU_GLIB_HELPER_H */
> +
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 122ff06..36f8a89 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -104,7 +104,7 @@ extern int daemon(int, int);
>  #include "sysemu/os-posix.h"
>  #endif
>
> -#include "glib-compat.h"
> +#include "glib/glib-compat.h"
>  #include "qemu/typedefs.h"
>
>  #ifndef O_LARGEFILE
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 10a3bb3..7cea6bc 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -35,7 +35,7 @@
>  #include "elf.h"
>  #include "exec/log.h"
>  #include "trace/control.h"
> -#include "glib-compat.h"
> +#include "glib/glib-compat.h"
>
>  char *exec_path;
>
> diff --git a/scripts/clean-includes b/scripts/clean-includes
> index dd938da..b32b928 100755
> --- a/scripts/clean-includes
> +++ b/scripts/clean-includes
> @@ -123,7 +123,7 @@ for f in "$@"; do
>        ;;
>      *include/qemu/osdep.h | \
>      *include/qemu/compiler.h | \
> -    *include/glib-compat.h | \
> +    *include/glib/glib-compat.h | \
>      *include/sysemu/os-posix.h | \
>      *include/sysemu/os-win32.h | \
>      *include/standard-headers/ )
> diff --git a/util/Makefile.objs b/util/Makefile.objs
> index c6205eb..0080712 100644
> --- a/util/Makefile.objs
> +++ b/util/Makefile.objs
> @@ -43,3 +43,4 @@ util-obj-y += qdist.o
>  util-obj-y += qht.o
>  util-obj-y += range.o
>  util-obj-y += systemd.o
> +util-obj-y += glib-helper.o
> diff --git a/util/glib-helper.c b/util/glib-helper.c
> new file mode 100644
> index 0000000..2557009
> --- /dev/null
> +++ b/util/glib-helper.c
> @@ -0,0 +1,29 @@
> +/*
> + * Implementation for GLIB helpers
> + * this file is intented to commulate and later reuse
> + * additional glib functions
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> +
> + */
> +
> +#include "glib/glib-helper.h"
> +
> +gint g_int_cmp64(gconstpointer a, gconstpointer b,
> +        gpointer __attribute__((unused)) user_data)
> +{
> +    guint64 ua = GPOINTER_TO_UINT64(a);
> +    guint64 ub = GPOINTER_TO_UINT64(b);
> +    return (ua > ub) - (ua < ub);
> +}
> +
> +/*
> + * return 1 in case of a > b, -1 otherwise and 0 if equeal
> + */
> +gint g_int_cmp(gconstpointer a, gconstpointer b,
> +        gpointer __attribute__((unused)) user_data)
> +{
> +    return g_int_cmp64(a, b, user_data);
> +}
> +
>
