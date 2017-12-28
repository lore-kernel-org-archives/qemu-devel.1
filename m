Received: from eggs.gnu.org ([2001:4830:134:3::10]:35198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eUgEU-00028Y-Ez
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 17:00:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eUgER-0001px-5l
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 17:00:58 -0500
Received: from indium.canonical.com ([91.189.90.7]:55508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eUgEQ-0001oo-TC
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 17:00:55 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eUgEO-0002x2-DI
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 22:00:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5B1BE2E8078
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 22:00:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Dec 2017 21:50:33 -0000
From: Matthew Schumacher <1712818@bugs.launchpad.net>
Reply-To: Bug 1712818 <1712818@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150357954932.16920.8202218494274187188.malonedeb@gac.canonical.com>
Message-Id: <151449783340.2939.8248956253845310155.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1712818] Re: live migration with storage
 encounter assert(!(bs->open_flags & BDRV_O_INACTIVE)) crashes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I see the same thing:

2017-12-28 21:36:26.837+0000: initiating migration
qemu-system-x86_64: block/io.c:1537: bdrv_co_pwritev: Assertion `!(bs->open=
_flags & BDRV_O_INACTIVE)' failed.
2017-12-28 21:36:40.516+0000: shutting down, reason=3Dcrashed
~

Running:
QEMU emulator version 2.10.1
libvirtd (libvirt) 3.10.0

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1712818

Title:
  live migration with storage encounter assert(!(bs->open_flags &
  BDRV_O_INACTIVE)) crashes

Status in QEMU:
  New

Bug description:
  The vm guest runs a iotest program, and i migrate it with virsh
  --copy-storage-all,then the qemu process on the source host happens to
  crash with the following message:

  kvm: block/io.c:1543: bdrv_co_pwritev: Assertion `!(bs->open_flags & 0x08=
00)' failed.
  2017-08-24 11:43:45.919+0000: shutting down, reason=3Dcrashed

  here is the release:
  qemu 2.7 & 2.10.rc3 were tested.
  libvirt 3.0.0 & 3.2.0 were tested.

  command line:
  src_host:virsh migrate --verbose --live --persistent --copy-storage-all v=
m-core qemu+ssh://dst_host/system

  Possible Reason: After bdrv_inactivate_all() was called, mirror_run
  coroutine still writes the left dirty disk data to remote nbd server,
  which triggers the assertion. But I don't known how to avoid the
  problem, help is needed!  Thanks.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1712818/+subscriptions
