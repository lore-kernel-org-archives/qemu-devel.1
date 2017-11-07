Received: from eggs.gnu.org ([2001:4830:134:3::10]:55119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eC53T-0004V7-Py
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 09:40:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eC53N-0003YN-ME
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 09:40:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eC53N-0003Xl-DE
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 09:40:37 -0500
Date: Tue, 7 Nov 2017 14:40:33 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171107144033.GG3213@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171106153342.24147-1-berrange@redhat.com>
	<CAFEAcA_jweuOwrNf93o=2uMzXQVUHcJ6cNsQd++sRt_D04j1nA@mail.gmail.com>
	<20171106174338.GP23361@redhat.com>
	<CAFEAcA_2o4R0eMGBz=P-5+_G+ax0UPWtytMC4XrKYHT3jZg=3g@mail.gmail.com>
	<20171107091945.GD14232@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171107091945.GD14232@redhat.com>
Subject: Re: [Qemu-devel] [PULL v1 0/2] Merge IO 2017/11/06
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, Nov 07, 2017 at 09:19:45AM +0000, Daniel P. Berrange wrote:
> On Mon, Nov 06, 2017 at 05:58:41PM +0000, Peter Maydell wrote:
> > On 6 November 2017 at 17:43, Daniel P. Berrange <berrange@redhat.com> wrote:
> > > On Mon, Nov 06, 2017 at 04:11:56PM +0000, Peter Maydell wrote:
> > >> On 6 November 2017 at 15:33, Daniel P. Berrange <berrange@redhat.com> wrote:
> > >> > The following changes since commit ec7a8bf0b8f7dc7288fe8745464ee8217528cc6c:
> > >> >
> > >> >   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-11-06 10:04:16 +0000)
> > >> >
> > >> > are available in the git repository at:
> > >> >
> > >> >   git://github.com/berrange/qemu tags/pull-qio-2017-11-06-1
> > >> >
> > >> > for you to fetch changes up to 74c0035408d5b327eac5985d976bca3009e0c5d6:
> > >> >
> > >> >   tests: Add test-listen - a stress test for QEMU socket listen (2017-11-06 11:49:15 +0000)
> > >> >
> > >> > ----------------------------------------------------------------
> > >> > Merge qio 2017-11-06 v1
> > >> >
> > >> > ----------------------------------------------------------------
> > >>
> > >> Hi. I'm afraid this fails on various hosts.
> > >
> > > Sigh, anything network related in unit tests is soo hard to get right :-(
> > > I was hoping the previous fail you saw with this test was all due to the
> > > file descriptor leak the first patch fixed, but I guess not....
> > >
> > >>
> > >> arm 32 bit (in a chroot on a 64 bit box):
> > >> TEST: tests/test-listen... (pid=319)
> > >>   /socket/listen-serial/ipv4:                                          OK
> > >>   /socket/listen-serial/ipv6:
> > >> ** Failed to assign a port to
> > >> thread 0 (errno = 98)
> > >> ** Failed to assign a port to thread 1 (errno = 98)
> > >> ** Failed to assign a port to thread 2 (errno = 98)
> > >> ** Failed to assign a port to thread 3 (errno = 98)
> > >> ** Failed to assign a port to thread 4 (errno = 98)
> > >> [...repeats all the way up to...]
> > >> ** Failed to assign a port to thread 197 (errno = 98)
> > >> ** Failed to assign a port to thread 198 (errno = 98)
> > >> ** Failed to assign a port to thread 199 (errno = 98)
> > >> **
> > >> ERROR:/home/peter.maydell/qemu/tests/test-listen.c:195:listen_compete_nthr:
> > >> assertion failed (failed_listens == 0): (200 == 0)
> > >
> > > Hmm, every single thread failed, which suggests some fundamental config in
> > > this environment that prevents any use of networking at all from tests.
> > >
> > > Anything interesting about this build env related to network availability
> > > that would prevent use of even localhost ?
> > 
> > You'll notice that the IPV4 test worked fine. I assume this is an
> > IPV6 specific problem.
> 
> Oh yes, so it is.  The strange thing is that the test does check if we have
> a protocol available by doing a test bind() at start.
> 
> > >> Test failure on OpenBSD:
> > >>
> > >> TEST: tests/test-listen... (pid=9208)
> > >>   /socket/listen-serial/ipv4:
> > >> ** Failed to assign a port to
> > >> thread 124 (errno = 48)
> > >> ** Failed to assign a port to thread 125 (errno = 48)
> > >> ** Failed to assign a port to thread 126 (errno = 48)
> > >> ** Failed to assign a port to thread 127 (errno = 48)
> > >> [repeats up to]
> > >> ** Failed to assign a port to thread 197 (errno = 48)
> > >> ** Failed to assign a port to thread 198 (errno = 48)
> > >> ** Failed to assign a port to thread 199 (errno = 48)
> > >> **
> > >> ERROR:/home/qemu/tests/test-listen.c:195:listen_compete_nthr:
> > >> assertion failed (failed_listens == 0): (76 == 0)
> > >> FAIL
> > >> GTester: last random seed: R02S17d50ab00329e514ffbe630191e76e83
> > >> (pid=80652)
> > >
> > > Only a subset failed, which is more interesting - this is definitely
> > > more like the problem seen when FD leaks. Could you mention what the
> > > ulimits are for your OpenBSD host - I wondering if it hits max FDs
> > > due to having a parallel builds / test run.
> > 
> > # ulimit -a
> > time(cpu-seconds)    unlimited
> > file(blocks)         unlimited
> > coredump(blocks)     unlimited
> > data(kbytes)         33554432
> > stack(kbytes)        8192
> > lockedmem(kbytes)    670784
> > memory(kbytes)       2010588
> > nofiles(descriptors) 128
> > processes            1310
> > 
> > That nofiles limit looks quite close to the number where we
> > start failing...
> 
> Ok, I think I'll just make the test skip unless nofiles >= 1024
> so we have a good margin of safety when things run very parallel

FYI, I've dropped the test suite addition in my 2nd PULL request, as I'm
not confident I can solve all the portability problems quickly, and don't
want to waste your time going back + forth testing new versions during
freeze.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
