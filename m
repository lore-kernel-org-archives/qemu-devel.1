Received: from eggs.gnu.org ([209.51.188.92]:40436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gycbA-0005f3-W7
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:16:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gycb3-0007Da-E0
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:16:37 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:36325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gycb0-0007Bq-OQ
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:16:31 -0500
Received: by mail-oi1-x235.google.com with SMTP id t206so10262291oib.3
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 05:16:26 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA-GYE98ceYOHQ5hGwb-Dh8qv=Jvr=EEp_Dk9YLCmQdA4g@mail.gmail.com>
	<CAFEAcA9295VBXHWzraE_ykcD+-1cLOMS158Lyf+gQxzumxV=xA@mail.gmail.com>
	<20190226121700.GF2721@work-vm>
	<CAFEAcA8fc74k5XKQhmDgv10bk2vyvqZuon395gT0YGhONOF_QA@mail.gmail.com>
In-Reply-To: <CAFEAcA8fc74k5XKQhmDgv10bk2vyvqZuon395gT0YGhONOF_QA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Feb 2019 13:16:14 +0000
Message-ID: <CAFEAcA_Pd9EW4pRQSakEPUj2A3Cv669rhhvyV2rmyY0A6evXxw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] can we disable the migration-test for TCG targets ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 26 Feb 2019 at 12:30, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 26 Feb 2019 at 12:17, Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> >
> > * Peter Maydell (peter.maydell@linaro.org) wrote:
> > > Backtrace of process 125450:
> > > Thread 6 (Thread 0xfff800012de0b900 (LWP 127434)):
> > > #0  0xfff80001034c5cdc in futex_abstimed_wait_cancelable (private=0,
> > > abstime=0xfff800012de09f88, expected=0, futex_word=0x10001236574)
> > >     at ../sysdeps/unix/sysv/linux/futex-internal.h:205
> > > #1  0xfff80001034c5cdc in do_futex_wait (sem=0x3c,
> > > abstime=0xfff800012de09f88) at sem_waitcommon.c:111
> > > #2  0xfff80001034c5e00 in __new_sem_wait_slow (sem=0x10001236570,
> > > abstime=0xfff800012de09f88) at sem_waitcommon.c:181
> > > #3  0x000001000091dacc in qemu_sem_timedwait (sem=0x10001236570,
> > > ms=<optimized out>) at /home/pm215/qemu/util/qemu-thread-posix.c:289
> > > #4  0x000001000078ae28 in migration_thread (opaque=0x100012364a0) at
> > > /home/pm215/qemu/migration/migration.c:3125
> >
> > So migration is still apparently running, it's rate-limiting
> > using a timedwait; but 'ms' has been unhelpfully optimised out; could
> > it be stuck in here for some reason?
>
> I looked at this from frame 4, and ms is 64. On the other
> hand if I tell gdb to 'fin' it doesn't ever leave
> futex_abstimed_wait_cancelable(), so I wonder if we're
> managing to get the conversion of the relative time into
> an absolute deadline wrong somehow ??

Very weirdly, gdb shows me an absolute timestamp passed
to the futex function which is indeed in the past, so it
seems like the issue is that the kernel isn't returning
control to us when the timestamp expires for some reason.

thanks
-- PMM
