Received: from eggs.gnu.org ([2001:4830:134:3::10]:58596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dkZFv-0007Fr-FK
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dkZFq-0004Un-EN
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:15:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:43084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dkZFq-0004Tp-72
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:15:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dkZFo-0000TG-DM
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 17:15:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5EDAB2E80CD
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 17:15:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Aug 2017 16:56:20 -0000
From: ChristianEhrhardt <1711602@bugs.launchpad.net>
Reply-To: Bug 1711602 <1711602@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150305905460.11582.12289718300820278863.malonedeb@wampee.canonical.com>
Message-Id: <150350738053.7999.1516503078105572953.malone@soybean.canonical.com>
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

Hmm,
it gets further but can still not complete this kind of migration:

$ virsh migrate --live --copy-storage-all kvmguest-artful-normal
qemu+ssh://10.22.69.30/system

Source:
2017-08-23 16:49:23.022+0000: initiating migration
Unexpected error in bdrv_check_perm() at /build/qemu-VjSgVJ/qemu-2.10~rc3+d=
fsg/block.c:1574:
2017-08-23T16:49:23.203181Z qemu-system-x86_64: Block node is read-only
2017-08-23 16:49:23.762+0000: shutting down, reason=3Dcrashed

Target:
2017-08-23T16:49:23.495478Z qemu-system-x86_64: Failed to load virtio_pci/m=
odern_state:modern_state
2017-08-23T16:49:23.495505Z qemu-system-x86_64: Failed to load virtio/extra=
_state:extra_state
2017-08-23T16:49:23.495510Z qemu-system-x86_64: Failed to load virtio-ballo=
on:virtio
2017-08-23T16:49:23.495515Z qemu-system-x86_64: error while loading state f=
or instance 0x0 of device '0000:00:06.0/virtio-balloon'
2017-08-23T16:49:23.496071Z qemu-system-x86_64: load of migration failed: I=
nput/output error
2017-08-23 16:49:23.797+0000: shutting down, reason=3Dcrashed

I was to eager to get this close-to-real so I don't have Davids fprintf's a=
pplied anymore - I'll build those and then run it in the debugger, but unti=
l then what I can see is that behavior slightly changes (worse).
It now crashes the guest on the source as well when aborting the migration.

I need to debug to confirm, but it seems it still aborts the migration
 -> qemu-system-x86_64: load of migration failed: Input/output error
But then can't fall back to the source and crashes at
 -> qemu-system-x86_64: Block node is read-only

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1711602

Title:
  --copy-storage-all failing with qemu 2.10

Status in QEMU:
  New
Status in libvirt package in Ubuntu:
  Confirmed
Status in qemu package in Ubuntu:
  Confirmed

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
