Received: from eggs.gnu.org ([2001:4830:134:3::10]:49597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dezGX-0007FD-JP
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 03:49:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dezGT-0007ZM-J9
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 03:49:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dezGT-0007Yk-DM
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 03:49:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 21F7B61463
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 07:49:20 +0000 (UTC)
Date: Tue, 8 Aug 2017 15:49:15 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170808074915.GB13486@pxdev.xzpeter.org>
References: <1502175607-9531-1-git-send-email-peterx@redhat.com>
	<3f0e8fe6-babd-df82-c690-de0f1ffdd460@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f0e8fe6-babd-df82-c690-de0f1ffdd460@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] rcu: init globals only once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

On Tue, Aug 08, 2017 at 09:26:43AM +0200, Paolo Bonzini wrote:
> On 08/08/2017 09:00, Peter Xu wrote:
> > We were calling rcu_init_complete() twice in the child processes when
> > fork happened. However the pthread library does not really suggest to do
> > it that way:
> > 
> > http://pubs.opengroup.org/onlinepubs/7908799/xsh/pthread_mutex_init.html
> > 
> > "Attempting to initialise an already initialised mutex results in
> >  undefined behaviour."
> > 
> > Actually, IMHO we can do it in a more natural way: Firstly, we only init
> > the RCU globals once in rcu_init(). Then, in rcu_init_child(), we unlock
> > all the locks held in rcu_init_lock() just like what we do in the parent
> > process, then do the rest of RCU re-init (e.g., create the RCU thread).
> 
> This doesn't work for error-checking mutexes: rcu_init_child has a
> different PID than the parent, so the mutexes aren't unlocked.  It's
> also true that right now we don't use error-checking mutexes (commit
> 24fa90499f, "qemu-thread: do not use PTHREAD_MUTEX_ERRORCHECK",
> 2015-03-10); however, that's also a bit sad.
> 
> The reason for the undefined behavior is probably that some operating
> systems allocate memory in pthread_mutex_init, and initializing twice
> causes a memory leak.  One such operating system is OpenBSD. :(

Good to know. :)

I thought pthread_atfork() was designed to solve such a locking
problem (in child hanlder, we unlock all the held locks). If
PTHREAD_MUTEX_ERRORCHECK cannot coop well with it, not sure whether
that means we should just avoid using PTHREAD_MUTEX_ERRORCHECK in such
a use case (but we should be able to use the error checks in other
mutexes that do not need extra fork handling)?

Another idea is: can we just destroy the mutex first then re-init it
in subprocess? A quick glance in libpthread code shows that at least
pthread_mutex_destroy() won't check PTHREAD_MUTEX_ERRORCHECK.

Thanks,

> 
> Eric, you chimed in on the patch that became commit 24fa90499f, what do
> you suggest?
> 
> Paolo

-- 
Peter Xu
