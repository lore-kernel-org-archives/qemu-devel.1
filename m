Received: from eggs.gnu.org ([2001:4830:134:3::10]:34919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC5SZ-00063p-11
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC5SP-0000CH-C9
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:39 -0500
Received: from indium.canonical.com ([91.189.90.7]:41802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eC5SP-0000Bq-5A
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:29 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eC5SO-0007uv-5R
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 15:06:28 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 144F52E802D
	for <qemu-devel@nongnu.org>; Tue,  7 Nov 2017 15:06:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Nov 2017 14:45:05 -0000
From: jepler <jepler@unpythonic.net>
Reply-To: Bug 1585840 <1585840@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160526014921.26209.46866.malonedeb@chaenomeles.canonical.com>
Message-Id: <151006590603.4122.9423726872402533995.malone@gac.canonical.com>
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

I agree.  The test program I originally attached works (completes in way un=
der 1 second) on
 debian wheezy
 x86_64
 i7-4930K

and doesn't work on
 debian stretch
 x86_64
 i7-4790K

The test program should run in well under 1s, even under qemu-user-arm.

The problem with my test program seems to be in the initial
synchronization, which is janky because my standalone test program isn't
using a proper synchronization primitive to make sure the two threads
start incrementing the shared counter at around the same time.  I've
attached an updated version which works for me on wheezy x86_64, stretch
x86_64, trusty armhf, but not on stretch x86-64 + qemu-user.


Typical output:
 $ ./a.out process
 multiprocess test
 starting is_primary=3D0
 starting is_primary=3D1
 at end, *mem =3D 2000000
 at end, *mem =3D 2000000
 should be 2000000
 should be 2000000

Typical failing output under qemu-arm-static:

 $ qemu-arm-static ./a.arm process
 multiprocess test
 starting is_primary=3D0
 starting is_primary=3D1
 at end, *mem =3D 1010975
 at end, *mem =3D 1010975
 should be 2000000
 should be 2000000

Note that when qemu-arm-static is restricted to 1 CPU via `tasket`, the
frequency of the failure changes from "almost every time" to "one in
ten".

Thank you for taking the time to look at my test program.  I apologize
that I caused you to waste a day of (CPU) time waiting for the test
program to complete.

** Attachment added: "Updated test program"
   https://bugs.launchpad.net/qemu/+bug/1585840/+attachment/5005420/+files/=
shmipc.c

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
