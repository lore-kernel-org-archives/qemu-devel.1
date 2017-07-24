Received: from eggs.gnu.org ([2001:4830:134:3::10]:43031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <huayanghao@gmail.com>) id 1dZjZa-00074T-Db
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <huayanghao@gmail.com>) id 1dZjZZ-0001MZ-B7
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:03:22 -0400
Received: from mail-yw0-x241.google.com ([2607:f8b0:4002:c05::241]:37412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <huayanghao@gmail.com>)
	id 1dZjZZ-0001MF-69
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:03:21 -0400
Received: by mail-yw0-x241.google.com with SMTP id h189so5657502ywf.4
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 13:03:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-R5DJUgT=fLDM4uYcRFyDWVm6hnJiPuS55jg=1AThZ6Q@mail.gmail.com>
References: <CAPTzt1Ai9x4OiHMH4HrDzj=vNbqhNnkmdDQ7wBLxYTJ-kcNM_w@mail.gmail.com>
	<CAFEAcA_TYFbv9EeafV8FZ=HEXx=kArVb2OYiC3mGQiP7_N1-UA@mail.gmail.com>
	<CAFEAcA-R5DJUgT=fLDM4uYcRFyDWVm6hnJiPuS55jg=1AThZ6Q@mail.gmail.com>
From: Hua Yanghao <huayanghao@gmail.com>
Date: Mon, 24 Jul 2017 22:03:19 +0200
Message-ID: <CAPTzt1DoAyZ3bCD3JDrt2-7UckQQ9dzG5mTrNBApoPpQ1GpV-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/core/loader: do not check for regions
 overlap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, Jul 24, 2017 at 6:46 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 23 July 2017 at 21:44, Peter Maydell <peter.maydell@linaro.org> wrote:
>> Does anybody know (a) what the ELF spec mandates
>> for overlapping segments and (b) what the history
>> and rationale for QEMU's overlapping-roms check is?
>
> Having asked around a bit, it appears that it's fairly common
> in the embedded world to treat the ELF "vaddr" as the "execution
> address" and the ELF "paddr" as "load address", with the
> size of the data to be loaded at the load address being
> specified by "filesz". The typical application is where
> an application is packed into ROM -- the ROM addresses are
> the paddr values, and something at runtime will unpack
> everything into the vaddr addresses where it eventually
> runs from (and handle the zero-initialization).

That's exactly what I am doing right now ;-)
I have code at runtime not only initialize the bss, but also moving
a few other sections around (e.g. from dram to onchip memory).
And we even have use cases that the bss part should not be
initialized at all! (on accurate simulation env where the .bss is
preloaded with zeros, without overlapping sections of course)

> The awkward part is that this is more pervasive convention
> rather than actually written down as a specification, and
> there's no way to tell whether a particular ELF file is
> using it or not.

Indeed, I thought this is the standard written somewhere :-)
Maybe I am just in the embedded world for too long.

> My current theory is that we can handle this with:
>  * load the segment with the assumption that the
>    memsz is the size to use (zero-filling), as
>    we do now
>  * _unless_ that would make it overlap with the following
>    segment, in which case use the filesz
>
> That ought to make all the ELF files we currently load
> OK continue to load with the same semantics, and also
> permit loading of ELF files using the ARM embedded
> conventions. In some cases of ELF files using the
> embedded convention but not tightly packing their
> segments into ROM it will zero out some of the gaps
> between segments, but I think that should be harmless.

Sounds good PPM! currently I am working around this by
objcopy a pure binary and it looks like qemu-system-arm is
loading a binary at loader address + 0x10000. From man page
it claims it also supports multiboot image which I thought I could
remove this loader address + 0x10000 limiation however with
no luck. but the binary works pretty fine though at the fixed address.
not as convenient as elf image which I can run from any address.

If this can be implemented in mainline I will be very happy but
my knowledge with qemu is probably not enough to make a clean
patch. Thanks a lot for the good discussion!

BR, Yanghao
