Received: from eggs.gnu.org ([209.51.188.92]:48747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gydD7-00048Z-Aj
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:55:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gydD0-00025z-6j
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:55:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gydD0-000248-0S
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:55:46 -0500
Date: Tue, 26 Feb 2019 13:55:41 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190226135541.GG2721@work-vm>
References: <CAFEAcA-GYE98ceYOHQ5hGwb-Dh8qv=Jvr=EEp_Dk9YLCmQdA4g@mail.gmail.com>
	<CAFEAcA9295VBXHWzraE_ykcD+-1cLOMS158Lyf+gQxzumxV=xA@mail.gmail.com>
	<20190226121700.GF2721@work-vm>
	<CAFEAcA8fc74k5XKQhmDgv10bk2vyvqZuon395gT0YGhONOF_QA@mail.gmail.com>
	<CAFEAcA_Pd9EW4pRQSakEPUj2A3Cv669rhhvyV2rmyY0A6evXxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_Pd9EW4pRQSakEPUj2A3Cv669rhhvyV2rmyY0A6evXxw@mail.gmail.com>
Subject: Re: [Qemu-devel] can we disable the migration-test for TCG targets ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Tue, 26 Feb 2019 at 12:30, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Tue, 26 Feb 2019 at 12:17, Dr. David Alan Gilbert
> > <dgilbert@redhat.com> wrote:
> > >
> > > * Peter Maydell (peter.maydell@linaro.org) wrote:
> > > > Backtrace of process 125450:
> > > > Thread 6 (Thread 0xfff800012de0b900 (LWP 127434)):
> > > > #0  0xfff80001034c5cdc in futex_abstimed_wait_cancelable (private=0,
> > > > abstime=0xfff800012de09f88, expected=0, futex_word=0x10001236574)
> > > >     at ../sysdeps/unix/sysv/linux/futex-internal.h:205
> > > > #1  0xfff80001034c5cdc in do_futex_wait (sem=0x3c,
> > > > abstime=0xfff800012de09f88) at sem_waitcommon.c:111
> > > > #2  0xfff80001034c5e00 in __new_sem_wait_slow (sem=0x10001236570,
> > > > abstime=0xfff800012de09f88) at sem_waitcommon.c:181
> > > > #3  0x000001000091dacc in qemu_sem_timedwait (sem=0x10001236570,
> > > > ms=<optimized out>) at /home/pm215/qemu/util/qemu-thread-posix.c:289
> > > > #4  0x000001000078ae28 in migration_thread (opaque=0x100012364a0) at
> > > > /home/pm215/qemu/migration/migration.c:3125
> > >
> > > So migration is still apparently running, it's rate-limiting
> > > using a timedwait; but 'ms' has been unhelpfully optimised out; could
> > > it be stuck in here for some reason?
> >
> > I looked at this from frame 4, and ms is 64. On the other
> > hand if I tell gdb to 'fin' it doesn't ever leave
> > futex_abstimed_wait_cancelable(), so I wonder if we're
> > managing to get the conversion of the relative time into
> > an absolute deadline wrong somehow ??
> 
> Very weirdly, gdb shows me an absolute timestamp passed
> to the futex function which is indeed in the past, so it
> seems like the issue is that the kernel isn't returning
> control to us when the timestamp expires for some reason.

I wonder if we have any more luck with blacklisting CONFIG_SEM_TIMEDWAIT
- I wonder if it uses a different kernel call?

Dave

> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
