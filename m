Received: from eggs.gnu.org ([209.51.188.92]:60407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1h0pTO-0004zN-FN
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:25:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1h0pTN-00013t-FE
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:25:46 -0500
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
References: <20190301214945.4353-1-palmer@sifive.com>
	<CAFEAcA-ZbFf+_Bt4QGu6ZchOZtvizWPR_5pFz4vOVVYAf23mgA@mail.gmail.com>
	<36b17c57-7caf-1e49-d500-bf2eddcd1f25@mail.uni-paderborn.de>
Message-ID: <35469245-ab32-5cb9-52d7-9ead8ffe6c42@mail.uni-paderborn.de>
Date: Mon, 4 Mar 2019 16:25:40 +0100
MIME-Version: 1.0
In-Reply-To: <36b17c57-7caf-1e49-d500-bf2eddcd1f25@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PULL] target/riscv: Convert to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt <palmer@sifive.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, "open list:RISC-V" <qemu-riscv@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>


On 3/4/19 1:52 PM, Bastian Koppelmann wrote:
>
> On 3/4/19 12:02 PM, Peter Maydell wrote:
>> On Fri, 1 Mar 2019 at 21:49, Palmer Dabbelt <palmer@sifive.com> wrote:
>>> merged tag 'i2c-for-release-20190228'
>>> Primary key fingerprint: FD0D 5CE6 7CE0 F59A 6688  2686 61F3 8C90 
>>> 919B FF81
>>> The following changes since commit 
>>> 20b084c4b1401b7f8fbc385649d48c67b6f43d44:
>>>
>>>    Merge remote-tracking branch 
>>> 'remotes/cminyard/tags/i2c-for-release-20190228' into staging 
>>> (2019-03-01 11:20:49 +0000)
>>>
>>> are available in the Git repository at:
>>>
>>>    git://github.com/palmer-dabbelt/qemu.git 
>>> tags/riscv-for-master-4.0-sf2
>>>
>>> for you to fetch changes up to 
>>> 0bcba29464ea9969fc69cd729e4c8bddfb2e18e3:
>>>
>>>    target/riscv: Remaining rvc insn reuse 32 bit translators 
>>> (2019-03-01 13:16:18 -0800)
>>>
>>> ----------------------------------------------------------------
>>> target/riscv: Convert to decodetree
>>>
>>> Bastian: this patchset converts the RISC-V decoder to decodetree in 
>>> four major steps:
>>>
>>> 1) Convert 32-bit instructions to decodetree [Patch 1-15]:
>>>      Many of the gen_* functions are called by the decode functions 
>>> for 16-bit
>>>      and 32-bit functions. If we move translation code from the gen_*
>>>      functions to the generated trans_* functions of decode-tree, we 
>>> get a lot of
>>>      duplication. Therefore, we mostly generate calls to the old 
>>> gen_* function
>>>      which are properly replaced after step 2).
>>>
>>>      Each of the trans_ functions are grouped into files 
>>> corresponding to their
>>>      ISA extension, e.g. addi which is in RV32I is translated in the 
>>> file
>>>      'trans_rvi.inc.c'.
>>>
>>> 2) Convert 16-bit instructions to decodetree [Patch 16-18]:
>>>      All 16 bit instructions have a direct mapping to a 32 bit 
>>> instruction. Thus,
>>>      we convert the arguments in the 16 bit trans_ function to the 
>>> arguments of
>>>      the corresponding 32 bit instruction and call the 32 bit trans_ 
>>> function.
>>>
>>> 3) Remove old manual decoding in gen_* function [Patch 19-29]:
>>>      this move all manual translation code into the trans_* 
>>> instructions of
>>>      decode tree, such that we can remove the old decode_* functions.
>>>
>>> 4) Simplify RVC by reusing as much as possible from the RVG decoder 
>>> as suggested
>>>     by Richard. [Patch 30-34]
>>>
>>> Palmer: This passed Alistar's testing on rv32 and rv64 as well as my
>>> testing on rv64, so I think it's good to go.  Thanks for the cleanup!
>>>
>> Hi; I'm afraid this has compile errors on the OSX build:
>>
>>
>> In file included from
>> /Users/pm215/src/qemu-for-merges/target/riscv/translate.c:377:
>> target/riscv/decode_insn16.inc.c:37:15: error: redefinition of typedef
>> 'arg_fld' is a C11 feature [-Werror,-Wtypedef-redefinition]
>> typedef arg_i arg_fld;
>>                ^
>> target/riscv/decode_insn32.inc.c:293:15: note: previous definition is 
>> here
>> typedef arg_i arg_fld;
>
>
> This looks like an unforeseen decodetree problem (CC' Richard). As 
> these 16/32 instructions share the same trans_* function, we emit the 
> same typedef once for 16 bit and once for 32 bit. I don't see an easy 
> fix in decodetree other than annotating one of the instructions with 
> something like !shared , since both insn are parsed in two runs of 
> decodetree and later included together into one file. I'll try to 
> prepare a patch.

This is something we can figure out after this PR. @Palmer I think you 
can drop patches 30-34 for now as these are the offenders and the rest 
of the PR is fine.

Cheers,

Bastian
