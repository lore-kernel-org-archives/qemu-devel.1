Received: from eggs.gnu.org ([2001:4830:134:3::10]:47409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fJeTW-0001nC-Od
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fJeTV-0005zG-Gq
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:27:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49978 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fJeTV-0005yz-BE
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:27:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 01592401EF14
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 12:27:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180509041734.14135-1-peterx@redhat.com>
	<20180509041734.14135-5-peterx@redhat.com>
	<87tvr6l9ix.fsf@dusky.pond.sub.org> <20180518105311.GP2569@xz-mi>
Date: Fri, 18 May 2018 14:27:00 +0200
In-Reply-To: <20180518105311.GP2569@xz-mi> (Peter Xu's message of "Fri, 18 May
	2018 18:53:11 +0800")
Message-ID: <877eo1f8tn.fsf@dusky.pond.sub.org>
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Dr .
	David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> On Thu, May 17, 2018 at 03:03:02PM +0200, Markus Armbruster wrote:
>
> [...]
>
>> > @@ -2502,7 +2525,9 @@ int monitor_fdset_get_fd(int64_t fdset_id, int flags)
>> >      MonFdset *mon_fdset;
>> >      MonFdsetFd *mon_fdset_fd;
>> >      int mon_fd_flags;
>> > +    int ret = -1;
>> 
>> Suggest not to initialize ret, and instead ret = -1 on both failure
>> paths.
>
> [1]
>
> But there is a third hidden failure path that we failed to find the fd
> specified?  In that case we still need that initial value.

You're right.  However, that failure path could be made explicit easily:

        QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
            [got out on error and on finding the right one...]
        }
        ret = -1;
        errno = ENOENT;

    out:
        qemu_mutex_unlock(&mon_fdsets_lock);
        return ret;

I find this clearer.  Your choice.

> But I didn't really notice that this function is returning error with
> -1 paired with errno.  So instead of set -1 here I may need to
> initialize it to -ENOENT, and I can convert it back to errno when
> return.  Please see below.
>
>> 
>> >  
>> > +    qemu_mutex_lock(&mon_fdsets_lock);
>> >      QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
>> >          if (mon_fdset->id != fdset_id) {
>> >              continue;
>> > @@ -2510,49 +2535,62 @@ int monitor_fdset_get_fd(int64_t fdset_id, int flags)
>> >          QLIST_FOREACH(mon_fdset_fd, &mon_fdset->fds, next) {
>> >              mon_fd_flags = fcntl(mon_fdset_fd->fd, F_GETFL);
>> >              if (mon_fd_flags == -1) {
>> > -                return -1;
>> > +                goto out;
>> 
>> Preexisting: we fail without setting errno.  Smells buggy.
>
> Indeed.  Here I possibly need to set "ret = -errno" since at [2] below
> the errno might be polluted by the mutex unlocking operation.

Good point.

>> Can we avoid setting errno and return a negative errno code instead?
>
> Yes that'll be nice, but it's getting out of the scope of this
> patchset.  So I'll try to avoid touching that.  I mean qemu_open() and
> its callers.

I'd change just monitor_fdset_get_fd(), and have its only caller
qemu_open() do

        fd = monitor_fdset_get_fd(fdset_id, flags);
        if (fd < 0) {
            errno = -fd;
            return -1;
        }

>> >              }
>> >  
>> >              if ((flags & O_ACCMODE) == (mon_fd_flags & O_ACCMODE)) {
>> > -                return mon_fdset_fd->fd;
>> > +                ret = mon_fdset_fd->fd;
>> > +                goto out;
>> >              }
>> >          }
>> >          errno = EACCES;
>> > -        return -1;
>> > +        break;
>> >      }
>> > -#endif
>> > -
>> > +out:
>> > +    qemu_mutex_unlock(&mon_fdsets_lock);
>
> [2]
>
>> > +    return ret;
>
> So in my next post I'll make sure I return -1 when error happens, and
> errno should contain the correct (positive) error.
>
>> > +#else
>> 
>> #ifndef _WIN32 ... #endif becomes #ifndef _WIN32 ... #else ... #endif.
>> I hate negative conditionals with else.  Mind to swap?
>
> Sure I can.
>
>> 
>> >      errno = ENOENT;
>> >      return -1;
>> > +#endif
>> >  }
>> >  
>> >  int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd)
>> >  {
>> >      MonFdset *mon_fdset;
>> >      MonFdsetFd *mon_fdset_fd_dup;
>> > +    int ret = -1;
>> 
>> Dead initializer, please remove.
>
> IMHO it's the same as above [1], so we still need that, right?

You're right.

>> >  
>> > +    qemu_mutex_lock(&mon_fdsets_lock);
>> >      QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
>> >          if (mon_fdset->id != fdset_id) {
>> >              continue;
>> >          }
>> >          QLIST_FOREACH(mon_fdset_fd_dup, &mon_fdset->dup_fds, next) {
>> >              if (mon_fdset_fd_dup->fd == dup_fd) {
>> > -                return -1;
>> > +                ret = -1;
>> > +                goto out;
>> >              }
>> >          }
>> >          mon_fdset_fd_dup = g_malloc0(sizeof(*mon_fdset_fd_dup));
>> >          mon_fdset_fd_dup->fd = dup_fd;
>> >          QLIST_INSERT_HEAD(&mon_fdset->dup_fds, mon_fdset_fd_dup, next);
>> > -        return 0;
>> > +        ret = 0;
>> > +        break;
>> >      }
>> > -    return -1;
>> > +
>> > +out:
>> > +    qemu_mutex_unlock(&mon_fdsets_lock);
>> > +    return ret;
>> >  }
>> >  
>> >  static int monitor_fdset_dup_fd_find_remove(int dup_fd, bool remove)
>> >  {
>> >      MonFdset *mon_fdset;
>> >      MonFdsetFd *mon_fdset_fd_dup;
>> > +    int ret = -1;
>> 
>> Likewise.
>
> Same as [1]?

Right again.
