Received: from eggs.gnu.org ([2001:4830:134:3::10]:36373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gUB47-0005zj-Ay
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:48:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gUB46-000140-8u
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:48:43 -0500
Date: Tue, 4 Dec 2018 13:48:30 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181204134830.GB17825@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1543865209-50994-1-git-send-email-peng.hao2@zte.com.cn>
	<CAFEAcA-oFFz-NtfwHmORxQd4rHsfKa1=tV1kyvPuGQoOZwDB3A@mail.gmail.com>
	<20181204124739.GA17825@redhat.com>
	<CAFEAcA_ovMgKPPjtYVASFqhzM7MX79EJYMZuFY4-FGRh4oqN8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_ovMgKPPjtYVASFqhzM7MX79EJYMZuFY4-FGRh4oqN8A@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V11 0/8] add pvpanic mmio support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Peng Hao <peng.hao2@zte.com.cn>, Andrew Jones <drjones@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Dec 04, 2018 at 12:59:51PM +0000, Peter Maydell wrote:
> On Tue, 4 Dec 2018 at 12:47, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
> > After it had merged there were some changes and the question of turni=
ng
> > it into a PCI device was raised. Paolo was concerned that the guest O=
S
> > is in an unknown state (arbitrary locks held, data structures corrupt=
,
> > etc) when panic is fired, so simplicity of the I/O port was desirable=
:
> >
> >   https://lists.gnu.org/archive/html/qemu-devel/2013-08/msg03309.html
> >
> > Anthony countered that even a PCI device could simply do an outb() in
> > config space:
> >
> >   https://lists.gnu.org/archive/html/qemu-devel/2013-08/msg03325.html
> >
> > So it is not clear using a PCI device is in fact a problem in terms o=
f
> > reliability at time of firing.
>=20
> ...and if we'd done it that way in the first place for x86 then
> we wouldn't be having to do anything at all now for Arm.
> That suggests to me that we should do it that way now, and then we
> can avoid having to do a bunch of extra development work for the
> next architecture, or the next interesting Arm board model.

On s390 there's always a panic notifier mechanism as it is a
integral part of the architecture.

On PowerPC, pSeries guests have access to a panic notifier provided
by the firmware.

On x86, as well as pvpanic, there is also a paravirtualized
option defined by the HyperV extensions "hv_crash"

IIUC a PCI based solution would be usable on x86, s390, powerpc (pseries)=
,
aarch64 (virt) and eventually riscv (virt). Of those, it is only
aarch64 and riscv that lack a panic notifier solution today.

I feel like we've already lost from the pov of a standardized solution,
but that doesn't mean we shouldn't still consider using PCI if it does
look like the best otion for arm/riscv.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
