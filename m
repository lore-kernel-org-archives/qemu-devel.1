Received: from eggs.gnu.org ([2001:4830:134:3::10]:43310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eBk0e-0002Pd-7i
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:12:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eBk0Y-0004vL-FZ
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:12:24 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:48498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eBk0Y-0004v5-9k
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:12:18 -0500
Received: by mail-wm0-x22b.google.com with SMTP id p75so14892731wmg.3
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 08:12:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171106153342.24147-1-berrange@redhat.com>
References: <20171106153342.24147-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Nov 2017 16:11:56 +0000
Message-ID: <CAFEAcA_jweuOwrNf93o=2uMzXQVUHcJ6cNsQd++sRt_D04j1nA@mail.gmail.com>
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

On 6 November 2017 at 15:33, Daniel P. Berrange <berrange@redhat.com> wrote:
> The following changes since commit ec7a8bf0b8f7dc7288fe8745464ee8217528cc6c:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-11-06 10:04:16 +0000)
>
> are available in the git repository at:
>
>   git://github.com/berrange/qemu tags/pull-qio-2017-11-06-1
>
> for you to fetch changes up to 74c0035408d5b327eac5985d976bca3009e0c5d6:
>
>   tests: Add test-listen - a stress test for QEMU socket listen (2017-11-06 11:49:15 +0000)
>
> ----------------------------------------------------------------
> Merge qio 2017-11-06 v1
>
> ----------------------------------------------------------------

Hi. I'm afraid this fails on various hosts.

arm 32 bit (in a chroot on a 64 bit box):
TEST: tests/test-listen... (pid=319)
  /socket/listen-serial/ipv4:                                          OK
  /socket/listen-serial/ipv6:
** Failed to assign a port to
thread 0 (errno = 98)
** Failed to assign a port to thread 1 (errno = 98)
** Failed to assign a port to thread 2 (errno = 98)
** Failed to assign a port to thread 3 (errno = 98)
** Failed to assign a port to thread 4 (errno = 98)
[...repeats all the way up to...]
** Failed to assign a port to thread 197 (errno = 98)
** Failed to assign a port to thread 198 (errno = 98)
** Failed to assign a port to thread 199 (errno = 98)
**
ERROR:/home/peter.maydell/qemu/tests/test-listen.c:195:listen_compete_nthr:
assertion failed (failed_listens == 0): (200 == 0)
FAIL
GTester: last random seed: R02Sbad2a742dbd146e85cb412ce8f8f3750
(pid=321)
  /socket/listen-serial/generic:                                       OK
  /socket/listen-compete/ipv4:                                         OK
  /socket/listen-compete/ipv6:                                         OK
  /socket/listen-compete/generic:                                      OK
FAIL: tests/test-listen

Compile failure for the test on FreeBSD:

/root/qemu/tests/test-listen.c:53:19: error: use of undeclared
identifier 'EAI_ADDRFAMILY'
        if (rc == EAI_ADDRFAMILY ||
                  ^


Test failure on OpenBSD:

TEST: tests/test-listen... (pid=9208)
  /socket/listen-serial/ipv4:
** Failed to assign a port to
thread 124 (errno = 48)
** Failed to assign a port to thread 125 (errno = 48)
** Failed to assign a port to thread 126 (errno = 48)
** Failed to assign a port to thread 127 (errno = 48)
[repeats up to]
** Failed to assign a port to thread 197 (errno = 48)
** Failed to assign a port to thread 198 (errno = 48)
** Failed to assign a port to thread 199 (errno = 48)
**
ERROR:/home/qemu/tests/test-listen.c:195:listen_compete_nthr:
assertion failed (failed_listens == 0): (76 == 0)
FAIL
GTester: last random seed: R02S17d50ab00329e514ffbe630191e76e83
(pid=80652)

& similarly for the other subtests.

Linux x86-64:

make: Entering directory '/home/petmay01/linaro/qemu-for-merges/build/all'
  GTESTER tests/test-listen
** Failed to assign a port to thread 0 (errno = 98)
** Failed to assign a port to thread 1 (errno = 98)
** Failed to assign a port to thread 2 (errno = 98)
** Failed to assign a port to thread 3 (errno = 98)
** Failed to assign a port to thread 4 (errno = 98)
** Failed to assign a port to thread 5 (errno = 98)
** Failed to assign a port to thread 6 (errno = 98)
[up to]
** Failed to assign a port to thread 199 (errno = 98)
**
ERROR:/home/petmay01/linaro/qemu-for-merges/tests/test-listen.c:195:listen_compete_nthr:
assertion failed (failed_listens == 0): (200 == 0)
GTester: last random seed: R02S041a056d256c9ae190cf026f5adfd979
/home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:863:
recipe for target 'check-tests/test-listen' failed

thanks
-- PMM
