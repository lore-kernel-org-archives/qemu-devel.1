Received: from eggs.gnu.org ([2001:4830:134:3::10]:52315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dfHcQ-000055-QH
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 23:25:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dfHcL-0002yP-Mm
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 23:25:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dfHcL-0002x3-EB
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 23:25:09 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DCCB57F41C
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 03:25:07 +0000 (UTC)
Date: Wed, 9 Aug 2017 11:25:02 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170809032502.GE13486@pxdev.xzpeter.org>
References: <1502175607-9531-1-git-send-email-peterx@redhat.com>
	<3f0e8fe6-babd-df82-c690-de0f1ffdd460@redhat.com>
	<20170808074915.GB13486@pxdev.xzpeter.org>
	<6a4a3fd1-51d2-3bcb-a343-9acb87a19d99@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a4a3fd1-51d2-3bcb-a343-9acb87a19d99@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] rcu: init globals only once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Tue, Aug 08, 2017 at 09:09:23AM -0500, Eric Blake wrote:
> On 08/08/2017 02:49 AM, Peter Xu wrote:
> >> This doesn't work for error-checking mutexes: rcu_init_child has a
> >> different PID than the parent, so the mutexes aren't unlocked.  It's
> >> also true that right now we don't use error-checking mutexes (commit
> >> 24fa90499f, "qemu-thread: do not use PTHREAD_MUTEX_ERRORCHECK",
> >> 2015-03-10); however, that's also a bit sad.
> >>
> >> The reason for the undefined behavior is probably that some operating
> >> systems allocate memory in pthread_mutex_init, and initializing twice
> >> causes a memory leak.  One such operating system is OpenBSD. :(
> > 
> > Good to know. :)
> > 
> > I thought pthread_atfork() was designed to solve such a locking
> > problem (in child hanlder, we unlock all the held locks).
> 
> What's also sad is that POSIX says that pthread_atfork() is rather
> useless - there's no way it can be reliably used to do everything that
> everyone wants (and I think this case of error-checking mutexes is just
> ONE of those reasons).
> 
> > If
> > PTHREAD_MUTEX_ERRORCHECK cannot coop well with it, not sure whether
> > that means we should just avoid using PTHREAD_MUTEX_ERRORCHECK in such
> > a use case (but we should be able to use the error checks in other
> > mutexes that do not need extra fork handling)?
> > 
> > Another idea is: can we just destroy the mutex first then re-init it
> > in subprocess? A quick glance in libpthread code shows that at least
> > pthread_mutex_destroy() won't check PTHREAD_MUTEX_ERRORCHECK.
> > 
> > Thanks,
> > 
> >>
> >> Eric, you chimed in on the patch that became commit 24fa90499f, what do
> >> you suggest?
> 
> If, after forking, you can successfully destroy the mutex to then
> reinitialize it (even though you can't unlock it), then that sounds as
> good as anything I can come up with.
> 
> An alternative approach might be to add a new mutex that anyone obtains
> just before forking; as long as you hold that mutex, you can then
> release any other mutex, fork, and then reobtain in the parent - but it
> still becomes tricky bookkeeping to know which locks need to be dropped
> and reobtained, and I worry that gating fork performance with such a
> heavy lock will have noticeable slowdowns.

It sounds like a MBQL (Much Bigger Qemu Lock :-).

I am thinking whether we can simplify this. After all, we have
existing assumptions:

1. for "-daemonize", we need the pthread_atfork() thing to make sure
   RCU works well even in the daemonized process

2. for all the rest of the fork cases, we assume that it will always
   be a quick exec() afterward, so need to maintain memory consistency

Then, why not we just initialize RCU after os_daemonize()? IIUC, we
can throw pthread_atfork() away then (considering that even it is not
suggested to use "officially").

I guess it also depends on whether we'll need RCU before
os_daemonize(). I assume not, but I may be wrong.

Thanks,

-- 
Peter Xu
