Received: from eggs.gnu.org ([2001:4830:134:3::10]:48778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df645-0000E8-Ul
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:05:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df642-0001Sc-Q7
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:05:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1df642-0001Rk-K7
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:04:58 -0400
Date: Tue, 8 Aug 2017 17:04:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170808150454.GM4850@dhcp-200-186.str.redhat.com>
References: <CAOMFOmXXRN02BT+8M+iKnrGmaTSR8uWoTYCu5A5gv+KTe9xAqg@mail.gmail.com>
	<20170730214231.GC16400@localhost.localdomain>
	<CAOMFOmUwi+jF4w7ve4iV_rrPt2uAqZDe6PMZ0r0W047yjFi-gw@mail.gmail.com>
	<f6024bcb-3dcb-609f-c2a7-3d425e738e33@twiddle.net>
	<CAOMFOmVN74ghnqWGyfxHB_LqcSLC8XzRkrk88VXaPh4JRvYRNQ@mail.gmail.com>
	<20170803083956.GD4456@dhcp-200-186.str.redhat.com>
	<CAOMFOmWaFAbkSYj3m1AWMN6sjdpGMzugOFtfArPjzDLx495N3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMFOmWaFAbkSYj3m1AWMN6sjdpGMzugOFtfArPjzDLx495N3Q@mail.gmail.com>
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
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>

Am 04.08.2017 um 06:53 hat Anatol Pomozov geschrieben:
> Hi Kevin
> 
> Thanks for the information.
> 
> So I sounds like we do want multiboot to load all sections regardless
> of its segments info. To achieve it we need to read sections headers
> and load all section that were not loaded yet.
> 
> I have a working implementation here
> https://github.com/anatol/qemu/commit/26773cf4f1f30b2d0d3fd89cce024f8e9c5603c5
> Tested it with my multiboot OS image. The target iterates over all
> sections and prints their names/address. The output result is the same
> for QEMU and for VmWare+GRUB.
> 
> Let me know if this idea looks good so I can send this patch to qemu maillist.

I'm not sure if I'll find the time to review this in detail, but I'll
just give it a quick look.

You seem to attempt to add support for 64 bit ELF binaries. The
Multiboot standard doesn't explicitly say that this is forbidden, but
everything in it expects 32 bit binaries and I don't think GRUB (as the
reference implementation for Multiboot) accepts 64 bit ELFs either. The
boot state is 32 bit protected mode in any case. So unless I'm mistaken
on GRUB's behaviour, I'd rather not support 64 bit ELFs.

You shouldn't look at ELF headers at all if MULTIBOOT_AOUT_KLUDGE is
given. In this case, the kernel image is to be treated as a flat binary
and section headers can't be expected. I think your code breaks non-ELF
kernels.

As for loading the section headers, duplicating ELF parser code may be
functionally correct, but probably not the best way to implement things.
As I wrote in an earlier email, load_elf() already parses all the
information that you need. You really just need to store it somewhere,
which would probably just mean adding a new parameter to load_elf() and
the parser could then store a copy of the data there if it's non-NULL.

If you have any other specific aspects that you want me to have a closer
look at, just let me know.

Kevin
