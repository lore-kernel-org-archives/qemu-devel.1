Received: from eggs.gnu.org ([2001:4830:134:3::10]:40359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dSCD4-0008It-90
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 21:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dSCD2-0003xH-WA
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 21:00:58 -0400
Received: from mail-pf0-x232.google.com ([2607:f8b0:400e:c00::232]:35526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dSCD2-0003vT-M3
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 21:00:56 -0400
Received: by mail-pf0-x232.google.com with SMTP id c73so107033290pfk.2
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 18:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <1498773362-18675-1-git-send-email-zuban32s@gmail.com>
	<20170630020622-mutt-send-email-mst@kernel.org>
	<ec616cb6-f693-76c5-5732-ec6ee7840d9c@redhat.com>
	<20170703142711.0a1db036@nial.brq.redhat.com>
	<20170703193026-mutt-send-email-mst@kernel.org>
	<8c2c1c27-0b92-3877-3f19-640c82682cc4@redhat.com>
	<20170703212749-mutt-send-email-mst@kernel.org>
	<CAKSfGUDdu8tPKXZz_14QDCZcy4LoVNEqkakGarSD0P9EGftLkg@mail.gmail.com>
In-Reply-To: <CAKSfGUDdu8tPKXZz_14QDCZcy4LoVNEqkakGarSD0P9EGftLkg@mail.gmail.com>
From: Alexander Bezzubikov <zuban32s@gmail.com>
Date: Tue, 04 Jul 2017 01:00:45 +0000
Message-ID: <CAKSfGUA9Fmk5Z0RpQKRi8oKBQd8FYdMbEiJifWSDhKJagjtd5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 0/6] q35: add acpi pci hotplug support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, ehabkost@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net

That is why I think we can consider a possibility of forgetting about ACPI
hot plug in pcie-pci bridge and use only SHPC (with some correcting work).
Especially since q35 is used only for 'modern' Windows guests and there're
no big problems with SHPC on Linux guests.

=D0=B2=D1=82, 4 =D0=B8=D1=8E=D0=BB=D1=8F 2017 =D0=B3. =D0=B2 1:06, Alexande=
r Bezzubikov <zuban32s@gmail.com>:

> Tried it on Win7 Enterprise SP1 - SHPC works well,  _OSC patches aren't
> necessary (since pci-bridge has its own controller, I suppose).
> On Linux guests it works when adding device from CLI with -device, but OS
> seems to fail detecting the device when I add it with device_add from
> monitor.
> Also there're some issues with unplugging on Linux (haven't tested
> unplugging on WIndows yet). That's the news.
>
> 2017-07-03 21:29 GMT+03:00 Michael S. Tsirkin <mst@redhat.com>:
>
>> On Mon, Jul 03, 2017 at 09:26:33PM +0300, Marcel Apfelbaum wrote:
>> > On 03/07/2017 19:34, Michael S. Tsirkin wrote:
>> > > On Mon, Jul 03, 2017 at 02:27:11PM +0200, Igor Mammedov wrote:
>> > > > On Fri, 30 Jun 2017 10:25:05 +0300
>> > > > Marcel Apfelbaum <marcel@redhat.com> wrote:
>> > > >
>> > > > [...]
>> > > > >
>> > > > > So for the modern systems not supporting PCI ACPI hotplug
>> > > > > we don't need pci-bridges anyway, but for the older ones
>> > > > > the ACPI code of the pci-bridge will be loaded into the
>> > > > > ACPI namespace only if a pci-bridge is actually hot-plugged.
>> > > >
>> > > > just note that the set of 'older' guest OSes is limited to
>> > > > one that do not support SHPC (i.e. to EOLed WinXP & co)
>> > > > as for linux and more modern Windows SHPC hotplug should
>> > > > just work without our ACPI hack (which taxes low memory
>> > > > to keep acpi tables for bridges).
>> > > >
>> > > > So I'm in favor of Michael's suggestion to leave ACPI PCI
>> > > > only in PC machine for old WinXP guests and to keep Q35
>> > > > clean, where linux or newer Windows guests could just
>> > > > use standard SHPC.
>> > > >
>> > > > [...]
>> > >
>> > > I didn't realize windows actually supports SHPC for PCI.
>> >
>> > Me neither, if Igor is right I am all for shpc hotplug
>> > since Q35 is not supposed to support older guests.
>> >
>> > I remember I succeeded to enable shpc hotplug some time
>> > ago, but only for Linux guests.
>> >
>> > Igor, do you have some spec/doc on newer Windows OSes that confirm
>> > PCI shpc hotplug support?
>>
>> Just try it, easier than poking at specs which aren't always up to date.
>>
>> > >
>> > > Do they correctly set _OSC Arg3, bit offset 1?
>> > >     SHPC Native Hot Plug control
>> > >     The OS sets this bit to 1 to request control over PCI/PCI-X
>> Standard Hot-Plug Controller
>> > >     (SHPC) hot plug. If the OS successfully receives control of this
>> feature, it must track and
>> > >     update the status of hot plug slots and handle hot plug events a=
s
>> described in the SHPC
>> > >     Specification.
>> > > I was under impression they only set bit 0.
>> > >
>> >
>> > Alexandr, if modern Windows OSes do support shpc, it makes our
>> > job easier, can you please try to enable shpc hotplug?
>> >
>> > Thanks,
>> > Marcel
>>
>> No need to enable or even have a bridge for that at all -
>> set the bit in _OSC, see what does guest enable.
>>
>
>
>
> --
> Alexander Bezzubikov
>
--=20
Alexander Bezzubikov
