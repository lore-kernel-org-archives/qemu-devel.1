Received: from eggs.gnu.org ([2001:4830:134:3::10]:33378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1dcENQ-0006Nw-9k
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 13:21:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1dcENP-0003ne-3Q
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 13:21:08 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:33736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatol.pomozov@gmail.com>)
	id 1dcENO-0003kb-UX
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 13:21:07 -0400
Received: by mail-it0-x243.google.com with SMTP id m34so1082051iti.0
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 10:21:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170730214231.GC16400@localhost.localdomain>
References: <CAOMFOmXXRN02BT+8M+iKnrGmaTSR8uWoTYCu5A5gv+KTe9xAqg@mail.gmail.com>
	<20170730214231.GC16400@localhost.localdomain>
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Mon, 31 Jul 2017 10:21:03 -0700
Message-ID: <CAOMFOmUwi+jF4w7ve4iV_rrPt2uAqZDe6PMZ0r0W047yjFi-gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Kevin Wolf <kwolf@redhat.com>

Hi

On Sun, Jul 30, 2017 at 2:42 PM, Eduardo Habkost <ehabkost@redhat.com> wrot=
e:
>
> CCing Alex, the original author of load_multiboot(), and Kevin,
> who touched multiboot code recently.
>
>
> On Fri, Jul 28, 2017 at 02:28:34PM -0700, Anatol Pomozov wrote:
>> Hi
>>
>> I am looking at x86 multiboot code and trying to add "ELF section
>> header" info feature. This will let target to learn more about booted
>> binary and its sections.
>
> Are there existing OSes that use that information?

ELF sections info is needed for an OS to map address space properly.

I do not know much about production-grade OS but multiboot protocol is
quite popular among newly created and hobby OS. Multiboot provide some
useful information that need to be found somewhere else (e.g. by
requesting info from BIOS).

Here is an example of Phil's Rust OS that uses multiboot to read ELF
section information. https://os.phil-opp.com/allocating-frames/ They
use GRUB that loads all ELF sections into memory and provides ELF info
via multiboot structure.

It is interesting to see how LittleKernel tries to find the sections
information by using _start/_end markers in their linker script
https://github.com/littlekernel/lk/blob/master/arch/x86/64/kernel.ld
And while it works, in fact it just tries to recover ELF sections
information. And that is why I think it would be more useful if qemu
implemented ELF sections feature from Multiboot.

> Do you have a pointer to what that feature does exactly?

Quoting Multiboot specification
https://www.gnu.org/software/grub/manual/multiboot/multiboot.html

=3D=3D=3D=3D=3D=3D=3DBEGIN=3D=3D=3D=3D=3D

If bit 5 in the =E2=80=98flags=E2=80=99 word is set, then the following fie=
lds in the
Multiboot information structure starting at byte 28 are valid:

             +-------------------+
     28      | num               |
     32      | size              |
     36      | addr              |
     40      | shndx             |
             +-------------------+

These indicate where the section header table from an ELF kernel is,
the size of each entry, number of entries, and the string table used
as the index of names. They correspond to the =E2=80=98shdr_*=E2=80=99 entr=
ies
(=E2=80=98shdr_num=E2=80=99, etc.) in the Executable and Linkable Format (e=
lf)
specification in the program header. All sections are loaded, and the
physical address fields of the elf section header then refer to where
the sections are in memory (refer to the i386 elf documentation for
details as to how to read the section header(s)). Note that =E2=80=98shdr_n=
um=E2=80=99
may be 0, indicating no symbols, even if bit 5 in the =E2=80=98flags=E2=80=
=99
=3D=3D=3D=3D=3D=3D=3DEND=3D=3D=3D=3D=3D=3D=3D

Basically it makes some info from ELF header and section headers
available for target.
