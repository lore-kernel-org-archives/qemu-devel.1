Received: from eggs.gnu.org ([2001:4830:134:3::10]:53411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eBlfs-0003Cm-VG
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:59:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eBlfr-00009n-NU
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:59:05 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:56486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eBlfr-00009M-Cl
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:59:03 -0500
Received: by mail-wr0-x241.google.com with SMTP id q66so5831314wrb.13
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 09:59:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171106174338.GP23361@redhat.com>
References: <20171106153342.24147-1-berrange@redhat.com>
	<CAFEAcA_jweuOwrNf93o=2uMzXQVUHcJ6cNsQd++sRt_D04j1nA@mail.gmail.com>
	<20171106174338.GP23361@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Nov 2017 17:58:41 +0000
Message-ID: <CAFEAcA_2o4R0eMGBz=P-5+_G+ax0UPWtytMC4XrKYHT3jZg=3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 0/2] Merge IO 2017/11/06
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 November 2017 at 17:43, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Mon, Nov 06, 2017 at 04:11:56PM +0000, Peter Maydell wrote:
>> On 6 November 2017 at 15:33, Daniel P. Berrange <berrange@redhat.com> wrote:
>> > The following changes since commit ec7a8bf0b8f7dc7288fe8745464ee8217528cc6c:
>> >
>> >   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-11-06 10:04:16 +0000)
>> >
>> > are available in the git repository at:
>> >
>> >   git://github.com/berrange/qemu tags/pull-qio-2017-11-06-1
>> >
>> > for you to fetch changes up to 74c0035408d5b327eac5985d976bca3009e0c5d6:
>> >
>> >   tests: Add test-listen - a stress test for QEMU socket listen (2017-11-06 11:49:15 +0000)
>> >
>> > ----------------------------------------------------------------
>> > Merge qio 2017-11-06 v1
>> >
>> > ----------------------------------------------------------------
>>
>> Hi. I'm afraid this fails on various hosts.
>
> Sigh, anything network related in unit tests is soo hard to get right :-(
> I was hoping the previous fail you saw with this test was all due to the
> file descriptor leak the first patch fixed, but I guess not....
>
>>
>> arm 32 bit (in a chroot on a 64 bit box):
>> TEST: tests/test-listen... (pid=319)
>>   /socket/listen-serial/ipv4:                                          OK
>>   /socket/listen-serial/ipv6:
>> ** Failed to assign a port to
>> thread 0 (errno = 98)
>> ** Failed to assign a port to thread 1 (errno = 98)
>> ** Failed to assign a port to thread 2 (errno = 98)
>> ** Failed to assign a port to thread 3 (errno = 98)
>> ** Failed to assign a port to thread 4 (errno = 98)
>> [...repeats all the way up to...]
>> ** Failed to assign a port to thread 197 (errno = 98)
>> ** Failed to assign a port to thread 198 (errno = 98)
>> ** Failed to assign a port to thread 199 (errno = 98)
>> **
>> ERROR:/home/peter.maydell/qemu/tests/test-listen.c:195:listen_compete_nthr:
>> assertion failed (failed_listens == 0): (200 == 0)
>
> Hmm, every single thread failed, which suggests some fundamental config in
> this environment that prevents any use of networking at all from tests.
>
> Anything interesting about this build env related to network availability
> that would prevent use of even localhost ?

You'll notice that the IPV4 test worked fine. I assume this is an
IPV6 specific problem.

>> Test failure on OpenBSD:
>>
>> TEST: tests/test-listen... (pid=9208)
>>   /socket/listen-serial/ipv4:
>> ** Failed to assign a port to
>> thread 124 (errno = 48)
>> ** Failed to assign a port to thread 125 (errno = 48)
>> ** Failed to assign a port to thread 126 (errno = 48)
>> ** Failed to assign a port to thread 127 (errno = 48)
>> [repeats up to]
>> ** Failed to assign a port to thread 197 (errno = 48)
>> ** Failed to assign a port to thread 198 (errno = 48)
>> ** Failed to assign a port to thread 199 (errno = 48)
>> **
>> ERROR:/home/qemu/tests/test-listen.c:195:listen_compete_nthr:
>> assertion failed (failed_listens == 0): (76 == 0)
>> FAIL
>> GTester: last random seed: R02S17d50ab00329e514ffbe630191e76e83
>> (pid=80652)
>
> Only a subset failed, which is more interesting - this is definitely
> more like the problem seen when FD leaks. Could you mention what the
> ulimits are for your OpenBSD host - I wondering if it hits max FDs
> due to having a parallel builds / test run.

# ulimit -a
time(cpu-seconds)    unlimited
file(blocks)         unlimited
coredump(blocks)     unlimited
data(kbytes)         33554432
stack(kbytes)        8192
lockedmem(kbytes)    670784
memory(kbytes)       2010588
nofiles(descriptors) 128
processes            1310

That nofiles limit looks quite close to the number where we
start failing...

>> Linux x86-64:
>>
>> make: Entering directory '/home/petmay01/linaro/qemu-for-merges/build/all'
>>   GTESTER tests/test-listen
>> ** Failed to assign a port to thread 0 (errno = 98)
>> ** Failed to assign a port to thread 1 (errno = 98)
>> ** Failed to assign a port to thread 2 (errno = 98)
>> ** Failed to assign a port to thread 3 (errno = 98)
>> ** Failed to assign a port to thread 4 (errno = 98)
>> ** Failed to assign a port to thread 5 (errno = 98)
>> ** Failed to assign a port to thread 6 (errno = 98)
>> [up to]
>> ** Failed to assign a port to thread 199 (errno = 98)
>> **
>> ERROR:/home/petmay01/linaro/qemu-for-merges/tests/test-listen.c:195:listen_compete_nthr:
>> assertion failed (failed_listens == 0): (200 == 0)
>> GTester: last random seed: R02S041a056d256c9ae190cf026f5adfd979
>> /home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:863:
>> recipe for target 'check-tests/test-listen' failed
>
> Looks same as your arm env, which suggests no network access at all.

This is running native on my primary development machine, so its
network access is fine :-)

thanks
-- PMM
