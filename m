Received: from eggs.gnu.org ([2001:4830:134:3::10]:56507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fTWd7-0001KC-R8
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 14:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fTWd4-0001go-6T
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 14:05:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:60658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fTWd4-0001fP-0E
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 14:05:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fTWd3-0006jX-5O
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 18:05:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 221DA2E80C8
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 18:05:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Jun 2018 17:50:53 -0000
From: Thomas Huth <1437367@bugs.launchpad.net>
Reply-To: Bug 1437367 <1437367@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150327144617.7150.85648.malonedeb@chaenomeles.canonical.com>
Message-Id: <152899865316.26144.2955451266617952501.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1437367] Re: Qemu guest fails to write files with
 raw disk (like \\.\PhysicalDrive1) on Windows host.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Is there still anything left to do here, or could we close this ticket
nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1437367

Title:
  Qemu guest fails to write files with raw disk (like
  \\.\PhysicalDrive1) on Windows host.

Status in QEMU:
  Incomplete

Bug description:
  Qemu guest fails to write files with specifing raw disk like \\.\Physical=
Drive1
  full command line is below.
  qemu-sysytem-i386.exe -kernel bzImage -drive file=3Drootfs.ext2,index=3D0=
,if=3Dscsi -append root=3D/dev/sda -drive file=3D\\.\PhysicalDrive1,index=
=3D1,if=3Dscsi

  I found the reason is below aio_worker returns -EIO when flush
  operation.

  https://github.com/qemu/qemu/blob/master/block/raw-win32.c#L95

  static int aio_worker(void *arg)
  ...
      case QEMU_AIO_FLUSH:
          if (!FlushFileBuffers(aiocb->hfile)) {
              return -EIO;
          }

  FlushFileBuffers always fails with GetLastError() =3D=3D ERROR_INVALID_FU=
NCTION
  I think this function doesn't support raw device.
  For flushing, you might have to issue scsi/ata command or use another way.
  Trying to just ignoring this error, writing function seems to be fine for=
 me.

  Thanks
  hiroaki

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1437367/+subscriptions
