Received: from eggs.gnu.org ([2001:4830:134:3::10]:39972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fJIYn-0008Dg-KA
	for qemu-devel@nongnu.org; Thu, 17 May 2018 09:03:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fJIYi-0000Ze-IP
	for qemu-devel@nongnu.org; Thu, 17 May 2018 09:03:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35512 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fJIYi-0000ZX-Dd
	for qemu-devel@nongnu.org; Thu, 17 May 2018 09:03:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D1D9E805A52F
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 13:03:03 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180509041734.14135-1-peterx@redhat.com>
	<20180509041734.14135-5-peterx@redhat.com>
Date: Thu, 17 May 2018 15:03:02 +0200
In-Reply-To: <20180509041734.14135-5-peterx@redhat.com> (Peter Xu's message of
	"Wed, 9 May 2018 12:17:34 +0800")
Message-ID: <87tvr6l9ix.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 4/4] monitor: add lock to protect
 mon_fdsets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> Similar to previous patch, but introduce a new global big lock for
> mon_fdsets.  Take it where needed.
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 64 +++++++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 53 insertions(+), 11 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index ae5bca9d7c..d72b695156 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -262,6 +262,9 @@ typedef struct QMPRequest QMPRequest;
>  /* Protects mon_list, monitor_event_state.  */
>  static QemuMutex monitor_lock;
>  
> +/* Protects mon_fdsets */
> +static QemuMutex mon_fdsets_lock;
> +
>  static QTAILQ_HEAD(mon_list, Monitor) mon_list;
>  static QLIST_HEAD(mon_fdsets, MonFdset) mon_fdsets;
>  static int mon_refcount;
> @@ -278,6 +281,16 @@ static QEMUClockType event_clock_type = QEMU_CLOCK_REALTIME;
>  static void monitor_command_cb(void *opaque, const char *cmdline,
>                                 void *readline_opaque);
>  
> +/*
> + * This lock can be used very early, even during param parsing.
> + * Meanwhile it can also be used even at the end of main.  Let's keep
> + * it initialized for the whole lifecycle of QEMU.
> + */
> +static void __attribute__((constructor)) mon_fdsets_lock_init(void)
> +{
> +    qemu_mutex_init(&mon_fdsets_lock);
> +}
> +
>  /**
>   * Is @mon a QMP monitor?
>   */
> @@ -2307,9 +2320,11 @@ static void monitor_fdsets_cleanup(void)
>      MonFdset *mon_fdset;
>      MonFdset *mon_fdset_next;
>  
> +    qemu_mutex_lock(&mon_fdsets_lock);
>      QLIST_FOREACH_SAFE(mon_fdset, &mon_fdsets, next, mon_fdset_next) {
>          monitor_fdset_cleanup(mon_fdset);
>      }
> +    qemu_mutex_unlock(&mon_fdsets_lock);
>  }
>  
>  AddfdInfo *qmp_add_fd(bool has_fdset_id, int64_t fdset_id, bool has_opaque,
> @@ -2344,6 +2359,7 @@ void qmp_remove_fd(int64_t fdset_id, bool has_fd, int64_t fd, Error **errp)
>      MonFdsetFd *mon_fdset_fd;
>      char fd_str[60];
>  
> +    qemu_mutex_lock(&mon_fdsets_lock);
>      QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
>          if (mon_fdset->id != fdset_id) {
>              continue;
> @@ -2363,10 +2379,12 @@ void qmp_remove_fd(int64_t fdset_id, bool has_fd, int64_t fd, Error **errp)
>              goto error;
>          }
>          monitor_fdset_cleanup(mon_fdset);
> +        qemu_mutex_unlock(&mon_fdsets_lock);
>          return;
>      }
>  
>  error:
> +    qemu_mutex_unlock(&mon_fdsets_lock);
>      if (has_fd) {
>          snprintf(fd_str, sizeof(fd_str), "fdset-id:%" PRId64 ", fd:%" PRId64,
>                   fdset_id, fd);
> @@ -2382,6 +2400,7 @@ FdsetInfoList *qmp_query_fdsets(Error **errp)
>      MonFdsetFd *mon_fdset_fd;
>      FdsetInfoList *fdset_list = NULL;
>  
> +    qemu_mutex_lock(&mon_fdsets_lock);
>      QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
>          FdsetInfoList *fdset_info = g_malloc0(sizeof(*fdset_info));
>          FdsetFdInfoList *fdsetfd_list = NULL;
> @@ -2411,6 +2430,7 @@ FdsetInfoList *qmp_query_fdsets(Error **errp)
>          fdset_info->next = fdset_list;
>          fdset_list = fdset_info;
>      }
> +    qemu_mutex_unlock(&mon_fdsets_lock);
>  
>      return fdset_list;
>  }
> @@ -2423,6 +2443,7 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
>      MonFdsetFd *mon_fdset_fd;
>      AddfdInfo *fdinfo;
>  
> +    qemu_mutex_lock(&mon_fdsets_lock);
>      if (has_fdset_id) {
>          QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
>              /* Break if match found or match impossible due to ordering by ID */
> @@ -2443,6 +2464,7 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
>              if (fdset_id < 0) {
>                  error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "fdset-id",
>                             "a non-negative value");
> +                qemu_mutex_unlock(&mon_fdsets_lock);
>                  return NULL;
>              }
>              /* Use specified fdset ID */
> @@ -2493,6 +2515,7 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
>      fdinfo->fdset_id = mon_fdset->id;
>      fdinfo->fd = mon_fdset_fd->fd;
>  
> +    qemu_mutex_unlock(&mon_fdsets_lock);
>      return fdinfo;
>  }
>  
> @@ -2502,7 +2525,9 @@ int monitor_fdset_get_fd(int64_t fdset_id, int flags)
>      MonFdset *mon_fdset;
>      MonFdsetFd *mon_fdset_fd;
>      int mon_fd_flags;
> +    int ret = -1;

Suggest not to initialize ret, and instead ret = -1 on both failure
paths.

>  
> +    qemu_mutex_lock(&mon_fdsets_lock);
>      QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
>          if (mon_fdset->id != fdset_id) {
>              continue;
> @@ -2510,49 +2535,62 @@ int monitor_fdset_get_fd(int64_t fdset_id, int flags)
>          QLIST_FOREACH(mon_fdset_fd, &mon_fdset->fds, next) {
>              mon_fd_flags = fcntl(mon_fdset_fd->fd, F_GETFL);
>              if (mon_fd_flags == -1) {
> -                return -1;
> +                goto out;

Preexisting: we fail without setting errno.  Smells buggy.

Can we avoid setting errno and return a negative errno code instead?

>              }
>  
>              if ((flags & O_ACCMODE) == (mon_fd_flags & O_ACCMODE)) {
> -                return mon_fdset_fd->fd;
> +                ret = mon_fdset_fd->fd;
> +                goto out;
>              }
>          }
>          errno = EACCES;
> -        return -1;
> +        break;
>      }
> -#endif
> -
> +out:
> +    qemu_mutex_unlock(&mon_fdsets_lock);
> +    return ret;
> +#else

#ifndef _WIN32 ... #endif becomes #ifndef _WIN32 ... #else ... #endif.
I hate negative conditionals with else.  Mind to swap?

>      errno = ENOENT;
>      return -1;
> +#endif
>  }
>  
>  int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd)
>  {
>      MonFdset *mon_fdset;
>      MonFdsetFd *mon_fdset_fd_dup;
> +    int ret = -1;

Dead initializer, please remove.

>  
> +    qemu_mutex_lock(&mon_fdsets_lock);
>      QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
>          if (mon_fdset->id != fdset_id) {
>              continue;
>          }
>          QLIST_FOREACH(mon_fdset_fd_dup, &mon_fdset->dup_fds, next) {
>              if (mon_fdset_fd_dup->fd == dup_fd) {
> -                return -1;
> +                ret = -1;
> +                goto out;
>              }
>          }
>          mon_fdset_fd_dup = g_malloc0(sizeof(*mon_fdset_fd_dup));
>          mon_fdset_fd_dup->fd = dup_fd;
>          QLIST_INSERT_HEAD(&mon_fdset->dup_fds, mon_fdset_fd_dup, next);
> -        return 0;
> +        ret = 0;
> +        break;
>      }
> -    return -1;
> +
> +out:
> +    qemu_mutex_unlock(&mon_fdsets_lock);
> +    return ret;
>  }
>  
>  static int monitor_fdset_dup_fd_find_remove(int dup_fd, bool remove)
>  {
>      MonFdset *mon_fdset;
>      MonFdsetFd *mon_fdset_fd_dup;
> +    int ret = -1;

Likewise.

>  
> +    qemu_mutex_lock(&mon_fdsets_lock);
>      QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
>          QLIST_FOREACH(mon_fdset_fd_dup, &mon_fdset->dup_fds, next) {
>              if (mon_fdset_fd_dup->fd == dup_fd) {
> @@ -2561,14 +2599,18 @@ static int monitor_fdset_dup_fd_find_remove(int dup_fd, bool remove)
>                      if (QLIST_EMPTY(&mon_fdset->dup_fds)) {
>                          monitor_fdset_cleanup(mon_fdset);
>                      }
> -                    return -1;
> +                    ret = -1;
> +                    goto out;
>                  } else {
> -                    return mon_fdset->id;
> +                    ret = mon_fdset->id;
> +                    goto out;
>                  }
>              }
>          }
>      }
> -    return -1;
> +out:
> +    qemu_mutex_unlock(&mon_fdsets_lock);
> +    return ret;
>  }
>  
>  int monitor_fdset_dup_fd_find(int dup_fd)
