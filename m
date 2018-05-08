Received: from eggs.gnu.org ([2001:4830:134:3::10]:54456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fG0pr-0003hW-5p
	for qemu-devel@nongnu.org; Tue, 08 May 2018 07:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fG0pn-0002hR-4c
	for qemu-devel@nongnu.org; Tue, 08 May 2018 07:31:11 -0400
Received: from indium.canonical.com ([91.189.90.7]:47070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fG0pm-0002gw-UY
	for qemu-devel@nongnu.org; Tue, 08 May 2018 07:31:07 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fG0pj-0000hm-IU
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 11:31:03 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AA98A2E8137
	for <qemu-devel@nongnu.org>; Tue,  8 May 2018 11:31:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 May 2018 11:23:39 -0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Reply-To: Bug 1769053 <1769053@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152541524728.557.4600864098110042577.malonedeb@gac.canonical.com>
	<152577650854.21921.3043264133804855985.malone@soybean.canonical.com>
Message-Id: <20180508112338.GI2500@work-vm>
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

* Daniel Berrange (1769053@bugs.launchpad.net) wrote:
> Hmm, if we know that QEMU guests will crash & burn when > 1 TB mem, when
> host-phys-bits/phys-bits are unset, then perhaps libvirt should do the
> right thing by default here. eg we can't use host-phys-bits=3Dtrue due to
> migration compat issues, but if we see > 1TB mem, libvirt could
> reasonably set phys-bits=3DNNN for some suitable value of NNN.  We should
> expose this in the XML config for the CPU explicitly too.

Yep:
  a) It should be possible to add a setting to the XML to specify the
     phys-bits
  b) It should be possible for libvirt to check the host it's on can
     satisfy that requirement
  c) libvirt can check that if RAM > 2^phys-bits it can complain

but

  d) For smaller amount of RAM it might still fail if
RAM+rounding+pci+hotplug space goes over the limit.
     Figuring that limit out is tricky (and I thought it
     might be BIOS/EFI dependent as well depending where they
     decide to put their PCI devices)

Dave

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
