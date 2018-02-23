Received: from eggs.gnu.org ([2001:4830:134:3::10]:53368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ep9hH-0006lG-2s
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 04:31:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ep9hD-0003Jy-Vk
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 04:31:19 -0500
Received: from indium.canonical.com ([91.189.90.7]:53660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ep9hD-0003JL-ON
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 04:31:15 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ep9hB-00079F-Pe
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 09:31:14 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E43482E80E5
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 09:31:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Feb 2018 09:24:12 -0000
From: zzfancy <1636217@bugs.launchpad.net>
Reply-To: Bug 1636217 <1636217@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161024141318.21041.87583.malonedeb@gac.canonical.com>
Message-Id: <151937785305.30417.6048368749316198267.malone@gac.canonical.com>
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

we still meet similar issue on centos.7 (qemu 2.9.0-16.el7_4.5.1 +
libvirt 3.2.0-14.el7_4.3)

my workaround including:
a) without kvm accel
or =

b) as comment #7 said "-machine type=3Dpc-i440fx-x" where x <=3D 2.6
or
c) with pci device "disable-modern=3Don"

i found the function _farcall16 in seabios was invoked (https://github.com/=
coreboot/seabios/blob/af0daeb2687ad2595482b8a71b02a082a5672ceb/src/stacks.c=
#L418)
and failed when guest hang with 'Booting from hard disk'.

the invoking sequence (in seabios rel-1.11.0-5-g14d91c3) like :
src/boot.c line 614, call_boot_entry->
src/stacks.c line 427, farcall16->
src/stack.c line 411, _farcall16


but the issue perform diff in our two clusters. =


I just name them cluster A(6.0.0.0 3029758 E5 2640 v2,ststem x3650 M4)
and cluster B (6.0.0.0 3029758 E5 2620 v4,system x3650 M5)for easy.

This issue in cluster B not be reproduced in cluster A(same
qemu/libvirt/esxi)

my command:
/usr/libexec/qemu-kvm  -machine pc-i440fx-rhel7.3.0 \
-m 256 -drive file=3Dcentos.qcow2,if=3Dnone,id=3Ddrive-virtio-disk0 \
-device virtio-blk-pci,disable-modern=3Don,scsi=3Doff,bus=3Dpci.0,addr=3D0x=
4,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0 \
-vnc :1 -chardev stdio,id=3Dseabios -device isa-debugcon,iobase=3D0x402,cha=
rdev=3Dseabios

hope the above info can help fix the bug.

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
