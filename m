Received: from eggs.gnu.org ([209.51.188.92]:46822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmB9w-0005C6-Hq
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 00:33:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmB8X-0003vq-2h
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 00:31:42 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gmB8W-0003v0-KF
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 00:31:41 -0500
Received: by mail-pl1-x642.google.com with SMTP id u6so552954plm.8
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 21:31:39 -0800 (PST)
References: <154800690066.11444.6761064786302350654.reportbug@deadeye.wl.decadent.org.uk>
	<4caef357-e49b-2314-ee19-3ae31f8e4c30@msgid.tls.msk.ru>
	<d78c26dc-727c-b58b-9536-a715aa44da77@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0fd131fc-3802-dde3-e21c-6c3ea5a444e3@linaro.org>
Date: Tue, 22 Jan 2019 21:31:35 -0800
MIME-Version: 1.0
In-Reply-To: <d78c26dc-727c-b58b-9536-a715aa44da77@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Bug#919921: qemu-user Linux ELF loader fails to
 handle pure BSS segments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, 919921@bugs.debian.org, Laurent Vivier <laurent@vivier.eu>, Ben Hutchings <benh@debian.org>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 1/22/19 1:39 AM, Philippe Mathieu-Daudé wrote:
> Hi Ben,
> 
> On 1/22/19 6:43 AM, Michael Tokarev wrote:
>> Forwarding to qemu-devel@
>> http://bugs.debian.org/919921
>>
>> Thanks!
>>
>> 20.01.2019 20:55, Ben Hutchings wrote:
>>> Package: qemu-user
>>> Version: 1:3.1+dfsg-2
>>> Severity: normal
>>> Tags: patch
>>>
>>> I've been building and testing klibc across many architectures using
>>> qemu-user, and I found that qemu-user fails to load a few programs on
>>> a few architectures, reporting an EINVAL error code.  Here's the
>>> "readelf -l" output for one such program:
>>>
>>>      Elf file type is EXEC (Executable file)
>>>      Entry point 0x10000100
>>>      There are 5 program headers, starting at offset 52
>>>           Program Headers:
>>>        Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz 
>>> Flg Align
>>>        PHDR           0x000034 0x10000034 0x10000034 0x000a0 0x000a0
>>> R   0x4
>>>        INTERP         0x0000d4 0x100000d4 0x100000d4 0x0002a 0x0002a
>>> R   0x1
>>>            [Requesting program interpreter:
>>> /lib/klibc-R7FVdnsTBUFpWPgCV6FR07b-mf8.so]
>>>        LOAD           0x000000 0x10000000 0x10000000 0x002f8 0x002f8 R
>>> E 0x10000
>>>        LOAD           0x010000 0x10020000 0x10020000 0x00000 0x08000
>>> RW  0x10000
>>>        GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000
>>> RWE 0x10
>>>            Section to Segment mapping:
>>>        Segment Sections...
>>>         00
>>>         01     .interp
>>>         02     .interp .text .rodata .eh_frame
>>>         03     .bss
>>>         04
>>>
>>> The unusual feature of this program, and all the others that failed,
>>> is that there is a LOAD segment with a file-size of 0 (i.e.  only BSS,
>>> no initialised data).  load_elf_image() will try to mmap() initialised
>>> data for this section even though there is none and a length of 0 is
>>> invalid.
>>>
>>> The change that seems to fix this is to skip the mmap() in this case:
>>>
>>> --- a/linux-user/elfload.c
>>> +++ b/linux-user/elfload.c
>>> @@ -2316,11 +2316,13 @@ static void load_elf_image(const char *i
>>>               vaddr_ps = TARGET_ELF_PAGESTART(vaddr);
>>>               vaddr_len = TARGET_ELF_PAGELENGTH(eppnt->p_filesz +
>>> vaddr_po);
>>>   -            error = target_mmap(vaddr_ps, vaddr_len,
>>> -                                elf_prot, MAP_PRIVATE | MAP_FIXED,
>>> -                                image_fd, eppnt->p_offset - vaddr_po);
>>> -            if (error == -1) {
>>> -                goto exit_perror;
>>> +            if (vaddr_len != 0) {
> 
> This is probably not the good fix, since now your process doesn't have
> anything mapped to use his BSS :)

Not true.  The mapping happens in zero_bss.

> What about this fix instead, using the segment memory size rather than
> the file size:
> 
> -- >8 --
> @@ -2314,7 +2314,7 @@ static void load_elf_image(const char *image_name,
> int image_fd,
>              vaddr = load_bias + eppnt->p_vaddr;
>              vaddr_po = TARGET_ELF_PAGEOFFSET(vaddr);
>              vaddr_ps = TARGET_ELF_PAGESTART(vaddr);
> -            vaddr_len = TARGET_ELF_PAGELENGTH(eppnt->p_filesz + vaddr_po);
> +            vaddr_len = TARGET_ELF_PAGELENGTH(eppnt->p_memsz + vaddr_po);
> 
>              error = target_mmap(vaddr_ps, vaddr_len,
>                                  elf_prot, MAP_PRIVATE | MAP_FIXED,

No, there's only filesz bytes in the file.  I'd expect zero_bss to map over the
extra that you just mapped, but it doesn't help.


r~
