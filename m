Received: from eggs.gnu.org ([2001:4830:134:3::10]:33433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1espjh-00054w-DW
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 08:01:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1espjX-0003NA-Vm
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 08:01:01 -0500
Received: from indium.canonical.com ([91.189.90.7]:39660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1espjX-0003Mx-PI
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 08:00:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1espjW-0001Xm-0K
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 13:00:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D6C182E80CC
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 13:00:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Mar 2018 12:51:16 -0000
From: Max Reitz <1753186@bugs.launchpad.net>
Reply-To: Bug 1753186 <1753186@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152012131660.6957.17826936817192816521.malonedeb@gac.canonical.com>
Message-Id: <152025427665.7678.10111816125434174751.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1753186] Re: qemu-nbd: always first snapshot
 loaded from VDI images with snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

As far as I can tell that's because only the first snapshot is actually sto=
red in the VDI.
(1) I've created a VM with /tmp/foo.vdi as storage
(2) Executed "echo 'snapshot' > /dev/sda" in the guest
(3) Took a snapshot
(4) Executed "echo 'next snapshot' > /dev/sda" in the guest
(5) Took a snapshot
(6) Executed "echo 'active layer' > /dev/sda" in the guest

$ strings /tmp/foo.vdi
<<< Oracle VM VirtualBox Disk Image >>>
snapshot
$ ls ~/VirtualBox\ VMs/foo/Snapshots
{c9a75c86-6c0d-4aaa-9d24-cbd4456c74fb}.vdi  {ce16e224-fa61-4b26-a5c5-21d920=
62ced7}.vdi
$ strings ~/VirtualBox\ VMs/foo/Snapshots/\{ce16e224-fa61-4b26-a5c5-21d9206=
2ced7\}.vdi =

<<< Oracle VM VirtualBox Disk Image >>>
next snapshot
$ strings ~/VirtualBox\ VMs/foo/Snapshots/\{c9a75c86-6c0d-4aaa-9d24-cbd4456=
c74fb\}.vdi =

<<< Oracle VM VirtualBox Disk Image >>>
active layer

So snapshots in VDI apparently are what qemu calls external snapshots, so t=
hey work through backing file links -- and the original file is simply the =
bottom-most backing file (that is, the oldest snapshot).  So the file you'd=
 want to open is {c9a75c86-6c0d-4aaa-9d24-cbd4456c74fb}.vdi. =

 However:
$ qemu-img info \{ce16e224-fa61-4b26-a5c5-21d92062ced7\}.vdi
qemu-img: Could not open '{ce16e224-fa61-4b26-a5c5-21d92062ced7}.vdi': unsu=
pported VDI image (non-NULL link UUID)

So qemu doesn't support this now.  The current behavior is more or less
correct (because the file only contains the data of the oldest
snapshot), supporting snapshots would be a feature request.

Max

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1753186

Title:
  qemu-nbd: always first snapshot loaded from VDI images with snapshots

Status in QEMU:
  New

Bug description:
  When mounting a virtual box disk image of a VM with snapshots, always
  the state of the first snapshot is shown.

  How to reproduce:
  1. Create a new VirtualBox VM or use an existing one, while choosing VDI =
as the disk image format.
  2. Create a snapshot of the VM.
  3. Modify the file system from within the VM enough that differences to t=
he snapshotted version are apparent.
  4. Create another snapshot.
  5. Shut down the VM.
  6. Mount the partition from the disk image with `qemu-nbd -c /dev/nbd0 /p=
ath/to/disk.vdi; mount /dev/nbd0pX /mnt`

  Expected result: The mounted disk image shall represent the latest state =
of the VM
  Actual result: The mounted disk image represents the VM state at the firs=
t snapshot

  version information: qemu-nbd-2.11.1(openSUSE Tumbleweed)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1753186/+subscriptions
