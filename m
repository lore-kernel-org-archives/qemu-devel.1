Received: from eggs.gnu.org ([2001:4830:134:3::10]:41247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fRASp-0007hT-Gz
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:01:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fRASl-000705-JU
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:01:31 -0400
Received: from indium.canonical.com ([91.189.90.7]:39006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fRASl-0006zY-D8
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:01:27 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fRASj-0001QS-GA
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 06:01:25 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2D4EA2E88DE
	for <qemu-devel@nongnu.org>; Fri,  8 Jun 2018 06:01:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Jun 2018 05:53:10 -0000
From: Thomas Huth <1636217@bugs.launchpad.net>
Reply-To: Bug 1636217 <1636217@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161024141318.21041.87583.malonedeb@gac.canonical.com>
Message-Id: <152843719040.24173.12432813490511028669.malone@gac.canonical.com>
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

Marking as fixed, according to comment #13

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1636217

Title:
  qemu-kvm 2.7 does not boot kvm VMs with virtio on top of VMware ESX

Status in QEMU:
  Fix Released

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
