Received: from eggs.gnu.org ([2001:4830:134:3::10]:46506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC1sk-00078f-6P
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:17:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC1se-0005ee-7q
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:17:26 -0500
Received: from indium.canonical.com ([91.189.90.7]:34598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eC1se-0005eN-0r
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:17:20 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eC1sd-0002VQ-89
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 11:17:19 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 369862E8059
	for <qemu-devel@nongnu.org>; Tue,  7 Nov 2017 11:17:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Nov 2017 11:05:41 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1585840 <1585840@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160526014921.26209.46866.malonedeb@chaenomeles.canonical.com>
Message-Id: <151005274150.8938.6238655546970537319.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1585840] Re: multiprocess program gets incorrect
 results with qemu arm-linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi. Your test program doesn't work for me running natively (x86-64):
$ gcc -O -pthread -o /tmp/shmipc-native -static /tmp/shmipc.c
$ time /tmp/shmipc-native =

threaded test
^C

real    929m16.382s
user    1858m14.140s
sys     0m2.924s

...I left it running overnight and it still hadn't finished when I got
in in the morning, so I killed it.

Do you have a repro case that completes in a more reasonable timescale?


** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1585840

Title:
  multiprocess program gets incorrect results with qemu arm-linux-user

Status in QEMU:
  Incomplete

Bug description:
  The attached program can run either in a threaded mode or a
  multiprocess mode.  It defaults to threaded mode, and switches to
  multiprocess mode if the first positional argument is "process".
  "success" of the test is defined as the final count being seen as
  2000000 by both tasks.

  In standard linux x86_64 userspace (i7, 4 cores) and in standard armhf
  userspace (4 cores), the test program consistently completes
  successfully in both modes.  But with qemu arm-linux-user, the test
  consistently succeeds in threaded mode and generally fails in
  multiprocess mode.

  The test reflects an essential aspect of how the Free and Open Source
  project linuxcnc's IPC system works: shared memory regions (created by
  shmat, but mmap would probably behave the same) contain data and
  mutexes.  I observed that our testsuite encounters numerous deadlocks
  and failures when running in an schroot with qemu-user (x86_64 host),
  and I believe the underlying cause is improper support for atomic
  operations in a multiprocess model. (the testsuite consistently passes
  on real hardware)

  I observed the same failure at v1.6.0 and master
  (v2.6.0-424-g287db79), as well as in the outdated Debian version
  1:2.1+dfsg-12+deb8u5a.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1585840/+subscriptions
