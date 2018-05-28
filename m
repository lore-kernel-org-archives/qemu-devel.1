Received: from eggs.gnu.org ([2001:4830:134:3::10]:33345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fNCEj-00024k-GB
	for qemu-devel@nongnu.org; Mon, 28 May 2018 03:06:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fNCEf-0003bW-Dl
	for qemu-devel@nongnu.org; Mon, 28 May 2018 03:06:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38482 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fNCEf-0003au-7O
	for qemu-devel@nongnu.org; Mon, 28 May 2018 03:06:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA3C640201A0
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 07:06:28 +0000 (UTC)
Date: Mon, 28 May 2018 15:06:21 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180528070621.GE2584@xz-mi>
References: <20180524043952.11245-1-peterx@redhat.com>
	<20180524043952.11245-5-peterx@redhat.com>
	<87sh6h77d0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sh6h77d0.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v7 4/4] monitor: add lock to protect
 mon_fdsets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Thu, May 24, 2018 at 11:03:55AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Similar to previous patch, but introduce a new global big lock for
> > mon_fdsets.  Take it where needed.
> 
> The previous patch is "monitor: more comments on lock-free
> fleids/funcs".  Sure you mean that one?

No... I'll remove that sentence directly:

  "Introduce a new global big lock for mon_fdsets.  Take it where needed."

> >
> > The monitor_fdset_get_fd() handling is a bit tricky: now we need to call
> > qemu_mutex_unlock() which might pollute errno, so we need to make sure
> > the correct errno be passed up to the callers.  To make things simpler,
> > we let monitor_fdset_get_fd() return the -errno directly when error
> > happens, then in qemu_open() we translate it back into errno.
> 
> Suggest s/translate/move/.

Okay.

> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  monitor.c    | 70 +++++++++++++++++++++++++++++++++++++++++-----------
> >  util/osdep.c |  3 ++-
> >  2 files changed, 58 insertions(+), 15 deletions(-)
> >
> > diff --git a/monitor.c b/monitor.c
> > index f01589f945..6266ff65c4 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -271,6 +271,9 @@ typedef struct QMPRequest QMPRequest;
> >  /* Protects mon_list, monitor_event_state.  */
> 
> Not this patch's problem: there is no monitor_event_state.  Screwed up
> in commit d622cb5879c.  I guess it's monitor_qapi_event_state.

I'll append another patch to do that, and move these fields together.

> 
> >  static QemuMutex monitor_lock;
> >  
> > +/* Protects mon_fdsets */
> > +static QemuMutex mon_fdsets_lock;
> > +
> >  static QTAILQ_HEAD(mon_list, Monitor) mon_list;
> >  static QLIST_HEAD(mon_fdsets, MonFdset) mon_fdsets;
> >  static int mon_refcount;
> 
> Suggest to move mon_fdsets next to the lock protecting it.

Will do.

> 
> > @@ -287,6 +290,16 @@ static QEMUClockType event_clock_type = QEMU_CLOCK_REALTIME;
> >  static void monitor_command_cb(void *opaque, const char *cmdline,
> >                                 void *readline_opaque);
> >  
> > +/*
> > + * This lock can be used very early, even during param parsing.
> 
> Do you mean CLI parsing?

Yes, will s/param/CLI/.

> 
> > + * Meanwhile it can also be used even at the end of main.  Let's keep
> > + * it initialized for the whole lifecycle of QEMU.
> > + */
> 
> Awkward question, since our main() is such a tangled mess, but here goes
> anyway...  The existing place to initialize monitor.c's globals is
> monitor_init_globals().  But that one runs too late, I guess:
> parse_add_fd() runs earlier, and calls monitor_fdset_add_fd().  Unclean
> even without this lock; no module should be used before its
> initialization function runs.  Sure we can't run monitor_init_globals()
> sufficiently early?

Please see the comment for monitor_init_globals():

    /*
     * Note: qtest_enabled() (which is used in monitor_qapi_event_init())
     * depends on configure_accelerator() above.
     */
    monitor_init_globals();

So I guess it won't work to directly move it earlier.  The init
dependency of QEMU is really complicated.  I'll be fine now that we
mark totally independent init functions (like this one, which is a
mutex init only) as constructor, then we can save some time on
ordering issue.

> 
> > +static void __attribute__((constructor)) mon_fdsets_lock_init(void)
> > +{
> > +    qemu_mutex_init(&mon_fdsets_lock);
> > +}
> > +
> >  /**
> >   * Is @mon a QMP monitor?
> >   */
> > @@ -2316,9 +2329,11 @@ static void monitor_fdsets_cleanup(void)
> >      MonFdset *mon_fdset;
> >      MonFdset *mon_fdset_next;
> >  
> > +    qemu_mutex_lock(&mon_fdsets_lock);
> >      QLIST_FOREACH_SAFE(mon_fdset, &mon_fdsets, next, mon_fdset_next) {
> >          monitor_fdset_cleanup(mon_fdset);
> >      }
> > +    qemu_mutex_unlock(&mon_fdsets_lock);
> >  }
> >  
> >  AddfdInfo *qmp_add_fd(bool has_fdset_id, int64_t fdset_id, bool has_opaque,
> > @@ -2353,6 +2368,7 @@ void qmp_remove_fd(int64_t fdset_id, bool has_fd, int64_t fd, Error **errp)
> >      MonFdsetFd *mon_fdset_fd;
> >      char fd_str[60];
> >  
> > +    qemu_mutex_lock(&mon_fdsets_lock);
> >      QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
> >          if (mon_fdset->id != fdset_id) {
> >              continue;
> > @@ -2372,10 +2388,12 @@ void qmp_remove_fd(int64_t fdset_id, bool has_fd, int64_t fd, Error **errp)
> >              goto error;
> >          }
> >          monitor_fdset_cleanup(mon_fdset);
> > +        qemu_mutex_unlock(&mon_fdsets_lock);
> >          return;
> >      }
> >  
> >  error:
> > +    qemu_mutex_unlock(&mon_fdsets_lock);
> >      if (has_fd) {
> >          snprintf(fd_str, sizeof(fd_str), "fdset-id:%" PRId64 ", fd:%" PRId64,
> >                   fdset_id, fd);
> > @@ -2391,6 +2409,7 @@ FdsetInfoList *qmp_query_fdsets(Error **errp)
> >      MonFdsetFd *mon_fdset_fd;
> >      FdsetInfoList *fdset_list = NULL;
> >  
> > +    qemu_mutex_lock(&mon_fdsets_lock);
> >      QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
> >          FdsetInfoList *fdset_info = g_malloc0(sizeof(*fdset_info));
> >          FdsetFdInfoList *fdsetfd_list = NULL;
> > @@ -2420,6 +2439,7 @@ FdsetInfoList *qmp_query_fdsets(Error **errp)
> >          fdset_info->next = fdset_list;
> >          fdset_list = fdset_info;
> >      }
> > +    qemu_mutex_unlock(&mon_fdsets_lock);
> >  
> >      return fdset_list;
> >  }
> > @@ -2432,6 +2452,7 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
> >      MonFdsetFd *mon_fdset_fd;
> >      AddfdInfo *fdinfo;
> >  
> > +    qemu_mutex_lock(&mon_fdsets_lock);
> >      if (has_fdset_id) {
> >          QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
> >              /* Break if match found or match impossible due to ordering by ID */
> > @@ -2452,6 +2473,7 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
> >              if (fdset_id < 0) {
> >                  error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "fdset-id",
> >                             "a non-negative value");
> > +                qemu_mutex_unlock(&mon_fdsets_lock);
> >                  return NULL;
> >              }
> >              /* Use specified fdset ID */
> > @@ -2502,16 +2524,21 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
> >      fdinfo->fdset_id = mon_fdset->id;
> >      fdinfo->fd = mon_fdset_fd->fd;
> >  
> > +    qemu_mutex_unlock(&mon_fdsets_lock);
> >      return fdinfo;
> >  }
> >  
> >  int monitor_fdset_get_fd(int64_t fdset_id, int flags)
> >  {
> > -#ifndef _WIN32
> > +#ifdef _WIN32
> > +    return -ENOENT;
> 
> ENOENT feels odd, but I guess makes some sense since there is no way to
> add entries.
> 
> > +#else
> >      MonFdset *mon_fdset;
> >      MonFdsetFd *mon_fdset_fd;
> >      int mon_fd_flags;
> > +    int ret = -ENOENT;
> >  
> > +    qemu_mutex_lock(&mon_fdsets_lock);
> >      QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
> >          if (mon_fdset->id != fdset_id) {
> >              continue;
> > @@ -2519,49 +2546,60 @@ int monitor_fdset_get_fd(int64_t fdset_id, int flags)
> >          QLIST_FOREACH(mon_fdset_fd, &mon_fdset->fds, next) {
> >              mon_fd_flags = fcntl(mon_fdset_fd->fd, F_GETFL);
> >              if (mon_fd_flags == -1) {
> > -                return -1;
> > +                ret = -errno;
> > +                goto out;
> >              }
> >  
> >              if ((flags & O_ACCMODE) == (mon_fd_flags & O_ACCMODE)) {
> > -                return mon_fdset_fd->fd;
> > +                ret = mon_fdset_fd->fd;
> > +                goto out;
> >              }
> >          }
> > -        errno = EACCES;
> > -        return -1;
> > +        ret = -EACCES;
> > +        break;
> >      }
> 
> I still think
> 
>            ret = -EACCES;
>            goto out;
>        }
>        ret = -ENOENT;
> 
>    out:
> 
> would be clearer.

I'll take your advice.

> 
> > +out:
> > +    qemu_mutex_unlock(&mon_fdsets_lock);
> > +    return ret;
> >  #endif
> > -
> > -    errno = ENOENT;
> > -    return -1;
> >  }
> >  
> >  int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd)
> >  {
> >      MonFdset *mon_fdset;
> >      MonFdsetFd *mon_fdset_fd_dup;
> > +    int ret = -1;
> >  
> > +    qemu_mutex_lock(&mon_fdsets_lock);
> >      QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
> >          if (mon_fdset->id != fdset_id) {
> >              continue;
> >          }
> >          QLIST_FOREACH(mon_fdset_fd_dup, &mon_fdset->dup_fds, next) {
> >              if (mon_fdset_fd_dup->fd == dup_fd) {
> > -                return -1;
> > +                ret = -1;
> 
> Dead assignment.  Alternatively,
> 
> > +                goto out;
> >              }
> >          }
> >          mon_fdset_fd_dup = g_malloc0(sizeof(*mon_fdset_fd_dup));
> >          mon_fdset_fd_dup->fd = dup_fd;
> >          QLIST_INSERT_HEAD(&mon_fdset->dup_fds, mon_fdset_fd_dup, next);
> > -        return 0;
> > +        ret = 0;
> > +        break;
> >      }
> 
> ... add
> 
>        ret = -1;
> 
> here, and drop the initializer.  Your choice.

The variable "ret" brought some trouble, so I decided to remove it
directly. :)

@@ -2538,20 +2569,25 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd)
     MonFdset *mon_fdset;
     MonFdsetFd *mon_fdset_fd_dup;

+    qemu_mutex_lock(&mon_fdsets_lock);
     QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
         if (mon_fdset->id != fdset_id) {
             continue;
         }
         QLIST_FOREACH(mon_fdset_fd_dup, &mon_fdset->dup_fds, next) {
             if (mon_fdset_fd_dup->fd == dup_fd) {
-                return -1;
+                goto err;
             }
         }
         mon_fdset_fd_dup = g_malloc0(sizeof(*mon_fdset_fd_dup));
         mon_fdset_fd_dup->fd = dup_fd;
         QLIST_INSERT_HEAD(&mon_fdset->dup_fds, mon_fdset_fd_dup, next);
+        qemu_mutex_unlock(&mon_fdsets_lock);
         return 0;
     }
+
+err:
+    qemu_mutex_unlock(&mon_fdsets_lock);
     return -1;
 }

> 
> > -    return -1;
> > +
> > +out:
> > +    qemu_mutex_unlock(&mon_fdsets_lock);
> > +    return ret;
> >  }
> >  
> >  static int monitor_fdset_dup_fd_find_remove(int dup_fd, bool remove)
> >  {
> >      MonFdset *mon_fdset;
> >      MonFdsetFd *mon_fdset_fd_dup;
> > +    int ret = -1;
> >  
> > +    qemu_mutex_lock(&mon_fdsets_lock);
> >      QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
> >          QLIST_FOREACH(mon_fdset_fd_dup, &mon_fdset->dup_fds, next) {
> >              if (mon_fdset_fd_dup->fd == dup_fd) {
> > @@ -2570,14 +2608,18 @@ static int monitor_fdset_dup_fd_find_remove(int dup_fd, bool remove)
> >                      if (QLIST_EMPTY(&mon_fdset->dup_fds)) {
> >                          monitor_fdset_cleanup(mon_fdset);
> >                      }
> > -                    return -1;
> > +                    ret = -1;
> > +                    goto out;
> >                  } else {
> > -                    return mon_fdset->id;
> > +                    ret = mon_fdset->id;
> > +                    goto out;
> >                  }
> >              }
> >          }
> >      }
> > -    return -1;
> > +out:
> > +    qemu_mutex_unlock(&mon_fdsets_lock);
> > +    return ret;
> >  }
> 
> Likewise.

I'll do similar thing to drop "ret":

@@ -2560,6 +2596,7 @@ static int monitor_fdset_dup_fd_find_remove(int dup_fd, bool remove)
     MonFdset *mon_fdset;
     MonFdsetFd *mon_fdset_fd_dup;

+    qemu_mutex_lock(&mon_fdsets_lock);
     QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
         QLIST_FOREACH(mon_fdset_fd_dup, &mon_fdset->dup_fds, next) {
             if (mon_fdset_fd_dup->fd == dup_fd) {
@@ -2568,13 +2605,17 @@ static int monitor_fdset_dup_fd_find_remove(int dup_fd, bool remove)
                     if (QLIST_EMPTY(&mon_fdset->dup_fds)) {
                         monitor_fdset_cleanup(mon_fdset);
                     }
-                    return -1;
+                    goto err;
                 } else {
+                    qemu_mutex_unlock(&mon_fdsets_lock);
                     return mon_fdset->id;
                 }
             }
         }
     }
+
+err:
+    qemu_mutex_unlock(&mon_fdsets_lock);
     return -1;
 }

Thanks,

-- 
Peter Xu
