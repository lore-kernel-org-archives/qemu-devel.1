Received: from eggs.gnu.org ([2001:4830:134:3::10]:38105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dkrum-0004qH-6s
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:11:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dkruh-00046E-7k
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:11:16 -0400
Received: from indium.canonical.com ([91.189.90.7]:48727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dkruh-00045b-1s
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:11:11 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dkrud-000253-VA
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 13:11:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1B11C2E8179
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 13:11:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Aug 2017 12:59:09 -0000
From: meeho yuen <1712818@bugs.launchpad.net>
Reply-To: Bug 1712818 <1712818@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150357954932.16920.8202218494274187188.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1712818] [NEW] live migration with storage
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

Public bug reported:

The vm guest runs a iotest program, and i migrate it with virsh --copy-
storage-all,then the qemu process on the source host happens to crash
with the following message:

kvm: block/io.c:1543: bdrv_co_pwritev: Assertion `!(bs->open_flags & 0x0800=
)' failed.
2017-08-24 11:43:45.919+0000: shutting down, reason=3Dcrashed

here is the release:
qemu 2.7 & 2.10.rc3 were tested.
libvirt 3.0.0 & 3.2.0 were tested.

command line:
src_host:virsh migrate --verbose --live --persistent --copy-storage-all vm-=
core qemu+ssh://dst_host/system

Possible Reason: After bdrv_inactivate_all() was called, mirror_run
coroutine still writes the left dirty disk data to remote nbd server,
which triggers the assertion. But I don't known how to avoid the
problem, help is needed!  Thanks.

** Affects: qemu
     Importance: Undecided
         Status: New

** Description changed:

  The vm guest runs a iotest program, and i migrate it with virsh --copy-
  storage-all,then the qemu process on the source host happens to crash
  with the following message:
  =

  kvm: block/io.c:1543: bdrv_co_pwritev: Assertion `!(bs->open_flags & 0x08=
00)' failed.
  2017-08-24 11:43:45.919+0000: shutting down, reason=3Dcrashed
- =

  =

  here is the release:
  qemu 2.7 & 2.10.rc3 were tested.
  libvirt 3.0.0 & 3.2.0 were tested.
  =

  command line:
  src_host:virsh migrate --verbose --live --persistent --copy-storage-all v=
m-core qemu+ssh://dst_host/system
  =

- Resaon: After bdrv_inactivate_all() was called, mirror_run coroutine
- stills write the left dirty disk data to remote nbd server, which
- triggers the assertion. But I don't known how to avoid the problem, help
- is needed!  Thanks.
+ Possible Reason: After bdrv_inactivate_all() was called, mirror_run
+ coroutine stills write the left dirty disk data to remote nbd server,
+ which triggers the assertion. But I don't known how to avoid the
+ problem, help is needed!  Thanks.

** Description changed:

  The vm guest runs a iotest program, and i migrate it with virsh --copy-
  storage-all,then the qemu process on the source host happens to crash
  with the following message:
  =

  kvm: block/io.c:1543: bdrv_co_pwritev: Assertion `!(bs->open_flags & 0x08=
00)' failed.
  2017-08-24 11:43:45.919+0000: shutting down, reason=3Dcrashed
  =

  here is the release:
  qemu 2.7 & 2.10.rc3 were tested.
  libvirt 3.0.0 & 3.2.0 were tested.
  =

  command line:
  src_host:virsh migrate --verbose --live --persistent --copy-storage-all v=
m-core qemu+ssh://dst_host/system
  =

  Possible Reason: After bdrv_inactivate_all() was called, mirror_run
- coroutine stills write the left dirty disk data to remote nbd server,
+ coroutine still writes the left dirty disk data to remote nbd server,
  which triggers the assertion. But I don't known how to avoid the
  problem, help is needed!  Thanks.

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
