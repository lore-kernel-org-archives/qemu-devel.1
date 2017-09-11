Received: from eggs.gnu.org ([2001:4830:134:3::10]:46314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1drTlE-0007Bl-8Q
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:48:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1drTlD-0002f2-7P
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:48:44 -0400
Received: from mail-vk0-x243.google.com ([2607:f8b0:400c:c05::243]:33572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatol.pomozov@gmail.com>)
	id 1drTlC-0002di-Vl
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:48:43 -0400
Received: by mail-vk0-x243.google.com with SMTP id j189so2290558vka.0
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 11:48:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOMFOmWcYxQU7Vf4h+6Q3pxmin5sWH+gNHUFVWGPaMye14Y1ng@mail.gmail.com>
References: <CAOMFOmXXRN02BT+8M+iKnrGmaTSR8uWoTYCu5A5gv+KTe9xAqg@mail.gmail.com>
	<20170730214231.GC16400@localhost.localdomain>
	<CAOMFOmUwi+jF4w7ve4iV_rrPt2uAqZDe6PMZ0r0W047yjFi-gw@mail.gmail.com>
	<f6024bcb-3dcb-609f-c2a7-3d425e738e33@twiddle.net>
	<CAOMFOmVN74ghnqWGyfxHB_LqcSLC8XzRkrk88VXaPh4JRvYRNQ@mail.gmail.com>
	<20170803083956.GD4456@dhcp-200-186.str.redhat.com>
	<CAOMFOmWaFAbkSYj3m1AWMN6sjdpGMzugOFtfArPjzDLx495N3Q@mail.gmail.com>
	<20170808150454.GM4850@dhcp-200-186.str.redhat.com>
	<CAOMFOmWcYxQU7Vf4h+6Q3pxmin5sWH+gNHUFVWGPaMye14Y1ng@mail.gmail.com>
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Mon, 11 Sep 2017 11:48:40 -0700
Message-ID: <CAOMFOmWWi_dEnneYQo2+d2V=uM0ne00OnYJEzFpyDRes_bvRfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] How to make ELF headers/symbol sections available
 for multiboot?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>

Hello

I have these changes ready now
http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg03265.html
It added ELF parser functionality as discussed above. Are there any
open questions? What is the best way to proceed forward with these
patches?

I also have interest in adding Multiboot2 support to qemu. But before
going with it I would like to finish working on my current patchset.

On Thu, Aug 17, 2017 at 1:54 PM, Anatol Pomozov
<anatol.pomozov@gmail.com> wrote:
> Hi
>
> On Tue, Aug 8, 2017 at 8:04 AM, Kevin Wolf <kwolf@redhat.com> wrote:
>> Am 04.08.2017 um 06:53 hat Anatol Pomozov geschrieben:
>>> Hi Kevin
>>>
>>> Thanks for the information.
>>>
>>> So I sounds like we do want multiboot to load all sections regardless
>>> of its segments info. To achieve it we need to read sections headers
>>> and load all section that were not loaded yet.
>>>
>>> I have a working implementation here
>>> https://github.com/anatol/qemu/commit/26773cf4f1f30b2d0d3fd89cce024f8e9c5603c5
>>> Tested it with my multiboot OS image. The target iterates over all
>>> sections and prints their names/address. The output result is the same
>>> for QEMU and for VmWare+GRUB.
>>>
>>> Let me know if this idea looks good so I can send this patch to qemu maillist.
>>
>> I'm not sure if I'll find the time to review this in detail, but I'll
>> just give it a quick look.
>>
>> You seem to attempt to add support for 64 bit ELF binaries. The
>> Multiboot standard doesn't explicitly say that this is forbidden, but
>> everything in it expects 32 bit binaries and I don't think GRUB (as the
>> reference implementation for Multiboot) accepts 64 bit ELFs either. The
>> boot state is 32 bit protected mode in any case. So unless I'm mistaken
>> on GRUB's behaviour, I'd rather not support 64 bit ELFs.
>
> Grub actually does support ELF64 loading with multiboot. Here is the
> GRUB code that implements it
> https://github.com/coreos/grub/blob/master/grub-core/loader/multiboot.c#L210
>
> It would be great if QEMU behaved similar way.
>
> Actually I've been using qemu with ELF64 multiboot for a while and it
> works great.
>
>>
>> You shouldn't look at ELF headers at all if MULTIBOOT_AOUT_KLUDGE is
>> given. In this case, the kernel image is to be treated as a flat binary
>> and section headers can't be expected. I think your code breaks non-ELF
>> kernels.
>
> Ok, will revert this part back.
>
>>
>> As for loading the section headers, duplicating ELF parser code may be
>> functionally correct, but probably not the best way to implement things.
>> As I wrote in an earlier email, load_elf() already parses all the
>> information that you need. You really just need to store it somewhere,
>> which would probably just mean adding a new parameter to load_elf() and
>> the parser could then store a copy of the data there if it's non-NULL.
>
> Loading section headers is actually a small part of my change. It also:
>   - calculates memory needed to load all sections into memory
>   - allocates memory
>   - loads sections
>
> This "load all sections into memory" functionality is very multiboot
> specific. But if you think if load_elf() is better place for it then I
> can look at moving it to load_elf().
