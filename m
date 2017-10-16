Received: from eggs.gnu.org ([2001:4830:134:3::10]:47738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1e4AHN-00089Z-8r
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 14:38:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1e4AHM-0000fY-2w
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 14:38:21 -0400
Received: from mail-ua0-x241.google.com ([2607:f8b0:400c:c08::241]:46542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatol.pomozov@gmail.com>)
	id 1e4AHL-0000Xj-Tz
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 14:38:19 -0400
Received: by mail-ua0-x241.google.com with SMTP id w45so10351266uac.3
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 11:38:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171016082755.GA5145@localhost.localdomain>
References: <20171012235439.19457-1-anatol.pomozov@gmail.com>
	<20171012235439.19457-3-anatol.pomozov@gmail.com>
	<20171013192550.GC3246@localhost.localdomain>
	<CAOMFOmW+r86WHWPUMtG54BrAQXqSWZ67oF-6G697ox-7AKL4GA@mail.gmail.com>
	<20171013232114.GD3246@localhost.localdomain>
	<CAFEAcA-zYJUOqH=WU_XnyxEfiZM7a2yqmzndTrf=pKkp=1wUGA@mail.gmail.com>
	<20171016082755.GA5145@localhost.localdomain>
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Mon, 16 Oct 2017 11:38:17 -0700
Message-ID: <CAOMFOmUM7Ct6kUdrB=y2vk6Fm+dFybQb=8hbcUmKNb2RrL2Lew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/4] multiboot: load any machine type of ELF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi

On Mon, Oct 16, 2017 at 1:27 AM, Kevin Wolf <kwolf@redhat.com> wrote:
> Am 14.10.2017 um 15:41 hat Peter Maydell geschrieben:
>> On 14 October 2017 at 00:21, Eduardo Habkost <ehabkost@redhat.com> wrote:
>> > I don't believe the spec restricts that, but I don't see why it
>> > would be useful to load an ELF file that doesn't match the target
>> > architecture (e.g. loading non-x86 ELF files on a x86 machine
>> > like PC).

I see what do you mean Eduardo. Yes it makes sense to restrict ELF to
the currently emulated platform.

On a second thought adding multiboot support for non x86 needs to go
with other changes, e.g. multiboot.c should be moved out of hw/i386 to
some platform-independent location. It probably worth to postpone this
change until after Qemu gets multiboot2 support that explicitly states
MIPS support, thus it will be easier to test this codepath on multiple
platforms.

So if you don't mind I'll remove this patch from the current patch
series and put it into later one.

>>
>> Agreed. If we have non i386 boards that want to use multiboot
>> we should probably move the common code out of hw/i386...
>
> Impossible with Multiboot 1, it's a spec that is really made for i386.
>
> The spec isn't really explicit about it being a requirement, but it does
> say that its target are 32-bit OSes on PCs, and it defines the boot
> state in terms of i386 registers, so it doesn't make sense for non-x86.
>
> From my interpretation of the spec, even support for 64-bit ELFs seems
> to be (implicitly) out of spec (there is one place where it even says
> "refer to the i386 ELF documentation for details"), but if GRUB
> implements it...

Yes GRUB has support for ELF64 multiboot loading and it successfully
used by many projects in osdev community.

This functionality has been added to GRUB 12 years ago
https://github.com/coreos/grub/commit/ea4097134fbd834d2f688363f9a8208bf6a49ecd
