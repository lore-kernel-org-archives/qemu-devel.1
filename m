Received: from eggs.gnu.org ([2001:4830:134:3::10]:39940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dd2OR-0001RH-HB
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 18:45:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dd2OO-0007Ar-BE
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 18:45:31 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:34764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dd2OO-0007AT-3z
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 18:45:28 -0400
Received: by mail-pg0-x244.google.com with SMTP id y192so7768637pgd.1
	for <qemu-devel@nongnu.org>; Wed, 02 Aug 2017 15:45:27 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <CAOMFOmXXRN02BT+8M+iKnrGmaTSR8uWoTYCu5A5gv+KTe9xAqg@mail.gmail.com>
	<20170730214231.GC16400@localhost.localdomain>
	<CAOMFOmUwi+jF4w7ve4iV_rrPt2uAqZDe6PMZ0r0W047yjFi-gw@mail.gmail.com>
	<f6024bcb-3dcb-609f-c2a7-3d425e738e33@twiddle.net>
	<CAOMFOmVN74ghnqWGyfxHB_LqcSLC8XzRkrk88VXaPh4JRvYRNQ@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <3270e67a-7ebc-6e2e-daeb-bb434dcd781b@twiddle.net>
Date: Wed, 2 Aug 2017 15:45:24 -0700
MIME-Version: 1.0
In-Reply-To: <CAOMFOmVN74ghnqWGyfxHB_LqcSLC8XzRkrk88VXaPh4JRvYRNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Kevin Wolf <kwolf@redhat.com>

On 08/02/2017 03:00 PM, Anatol Pomozov wrote:
> What ELF specification says about it? Does it tell a loader to load
> only PT_LOAD segments?

Yes.  In https://refspecs.linuxfoundation.org/ there is a link to "System V ABI
Edition 4.1", which AFAIK is the latest version of the ELF "gABI" spec.
Section 5 describes program loading.

> Here is my current linker script:
> 
> ======================
> ENTRY(start)
> 
> SECTIONS {
>     . = 1M;
> 
>     .text : {
>         KEEP(*(.data.multiboot))
>         *(.text .text*)
>     }
> 
>     .rodata : {
>         *(.rodata .rodata*)
>     }
> 
>     .data : {
>         *(.data .data.*)
>     }
> 
>     .bss : {
>         __bss_start = .;
>         *(.bss .bss*)
>         . = ALIGN(8);
>         __bss_end = .;
>     }
> }
> =======================

In the gnu ld manual, read about the PHDRS command, which describes all of the
ways you can manipulate the program header table.

Re-reading that now, I see FILEHDR and PHDR as keywords that can be used to
induce those portions of the file into the loadable segment, but I do not see
anything that could be used to load the section header.

You could force the symbol table and string table to be loaded, by referencing
their sections, but that won't affect the section header itself.


r~
