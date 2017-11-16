Received: from eggs.gnu.org ([2001:4830:134:3::10]:48688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eFA25-00043a-TZ
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 21:36:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eFA22-0004tF-Op
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 21:36:01 -0500
Received: from indium.canonical.com ([91.189.90.7]:50432)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eFA22-0004rV-IY
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 21:35:58 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eFA1z-0008DZ-JP
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 02:35:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 29A9B2E8196
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 02:35:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Nov 2017 02:24:44 -0000
From: introom <i@introo.me>
Reply-To: Bug 1636217 <1636217@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161024141318.21041.87583.malonedeb@gac.canonical.com>
Message-Id: <151079908470.28848.6280955136471274390.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1636217] Re: qemu-kvm 2.7 does not boot kvm VMs
 with virtio on top of VMware ESX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This problem still exists as of now on Debian sid. Qemu version is "QEMU
emulator version 2.10.1(Debian 1:2.10.0+dfsg-2)".


for "-machine type=3Dpc-i440fx-x" where x > 2.6, all stuck at boot if the i=
nterface is virtio.

I use nested virtualization where the first level is VMWARE FUSION
(might not be the same as ESX), and the second is qemu-kvm.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1636217

Title:
  qemu-kvm 2.7 does not boot kvm VMs with virtio on top of VMware ESX

Status in QEMU:
  New

Bug description:
  After todays Proxmox update all my Linux VMs stopped booting.

  # How to reproduce
  - Have KVM on top of VMware ESX (I use VMware ESX 6)
  - Boot Linux VM with virtio Disk drive.

  =

  # Result
  virtio based VMs do not boot anymore:

  root@demotuxdc:/etc/pve/nodes/demotuxdc/qemu-server# grep virtio0 100.con=
f =

  bootdisk: virtio0
  virtio0: pvestorage:100/vm-100-disk-1.raw,discard=3Don,size=3D20G

  (initially with cache=3Dwritethrough, but that doesn=C2=B4t matter)

  What happens instead is:

  - BIOS displays "Booting from harddisk..."
  - kvm process of VM loops at about 140% of Intel(R) Core(TM) i5-6260U CPU=
 @ 1.80GHz Skylake dual core CPU

  Disk of course has valid bootsector:

  root@demotuxdc:/srv/pvestorage/images/100# file -sk vm-100-disk-1.raw =

  vm-100-disk-1.raw: DOS/MBR boot sector DOS/MBR boot sector DOS executable=
 (COM), boot code
  root@demotuxdc:/srv/pvestorage/images/100# head -c 2048 vm-100-disk-1.raw=
 | hd | grep GRUB
  00000170  be 94 7d e8 2e 00 cd 18  eb fe 47 52 55 42 20 00  |..}.......GR=
UB .|

  =

  # Workaround 1
  - Change disk from virtio0 to scsi0
  - Debian boots out of the box after this change
  - SLES 12 needs a rebuilt initrd
  - CentOS 7 too, but it seems that is not even enough and it still fails (=
even in hostonly=3D"no" mode for dracut)

  =

  # Workaround 2
  Downgrade pve-qemu-kvm 2.7.0-3 to 2.6.2-2.

  =

  # Expected results
  Disk boots just fine via virtio like it did before.

  =

  # Downstream bug report
  Downstream suggests an issue with upstream qemu-kvm:

  https://bugzilla.proxmox.com/show_bug.cgi?id=3D1181

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1636217/+subscriptions
