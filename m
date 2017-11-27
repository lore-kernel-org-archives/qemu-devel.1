Received: from eggs.gnu.org ([2001:4830:134:3::10]:46902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJLHN-0005Nb-VE
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 10:25:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJLHN-0008PI-0n
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 10:25:05 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:33890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eJLHM-0008P4-RZ
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 10:25:04 -0500
Received: by mail-ot0-x244.google.com with SMTP id o23so24488855otd.1
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 07:25:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <af9abebc-0650-a7c7-e63d-adafaa7031d6@linaro.org>
References: <ab2eda3b-571f-025e-66e9-6c1577793a08@physik.fu-berlin.de>
	<b3becdc0-6540-30a6-b70b-8312ac5dddd9@physik.fu-berlin.de>
	<af9abebc-0650-a7c7-e63d-adafaa7031d6@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Nov 2017 16:24:43 +0100
Message-ID: <CAFEAcA_mR86vZhqe7yZwUdSSFyKDcms6UoK-NnXgW2ER8GL5tw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Rasmus Villemoes <rv@rasmusvillemoes.dk>, QEMU Developers <qemu-devel@nongnu.org>, Michael Karcher <debian@mkarcher.dialup.fu-berlin.de>, James Clarke <jrtc27@jrtc27.com>, Laurent Vivier <laurent@vivier.eu>, Adhemerval Zanella <adhemerval.zanella@linaro.com>

On 27 November 2017 at 12:57, Adhemerval Zanella
<adhemerval.zanella@linaro.org> wrote:
> We found out this potential bogus assert on 2.27 development [1] which
> resulted in two fixes [2][3].
>
> It should not be an issue for generic posix_spawn usage where there is
> no expectation system/user/program kills random pids (since posix_spawn
> auxiliary process has not yet returned). Some say the possible kind of
> behaviour is rather undefined, but it shouldn't also trigger an assert.
>
> I am not really sure what is happening in qemu usermode because comment
> #4 in the bug reports states clone is returning an error and it should
> not trigger the assert in first place.  What seems to be happening in
> this scenario is clone is actually returning a success, but the auxiliary
> process is being killed before actually calling execve.

The bug report is a bit confused, but I think what is happening
in the QEMU case is that QEMU implements clone(CLONE_VFORK) as having
the same semantics as fork() (ie the parent will not autowait for
the child, and the child does not share a memory map with the parent).
(ie QEMU treats it as having the semantics of a vfork() call, which
is allowed to be implemented as fork()).
Previous versions of glibc's posix_spawn() could cope with this
divergence from the kernel's native clone() behaviour, but the
rewrite can't. It's not unreasonable for glibc() to rely on the
kernel behaviour, but on the other hand it's not too surprising
if this breaks non-kernel implementations of the syscall ABI
like QEMU and the MS Linux subsystem, because it's a tricky
corner case that previously nobody was trying to use.

Unfortunately I can't really think of a mechanism for implementing
this in QEMU usermode, because the only tools we have available
for creating new threads and processes are the ones the host libc
gives us: so we can spawn new threads with pthread_create() and
fork the process with fork(), but we don't have a safe way to
create a new process which shares the memory map and where the
new process can call the various libc functions which QEMU will
do as it executes the guest code.

thanks
-- PMM
