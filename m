Received: from eggs.gnu.org ([2001:4830:134:3::10]:40445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bruce.hoult@gmail.com>) id 1da2pp-0001re-4X
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 12:37:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bruce.hoult@gmail.com>) id 1da2pn-0006uk-MW
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 12:37:25 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:34273)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bruce.hoult@gmail.com>)
	id 1da2pn-0006tJ-GJ
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 12:37:23 -0400
Received: by mail-io0-x242.google.com with SMTP id m88so4852750iod.1
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 09:37:21 -0700 (PDT)
MIME-Version: 1.0
Sender: bruce.hoult@gmail.com
In-Reply-To: <e071dd23-8d19-93ba-7962-b2e2df69a6ee@mail.uni-paderborn.de>
References: <e071dd23-8d19-93ba-7962-b2e2df69a6ee@mail.uni-paderborn.de>
From: Bruce Hoult <bruce@hoult.org>
Date: Tue, 25 Jul 2017 19:37:19 +0300
Message-ID: <CAMU+Ekyxu9rwJ4s8xCGb87cSexfGweTmQ_Q7smLVWxjmbVqu_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [sw-dev] RFC: QEMU RISC-V modular ISA decoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: RISC-V SW Dev <sw-dev@groups.riscv.org>, QEMU Developers <qemu-devel@nongnu.org>

Do you have any good estimates for how much of the execution time is
typically spent in instruction decode?

RISC-V qemu is twice as fast as ARM or Aarch64 qemu, so it's doing
something right!

(I suspect it's probably mostly the lack of needing to emulate condition
codes)


On Tue, Jul 25, 2017 at 4:04 PM, Bastian Koppelmann <
kbastian@mail.uni-paderborn.de> wrote:

> Hi QEMU devs, hi risc-v-sw devs,
>
> I'm posting this cross mailing list since I'd like to get feedback from
> the both sides.
>
> Right now the RISC-V port for QEMU uses the classic decoding scheme of
> one function decoding the first opcode (and prefixes) and then branches
> to different functions for decoding the rest (as in target/arm or most
> of the other targets). This is all done using switch, case statements.
>
> This is a little bit tricky to extend, especially for third parties. I
> don't think it's too bad, but it can definitely be improved and I really
> like the way target/s390x does it, but I'm not sure about it's drawbacks.
>
> I see three options to proceed from here:
>
>     1) Completely move to a decoding scheme similar to target/s390x in
>        QEMU. On the plus side it make it super easy to add new
>        instructions and/or new instruction formats, and reduces decoding
>        errors. I don't know the major drawbacks to this approach, maybe
>        performance. Does anyone know? Other than that it needs a major
>        rewrite of the decoder, which will take some time and thus delay
>        the development of RISC-V QEMU upstream. (I think RV32/64I can
>        be left as is, since everybody has to implement it anyways)
>
>     2) The compromise: Leave the core as is, i.e. RV32GC, and provide a
>        nice interface for any other extension similar to target/s390.
>        The big plus here is that no code needs to be changed and only
>        the interface needs to be added. We don't add any performance
>        overhead (if s390x-style decoding adds any), but this might
>        result in nobody using it, since they don't know about the
>        interface and they just hack their stuff in. Then it was a waste
>        of our time to implement the interface.
>
>     3) The status quo. Just leave it as is.
>
> Any comments?
>
> Cheers,
> Bastian
>
>
>
> --
> You received this message because you are subscribed to the Google Groups
> "RISC-V SW Dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to sw-dev+unsubscribe@groups.riscv.org.
> To post to this group, send email to sw-dev@groups.riscv.org.
> Visit this group at https://groups.google.com/a/
> groups.riscv.org/group/sw-dev/.
> To view this discussion on the web visit https://groups.google.com/a/
> groups.riscv.org/d/msgid/sw-dev/e071dd23-8d19-93ba-7962-
> b2e2df69a6ee%40mail.uni-paderborn.de.
>
