Received: from eggs.gnu.org ([2001:4830:134:3::10]:41853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <adhemerval.zanella@linaro.org>) id 1eJLwu-0005jV-4V
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:08:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <adhemerval.zanella@linaro.org>) id 1eJLwn-0005H3-Q9
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:08:00 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <adhemerval.zanella@linaro.org>)
	id 1eJLwn-0005Gn-KG
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:07:53 -0500
Received: by mail-qk0-x244.google.com with SMTP id p19so33054180qke.2
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 08:07:53 -0800 (PST)
References: <ab2eda3b-571f-025e-66e9-6c1577793a08@physik.fu-berlin.de>
	<b3becdc0-6540-30a6-b70b-8312ac5dddd9@physik.fu-berlin.de>
	<af9abebc-0650-a7c7-e63d-adafaa7031d6@linaro.org>
	<CAFEAcA_mR86vZhqe7yZwUdSSFyKDcms6UoK-NnXgW2ER8GL5tw@mail.gmail.com>
From: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Message-ID: <9e520d68-0aba-1a32-06d9-351e90d0a7bf@linaro.org>
Date: Mon, 27 Nov 2017 14:07:46 -0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_mR86vZhqe7yZwUdSSFyKDcms6UoK-NnXgW2ER8GL5tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] glibc "linux: spawni.c: simplify error reporting
 to parent" breaks qemu-user/Windows Service For Linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Rasmus Villemoes <rv@rasmusvillemoes.dk>, QEMU Developers <qemu-devel@nongnu.org>, Michael Karcher <debian@mkarcher.dialup.fu-berlin.de>, James Clarke <jrtc27@jrtc27.com>, Laurent Vivier <laurent@vivier.eu>, Adhemerval Zanella <adhemerval.zanella@linaro.com>



On 27/11/2017 13:24, Peter Maydell wrote:
> On 27 November 2017 at 12:57, Adhemerval Zanella
> <adhemerval.zanella@linaro.org> wrote:
>> We found out this potential bogus assert on 2.27 development [1] which
>> resulted in two fixes [2][3].
>>
>> It should not be an issue for generic posix_spawn usage where there is
>> no expectation system/user/program kills random pids (since posix_spawn
>> auxiliary process has not yet returned). Some say the possible kind of
>> behaviour is rather undefined, but it shouldn't also trigger an assert.
>>
>> I am not really sure what is happening in qemu usermode because comment
>> #4 in the bug reports states clone is returning an error and it should
>> not trigger the assert in first place.  What seems to be happening in
>> this scenario is clone is actually returning a success, but the auxiliary
>> process is being killed before actually calling execve.
> 
> The bug report is a bit confused, but I think what is happening
> in the QEMU case is that QEMU implements clone(CLONE_VFORK) as having
> the same semantics as fork() (ie the parent will not autowait for
> the child, and the child does not share a memory map with the parent).
> (ie QEMU treats it as having the semantics of a vfork() call, which
> is allowed to be implemented as fork()).

Right, that explains what is happening. 

> Previous versions of glibc's posix_spawn() could cope with this
> divergence from the kernel's native clone() behaviour, but the
> rewrite can't. It's not unreasonable for glibc() to rely on the
> kernel behaviour, but on the other hand it's not too surprising
> if this breaks non-kernel implementations of the syscall ABI
> like QEMU and the MS Linux subsystem, because it's a tricky
> corner case that previously nobody was trying to use.

The problem is vfork is such a broken API [1] that even POSIX has 
deprecated it on the latest 2008 standard. It was used on GLIBC
posix_spawn on some specific usage (old POSIX_SPAWN_USEVFORK 
flag) only because it was 'faster' than using fork, however
it also created its own set bugs [2][3][4][5].

Current implementation is as fast as using vfork on Linux using
which should be platform neutral clone flags and assumptions
(in fact we found out that Linux does not work as expected with
clone (CLONE_VFORK | CLONE_VM) -> exit -> waitpid (WNOHANG)
which resulted in aa95a2414).

GLIBC also maintains another implementation at 
sysdeps/posix/spawni.c which should be more platform neutral
since it uses only POSIX expected semantics (the synchronization
is done using a pipe2 instead of CLONE_VM, so a vfork acting
as fork shouldn't be a problem). It is not used in any architecture
on GLIBC currently.

However I am not very compelled to change internal posix_spawn
on GLIBC on Linux mainly because it uses a slight less resources
than the generic POSIX one (check e83be730910c) and it works
on Linux kernel as expected.

[1] https://ewontfix.com/7/
[2] https://sourceware.org/bugzilla/show_bug.cgi?id=14750
[3] https://sourceware.org/bugzilla/show_bug.cgi?id=14749
[4] https://sourceware.org/bugzilla/show_bug.cgi?id=14499
[5] https://sourceware.org/bugzilla/show_bug.cgi?id=10354

> 
> Unfortunately I can't really think of a mechanism for implementing
> this in QEMU usermode, because the only tools we have available
> for creating new threads and processes are the ones the host libc
> gives us: so we can spawn new threads with pthread_create() and
> fork the process with fork(), but we don't have a safe way to
> create a new process which shares the memory map and where the
> new process can call the various libc functions which QEMU will
> do as it executes the guest code.

Current GLIBC won't trigger any assert anymore (and it was backported
to 2.25 and 2.26 branch as well), however I am not sure if posix_spawn 
semantic will works for all the expected scenarios in qemu user-mode.

Most likely any failure (sched_set{param,scheduler}, setsid, setpgid,
seteuid, any file action or execve itself) won't be advertise to main
process, since err is set 0 as default and the auxiliary process will
write to a expected shared memory to signalling an issue. 

Also, I don't think trying to emulate "CLONE_VM | CLONE_VFORK" with
pthread_create without actually synchronize the threads will work
as expected. If clone actually uses CLONE_VFORK I would expect the
underlying qemu usermode to block the caller thread (using a condition
variable or a barrier) and to release its execution only for execve
or exit in the callee. I am not very versed on qemu code, so I 
am not sure how complex it would be.
