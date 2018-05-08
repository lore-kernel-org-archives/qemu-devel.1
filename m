Received: from eggs.gnu.org ([2001:4830:134:3::10]:35551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fG3FU-0001pk-V1
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fG3FS-00054O-6i
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:05:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:37370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fG3FR-00054A-Uw
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:05:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fG3FQ-0000C4-QC
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 14:05:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BDA6A2E80CB
	for <qemu-devel@nongnu.org>; Tue,  8 May 2018 14:05:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 May 2018 14:00:19 -0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Reply-To: Bug 1769053 <1769053@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152541524728.557.4600864098110042577.malonedeb@gac.canonical.com>
	<152577650854.21921.3043264133804855985.malone@soybean.canonical.com>
	<20180508112338.GI2500@work-vm>
	<20180508132234.yegmw442swuofykh@sirius.home.kraxel.org>
Message-Id: <20180508140019.GM2500@work-vm>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1769053] Re: Cannot start a guest with more
 than 1TB of RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

* Gerd Hoffmann (1769053@bugs.launchpad.net) wrote:
> Hi,
> =

> >   d) For smaller amount of RAM it might still fail if
> > RAM+rounding+pci+hotplug space goes over the limit.
> >      Figuring that limit out is tricky (and I thought it
> >      might be BIOS/EFI dependent as well depending where they
> >      decide to put their PCI devices)
> =

> Both seabios and ovmf try to not go too high in address space.  Reason
> is exactly the phys-bits issue.  Using 40 here by default does not only
> limit the memory to 1TB.  It also has the problem that the guest thinks
> it has 1TB of address space but in reality it might be less.  Even
> recent skylake machines have phys-bits=3D39 (512G) only, and trying to use
> the physical address space above 512G in the guest just doesn't work
> because the phys-bits=3D39 limit applies to EPT too.
> =

> So checking phys-bits in the firmware, for example to place pci bars as
> high as possible in physical address space, is not going to work.
> =

> IIRC ovmf uses a 32G sized region with 32G alignment by default, which
> will land below 64G (aka phys-bits=3D36 address space) unless the guest
> has more than 30 (q35) or 31 (piix4) GB of memory.
> =

> seabios will not map pci bars above 4G unless it runs out of space below
> 4G.  If needed 64bit PCI bars will be placed right above ram, with
> gigabyte alignment.

Yep, I was tempted to set host-phys-bits=3Dtrue on upstream, but TCG
has a fixed 40 bits last time I looked.

Dave

> cheers,
>   Gerd
> =

> -- =

> You received this bug notification because you are subscribed to the bug
> report.
> https://bugs.launchpad.net/bugs/1769053
> =

> Title:
>   Cannot start a guest with more than 1TB of RAM
> =

> Status in QEMU:
>   Incomplete
> Status in qemu package in Ubuntu:
>   Incomplete
> =

> Bug description:
>   Attempting to start a KVM guest with more than 1TB of RAM fails.
> =

>   It looks like we might need some extra patches:
>   https://lists.gnu.org/archive/html/qemu-discuss/2017-12/msg00005.html
> =

>   ProblemType: Bug
>   DistroRelease: Ubuntu 18.04
>   Package: qemu-system-x86 1:2.11+dfsg-1ubuntu7
>   ProcVersionSignature: Ubuntu 4.15.0-20.21-generic 4.15.17
>   Uname: Linux 4.15.0-20-generic x86_64
>   ApportVersion: 2.20.9-0ubuntu7
>   Architecture: amd64
>   CurrentDesktop: Unity:Unity7:ubuntu
>   Date: Fri May  4 16:21:14 2018
>   InstallationDate: Installed on 2017-04-05 (393 days ago)
>   InstallationMedia: Ubuntu 16.10 "Yakkety Yak" - Release amd64 (20161012=
.2)
>   MachineType: Dell Inc. XPS 13 9360
>   ProcKernelCmdLine: BOOT_IMAGE=3D/vmlinuz-4.15.0-20-generic root=3D/dev/=
mapper/ubuntu--vg-root ro quiet splash transparent_hugepage=3Dmadvise vt.ha=
ndoff=3D1
>   SourcePackage: qemu
>   UpgradeStatus: Upgraded to bionic on 2018-04-30 (3 days ago)
>   dmi.bios.date: 02/26/2018
>   dmi.bios.vendor: Dell Inc.
>   dmi.bios.version: 2.6.2
>   dmi.board.name: 0PF86Y
>   dmi.board.vendor: Dell Inc.
>   dmi.board.version: A00
>   dmi.chassis.type: 9
>   dmi.chassis.vendor: Dell Inc.
>   dmi.modalias: dmi:bvnDellInc.:bvr2.6.2:bd02/26/2018:svnDellInc.:pnXPS13=
9360:pvr:rvnDellInc.:rn0PF86Y:rvrA00:cvnDellInc.:ct9:cvr:
>   dmi.product.family: XPS
>   dmi.product.name: XPS 13 9360
>   dmi.sys.vendor: Dell Inc.
> =

> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1769053/+subscriptions
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1769053

Title:
  Cannot start a guest with more than 1TB of RAM

Status in QEMU:
  Incomplete
Status in qemu package in Ubuntu:
  Incomplete

Bug description:
  Attempting to start a KVM guest with more than 1TB of RAM fails.

  It looks like we might need some extra patches:
  https://lists.gnu.org/archive/html/qemu-discuss/2017-12/msg00005.html

  ProblemType: Bug
  DistroRelease: Ubuntu 18.04
  Package: qemu-system-x86 1:2.11+dfsg-1ubuntu7
  ProcVersionSignature: Ubuntu 4.15.0-20.21-generic 4.15.17
  Uname: Linux 4.15.0-20-generic x86_64
  ApportVersion: 2.20.9-0ubuntu7
  Architecture: amd64
  CurrentDesktop: Unity:Unity7:ubuntu
  Date: Fri May  4 16:21:14 2018
  InstallationDate: Installed on 2017-04-05 (393 days ago)
  InstallationMedia: Ubuntu 16.10 "Yakkety Yak" - Release amd64 (20161012.2)
  MachineType: Dell Inc. XPS 13 9360
  ProcKernelCmdLine: BOOT_IMAGE=3D/vmlinuz-4.15.0-20-generic root=3D/dev/ma=
pper/ubuntu--vg-root ro quiet splash transparent_hugepage=3Dmadvise vt.hand=
off=3D1
  SourcePackage: qemu
  UpgradeStatus: Upgraded to bionic on 2018-04-30 (3 days ago)
  dmi.bios.date: 02/26/2018
  dmi.bios.vendor: Dell Inc.
  dmi.bios.version: 2.6.2
  dmi.board.name: 0PF86Y
  dmi.board.vendor: Dell Inc.
  dmi.board.version: A00
  dmi.chassis.type: 9
  dmi.chassis.vendor: Dell Inc.
  dmi.modalias: dmi:bvnDellInc.:bvr2.6.2:bd02/26/2018:svnDellInc.:pnXPS1393=
60:pvr:rvnDellInc.:rn0PF86Y:rvrA00:cvnDellInc.:ct9:cvr:
  dmi.product.family: XPS
  dmi.product.name: XPS 13 9360
  dmi.sys.vendor: Dell Inc.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1769053/+subscriptions
