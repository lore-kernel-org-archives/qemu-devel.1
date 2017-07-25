Received: from eggs.gnu.org ([2001:4830:134:3::10]:36211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1dZzWc-0000eT-5c
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1dZzWZ-0005y6-27
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:05:22 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:50759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1dZzWY-0005vL-O2
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:05:19 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <e071dd23-8d19-93ba-7962-b2e2df69a6ee@mail.uni-paderborn.de>
Date: Tue, 25 Jul 2017 15:04:18 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] RFC: QEMU RISC-V modular ISA decoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: RISC-V SW Dev <sw-dev@groups.riscv.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi QEMU devs, hi risc-v-sw devs,

I'm posting this cross mailing list since I'd like to get feedback from
the both sides.

Right now the RISC-V port for QEMU uses the classic decoding scheme of
one function decoding the first opcode (and prefixes) and then branches
to different functions for decoding the rest (as in target/arm or most
of the other targets). This is all done using switch, case statements.

This is a little bit tricky to extend, especially for third parties. I
don't think it's too bad, but it can definitely be improved and I really
like the way target/s390x does it, but I'm not sure about it's drawbacks.

I see three options to proceed from here:

    1) Completely move to a decoding scheme similar to target/s390x in
       QEMU. On the plus side it make it super easy to add new
       instructions and/or new instruction formats, and reduces decoding
       errors. I don't know the major drawbacks to this approach, maybe
       performance. Does anyone know? Other than that it needs a major
       rewrite of the decoder, which will take some time and thus delay
       the development of RISC-V QEMU upstream. (I think RV32/64I can
       be left as is, since everybody has to implement it anyways)

    2) The compromise: Leave the core as is, i.e. RV32GC, and provide a
       nice interface for any other extension similar to target/s390.
       The big plus here is that no code needs to be changed and only
       the interface needs to be added. We don't add any performance
       overhead (if s390x-style decoding adds any), but this might
       result in nobody using it, since they don't know about the
       interface and they just hack their stuff in. Then it was a waste
       of our time to implement the interface.

    3) The status quo. Just leave it as is.

Any comments?

Cheers,
Bastian
