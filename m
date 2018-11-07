Received: from eggs.gnu.org ([2001:4830:134:3::10]:43155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gKE1S-0000zM-AZ
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 21:56:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gKE1O-0004Jd-VL
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 21:56:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gKE1O-0004BM-H2
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 21:56:46 -0500
Date: Wed, 7 Nov 2018 10:56:28 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181107025628.GB17134@xz-x1>
References: <20181030191620.32168-1-armbru@redhat.com>
	<CAFEAcA8RdNrbCLL7tXY=e95N2Y0LcZdCPr3EuQo1_hu08qJuaQ@mail.gmail.com>
	<87sh0eyzb0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sh0eyzb0.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PULL 0/8] Monitor patches for 2018-10-30
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Nov 06, 2018 at 04:56:51PM +0100, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
> > On 30 October 2018 at 19:16, Markus Armbruster <armbru@redhat.com> wrote:
> >> The following changes since commit 3f3285491dd52014852a56135c90e428c8b507ea:
> >>
> >>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2018-10-30 14:09:25 +0000)
> >>
> >> are available in the Git repository at:
> >>
> >>   git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2018-10-30
> >>
> >> for you to fetch changes up to 1a8de278dd3c93a7aa40f88486509fe0e2de04da:
> >>
> >>   vl: Avoid crash when -mon is underspecified (2018-10-30 20:13:52 +0100)
> >>
> >> ----------------------------------------------------------------
> >> Monitor patches for 2018-10-30
> >>
> >> * Fix crash on shutdown with --daemonize
> >> * Change out-of-band execution to stop reading instead of dropping
> >>   commands
> >> * Enable out-of-band execution by default
> >> * Avoid crash when -mon lacks chardev=...
> >>
> >> ----------------------------------------------------------------
> >
> > Hi; I get test failures on FreeBSD host:
> >
> > TEST: tests/qmp-test... (pid=18305)
> >   /sparc64/qmp/protocol:                                               OK
> >   /sparc64/qmp/oob:                                                    FAIL
> > GTester: last random seed: R02Se36038cab4c051a2cd47374ec9718e98
> > (pid=18337)
> >   /sparc64/qmp/preconfig:                                              OK
> > FAIL: tests/qmp-test
> >
> > ERROR:tests/qmp-test.c:211:recv_cmd_id: assertion failed
> > (qdict_get_try_str(resp, "id") == id): ("oob-1" == "queue-blocks-1")
> > gmake: *** [/var/tmp/qemu-test.2n2tBU/tests/Makefile.include:805:
> > check-qtest-sparc] Error 1
> >
> > and similarly with i386/qmp/oob and sparc/qmp/oob.
> 
> I haven't been able to reproduce, yet.  I'm going to respin with fewer
> patches, to get the other stuff in while I debug.

Strange, "make check -j8" failed on my hosts (I tried two) with either
Markus's pull tree or qemu master:

hw/core/ptimer.o: In function `timer_new_tl':
/home/xz/git/qemu/include/qemu/timer.h:536: undefined reference to `timer_init_tl'
collect2: error: ld returned 1 exit status
make: *** [/home/xz/git/qemu/rules.mak:124: tests/ptimer-test] Error 1

Is that only happening on my hosts?

And I can't reproduce the error too by only running the standalone
qmp-test.

Regaring to the test failure reported - when I saw that I thought
about the patch "monitor: resume the monitor earlier if needed" in my
series since that seems to have the possibility to bring such an
uncertainty, though I noticed that Markus has already removed that
patch from the pull.

-- 
Peter Xu
