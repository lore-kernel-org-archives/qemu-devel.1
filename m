Received: from eggs.gnu.org ([2001:4830:134:3::10]:41249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eCvLj-0007wx-ND
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 17:31:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eCvLe-0006nu-Ps
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 17:31:03 -0500
Received: from indium.canonical.com ([91.189.90.7]:59488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eCvLe-0006nA-JX
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 17:30:58 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eCvLd-0002vb-0s
	for <qemu-devel@nongnu.org>; Thu, 09 Nov 2017 22:30:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D9CF02E80D1
	for <qemu-devel@nongnu.org>; Thu,  9 Nov 2017 22:30:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Nov 2017 22:22:08 -0000
From: Johannes Falke <1731347@bugs.launchpad.net>
Reply-To: Bug 1731347 <1731347@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151026612898.3153.4753501294134415779.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1731347] [NEW] VFIO Passthrough of SAS2008-based
 HBA card fails on E3-1225v3 due to failed DMA mapping (-14)
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

There is a bug preventing multiple people with my combination of
hardware from using PCI passthrough. I am not actually sure whether the
bug is in kernel/kvm, vfio or qemu, however, as qemu is the highest-
level of these, I am reporting the bug here as you will likely know
better where the origin of the bug may be found.

When attempting to pass through this device to a KVM using VFIO, this
results in error -14 (Bad Address):

# qemu-system-x86_64 -enable-kvm -m 10G -net none -monitor stdio -serial
# none -parallel none -vnc :1 -device vfio-pci,host=3D1:00.0 -S
QEMU 2.9.1 monitor - type 'help' for more information
(qemu) c
(qemu) qemu-system-x86_64: VFIO_MAP_DMA: -14
qemu-system-x86_64: vfio_dma_map(0x7f548f0a1fc0, 0xfebd0000, 0x2000, 0x7f54=
a909d000) =3D -14 (Bad address)
qemu: hardware error: vfio: DMA mapping failed, unable to continue

See also:
https://bugzilla.proxmox.com/show_bug.cgi?id=3D1556
https://www.redhat.com/archives/vfio-users/2016-May/msg00088.html

This has occurred on Proxmox (Proxmox and Debian packages, Ubuntu kernel), =
Ubuntu,
and pure Debian packages and kernel on Proxmox. However, this error
reportedly does NOT occur for:

- different distributions(!) (Fedora 24, 25)
- different HBA cards (SAS2308, SAS3008)
- different CPU (E3-1220v5)

I would be thankful for any input and I'll be happy to provide any
further info necessary. This is my first time delving this deep into
anything close to the kernel.

Thanks and best regards,
Johannes Falke

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "strace.txt"
   https://bugs.launchpad.net/bugs/1731347/+attachment/5006683/+files/strac=
e.txt

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1731347

Title:
  VFIO Passthrough of SAS2008-based HBA card fails on E3-1225v3 due to
  failed DMA mapping (-14)

Status in QEMU:
  New

Bug description:
  There is a bug preventing multiple people with my combination of
  hardware from using PCI passthrough. I am not actually sure whether
  the bug is in kernel/kvm, vfio or qemu, however, as qemu is the
  highest-level of these, I am reporting the bug here as you will likely
  know better where the origin of the bug may be found.

  When attempting to pass through this device to a KVM using VFIO, this
  results in error -14 (Bad Address):

  # qemu-system-x86_64 -enable-kvm -m 10G -net none -monitor stdio -serial
  # none -parallel none -vnc :1 -device vfio-pci,host=3D1:00.0 -S
  QEMU 2.9.1 monitor - type 'help' for more information
  (qemu) c
  (qemu) qemu-system-x86_64: VFIO_MAP_DMA: -14
  qemu-system-x86_64: vfio_dma_map(0x7f548f0a1fc0, 0xfebd0000, 0x2000, 0x7f=
54a909d000) =3D -14 (Bad address)
  qemu: hardware error: vfio: DMA mapping failed, unable to continue

  See also:
  https://bugzilla.proxmox.com/show_bug.cgi?id=3D1556
  https://www.redhat.com/archives/vfio-users/2016-May/msg00088.html

  This has occurred on Proxmox (Proxmox and Debian packages, Ubuntu kernel)=
, Ubuntu,
  and pure Debian packages and kernel on Proxmox. However, this error
  reportedly does NOT occur for:

  - different distributions(!) (Fedora 24, 25)
  - different HBA cards (SAS2308, SAS3008)
  - different CPU (E3-1220v5)

  I would be thankful for any input and I'll be happy to provide any
  further info necessary. This is my first time delving this deep into
  anything close to the kernel.

  Thanks and best regards,
  Johannes Falke

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1731347/+subscriptions
