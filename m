Received: from eggs.gnu.org ([2001:4830:134:3::10]:43885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dW97f-0004Z5-Uq
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 18:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dW97a-0001Lu-Vo
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 18:31:43 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:33943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dW97a-0001KU-Kk
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 18:31:38 -0400
Received: by mail-lf0-x244.google.com with SMTP id g21so9093601lfk.1
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 15:31:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170715011517-mutt-send-email-mst@kernel.org>
References: <20170714182012.4595-1-marcandre.lureau@redhat.com>
	<20170714222705-mutt-send-email-mst@kernel.org>
	<71fd872e-ca59-169d-07fb-5e304713fa84@redhat.com>
	<20170715011517-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 15 Jul 2017 00:31:36 +0200
Message-ID: <CAJ+F1CJZ2p_i-SCi-s5=-xcmg4wORv6B_7kjCyRGb5r8oDBWCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 0/8] KASLR kernel dump support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Dave Anderson <anderson@redhat.com>, QEMU <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

Hi

On Sat, Jul 15, 2017 at 12:23 AM, Michael S. Tsirkin <mst@redhat.com> wrote=
:
> On Fri, Jul 14, 2017 at 10:21:43PM +0200, Laszlo Ersek wrote:
>> On 07/14/17 21:59, Michael S. Tsirkin wrote:
>> > On Fri, Jul 14, 2017 at 08:20:03PM +0200, Marc-Andr=C3=A9 Lureau wrote=
:
>> >> Recent linux kernels enable KASLR to randomize phys/virt memory
>> >> addresses. This series aims to provide enough information in qemu
>> >> dumps so that crash utility can work with randomized kernel too (it
>> >> hasn't been tested on other archs than x86 though, help welcome).
>> >>
>> >> The vmcoreinfo device is an emulated ACPI device that exposes a 4k
>> >> memory range to the guest to store various informations useful to
>> >> debug the guest OS. (it is greatly inspired by the VMGENID device
>> >> implementation). The version field with value 0 is meant to give
>> >> paddr/size of the VMCOREINFO ELF PT_NOTE, other values can be used fo=
r
>> >> different purposes or OSes. (note: some wanted to see pvpanic somehow
>> >> merged with this device, I have no clear idea how to do that, nor do =
I
>> >> think this is a good idea since the devices are quite different, used
>> >> at different time for different purposes. And it can be done as a
>> >> future iteration if it is appropriate, feel free to send patches)
>> >
>> > First, I think you underestimate the difficulty of maintaining
>> > compatibility.
>> >
>> > Second, this seems racy - how do you know when is guest done writing o=
ut
>> > the data?
>>
>> What data exactly?
>>
>> The guest kernel module points the fields in the "vmcoreinfo page" to
>> the then-existent vmcoreinfo ELF note. At that point, the ELF note is
>> complete.
>
> When does this happen?

Very early boot afaik. But the exact details on when to expose it is
left to the kernel side. For now, it's a test module I load manually.

>
>> If we catch the guest with a dump request while the kernel module is
>> setting up the fields (i.e., the fields are not consistent), then we'll
>> catch that in our sanity checks, and the note won't be extracted.
>
> Are there assumptions about e.g. in which order pa and size
> are written out then? Atomicity of these writes?

I expect it to be atomic, but as Laszlo said, the code should be quite
careful when trying to read the data.

>
>> This
>> is no different from the case when you simply dump the guest RAM before
>> the module got invoked.
>>
>> > Given you have very little data to export (PA, size - do
>> > you even need size?)
>>
>> Yes, it tells us in advance how much memory to allocate before we copy
>> out the vmcoreinfo ELF note (and we enforce a sanity limit on the size).
>>
>> > - how about just using an ACPI method do it,
>>
>> Do what exactly?
>
> Pass address + size to host - that's what the interface is doing,
> isn't it?
>


The memory region is meant to be usable for other OS, or to export
more details in the future. I think if we add a method, it would be to
tell qemu that the memory has been written, but it may still be
corrupted at the time we read it. So I am not sure it will really help


>> > instead of exporting a physical addess and storing address there.  Thi=
s
>> > way you can add more methods as you add functionality.
>>
>> I'm not saying this is a bad idea (especially because I don't fully
>> understand your point), but I will say that I'm quite sad that you are
>> sending Marc-Andr=C3=A9 back to the drawing board after he posted v4 -- =
also
>> invalidating my review efforts. :/
>>
>> Laszlo
>
> You are right, I should have looked at this sooner. Early RFC
> suggested writing into fw cfg directly. I couldn't find any
> discussion around this - why was this abandoned?

Violation (or rather abuse) of layers iirc



--=20
Marc-Andr=C3=A9 Lureau
