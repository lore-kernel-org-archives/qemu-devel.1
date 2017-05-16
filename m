Received: from eggs.gnu.org ([2001:4830:134:3::10]:45086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1dAl7k-0000PD-P7
	for qemu-devel@nongnu.org; Tue, 16 May 2017 18:39:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1dAl7g-0002ZG-Rc
	for qemu-devel@nongnu.org; Tue, 16 May 2017 18:39:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:47485)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1dAl7g-0002Z8-IR
	for qemu-devel@nongnu.org; Tue, 16 May 2017 18:39:20 -0400
From: "Xu, Anthony" <anthony.xu@intel.com>
Date: Tue, 16 May 2017 22:39:17 +0000
Message-ID: <4712D8F4B26E034E80552F30A67BE0B1AB9F97@ORSMSX112.amr.corp.intel.com>
References: <4712D8F4B26E034E80552F30A67BE0B1AB61D5@ORSMSX112.amr.corp.intel.com>
	<ff74288a-d26d-b037-2b55-7dac459aa4ec@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1AB6AA2@ORSMSX112.amr.corp.intel.com>
	<f9c33614-be36-e789-b72b-b4ffcc8bb6a8@redhat.com>
	<20170512193840.GA22454@morn.lan>
	<4712D8F4B26E034E80552F30A67BE0B1AB6CBF@ORSMSX112.amr.corp.intel.com>
	<20170513000141.GA542@morn.lan>
	<4712D8F4B26E034E80552F30A67BE0B1AB6DEF@ORSMSX112.amr.corp.intel.com>
	<20170516162442.GA4177@morn.lan>
	<4712D8F4B26E034E80552F30A67BE0B1AB8B3D@ORSMSX112.amr.corp.intel.com>
	<20170516214211.GA21896@morn.lan>
In-Reply-To: <20170516214211.GA21896@morn.lan>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] target/i386: enable A20 automatically in
 system management mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin O'Connor <kevin@koconnor.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> > > > With the above change,   I got below data
> > > >
> > > > Platform	accel		count of restoring A20 to 0
> > > > Q35		kvm		96
> > > > Q35		tcg		271
> > > > PC		kvm		3
> > > > PC		tcg		3
> > >
> > > Okay, thanks.  I think the number of a20 switches is due to
> > > differences in option rom execution interacting with the fact that
> > > some mode switches were occurring before SeaBIOS set
> > > call16_override().
> > >
> > > > But I still see a lot of PORT_A20 accesses in QEMU as I expected
> > >
> > > Yes, but it should be possible to significantly reduce the number of
> > > outb() calls by limiting them to when A20 changes.  This should also
> > > be useful to reduce the number of outb() calls needed to disable NMIs=
.
> > > I sent a patch series to the seabios mailing list to demonstrate the
> > > idea.
> >
> > If both TCG and KVM work by ignoring A20,  why not remove all PORT_A20
> > access in SeaBios when CONFIG_DISABLE_A20 is not defined?
> > Do you see any impact?
>=20
> The SeaBIOS CONFIG_DISABLE_A20 build option does not mean "disable
> support for A20"; it means "start the initial operating system
> bootloader with A20 disabled".  CONFIG_DISABLE_A20=3Dy is a
> pessimization, not an optimization.
Make sense, Thanks for explanation,=20

>=20
> As for adding a new SeaBIOS build option to compile out support for
> A20 - that seems like a very small optimization that would risk memory
> corruption and hard to diagnose crashes.  SeaBIOS runs natively on
> real hardware (with coreboot and as a CSM on UEFI) as well as on
> QEMU/KVM.
I heard new platform doesn't support A20.
What's the hardware SeaBIOS runs natively on needs A20 support?

It is just a build option, we can disable A20 support for QEMU/KVM and
enable A20 support for real hardware. Any concerns here?

BTW QEMU/KVM ignores A20 even SeaBIOS supports A20.

Or, we can add some logic in SeaBIOS to check if the platform supports A20,
if it doesn't support A20, SeaBIOS won't access PORT_A20 anymore.

The check logic is like,
write 0x55 to 0x00:0xeff0 (or other unused address)
disable A20
write 0xaa to 0xffff:0xf000
read from 0x00:0xeff0,
If the return value is 0x55, A20 is not supported by this platform.


Anthony
