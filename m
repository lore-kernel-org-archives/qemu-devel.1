Received: from eggs.gnu.org ([2001:4830:134:3::10]:48651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eBlR4-0005FS-07
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:43:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eBlR0-0001Cs-8e
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:43:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eBlQz-0001CP-Vj
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:43:42 -0500
Date: Mon, 6 Nov 2017 17:43:38 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171106174338.GP23361@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171106153342.24147-1-berrange@redhat.com>
	<CAFEAcA_jweuOwrNf93o=2uMzXQVUHcJ6cNsQd++sRt_D04j1nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_jweuOwrNf93o=2uMzXQVUHcJ6cNsQd++sRt_D04j1nA@mail.gmail.com>
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

On Mon, Nov 06, 2017 at 04:11:56PM +0000, Peter Maydell wrote:
> On 6 November 2017 at 15:33, Daniel P. Berrange <berrange@redhat.com> wrote:
> > The following changes since commit ec7a8bf0b8f7dc7288fe8745464ee8217528cc6c:
> >
> >   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-11-06 10:04:16 +0000)
> >
> > are available in the git repository at:
> >
> >   git://github.com/berrange/qemu tags/pull-qio-2017-11-06-1
> >
> > for you to fetch changes up to 74c0035408d5b327eac5985d976bca3009e0c5d6:
> >
> >   tests: Add test-listen - a stress test for QEMU socket listen (2017-11-06 11:49:15 +0000)
> >
> > ----------------------------------------------------------------
> > Merge qio 2017-11-06 v1
> >
> > ----------------------------------------------------------------
> 
> Hi. I'm afraid this fails on various hosts.

Sigh, anything network related in unit tests is soo hard to get right :-(
I was hoping the previous fail you saw with this test was all due to the
file descriptor leak the first patch fixed, but I guess not....

> 
> arm 32 bit (in a chroot on a 64 bit box):
> TEST: tests/test-listen... (pid=319)
>   /socket/listen-serial/ipv4:                                          OK
>   /socket/listen-serial/ipv6:
> ** Failed to assign a port to
> thread 0 (errno = 98)
> ** Failed to assign a port to thread 1 (errno = 98)
> ** Failed to assign a port to thread 2 (errno = 98)
> ** Failed to assign a port to thread 3 (errno = 98)
> ** Failed to assign a port to thread 4 (errno = 98)
> [...repeats all the way up to...]
> ** Failed to assign a port to thread 197 (errno = 98)
> ** Failed to assign a port to thread 198 (errno = 98)
> ** Failed to assign a port to thread 199 (errno = 98)
> **
> ERROR:/home/peter.maydell/qemu/tests/test-listen.c:195:listen_compete_nthr:
> assertion failed (failed_listens == 0): (200 == 0)

Hmm, every single thread failed, which suggests some fundamental config in
this environment that prevents any use of networking at all from tests.

Anything interesting about this build env related to network availability
that would prevent use of even localhost ?

> FAIL
> GTester: last random seed: R02Sbad2a742dbd146e85cb412ce8f8f3750
> (pid=321)
>   /socket/listen-serial/generic:                                       OK
>   /socket/listen-compete/ipv4:                                         OK
>   /socket/listen-compete/ipv6:                                         OK
>   /socket/listen-compete/generic:                                      OK
> FAIL: tests/test-listen
> 
> Compile failure for the test on FreeBSD:
> 
> /root/qemu/tests/test-listen.c:53:19: error: use of undeclared
> identifier 'EAI_ADDRFAMILY'
>         if (rc == EAI_ADDRFAMILY ||
>                   ^

Ok, that's at least an easy one to fix.

> 
> 
> Test failure on OpenBSD:
> 
> TEST: tests/test-listen... (pid=9208)
>   /socket/listen-serial/ipv4:
> ** Failed to assign a port to
> thread 124 (errno = 48)
> ** Failed to assign a port to thread 125 (errno = 48)
> ** Failed to assign a port to thread 126 (errno = 48)
> ** Failed to assign a port to thread 127 (errno = 48)
> [repeats up to]
> ** Failed to assign a port to thread 197 (errno = 48)
> ** Failed to assign a port to thread 198 (errno = 48)
> ** Failed to assign a port to thread 199 (errno = 48)
> **
> ERROR:/home/qemu/tests/test-listen.c:195:listen_compete_nthr:
> assertion failed (failed_listens == 0): (76 == 0)
> FAIL
> GTester: last random seed: R02S17d50ab00329e514ffbe630191e76e83
> (pid=80652)

Only a subset failed, which is more interesting - this is definitely
more like the problem seen when FD leaks. Could you mention what the
ulimits are for your OpenBSD host - I wondering if it hits max FDs
due to having a parallel builds / test run.


> & similarly for the other subtests.
> 
> Linux x86-64:
> 
> make: Entering directory '/home/petmay01/linaro/qemu-for-merges/build/all'
>   GTESTER tests/test-listen
> ** Failed to assign a port to thread 0 (errno = 98)
> ** Failed to assign a port to thread 1 (errno = 98)
> ** Failed to assign a port to thread 2 (errno = 98)
> ** Failed to assign a port to thread 3 (errno = 98)
> ** Failed to assign a port to thread 4 (errno = 98)
> ** Failed to assign a port to thread 5 (errno = 98)
> ** Failed to assign a port to thread 6 (errno = 98)
> [up to]
> ** Failed to assign a port to thread 199 (errno = 98)
> **
> ERROR:/home/petmay01/linaro/qemu-for-merges/tests/test-listen.c:195:listen_compete_nthr:
> assertion failed (failed_listens == 0): (200 == 0)
> GTester: last random seed: R02S041a056d256c9ae190cf026f5adfd979
> /home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:863:
> recipe for target 'check-tests/test-listen' failed

Looks same as your arm env, which suggests no network access at all.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
