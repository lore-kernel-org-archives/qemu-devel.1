Received: from eggs.gnu.org ([2001:4830:134:3::10]:50863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cX7yV-0007wM-4F
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:58:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cX7yT-0002Zr-N2
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:58:03 -0500
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:32793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cX7yT-0002Zb-IK
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:58:01 -0500
Received: by mail-it0-x242.google.com with SMTP id e137so8534129itc.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 06:58:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <95f20307-f7c0-e88f-67c8-45d3f22af588@redhat.com>
References: <cover.1484165352.git.atar4qemu@gmail.com>
	<662c7a5b81926a9daba26c943b0c11e99068c867.1484165352.git.atar4qemu@gmail.com>
	<87bmuumfxp.fsf@dusky.pond.sub.org>
	<CACXAS8CFZzU1-PQenvAX2iSnDoWOo62Zb7mNPJSeJJnzNmyXVQ@mail.gmail.com>
	<8737g4k36w.fsf@dusky.pond.sub.org>
	<95f20307-f7c0-e88f-67c8-45d3f22af588@redhat.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Fri, 27 Jan 2017 15:57:40 +0100
Message-ID: <CACXAS8AxXY0oz2WpT-Q20QcDCa=GbYBY+2PnBO_LJXc1ELtY=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 30/30] target-sparc: fix up niagara
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, Jan 27, 2017 at 3:27 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 27/01/2017 15:06, Markus Armbruster wrote:
>>> Is rom_add_file_fixed supposed to mark the memory region read-only? Or
>>> should it be created read-only before calling rom_add_file_fixed?
>> I'm not familiar with the memory API, but the fact that you're getting
>> RW suggests that you need to mark read-only yourself.  Suggest to
>> examine similar code elsewhere for additional clues.
>>
>>>> The monkey-patching of dinfo->is_default is to silence the "Orphaned
>>>> drive without device" warning.  Naughty.
>>>>
>>>> This use of -drive if=pflash is highly unorthodox.  To suggest better
>>>> ways, we need to understand the role of "the virtual ramdisk".  Can you
>>>> explain?  How does it work on a physical system?
>>> AFAIK except for simulators it's only used on FPGA boards. It's what
>>> the comment says: a kind of initrd, but it resides outside of the
>>> partition RAM. So, it is a RAM region pre-filled with data in the way
>>> not visible to the guest.
>>>
>>> I would have used an -initrd option instead of -pflash, but it
>>> required a -kernel option, and there is no sensible way to use the
>>> -kernel with Solaris.
>>> If QEMU had something like a nvram-disk - it would have worked here the best.
>>
>> Have you considered pressing -bios into service?  -option-rom?  -object
>> memory-backend-file?  Paolo, any recommendations?
>
> Yeah, I think -bios is closest.

I think it may sound misleading to a user: it's an optional
(NV)RAM-disk, not a part of a firmware.
Maybe -object memory-backend-file would do it, but it clears the file
on reset, doesn't it?

> By the way, where do I get all the .rom
> files for the Niagara board?  "make check" complains about them.

The machine uses the firmware supplied with the OpenSPARC T1 project,
http://download.oracle.com/technetwork/systems/opensparc/OpenSPARCT1_Arch.1.5.tar.bz2
in the directory S10image/

Also I posted a patch to silence "make check" a couple of days ago.

-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu
