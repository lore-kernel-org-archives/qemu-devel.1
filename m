Received: from eggs.gnu.org ([209.51.188.92]:56833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1goYyH-0001Go-65
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 14:22:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1goYyG-0001IN-6E
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 14:22:57 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38761)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1goYyF-0001HX-Td
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 14:22:56 -0500
Received: by mail-pl1-x644.google.com with SMTP id e5so9793703plb.5
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 11:22:55 -0800 (PST)
Date: Tue, 29 Jan 2019 11:22:53 -0800 (PST)
In-Reply-To: <69b40819-748e-d555-316a-6ce90e944bde@mail.uni-paderborn.de>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-2dd4c232-3efb-4173-aae1-491b9aa2685b@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 00/35] target/riscv: Convert to
 decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <Alistair.Francis@wdc.com>
Cc: richard.henderson@linaro.org, peer.adelt@hni.uni-paderborn.de, qemu-riscv@nongnu.org, qemu-devel@nongnu.org, sagark@eecs.berkeley.edu

On Sat, 26 Jan 2019 00:51:23 PST (-0800), Bastian Koppelmann wrote:
> On 1/26/19 12:54 AM, Palmer Dabbelt wrote:
>> On Tue, 22 Jan 2019 13:38:52 PST (-0800), richard.henderson@linaro.org wrote:
>>> On 1/22/19 1:28 AM, Bastian Koppelmann wrote:
>>>> Hi,
>>>>
>>>> this patchset converts the RISC-V decoder to decodetree in four major steps:
>>>>
>>>> 1) Convert 32-bit instructions to decodetree [Patch 1-16]:
>>>>     Many of the gen_* functions are called by the decode functions for 16-bit
>>>>     and 32-bit functions. If we move translation code from the gen_*
>>>>     functions to the generated trans_* functions of decode-tree, we get a lot of
>>>>     duplication. Therefore, we mostly generate calls to the old gen_* function
>>>>     which are properly replaced after step 2).
>>>>
>>>>     Each of the trans_ functions are grouped into files corresponding to their
>>>>     ISA extension, e.g. addi which is in RV32I is translated in the file
>>>>     'trans_rvi.inc.c'.
>>>>
>>>> 2) Convert 16-bit instructions to decodetree [Patch 17-19]:
>>>>     All 16 bit instructions have a direct mapping to a 32 bit instruction. Thus,
>>>>     we convert the arguments in the 16 bit trans_ function to the arguments of
>>>>     the corresponding 32 bit instruction and call the 32 bit trans_ function.
>>>>
>>>> 3) Remove old manual decoding in gen_* function [Patch 20-30]:
>>>>     this move all manual translation code into the trans_* instructions of
>>>>     decode tree, such that we can remove the old decode_* functions.
>>>>
>>>> 4) Simplify RVC by reusing as much as possible from the RVG decoder as suggested
>>>>    by Richard. [Patch 31-35]
>>>>
>>>> full tree available at
>>>> https://github.com/bkoppelmann/qemu/tree/riscv-dt-v5
>>>>
>>>> Cheers,
>>>> Bastian
>>>>
>>>> v4 -> v5:
>>>>     - fixed rebase error
>>>>     - moved TARGET_LONG_BITS check of shift instructions before rd == 0 check
>>>>     - removed extra sign extension of sraiw
>>>>     - removed rs2 == 0 special cases in sraw/srlw
>>>
>>> All looks good to me now.  Thanks for persevering.
>>
>> Thanks for reviewing this.
>>
>> Bastian: what sort of testing have you done here?  This is a pretty big change,
>> and while it's been fairly extensively reviewed I'm just generally paranoid.
>>
>
> I ran riscv-test as well as booting the newest fedora.

Well, that pretty much exhausts my testing scheme :).  I think Alistair might 
have a setup for booting a 32-bit Yocto-based distro in QEMU.  Assuming he has 
the flow set up and it boots then I don't see any reason not to merge it.

Thanks for pulling this all together, it's really great to have a cleaner 
decoder!

Alistair: if that's true, can you give this a shot?

Bastian: do you mind collecting the relevant tags (Reviwed-by, etc) and putting 
them in a v6?
