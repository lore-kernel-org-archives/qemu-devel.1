Received: from eggs.gnu.org ([2001:4830:134:3::10]:60125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1daL06-0007xr-K1
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1daL04-000745-28
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:01:14 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:55094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1daL03-00073X-OO
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:01:12 -0400
References: <e071dd23-8d19-93ba-7962-b2e2df69a6ee@mail.uni-paderborn.de>
	<CAEz=sonvfDHymUBec0Xw3RqhiANmUvrCjqMvn2eQ4zuOu1rH5A@mail.gmail.com>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <58da690d-03d4-2c96-469a-35ff8c25ef1d@mail.uni-paderborn.de>
Date: Wed, 26 Jul 2017 14:00:14 +0200
MIME-Version: 1.0
In-Reply-To: <CAEz=sonvfDHymUBec0Xw3RqhiANmUvrCjqMvn2eQ4zuOu1rH5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [sw-dev] RFC: QEMU RISC-V modular ISA decoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Falvo II <sam.falvo@gmail.com>
Cc: RISC-V SW Dev <sw-dev@groups.riscv.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi Samuel,

On 07/25/2017 04:31 PM, Samuel Falvo II wrote:
> For those of us who are not in the know, how does target/s390 decoding work?

sorry about that. I was going into this with a QEMU-dev mindset :)

The basic idea of s390x is to have every instruction + instruction
formats specified in files that are parsed by the preprocessor and then
used through preprocessor magic to generate switch-case statements for
insn selection and data structures filled with the decoded data.

s390x has two files:
    - insn-data.def -> contains all the instructions, including opcodes,
                       name, ref to insn specific translate function,
                       ref to insn format, and some more
    - insn-format.def -> contains all the instruction formats

these are then used to automatically generate the switch-case statements
and decoding code.

If you want to extend this, you add your own insn format to the
insn-format.def files add functions for decoding parameters in
translate.c. And then add your insn referencing the new format to
insn-def.data and add translation functions for each of them.

The main benefit here is that you don't have to bother with writing all
that boring glue code.

I hope that helped :)

Cheers,
Bastian

> 
> I've maintained a 65816 emulator
> (https://bitbucket.org/kc5tja/lib65816/src) which also uses a giant
> case construct.  This method is used because it's fast.  Any
> alternative approaches you decide to take might well work and satisfy
> extensibility requirements, but it'll likely take a performance hit as
> well.
> 
> On Tue, Jul 25, 2017 at 6:04 AM, Bastian Koppelmann
> <kbastian@mail.uni-paderborn.de> wrote:
>> Hi QEMU devs, hi risc-v-sw devs,
>>
>> I'm posting this cross mailing list since I'd like to get feedback from
>> the both sides.
>>
>> Right now the RISC-V port for QEMU uses the classic decoding scheme of
>> one function decoding the first opcode (and prefixes) and then branches
>> to different functions for decoding the rest (as in target/arm or most
>> of the other targets). This is all done using switch, case statements.
>>
>> This is a little bit tricky to extend, especially for third parties. I
>> don't think it's too bad, but it can definitely be improved and I really
>> like the way target/s390x does it, but I'm not sure about it's drawbacks.
>>
>> I see three options to proceed from here:
>>
>>     1) Completely move to a decoding scheme similar to target/s390x in
>>        QEMU. On the plus side it make it super easy to add new
>>        instructions and/or new instruction formats, and reduces decoding
>>        errors. I don't know the major drawbacks to this approach, maybe
>>        performance. Does anyone know? Other than that it needs a major
>>        rewrite of the decoder, which will take some time and thus delay
>>        the development of RISC-V QEMU upstream. (I think RV32/64I can
>>        be left as is, since everybody has to implement it anyways)
>>
>>     2) The compromise: Leave the core as is, i.e. RV32GC, and provide a
>>        nice interface for any other extension similar to target/s390.
>>        The big plus here is that no code needs to be changed and only
>>        the interface needs to be added. We don't add any performance
>>        overhead (if s390x-style decoding adds any), but this might
>>        result in nobody using it, since they don't know about the
>>        interface and they just hack their stuff in. Then it was a waste
>>        of our time to implement the interface.
>>
>>     3) The status quo. Just leave it as is.
>>
>> Any comments?
>>
>> Cheers,
>> Bastian
>>
>>
>>
>> --
>> You received this message because you are subscribed to the Google Groups "RISC-V SW Dev" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to sw-dev+unsubscribe@groups.riscv.org.
>> To post to this group, send email to sw-dev@groups.riscv.org.
>> Visit this group at https://groups.google.com/a/groups.riscv.org/group/sw-dev/.
>> To view this discussion on the web visit https://groups.google.com/a/groups.riscv.org/d/msgid/sw-dev/e071dd23-8d19-93ba-7962-b2e2df69a6ee%40mail.uni-paderborn.de.
> 
> 
> 
