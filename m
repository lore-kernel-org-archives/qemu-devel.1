Received: from eggs.gnu.org ([2001:4830:134:3::10]:57873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dezg2-0007Lg-Hy
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 04:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dezfy-0001y3-0s
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 04:15:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dezfx-0001xp-Ff
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 04:15:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2DEC681235
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 08:15:40 +0000 (UTC)
References: <1502175607-9531-1-git-send-email-peterx@redhat.com>
	<3f0e8fe6-babd-df82-c690-de0f1ffdd460@redhat.com>
	<20170808074915.GB13486@pxdev.xzpeter.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e72b6895-3aa1-acf2-b863-2d39b3cafa87@redhat.com>
Date: Tue, 8 Aug 2017 10:15:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170808074915.GB13486@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.11] rcu: init globals only once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

On 08/08/2017 09:49, Peter Xu wrote:
> On Tue, Aug 08, 2017 at 09:26:43AM +0200, Paolo Bonzini wrote:
>> On 08/08/2017 09:00, Peter Xu wrote:
>>> We were calling rcu_init_complete() twice in the child processes when
>>> fork happened. However the pthread library does not really suggest to=
 do
>>> it that way:
>>>
>>> http://pubs.opengroup.org/onlinepubs/7908799/xsh/pthread_mutex_init.h=
tml
>>>
>>> "Attempting to initialise an already initialised mutex results in
>>>  undefined behaviour."
>>>
>>> Actually, IMHO we can do it in a more natural way: Firstly, we only i=
nit
>>> the RCU globals once in rcu_init(). Then, in rcu_init_child(), we unl=
ock
>>> all the locks held in rcu_init_lock() just like what we do in the par=
ent
>>> process, then do the rest of RCU re-init (e.g., create the RCU thread=
).
>>
>> This doesn't work for error-checking mutexes: rcu_init_child has a
>> different PID than the parent, so the mutexes aren't unlocked.  It's
>> also true that right now we don't use error-checking mutexes (commit
>> 24fa90499f, "qemu-thread: do not use PTHREAD_MUTEX_ERRORCHECK",
>> 2015-03-10); however, that's also a bit sad.
>>
>> The reason for the undefined behavior is probably that some operating
>> systems allocate memory in pthread_mutex_init, and initializing twice
>> causes a memory leak.  One such operating system is OpenBSD. :(
>=20
> Good to know. :)
>=20
> I thought pthread_atfork() was designed to solve such a locking
> problem (in child hanlder, we unlock all the held locks). If
> PTHREAD_MUTEX_ERRORCHECK cannot coop well with it, not sure whether
> that means we should just avoid using PTHREAD_MUTEX_ERRORCHECK in such
> a use case (but we should be able to use the error checks in other
> mutexes that do not need extra fork handling)?
>=20
> Another idea is: can we just destroy the mutex first then re-init it
> in subprocess? A quick glance in libpthread code shows that at least
> pthread_mutex_destroy() won't check PTHREAD_MUTEX_ERRORCHECK.

Destroying a mutex that is locked is also undefined behavior, even if it
has no waiters.  So it's a nice catch-22: we cannot destroy before
unlocking, and we cannot unlock an error-checking mutex, so we cannot
destroy before init.

Actually, unlocking in atfork's child callback is interesting even for
non-error-checking mutexes.  If there are waiters, waking up the first
one in pthread_mutex_unlock fails.  This is okay if (as on Linux)
pthread_mutex_lock does none of the woken-up process's work.  However,
on OpenBSD pthread_mutex_lock sets mutex->owner... but in the child
there's no other thread to wake up and thus no one will set mutex->owner
to NULL.  This should lead to deadlock scenarios with pthread_atfork.

So pthread_atfork is impossible to use correctly with mutexes, and
reinitializing is the best we can do (the memory leak being a lesser evil=
).

The workaround would be to replace mutexes with semaphores, and to
implement QemuEvent natively for OpenBSD using its __thrsleep and
__thrwakeup system calls (no, I am not going to do that :)).

Let's wait and hear what Eric has to say.

Paolo

> Thanks,
>=20
>>
>> Eric, you chimed in on the patch that became commit 24fa90499f, what d=
o
>> you suggest?
>>
>> Paolo
>=20
