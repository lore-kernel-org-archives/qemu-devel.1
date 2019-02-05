Received: from eggs.gnu.org ([209.51.188.92]:52407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gr5xr-0006SQ-Bh
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:01:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gr5xl-0008G5-Af
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:00:59 -0500
Received: from indium.canonical.com ([91.189.90.7]:47270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gr5xl-00081b-3K
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:00:53 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gr5xg-0006M2-Pl
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 19:00:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7FB5C2E80CE
	for <qemu-devel@nongnu.org>; Tue,  5 Feb 2019 19:00:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 Feb 2019 18:53:34 -0000
From: elmarco <marcandre.lureau@gmail.com>
Reply-To: Bug 1813940 <1813940@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154885462996.30915.15408927273139016803.malonedeb@gac.canonical.com>
Message-Id: <154939281425.20754.14224436209004958596.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1813940] Re: kvm_mem_ioeventfd_add: error adding
 ioeventfd: No space left on device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The bug is also reproducible with virtio-9p =

-fsdev local,id=3Dr,path=3D/,security_model=3Dnone -device virtio-9p-pci,fs=
dev=3Dr,mount_tag=3Dr

I bisected it to the same commit.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1813940

Title:
  kvm_mem_ioeventfd_add: error adding ioeventfd: No space left on device

Status in QEMU:
  New

Bug description:
  Latest QEMU master fails to run with too many MMIO devices specified.

  After patch 3ac7d43a6fb [1] QEMU just prints an error message and exits.
  > kvm_mem_ioeventfd_add: error adding ioeventfd: No space left on device

  This is reproducible e.g. with the following setup:

  qemu-3.1.50-dirty \
      -machine pc-i440fx-2.7,accel=3Dkvm \
      -cpu host -m 4096 \
      -smp 2,sockets=3D2,cores=3D1,threads=3D1 \
      -drive file=3Dfreebsd_vm_1.qcow2,format=3Dqcow2,if=3Dnone,id=3Dbootdr=
 \
      -device ide-hd,drive=3Dbootdr,bootindex=3D0 \
      -device virtio-scsi-pci,id=3Dvc0 \
      -device virtio-scsi-pci,id=3Dvc1 \
      -device virtio-scsi-pci,id=3Dvc2 \
      -device virtio-scsi-pci,id=3Dvc3 \

  Running with just 3 Virtio-SCSI controllers seems to work fine, adding
  more than that causes the error above. Note that this is not Virtio-
  SCSI specific. I've also reproduced this without any Virtio devices
  whatsoever.

  strace shows the following ioctl chain over and over:

  145787 ioctl(11, KVM_UNREGISTER_COALESCED_MMIO, 0x7f60a4985410) =3D 0
  145787 ioctl(11, KVM_UNREGISTER_COALESCED_MMIO, 0x7f60a4985410) =3D 0
  145787 ioctl(11, KVM_REGISTER_COALESCED_MMIO, 0x7f60a49853b0) =3D 0
  145787 ioctl(11, KVM_REGISTER_COALESCED_MMIO, 0x7f60a49853b0) =3D -1 ENOS=
PC (No space left on device)
  145787 ioctl(11, KVM_REGISTER_COALESCED_MMIO, 0x7f60a49853b0) =3D -1 ENOS=
PC (No space left on device)
  145787 ioctl(11, KVM_REGISTER_COALESCED_MMIO, 0x7f60a49853b0) =3D -1 ENOS=
PC (No space left on device)
  145787 ioctl(11, KVM_REGISTER_COALESCED_MMIO, 0x7f60a49853b0) =3D -1 ENOS=
PC (No space left on device)
  145787 ioctl(11, KVM_REGISTER_COALESCED_MMIO, 0x7f60a49853b0) =3D -1 ENOS=
PC (No space left on device)
  145787 ioctl(11, KVM_REGISTER_COALESCED_MMIO, 0x7f60a49853b0) =3D -1 ENOS=
PC (No space left on device)
  145787 ioctl(11, KVM_REGISTER_COALESCED_MMIO, 0x7f60a49853b0) =3D -1 ENOS=
PC (No space left on device)
  145787 ioctl(11, KVM_REGISTER_COALESCED_MMIO, 0x7f60a49853b0) =3D -1 ENOS=
PC (No space left on device)

  Which suggests there's some kind of MMIO region leak.

  [1]
  commit 3ac7d43a6fbb5d4a3d01fc9a055c218030af3727
  Author:     Paolo Bonzini <pbonzini@redhat.com>
  AuthorDate: Wed Nov 28 17:28:45 2018 +0100
  Commit:     Paolo Bonzini <pbonzini@redhat.com>
  CommitDate: Fri Jan 11 13:57:24 2019 +0100

      memory: update coalesced_range on transaction_commit

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1813940/+subscriptions
