Received: from eggs.gnu.org ([2001:4830:134:3::10]:45824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gUA7G-00067y-Qa
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 07:47:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gUA7F-0003Z2-6g
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 07:47:54 -0500
Date: Tue, 4 Dec 2018 12:47:39 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181204124739.GA17825@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1543865209-50994-1-git-send-email-peng.hao2@zte.com.cn>
	<CAFEAcA-oFFz-NtfwHmORxQd4rHsfKa1=tV1kyvPuGQoOZwDB3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-oFFz-NtfwHmORxQd4rHsfKa1=tV1kyvPuGQoOZwDB3A@mail.gmail.com>
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

On Mon, Dec 03, 2018 at 06:50:03PM +0000, Peter Maydell wrote:
> On Mon, 3 Dec 2018 at 11:04, Peng Hao <peng.hao2@zte.com.cn> wrote:
> >
> > The first patches are simple cleanups:
> >      - patch 1 move the pvpanic device with the 'ocmmon objects' so we compile
> >                it once for the x86/arm/aarch64 archs,
> >      - patch 2 simply renames ISA fields/definitions to generic ones.
> >
> >      Then instead of add/use the MMIO pvpanic device in the virt machine in an
> >      unique patch, I split it in two distinct patches:
> >      - patch 3 uses Peng Hao's work, but add the MMIO interface to the existing
> >         device (no logical change).
> >      - patch 4 is Peng Hao's work in the virt machine (no logical change).
> >      - patch 5 add pvpanic device in acpi table in virt machine
> >      v2 from Peng Hao is:
> >      https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg03433.html
> 
> I would still prefer to see a more detailed examination of whether
> we can do this with a PCI device before we commit to taking the
> MMIO version into the virt board.

The original design rational for using an I/O port is mentioned here,
though it is quite brief:

  http://lists.gnu.org/archive/html/qemu-devel/2012-10/msg04361.html

[quote]
We have three solutions to implement this feature:
1. use vmcall
2. use I/O port
3. use virtio-serial.

We have decided to avoid touching hypervisor. The reason why I choose
choose the I/O port is:
1. it is easier to implememt
2. it does not depend any virtual device
3. it can work when starting the kernel
[/quote]

Later postings then exposed the port via ACPI

  http://lists.nongnu.org/archive/html/qemu-devel/2013-03/msg02293.html

After it had merged there were some changes and the question of turning
it into a PCI device was raised. Paolo was concerned that the guest OS
is in an unknown state (arbitrary locks held, data structures corrupt,
etc) when panic is fired, so simplicity of the I/O port was desirable:

  https://lists.gnu.org/archive/html/qemu-devel/2013-08/msg03309.html

Anthony countered that even a PCI device could simply do an outb() in
config space:

  https://lists.gnu.org/archive/html/qemu-devel/2013-08/msg03325.html

So it is not clear using a PCI device is in fact a problem in terms of
reliability at time of firing.


Perhaps more relevant is the question of how easily it can be initialized,
as that affects whether it can be used for panics during very early boot,
or from firmware:

  https://lists.gnu.org/archive/html/qemu-devel/2013-08/msg03296.html

Finally, there is also the point that PCI slots are precious, and this
is something to be enabled out of the box on all VMs, so you'd be removing
one extra PCI slot from general usage. Thus mgmt apps would need to start
adding PCI bridges sooner. Not a blocker but something to bear in mind
when weighing up options.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
