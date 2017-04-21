Received: from eggs.gnu.org ([2001:4830:134:3::10]:47293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d1VO6-0001M9-Lu
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 06:02:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d1VO2-0005Is-Ka
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 06:02:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d1VO2-0005Io-6r
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 06:01:58 -0400
Date: Fri, 21 Apr 2017 11:01:53 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170421100151.GC2908@work-vm>
References: <1492175840-5021-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170414131739eucas1p1ea9a6adcdbe8cfe45ac1ff582d28d873@eucas1p1.samsung.com>
	<1492175840-5021-3-git-send-email-a.perevalov@samsung.com>
	<c38e0275-2f7e-6063-3534-daa629b0d400@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <c38e0275-2f7e-6063-3534-daa629b0d400@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/6] util: introduce glib-helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alexey Perevalov <a.perevalov@samsung.com>, qemu-devel@nongnu.org, i.maximets@samsung.com

* Philippe Mathieu-Daud=E9 (f4bug@amsat.org) wrote:
> Hi Alexey,
>=20
> On 04/14/2017 10:17 AM, Alexey Perevalov wrote:
> > There is a lack of g_int_cmp which compares pointers value in glib,
> > xen_disk.c introduced its own, so the same function now requires
> > in migration.c. So logically to move it into common place.
> > Futher: maybe extend glib.
> >=20
> > Also this commit moves existing glib-compat.h into util/glib
> > folder for consolidation purpose.
>=20
> Can you do this in two commits? First one moving files only, second mov=
e the
> function?

Yes, if you're lucky and do it with git mv  then perhaps git  will genera=
te us a nice
small commit with a move in it rather than a vast delete/add.

> I'm not sure naming it "g_int_cmp()" won't clash with future _extended_
> glib, what do you think about naming it "qemu_g_int_cmp()"?

Also agreed.

Dave

>=20
> > Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> > ---
> >  hw/block/xen_disk.c        |  10 +-
> >  include/glib-compat.h      | 352 -----------------------------------=
----------
> >  include/glib/glib-compat.h | 352 +++++++++++++++++++++++++++++++++++=
++++++++++
> >  include/glib/glib-helper.h |  30 ++++
> >  include/qemu/osdep.h       |   2 +-
> >  linux-user/main.c          |   2 +-
> >  scripts/clean-includes     |   2 +-
> >  util/Makefile.objs         |   1 +
> >  util/glib-helper.c         |  29 ++++
> >  9 files changed, 417 insertions(+), 363 deletions(-)
> >  delete mode 100644 include/glib-compat.h
> >  create mode 100644 include/glib/glib-compat.h
> >  create mode 100644 include/glib/glib-helper.h
> >  create mode 100644 util/glib-helper.c
> >=20
> > diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
> > index 456a2d5..36f6396 100644
> > --- a/hw/block/xen_disk.c
> > +++ b/hw/block/xen_disk.c
> > @@ -20,6 +20,7 @@
> >   */
> >=20
> >  #include "qemu/osdep.h"
> > +#include "glib/glib-helper.h"
> >  #include <sys/ioctl.h>
> >  #include <sys/uio.h>
> >=20
> > @@ -154,13 +155,6 @@ static void ioreq_reset(struct ioreq *ioreq)
> >      qemu_iovec_reset(&ioreq->v);
> >  }
> >=20
> > -static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_=
data)
> > -{
> > -    uint ua =3D GPOINTER_TO_UINT(a);
> > -    uint ub =3D GPOINTER_TO_UINT(b);
> > -    return (ua > ub) - (ua < ub);
> > -}
> > -
> >  static void destroy_grant(gpointer pgnt)
> >  {
> >      PersistentGrant *grant =3D pgnt;
> > @@ -1191,7 +1185,7 @@ static int blk_connect(struct XenDevice *xendev=
)
> >      if (blkdev->feature_persistent) {
> >          /* Init persistent grants */
> >          blkdev->max_grants =3D max_requests * BLKIF_MAX_SEGMENTS_PER=
_REQUEST;
> > -        blkdev->persistent_gnts =3D g_tree_new_full((GCompareDataFun=
c)int_cmp,
> > +        blkdev->persistent_gnts =3D g_tree_new_full((GCompareDataFun=
c)g_int_cmp,
> >                                               NULL, NULL,
> >                                               batch_maps ?
> >                                               (GDestroyNotify)g_free =
:
> > diff --git a/include/glib-compat.h b/include/glib-compat.h
> > deleted file mode 100644
> > index 863c8cf..0000000
> > --- a/include/glib-compat.h
> > +++ /dev/null
> > @@ -1,352 +0,0 @@
> > -/*
> > - * GLIB Compatibility Functions
> > - *
> > - * Copyright IBM, Corp. 2013
> > - *
> > - * Authors:
> > - *  Anthony Liguori   <aliguori@us.ibm.com>
> > - *  Michael Tokarev   <mjt@tls.msk.ru>
> > - *  Paolo Bonzini     <pbonzini@redhat.com>
> > - *
> > - * This work is licensed under the terms of the GNU GPL, version 2 o=
r later.
> > - * See the COPYING file in the top-level directory.
> > - *
> > - */
> > -
> > -#ifndef QEMU_GLIB_COMPAT_H
> > -#define QEMU_GLIB_COMPAT_H
> > -
> > -#include <glib.h>
> > -
> > -/* GLIB version compatibility flags */
> > -#if !GLIB_CHECK_VERSION(2, 26, 0)
> > -#define G_TIME_SPAN_SECOND              (G_GINT64_CONSTANT(1000000))
> > -#endif
> > -
> > -#if !GLIB_CHECK_VERSION(2, 28, 0)
> > -static inline gint64 qemu_g_get_monotonic_time(void)
> > -{
> > -    /* g_get_monotonic_time() is best-effort so we can use the wall =
clock as a
> > -     * fallback.
> > -     */
> > -
> > -    GTimeVal time;
> > -    g_get_current_time(&time);
> > -
> > -    return time.tv_sec * G_TIME_SPAN_SECOND + time.tv_usec;
> > -}
> > -/* work around distro backports of this interface */
> > -#define g_get_monotonic_time() qemu_g_get_monotonic_time()
> > -#endif
> > -
> > -#if defined(_WIN32) && !GLIB_CHECK_VERSION(2, 50, 0)
> > -/*
> > - * g_poll has a problem on Windows when using
> > - * timeouts < 10ms, so use wrapper.
> > - */
> > -#define g_poll(fds, nfds, timeout) g_poll_fixed(fds, nfds, timeout)
> > -gint g_poll_fixed(GPollFD *fds, guint nfds, gint timeout);
> > -#endif
> > -
> > -#if !GLIB_CHECK_VERSION(2, 30, 0)
> > -/* Not a 100% compatible implementation, but good enough for most
> > - * cases. Placeholders are only supported at the end of the
> > - * template. */
> > -static inline gchar *qemu_g_dir_make_tmp(gchar const *tmpl, GError *=
*error)
> > -{
> > -    gchar *path =3D g_build_filename(g_get_tmp_dir(), tmpl ?: ".XXXX=
XX", NULL);
> > -
> > -    if (mkdtemp(path) !=3D NULL) {
> > -        return path;
> > -    }
> > -    /* Error occurred, clean up. */
> > -    g_set_error(error, G_FILE_ERROR, g_file_error_from_errno(errno),
> > -                "mkdtemp() failed");
> > -    g_free(path);
> > -    return NULL;
> > -}
> > -#define g_dir_make_tmp(tmpl, error) qemu_g_dir_make_tmp(tmpl, error)
> > -#endif /* glib 2.30 */
> > -
> > -#if !GLIB_CHECK_VERSION(2, 31, 0)
> > -/* before glib-2.31, GMutex and GCond was dynamic-only (there was a =
separate
> > - * GStaticMutex, but it didn't work with condition variables).
> > - *
> > - * Our implementation uses GOnce to fake a static implementation tha=
t does
> > - * not require separate initialization.
> > - * We need to rename the types to avoid passing our CompatGMutex/Com=
patGCond
> > - * by mistake to a function that expects GMutex/GCond.  However, for=
 ease
> > - * of use we keep the GLib function names.  GLib uses macros for the
> > - * implementation, we use inline functions instead and undefine the =
macros.
> > - */
> > -
> > -typedef struct CompatGMutex {
> > -    GOnce once;
> > -} CompatGMutex;
> > -
> > -typedef struct CompatGCond {
> > -    GOnce once;
> > -} CompatGCond;
> > -
> > -static inline gpointer do_g_mutex_new(gpointer unused)
> > -{
> > -    return (gpointer) g_mutex_new();
> > -}
> > -
> > -static inline void g_mutex_init(CompatGMutex *mutex)
> > -{
> > -    mutex->once =3D (GOnce) G_ONCE_INIT;
> > -}
> > -
> > -static inline void g_mutex_clear(CompatGMutex *mutex)
> > -{
> > -    g_assert(mutex->once.status !=3D G_ONCE_STATUS_PROGRESS);
> > -    if (mutex->once.retval) {
> > -        g_mutex_free((GMutex *) mutex->once.retval);
> > -    }
> > -    mutex->once =3D (GOnce) G_ONCE_INIT;
> > -}
> > -
> > -static inline void (g_mutex_lock)(CompatGMutex *mutex)
> > -{
> > -    g_once(&mutex->once, do_g_mutex_new, NULL);
> > -    g_mutex_lock((GMutex *) mutex->once.retval);
> > -}
> > -#undef g_mutex_lock
> > -
> > -static inline gboolean (g_mutex_trylock)(CompatGMutex *mutex)
> > -{
> > -    g_once(&mutex->once, do_g_mutex_new, NULL);
> > -    return g_mutex_trylock((GMutex *) mutex->once.retval);
> > -}
> > -#undef g_mutex_trylock
> > -
> > -
> > -static inline void (g_mutex_unlock)(CompatGMutex *mutex)
> > -{
> > -    g_mutex_unlock((GMutex *) mutex->once.retval);
> > -}
> > -#undef g_mutex_unlock
> > -
> > -static inline gpointer do_g_cond_new(gpointer unused)
> > -{
> > -    return (gpointer) g_cond_new();
> > -}
> > -
> > -static inline void g_cond_init(CompatGCond *cond)
> > -{
> > -    cond->once =3D (GOnce) G_ONCE_INIT;
> > -}
> > -
> > -static inline void g_cond_clear(CompatGCond *cond)
> > -{
> > -    g_assert(cond->once.status !=3D G_ONCE_STATUS_PROGRESS);
> > -    if (cond->once.retval) {
> > -        g_cond_free((GCond *) cond->once.retval);
> > -    }
> > -    cond->once =3D (GOnce) G_ONCE_INIT;
> > -}
> > -
> > -static inline void (g_cond_wait)(CompatGCond *cond, CompatGMutex *mu=
tex)
> > -{
> > -    g_assert(mutex->once.status !=3D G_ONCE_STATUS_PROGRESS);
> > -    g_once(&cond->once, do_g_cond_new, NULL);
> > -    g_cond_wait((GCond *) cond->once.retval, (GMutex *) mutex->once.=
retval);
> > -}
> > -#undef g_cond_wait
> > -
> > -static inline void (g_cond_broadcast)(CompatGCond *cond)
> > -{
> > -    g_once(&cond->once, do_g_cond_new, NULL);
> > -    g_cond_broadcast((GCond *) cond->once.retval);
> > -}
> > -#undef g_cond_broadcast
> > -
> > -static inline void (g_cond_signal)(CompatGCond *cond)
> > -{
> > -    g_once(&cond->once, do_g_cond_new, NULL);
> > -    g_cond_signal((GCond *) cond->once.retval);
> > -}
> > -#undef g_cond_signal
> > -
> > -static inline gboolean (g_cond_timed_wait)(CompatGCond *cond,
> > -                                           CompatGMutex *mutex,
> > -                                           GTimeVal *time)
> > -{
> > -    g_assert(mutex->once.status !=3D G_ONCE_STATUS_PROGRESS);
> > -    g_once(&cond->once, do_g_cond_new, NULL);
> > -    return g_cond_timed_wait((GCond *) cond->once.retval,
> > -                             (GMutex *) mutex->once.retval, time);
> > -}
> > -#undef g_cond_timed_wait
> > -
> > -/* This is not a macro, because it didn't exist until 2.32.  */
> > -static inline gboolean g_cond_wait_until(CompatGCond *cond, CompatGM=
utex *mutex,
> > -                                         gint64 end_time)
> > -{
> > -    GTimeVal time;
> > -
> > -    /* Convert from monotonic to CLOCK_REALTIME.  */
> > -    end_time -=3D g_get_monotonic_time();
> > -    g_get_current_time(&time);
> > -    end_time +=3D time.tv_sec * G_TIME_SPAN_SECOND + time.tv_usec;
> > -
> > -    time.tv_sec =3D end_time / G_TIME_SPAN_SECOND;
> > -    time.tv_usec =3D end_time % G_TIME_SPAN_SECOND;
> > -    return g_cond_timed_wait(cond, mutex, &time);
> > -}
> > -
> > -/* before 2.31 there was no g_thread_new() */
> > -static inline GThread *g_thread_new(const char *name,
> > -                                    GThreadFunc func, gpointer data)
> > -{
> > -    GThread *thread =3D g_thread_create(func, data, TRUE, NULL);
> > -    if (!thread) {
> > -        g_error("creating thread");
> > -    }
> > -    return thread;
> > -}
> > -#else
> > -#define CompatGMutex GMutex
> > -#define CompatGCond GCond
> > -#endif /* glib 2.31 */
> > -
> > -#if !GLIB_CHECK_VERSION(2, 32, 0)
> > -/* Beware, function returns gboolean since 2.39.2, see GLib commit 9=
101915 */
> > -static inline void g_hash_table_add(GHashTable *hash_table, gpointer=
 key)
> > -{
> > -    g_hash_table_replace(hash_table, key, key);
> > -}
> > -#endif
> > -
> > -#ifndef g_assert_true
> > -#define g_assert_true(expr)                                         =
           \
> > -    do {                                                            =
           \
> > -        if (G_LIKELY(expr)) {                                       =
           \
> > -        } else {                                                    =
           \
> > -            g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_=
STRFUNC,   \
> > -                                "'" #expr "' should be TRUE");      =
           \
> > -        }                                                           =
           \
> > -    } while (0)
> > -#endif
> > -
> > -#ifndef g_assert_false
> > -#define g_assert_false(expr)                                        =
           \
> > -    do {                                                            =
           \
> > -        if (G_LIKELY(!(expr))) {                                    =
           \
> > -        } else {                                                    =
           \
> > -            g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_=
STRFUNC,   \
> > -                                "'" #expr "' should be FALSE");     =
           \
> > -        }                                                           =
           \
> > -    } while (0)
> > -#endif
> > -
> > -#ifndef g_assert_null
> > -#define g_assert_null(expr)                                         =
           \
> > -    do {                                                            =
           \
> > -        if (G_LIKELY((expr) =3D=3D NULL)) {                         =
               \
> > -        } else {                                                    =
           \
> > -            g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_=
STRFUNC,   \
> > -                                "'" #expr "' should be NULL");      =
           \
> > -        }                                                           =
           \
> > -    } while (0)
> > -#endif
> > -
> > -#ifndef g_assert_nonnull
> > -#define g_assert_nonnull(expr)                                      =
           \
> > -    do {                                                            =
           \
> > -        if (G_LIKELY((expr) !=3D NULL)) {                           =
             \
> > -        } else {                                                    =
           \
> > -            g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_=
STRFUNC,   \
> > -                                "'" #expr "' should not be NULL");  =
           \
> > -        }                                                           =
           \
> > -    } while (0)
> > -#endif
> > -
> > -#ifndef g_assert_cmpmem
> > -#define g_assert_cmpmem(m1, l1, m2, l2)                             =
           \
> > -    do {                                                            =
           \
> > -        gconstpointer __m1 =3D m1, __m2 =3D m2;                     =
               \
> > -        int __l1 =3D l1, __l2 =3D l2;                               =
               \
> > -        if (__l1 !=3D __l2) {                                       =
             \
> > -            g_assertion_message_cmpnum(                             =
           \
> > -                G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC,        =
           \
> > -                #l1 " (len(" #m1 ")) =3D=3D " #l2 " (len(" #m2 "))",=
 __l1, "=3D=3D",   \
> > -                __l2, 'i');                                         =
           \
> > -        } else if (memcmp(__m1, __m2, __l1) !=3D 0) {               =
             \
> > -            g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_=
STRFUNC,   \
> > -                                "assertion failed (" #m1 " =3D=3D " =
#m2 ")");      \
> > -        }                                                           =
           \
> > -    } while (0)
> > -#endif
> > -
> > -#if !GLIB_CHECK_VERSION(2, 28, 0)
> > -static inline void g_list_free_full(GList *list, GDestroyNotify free=
_func)
> > -{
> > -    GList *l;
> > -
> > -    for (l =3D list; l; l =3D l->next) {
> > -        free_func(l->data);
> > -    }
> > -
> > -    g_list_free(list);
> > -}
> > -
> > -static inline void g_slist_free_full(GSList *list, GDestroyNotify fr=
ee_func)
> > -{
> > -    GSList *l;
> > -
> > -    for (l =3D list; l; l =3D l->next) {
> > -        free_func(l->data);
> > -    }
> > -
> > -    g_slist_free(list);
> > -}
> > -#endif
> > -
> > -#if !GLIB_CHECK_VERSION(2, 26, 0)
> > -static inline void g_source_set_name(GSource *source, const char *na=
me)
> > -{
> > -    /* This is just a debugging aid, so leaving it a no-op */
> > -}
> > -static inline void g_source_set_name_by_id(guint tag, const char *na=
me)
> > -{
> > -    /* This is just a debugging aid, so leaving it a no-op */
> > -}
> > -#endif
> > -
> > -#if !GLIB_CHECK_VERSION(2, 36, 0)
> > -/* Always fail.  This will not include error_report output in the te=
st log,
> > - * sending it instead to stderr.
> > - */
> > -#define g_test_initialized() (0)
> > -#endif
> > -#if !GLIB_CHECK_VERSION(2, 38, 0)
> > -#ifdef CONFIG_HAS_GLIB_SUBPROCESS_TESTS
> > -#error schizophrenic detection of glib subprocess testing
> > -#endif
> > -#define g_test_subprocess() (0)
> > -#endif
> > -
> > -
> > -#if !GLIB_CHECK_VERSION(2, 34, 0)
> > -static inline void
> > -g_test_add_data_func_full(const char *path,
> > -                          gpointer data,
> > -                          gpointer fn,
> > -                          gpointer data_free_func)
> > -{
> > -#if GLIB_CHECK_VERSION(2, 26, 0)
> > -    /* back-compat casts, remove this once we can require new-enough=
 glib */
> > -    g_test_add_vtable(path, 0, data, NULL,
> > -                      (GTestFixtureFunc)fn, (GTestFixtureFunc) data_=
free_func);
> > -#else
> > -    /* back-compat casts, remove this once we can require new-enough=
 glib */
> > -    g_test_add_vtable(path, 0, data, NULL,
> > -                      (void (*)(void)) fn, (void (*)(void)) data_fre=
e_func);
> > -#endif
> > -}
> > -#endif
> > -
> > -
> > -#endif
> > diff --git a/include/glib/glib-compat.h b/include/glib/glib-compat.h
> > new file mode 100644
> > index 0000000..863c8cf
> > --- /dev/null
> > +++ b/include/glib/glib-compat.h
> > @@ -0,0 +1,352 @@
> > +/*
> > + * GLIB Compatibility Functions
> > + *
> > + * Copyright IBM, Corp. 2013
> > + *
> > + * Authors:
> > + *  Anthony Liguori   <aliguori@us.ibm.com>
> > + *  Michael Tokarev   <mjt@tls.msk.ru>
> > + *  Paolo Bonzini     <pbonzini@redhat.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 o=
r later.
> > + * See the COPYING file in the top-level directory.
> > + *
> > + */
> > +
> > +#ifndef QEMU_GLIB_COMPAT_H
> > +#define QEMU_GLIB_COMPAT_H
> > +
> > +#include <glib.h>
> > +
> > +/* GLIB version compatibility flags */
> > +#if !GLIB_CHECK_VERSION(2, 26, 0)
> > +#define G_TIME_SPAN_SECOND              (G_GINT64_CONSTANT(1000000))
> > +#endif
> > +
> > +#if !GLIB_CHECK_VERSION(2, 28, 0)
> > +static inline gint64 qemu_g_get_monotonic_time(void)
> > +{
> > +    /* g_get_monotonic_time() is best-effort so we can use the wall =
clock as a
> > +     * fallback.
> > +     */
> > +
> > +    GTimeVal time;
> > +    g_get_current_time(&time);
> > +
> > +    return time.tv_sec * G_TIME_SPAN_SECOND + time.tv_usec;
> > +}
> > +/* work around distro backports of this interface */
> > +#define g_get_monotonic_time() qemu_g_get_monotonic_time()
> > +#endif
> > +
> > +#if defined(_WIN32) && !GLIB_CHECK_VERSION(2, 50, 0)
> > +/*
> > + * g_poll has a problem on Windows when using
> > + * timeouts < 10ms, so use wrapper.
> > + */
> > +#define g_poll(fds, nfds, timeout) g_poll_fixed(fds, nfds, timeout)
> > +gint g_poll_fixed(GPollFD *fds, guint nfds, gint timeout);
> > +#endif
> > +
> > +#if !GLIB_CHECK_VERSION(2, 30, 0)
> > +/* Not a 100% compatible implementation, but good enough for most
> > + * cases. Placeholders are only supported at the end of the
> > + * template. */
> > +static inline gchar *qemu_g_dir_make_tmp(gchar const *tmpl, GError *=
*error)
> > +{
> > +    gchar *path =3D g_build_filename(g_get_tmp_dir(), tmpl ?: ".XXXX=
XX", NULL);
> > +
> > +    if (mkdtemp(path) !=3D NULL) {
> > +        return path;
> > +    }
> > +    /* Error occurred, clean up. */
> > +    g_set_error(error, G_FILE_ERROR, g_file_error_from_errno(errno),
> > +                "mkdtemp() failed");
> > +    g_free(path);
> > +    return NULL;
> > +}
> > +#define g_dir_make_tmp(tmpl, error) qemu_g_dir_make_tmp(tmpl, error)
> > +#endif /* glib 2.30 */
> > +
> > +#if !GLIB_CHECK_VERSION(2, 31, 0)
> > +/* before glib-2.31, GMutex and GCond was dynamic-only (there was a =
separate
> > + * GStaticMutex, but it didn't work with condition variables).
> > + *
> > + * Our implementation uses GOnce to fake a static implementation tha=
t does
> > + * not require separate initialization.
> > + * We need to rename the types to avoid passing our CompatGMutex/Com=
patGCond
> > + * by mistake to a function that expects GMutex/GCond.  However, for=
 ease
> > + * of use we keep the GLib function names.  GLib uses macros for the
> > + * implementation, we use inline functions instead and undefine the =
macros.
> > + */
> > +
> > +typedef struct CompatGMutex {
> > +    GOnce once;
> > +} CompatGMutex;
> > +
> > +typedef struct CompatGCond {
> > +    GOnce once;
> > +} CompatGCond;
> > +
> > +static inline gpointer do_g_mutex_new(gpointer unused)
> > +{
> > +    return (gpointer) g_mutex_new();
> > +}
> > +
> > +static inline void g_mutex_init(CompatGMutex *mutex)
> > +{
> > +    mutex->once =3D (GOnce) G_ONCE_INIT;
> > +}
> > +
> > +static inline void g_mutex_clear(CompatGMutex *mutex)
> > +{
> > +    g_assert(mutex->once.status !=3D G_ONCE_STATUS_PROGRESS);
> > +    if (mutex->once.retval) {
> > +        g_mutex_free((GMutex *) mutex->once.retval);
> > +    }
> > +    mutex->once =3D (GOnce) G_ONCE_INIT;
> > +}
> > +
> > +static inline void (g_mutex_lock)(CompatGMutex *mutex)
> > +{
> > +    g_once(&mutex->once, do_g_mutex_new, NULL);
> > +    g_mutex_lock((GMutex *) mutex->once.retval);
> > +}
> > +#undef g_mutex_lock
> > +
> > +static inline gboolean (g_mutex_trylock)(CompatGMutex *mutex)
> > +{
> > +    g_once(&mutex->once, do_g_mutex_new, NULL);
> > +    return g_mutex_trylock((GMutex *) mutex->once.retval);
> > +}
> > +#undef g_mutex_trylock
> > +
> > +
> > +static inline void (g_mutex_unlock)(CompatGMutex *mutex)
> > +{
> > +    g_mutex_unlock((GMutex *) mutex->once.retval);
> > +}
> > +#undef g_mutex_unlock
> > +
> > +static inline gpointer do_g_cond_new(gpointer unused)
> > +{
> > +    return (gpointer) g_cond_new();
> > +}
> > +
> > +static inline void g_cond_init(CompatGCond *cond)
> > +{
> > +    cond->once =3D (GOnce) G_ONCE_INIT;
> > +}
> > +
> > +static inline void g_cond_clear(CompatGCond *cond)
> > +{
> > +    g_assert(cond->once.status !=3D G_ONCE_STATUS_PROGRESS);
> > +    if (cond->once.retval) {
> > +        g_cond_free((GCond *) cond->once.retval);
> > +    }
> > +    cond->once =3D (GOnce) G_ONCE_INIT;
> > +}
> > +
> > +static inline void (g_cond_wait)(CompatGCond *cond, CompatGMutex *mu=
tex)
> > +{
> > +    g_assert(mutex->once.status !=3D G_ONCE_STATUS_PROGRESS);
> > +    g_once(&cond->once, do_g_cond_new, NULL);
> > +    g_cond_wait((GCond *) cond->once.retval, (GMutex *) mutex->once.=
retval);
> > +}
> > +#undef g_cond_wait
> > +
> > +static inline void (g_cond_broadcast)(CompatGCond *cond)
> > +{
> > +    g_once(&cond->once, do_g_cond_new, NULL);
> > +    g_cond_broadcast((GCond *) cond->once.retval);
> > +}
> > +#undef g_cond_broadcast
> > +
> > +static inline void (g_cond_signal)(CompatGCond *cond)
> > +{
> > +    g_once(&cond->once, do_g_cond_new, NULL);
> > +    g_cond_signal((GCond *) cond->once.retval);
> > +}
> > +#undef g_cond_signal
> > +
> > +static inline gboolean (g_cond_timed_wait)(CompatGCond *cond,
> > +                                           CompatGMutex *mutex,
> > +                                           GTimeVal *time)
> > +{
> > +    g_assert(mutex->once.status !=3D G_ONCE_STATUS_PROGRESS);
> > +    g_once(&cond->once, do_g_cond_new, NULL);
> > +    return g_cond_timed_wait((GCond *) cond->once.retval,
> > +                             (GMutex *) mutex->once.retval, time);
> > +}
> > +#undef g_cond_timed_wait
> > +
> > +/* This is not a macro, because it didn't exist until 2.32.  */
> > +static inline gboolean g_cond_wait_until(CompatGCond *cond, CompatGM=
utex *mutex,
> > +                                         gint64 end_time)
> > +{
> > +    GTimeVal time;
> > +
> > +    /* Convert from monotonic to CLOCK_REALTIME.  */
> > +    end_time -=3D g_get_monotonic_time();
> > +    g_get_current_time(&time);
> > +    end_time +=3D time.tv_sec * G_TIME_SPAN_SECOND + time.tv_usec;
> > +
> > +    time.tv_sec =3D end_time / G_TIME_SPAN_SECOND;
> > +    time.tv_usec =3D end_time % G_TIME_SPAN_SECOND;
> > +    return g_cond_timed_wait(cond, mutex, &time);
> > +}
> > +
> > +/* before 2.31 there was no g_thread_new() */
> > +static inline GThread *g_thread_new(const char *name,
> > +                                    GThreadFunc func, gpointer data)
> > +{
> > +    GThread *thread =3D g_thread_create(func, data, TRUE, NULL);
> > +    if (!thread) {
> > +        g_error("creating thread");
> > +    }
> > +    return thread;
> > +}
> > +#else
> > +#define CompatGMutex GMutex
> > +#define CompatGCond GCond
> > +#endif /* glib 2.31 */
> > +
> > +#if !GLIB_CHECK_VERSION(2, 32, 0)
> > +/* Beware, function returns gboolean since 2.39.2, see GLib commit 9=
101915 */
> > +static inline void g_hash_table_add(GHashTable *hash_table, gpointer=
 key)
> > +{
> > +    g_hash_table_replace(hash_table, key, key);
> > +}
> > +#endif
> > +
> > +#ifndef g_assert_true
> > +#define g_assert_true(expr)                                         =
           \
> > +    do {                                                            =
           \
> > +        if (G_LIKELY(expr)) {                                       =
           \
> > +        } else {                                                    =
           \
> > +            g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_=
STRFUNC,   \
> > +                                "'" #expr "' should be TRUE");      =
           \
> > +        }                                                           =
           \
> > +    } while (0)
> > +#endif
> > +
> > +#ifndef g_assert_false
> > +#define g_assert_false(expr)                                        =
           \
> > +    do {                                                            =
           \
> > +        if (G_LIKELY(!(expr))) {                                    =
           \
> > +        } else {                                                    =
           \
> > +            g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_=
STRFUNC,   \
> > +                                "'" #expr "' should be FALSE");     =
           \
> > +        }                                                           =
           \
> > +    } while (0)
> > +#endif
> > +
> > +#ifndef g_assert_null
> > +#define g_assert_null(expr)                                         =
           \
> > +    do {                                                            =
           \
> > +        if (G_LIKELY((expr) =3D=3D NULL)) {                         =
               \
> > +        } else {                                                    =
           \
> > +            g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_=
STRFUNC,   \
> > +                                "'" #expr "' should be NULL");      =
           \
> > +        }                                                           =
           \
> > +    } while (0)
> > +#endif
> > +
> > +#ifndef g_assert_nonnull
> > +#define g_assert_nonnull(expr)                                      =
           \
> > +    do {                                                            =
           \
> > +        if (G_LIKELY((expr) !=3D NULL)) {                           =
             \
> > +        } else {                                                    =
           \
> > +            g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_=
STRFUNC,   \
> > +                                "'" #expr "' should not be NULL");  =
           \
> > +        }                                                           =
           \
> > +    } while (0)
> > +#endif
> > +
> > +#ifndef g_assert_cmpmem
> > +#define g_assert_cmpmem(m1, l1, m2, l2)                             =
           \
> > +    do {                                                            =
           \
> > +        gconstpointer __m1 =3D m1, __m2 =3D m2;                     =
               \
> > +        int __l1 =3D l1, __l2 =3D l2;                               =
               \
> > +        if (__l1 !=3D __l2) {                                       =
             \
> > +            g_assertion_message_cmpnum(                             =
           \
> > +                G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC,        =
           \
> > +                #l1 " (len(" #m1 ")) =3D=3D " #l2 " (len(" #m2 "))",=
 __l1, "=3D=3D",   \
> > +                __l2, 'i');                                         =
           \
> > +        } else if (memcmp(__m1, __m2, __l1) !=3D 0) {               =
             \
> > +            g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_=
STRFUNC,   \
> > +                                "assertion failed (" #m1 " =3D=3D " =
#m2 ")");      \
> > +        }                                                           =
           \
> > +    } while (0)
> > +#endif
> > +
> > +#if !GLIB_CHECK_VERSION(2, 28, 0)
> > +static inline void g_list_free_full(GList *list, GDestroyNotify free=
_func)
> > +{
> > +    GList *l;
> > +
> > +    for (l =3D list; l; l =3D l->next) {
> > +        free_func(l->data);
> > +    }
> > +
> > +    g_list_free(list);
> > +}
> > +
> > +static inline void g_slist_free_full(GSList *list, GDestroyNotify fr=
ee_func)
> > +{
> > +    GSList *l;
> > +
> > +    for (l =3D list; l; l =3D l->next) {
> > +        free_func(l->data);
> > +    }
> > +
> > +    g_slist_free(list);
> > +}
> > +#endif
> > +
> > +#if !GLIB_CHECK_VERSION(2, 26, 0)
> > +static inline void g_source_set_name(GSource *source, const char *na=
me)
> > +{
> > +    /* This is just a debugging aid, so leaving it a no-op */
> > +}
> > +static inline void g_source_set_name_by_id(guint tag, const char *na=
me)
> > +{
> > +    /* This is just a debugging aid, so leaving it a no-op */
> > +}
> > +#endif
> > +
> > +#if !GLIB_CHECK_VERSION(2, 36, 0)
> > +/* Always fail.  This will not include error_report output in the te=
st log,
> > + * sending it instead to stderr.
> > + */
> > +#define g_test_initialized() (0)
> > +#endif
> > +#if !GLIB_CHECK_VERSION(2, 38, 0)
> > +#ifdef CONFIG_HAS_GLIB_SUBPROCESS_TESTS
> > +#error schizophrenic detection of glib subprocess testing
> > +#endif
> > +#define g_test_subprocess() (0)
> > +#endif
> > +
> > +
> > +#if !GLIB_CHECK_VERSION(2, 34, 0)
> > +static inline void
> > +g_test_add_data_func_full(const char *path,
> > +                          gpointer data,
> > +                          gpointer fn,
> > +                          gpointer data_free_func)
> > +{
> > +#if GLIB_CHECK_VERSION(2, 26, 0)
> > +    /* back-compat casts, remove this once we can require new-enough=
 glib */
> > +    g_test_add_vtable(path, 0, data, NULL,
> > +                      (GTestFixtureFunc)fn, (GTestFixtureFunc) data_=
free_func);
> > +#else
> > +    /* back-compat casts, remove this once we can require new-enough=
 glib */
> > +    g_test_add_vtable(path, 0, data, NULL,
> > +                      (void (*)(void)) fn, (void (*)(void)) data_fre=
e_func);
> > +#endif
> > +}
> > +#endif
> > +
> > +
> > +#endif
> > diff --git a/include/glib/glib-helper.h b/include/glib/glib-helper.h
> > new file mode 100644
> > index 0000000..db740fb
> > --- /dev/null
> > +++ b/include/glib/glib-helper.h
> > @@ -0,0 +1,30 @@
> > +/*
> > + * Helpers for GLIB
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 o=
r later.
> > + * See the COPYING file in the top-level directory.
> > + *
> > + */
> > +
> > +#ifndef QEMU_GLIB_HELPER_H
> > +#define QEMU_GLIB_HELPER_H
> > +
> > +
> > +#include "glib/glib-compat.h"
> > +
> > +#define GPOINTER_TO_UINT64(a) ((guint64) (a))
> > +
> > +/*
> > + * return 1 in case of a > b, -1 otherwise and 0 if equeal
> > + */
> > +gint g_int_cmp64(gconstpointer a, gconstpointer b,
> > +        gpointer __attribute__((unused)) user_data);
> > +
> > +/*
> > + * return 1 in case of a > b, -1 otherwise and 0 if equeal
> > + */
> > +int g_int_cmp(gconstpointer a, gconstpointer b,
> > +        gpointer __attribute__((unused)) user_data);
> > +
> > +#endif /* QEMU_GLIB_HELPER_H */
> > +
> > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > index 122ff06..36f8a89 100644
> > --- a/include/qemu/osdep.h
> > +++ b/include/qemu/osdep.h
> > @@ -104,7 +104,7 @@ extern int daemon(int, int);
> >  #include "sysemu/os-posix.h"
> >  #endif
> >=20
> > -#include "glib-compat.h"
> > +#include "glib/glib-compat.h"
> >  #include "qemu/typedefs.h"
> >=20
> >  #ifndef O_LARGEFILE
> > diff --git a/linux-user/main.c b/linux-user/main.c
> > index 10a3bb3..7cea6bc 100644
> > --- a/linux-user/main.c
> > +++ b/linux-user/main.c
> > @@ -35,7 +35,7 @@
> >  #include "elf.h"
> >  #include "exec/log.h"
> >  #include "trace/control.h"
> > -#include "glib-compat.h"
> > +#include "glib/glib-compat.h"
> >=20
> >  char *exec_path;
> >=20
> > diff --git a/scripts/clean-includes b/scripts/clean-includes
> > index dd938da..b32b928 100755
> > --- a/scripts/clean-includes
> > +++ b/scripts/clean-includes
> > @@ -123,7 +123,7 @@ for f in "$@"; do
> >        ;;
> >      *include/qemu/osdep.h | \
> >      *include/qemu/compiler.h | \
> > -    *include/glib-compat.h | \
> > +    *include/glib/glib-compat.h | \
> >      *include/sysemu/os-posix.h | \
> >      *include/sysemu/os-win32.h | \
> >      *include/standard-headers/ )
> > diff --git a/util/Makefile.objs b/util/Makefile.objs
> > index c6205eb..0080712 100644
> > --- a/util/Makefile.objs
> > +++ b/util/Makefile.objs
> > @@ -43,3 +43,4 @@ util-obj-y +=3D qdist.o
> >  util-obj-y +=3D qht.o
> >  util-obj-y +=3D range.o
> >  util-obj-y +=3D systemd.o
> > +util-obj-y +=3D glib-helper.o
> > diff --git a/util/glib-helper.c b/util/glib-helper.c
> > new file mode 100644
> > index 0000000..2557009
> > --- /dev/null
> > +++ b/util/glib-helper.c
> > @@ -0,0 +1,29 @@
> > +/*
> > + * Implementation for GLIB helpers
> > + * this file is intented to commulate and later reuse
> > + * additional glib functions
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 o=
r later.
> > + * See the COPYING file in the top-level directory.
> > +
> > + */
> > +
> > +#include "glib/glib-helper.h"
> > +
> > +gint g_int_cmp64(gconstpointer a, gconstpointer b,
> > +        gpointer __attribute__((unused)) user_data)
> > +{
> > +    guint64 ua =3D GPOINTER_TO_UINT64(a);
> > +    guint64 ub =3D GPOINTER_TO_UINT64(b);
> > +    return (ua > ub) - (ua < ub);
> > +}
> > +
> > +/*
> > + * return 1 in case of a > b, -1 otherwise and 0 if equeal
> > + */
> > +gint g_int_cmp(gconstpointer a, gconstpointer b,
> > +        gpointer __attribute__((unused)) user_data)
> > +{
> > +    return g_int_cmp64(a, b, user_data);
> > +}
> > +
> >=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
