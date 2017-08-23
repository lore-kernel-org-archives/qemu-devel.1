Received: from eggs.gnu.org ([2001:4830:134:3::10]:50774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dkcvZ-00071M-Ok
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 17:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dkcvW-0002yX-F7
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 17:11:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:51933)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dkcvW-0002wM-8c
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 17:11:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dkcvU-0001v0-1e
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 21:11:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 08B582E80DA
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 21:11:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Aug 2017 21:02:45 -0000
From: ChristianEhrhardt <1711602@bugs.launchpad.net>
Reply-To: Bug 1711602 <1711602@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150305905460.11582.12289718300820278863.malonedeb@wampee.canonical.com>
Message-Id: <150352216515.11546.8109832659648378205.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1711602] Re: --copy-storage-all failing with qemu
 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Yes, with all the series of [1] on top it finally works.
Saw it already being merged on master.
Expecting a late rc4 or early release tag and then wrap all it up.

Thanks everybody involved!

[1]: http://lists.nongnu.org/archive/html/qemu-
devel/2017-08/msg04513.html

** Changed in: qemu
       Status: New =3D> Fix Committed

** No longer affects: libvirt (Ubuntu)

** Changed in: qemu (Ubuntu)
       Status: Confirmed =3D> In Progress

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1711602

Title:
  --copy-storage-all failing with qemu 2.10

Status in QEMU:
  Fix Committed
Status in qemu package in Ubuntu:
  In Progress

Bug description:
  We fixed an issue around disk locking already in regard to qemu-nbd
  [1], but there still seem to be issues.

  $ virsh migrate --live --copy-storage-all kvmguest-artful-normal qemu+ssh=
://10.22.69.196/system
  error: internal error: qemu unexpectedly closed the monitor: 2017-08-18T1=
2:10:29.800397Z qemu-system-x86_64: -chardev pty,id=3Dcharserial0: char dev=
ice redirected to /dev/pts/0 (label charserial0)
  2017-08-18T12:10:48.545776Z qemu-system-x86_64: load of migration failed:=
 Input/output error

  Source libvirt log for the guest:
  2017-08-18 12:09:08.251+0000: initiating migration
  2017-08-18T12:09:08.809023Z qemu-system-x86_64: Unable to read from socke=
t: Connection reset by peer
  2017-08-18T12:09:08.809481Z qemu-system-x86_64: Unable to read from socke=
t: Connection reset by peer

  Target libvirt log for the guest:
  2017-08-18T12:09:08.730911Z qemu-system-x86_64: load of migration failed:=
 Input/output error
  2017-08-18 12:09:09.010+0000: shutting down, reason=3Dcrashed

  Given the timing it seems that the actual copy now works (it is busy ~10 =
seconds on my environment which would be the copy).
  Also we don't see the old errors we saw before, but afterwards on the act=
ual take-over it fails.

  Dmesg has no related denials as often apparmor is in the mix.

  Need to check libvirt logs of source [2] and target [3] in Detail.

  [1]: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02200.html
  [2]: http://paste.ubuntu.com/25339356/
  [3]: http://paste.ubuntu.com/25339358/

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1711602/+subscriptions
