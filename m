Received: from eggs.gnu.org ([2001:4830:134:3::10]:42231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fG03q-0004F3-GT
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:41:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fG03m-0001zq-GZ
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:41:34 -0400
Received: from indium.canonical.com ([91.189.90.7]:38312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fG03m-0001zW-6p
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:41:30 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fG03k-0003yJ-Oq
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 10:41:28 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B61642E80D0
	for <qemu-devel@nongnu.org>; Tue,  8 May 2018 10:41:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 May 2018 10:26:46 -0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Reply-To: Bug 1769053 <1769053@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152541524728.557.4600864098110042577.malonedeb@gac.canonical.com>
	<152568921469.6485.15990399219355923244.malone@chaenomeles.canonical.com>
	<20180508083722.GB2500@work-vm>
	<CAATJJ0LEGg1AZbfDjfA_SvWonA5VO-xd5XtG4t4cDTRz4ZyR8g@mail.gmail.com>
Message-Id: <20180508102645.GG2500@work-vm>
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

* ChristianEhrhardt (1769053@bugs.launchpad.net) wrote:
> On Tue, May 8, 2018 at 10:37 AM, Dr. David Alan Gilbert <dgilbert@redhat.=
com
> > wrote:
> =

> > * ChristianEhrhardt (1769053@bugs.launchpad.net) wrote:
> > > > Interesting; I thought this was supposed to work.
> > >
> > > Exactly that was my thought when triaging it initially
> > > Furthermore I assume people working la57 (https://lwn.net/Articles/
> > 730925/) and such ran tests on much bigger sizes.
> >
> > I assume so, but I've not looked at the detail of that.
> >
> > > > Ah right Dan, if you're seeing the 40 bits physical in the guest you
> > > definitely need to try the flags I suggest in comment 6; host-phys-
> > > bits=3Dtrue should work for you.
> > >
> > > I tested Bionic to be at least on libvirt 4.0 / qemu 2.11.1 when we w=
ant
> > > to check things under the "supposed to work now" flag.
> > >
> > > Defaults:
> > > Host:  address sizes   : 46 bits physical, 48 bits virtual
> > > Guest: address sizes   : 40 bits physical, 48 bits virtual
> > >
> > > I ensured that with option -cpu host,host-phys-bits=3Dtrue set I
> > successfully get what my host can provide in the guest:
> > > Guest: address sizes   : 46 bits physical, 48 bits virtual
> > >
> > > Starting a guest with that >1TB (that would be mostly on swap if need=
ed)
> > works just fine as expected. Here ~1063 GB from /proc/meminfo
> > > MemTotal:       1114676492 kB
> >
> > OK, good - that suggests there's nothing missing.
> > We enable host-phys-bits=3Dtrue by default I think (in our machine type=
?)
> >
> =

> Interesting approach, I see your comment about that already in [1] when it
> was added.
> I didn't realize some machine types were setting this already - I assume =
it
> isn't the general default for migratebility to other hosts (like our 36/39
> bit laptops).
> =

> I assume "we" in this context are RedHat downstream changes to the (some)
> machine type(s)?

That's right; you sohuld be able to find them if you dig around CentOS's
set.

> I see the benefit for huge guests to work without setting those propertie=
s,
> but I wonder if that caused you trouble in regard to migrations?

It could, although I don't remember any reports of people hitting it.
The problem is finding a better solution;  that's why I added both the
host-phys-bits and the ability to set phys-bits=3D   so that you can make
a smarter choice based on what hardware you actually have.  Who or what
should make that smarter choice hasn't really ever been answered.

> [1]: https://patchwork.kernel.org/patch/9223999/

Prior to that patch set, QEMU had always been a fixed 40 bits, so I
didn't change the default behaviour with that set; I just let you change
it by adding the flags.
(As I remember TCG was hard coded as 40 bits in some places so didn't
want to break that either).

Dave

> =

> =

> > > I also checked a more compatible approach like -cpu qemu64,phys-bits=
=3D42
> > > and that works as well.
> > >
> > > IMHO - if anything - one could argue that libvirt/qemu could be smart=
er
> > > about e.g. auto adding those arguments (or print a warning) when
> > > crossing a certain memory size.
> >
> > The problem is there are a whole bunch of things that are hard to deal
> > with:
> >   a) Cheaper CPUs tend to have smaller phys-bits even in the same
> > generation; e.g. my laptop is still 36 bits, a lot are 39 bits.  I think
> > the same is true of the Xeon E3-.... family.   It makes it hard to know
> > what to pick when you're going to allow migration.
> >
> >   b) Reasoning about the total address size range is difficult; you've
> > got to take into account PCI address space and hot plug space etc
> > to know where the upper edge is.
> >
> =

> I agree that checking the total address size might have too much false
> positives for all the complexities around "estimating" that size.
> /me is giving up this idea :-)
> =

> =

> > Dave
> >
> > > So for now I'd stick to the "actually works" summary and keep the sta=
tus
> > > to incomplete.
> > >
> > > --
> > > You received this bug notification because you are subscribed to the =
bug
> > > report.
> > > https://bugs.launchpad.net/bugs/1769053
> > >
> > > Title:
> > >   Cannot start a guest with more than 1TB of RAM
> > >
> > > Status in QEMU:
> > >   Incomplete
> > > Status in qemu package in Ubuntu:
> > >   Incomplete
> > >
> > > Bug description:
> > >   Attempting to start a KVM guest with more than 1TB of RAM fails.
> > >
> > >   It looks like we might need some extra patches:
> > >   https://lists.gnu.org/archive/html/qemu-discuss/2017-12/msg00005.ht=
ml
> > >
> > >   ProblemType: Bug
> > >   DistroRelease: Ubuntu 18.04
> > >   Package: qemu-system-x86 1:2.11+dfsg-1ubuntu7
> > >   ProcVersionSignature: Ubuntu 4.15.0-20.21-generic 4.15.17
> > >   Uname: Linux 4.15.0-20-generic x86_64
> > >   ApportVersion: 2.20.9-0ubuntu7
> > >   Architecture: amd64
> > >   CurrentDesktop: Unity:Unity7:ubuntu
> > >   Date: Fri May  4 16:21:14 2018
> > >   InstallationDate: Installed on 2017-04-05 (393 days ago)
> > >   InstallationMedia: Ubuntu 16.10 "Yakkety Yak" - Release amd64
> > (20161012.2)
> > >   MachineType: Dell Inc. XPS 13 9360
> > >   ProcKernelCmdLine: BOOT_IMAGE=3D/vmlinuz-4.15.0-20-generic
> > root=3D/dev/mapper/ubuntu--vg-root ro quiet splash
> > transparent_hugepage=3Dmadvise vt.handoff=3D1
> > >   SourcePackage: qemu
> > >   UpgradeStatus: Upgraded to bionic on 2018-04-30 (3 days ago)
> > >   dmi.bios.date: 02/26/2018
> > >   dmi.bios.vendor: Dell Inc.
> > >   dmi.bios.version: 2.6.2
> > >   dmi.board.name: 0PF86Y
> > >   dmi.board.vendor: Dell Inc.
> > >   dmi.board.version: A00
> > >   dmi.chassis.type: 9
> > >   dmi.chassis.vendor: Dell Inc.
> > >   dmi.modalias: dmi:bvnDellInc.:bvr2.6.2:bd02/26/2018:svnDellInc.:
> > pnXPS139360:pvr:rvnDellInc.:rn0PF86Y:rvrA00:cvnDellInc.:ct9:cvr:
> > >   dmi.product.family: XPS
> > >   dmi.product.name: XPS 13 9360
> > >   dmi.sys.vendor: Dell Inc.
> > >
> > > To manage notifications about this bug go to:
> > > https://bugs.launchpad.net/qemu/+bug/1769053/+subscriptions
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >
> > --
> > You received this bug notification because you are a member of Ubuntu
> > Virtualisation team, which is subscribed to qemu in Ubuntu.
> > https://bugs.launchpad.net/bugs/1769053
> >
> > Title:
> >   Cannot start a guest with more than 1TB of RAM
> >
> > Status in QEMU:
> >   Incomplete
> > Status in qemu package in Ubuntu:
> >   Incomplete
> >
> > Bug description:
> >   Attempting to start a KVM guest with more than 1TB of RAM fails.
> >
> >   It looks like we might need some extra patches:
> >   https://lists.gnu.org/archive/html/qemu-discuss/2017-12/msg00005.html
> >
> >   ProblemType: Bug
> >   DistroRelease: Ubuntu 18.04
> >   Package: qemu-system-x86 1:2.11+dfsg-1ubuntu7
> >   ProcVersionSignature: Ubuntu 4.15.0-20.21-generic 4.15.17
> >   Uname: Linux 4.15.0-20-generic x86_64
> >   ApportVersion: 2.20.9-0ubuntu7
> >   Architecture: amd64
> >   CurrentDesktop: Unity:Unity7:ubuntu
> >   Date: Fri May  4 16:21:14 2018
> >   InstallationDate: Installed on 2017-04-05 (393 days ago)
> >   InstallationMedia: Ubuntu 16.10 "Yakkety Yak" - Release amd64
> > (20161012.2)
> >   MachineType: Dell Inc. XPS 13 9360
> >   ProcKernelCmdLine: BOOT_IMAGE=3D/vmlinuz-4.15.0-20-generic
> > root=3D/dev/mapper/ubuntu--vg-root ro quiet splash
> > transparent_hugepage=3Dmadvise vt.handoff=3D1
> >   SourcePackage: qemu
> >   UpgradeStatus: Upgraded to bionic on 2018-04-30 (3 days ago)
> >   dmi.bios.date: 02/26/2018
> >   dmi.bios.vendor: Dell Inc.
> >   dmi.bios.version: 2.6.2
> >   dmi.board.name: 0PF86Y
> >   dmi.board.vendor: Dell Inc.
> >   dmi.board.version: A00
> >   dmi.chassis.type: 9
> >   dmi.chassis.vendor: Dell Inc.
> >   dmi.modalias: dmi:bvnDellInc.:bvr2.6.2:bd02/26/2018:svnDellInc.:
> > pnXPS139360:pvr:rvnDellInc.:rn0PF86Y:rvrA00:cvnDellInc.:ct9:cvr:
> >   dmi.product.family: XPS
> >   dmi.product.name: XPS 13 9360
> >   dmi.sys.vendor: Dell Inc.
> >
> > To manage notifications about this bug go to:
> > https://bugs.launchpad.net/qemu/+bug/1769053/+subscriptions
> >
> =

> =

> -- =

> Christian Ehrhardt
> Software Engineer, Ubuntu Server
> Canonical Ltd
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
