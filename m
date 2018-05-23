Received: from eggs.gnu.org ([2001:4830:134:3::10]:45428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fLPVN-0007de-J1
	for qemu-devel@nongnu.org; Wed, 23 May 2018 04:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fLPVJ-0004CG-L3
	for qemu-devel@nongnu.org; Wed, 23 May 2018 04:52:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56854 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fLPVJ-0004C4-Hh
	for qemu-devel@nongnu.org; Wed, 23 May 2018 04:52:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1108F406E897
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 08:52:17 +0000 (UTC)
Date: Wed, 23 May 2018 16:52:08 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180523085208.GB2540@xz-mi>
References: <20180509041734.14135-1-peterx@redhat.com>
	<20180509041734.14135-5-peterx@redhat.com>
	<87tvr6l9ix.fsf@dusky.pond.sub.org> <20180518105311.GP2569@xz-mi>
	<877eo1f8tn.fsf@dusky.pond.sub.org> <20180521051846.GC27506@xz-mi>
	<87fu2iix53.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87fu2iix53.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, May 23, 2018 at 10:39:20AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Fri, May 18, 2018 at 02:27:00PM +0200, Markus Armbruster wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Thu, May 17, 2018 at 03:03:02PM +0200, Markus Armbruster wrote:
> >> >
> >> > [...]
> >> >
> >> >> > @@ -2502,7 +2525,9 @@ int monitor_fdset_get_fd(int64_t fdset_id, int flags)
> >> >> >      MonFdset *mon_fdset;
> >> >> >      MonFdsetFd *mon_fdset_fd;
> >> >> >      int mon_fd_flags;
> >> >> > +    int ret = -1;
> >> >> 
> >> >> Suggest not to initialize ret, and instead ret = -1 on both failure
> >> >> paths.
> >> >
> >> > [1]
> >> >
> >> > But there is a third hidden failure path that we failed to find the fd
> >> > specified?  In that case we still need that initial value.
> >> 
> >> You're right.  However, that failure path could be made explicit easily:
> >> 
> >>         QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
> >>             [got out on error and on finding the right one...]
> >>         }
> >>         ret = -1;
> >>         errno = ENOENT;
> >> 
> >>     out:
> >>         qemu_mutex_unlock(&mon_fdsets_lock);
> >>         return ret;
> >> 
> >> I find this clearer.  Your choice.
> >
> > Yes this works too.  Considering that I just posted v6, I'll
> > temporarily just keep the old way.
> 
> Your v6 raced with my review of v5.  Do you intend to post v7?  If not,
> I need to figure out what I can and want to do to v6 on commit to my
> tree.

I can repost v7 after we finish the discussion in the other thread:

  [PATCH v5 3/4] monitor: more comments on lock-free fleids/funcs
  Message-ID: <87muwqixla.fsf@dusky.pond.sub.org>

I think there is a comment to be refined, meanwhile I can at least
pick up the qemu_open() suggestion too.

Regards,

-- 
Peter Xu
