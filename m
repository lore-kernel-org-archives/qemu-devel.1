Received: from eggs.gnu.org ([2001:4830:134:3::10]:53930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1daQEd-0007ev-E5
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 13:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1daQEZ-0006CX-LI
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 13:36:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1daQEZ-0006CK-Ce
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 13:36:31 -0400
Date: Wed, 26 Jul 2017 18:36:28 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170726173628.GF30459@redhat.com>
References: <e071dd23-8d19-93ba-7962-b2e2df69a6ee@mail.uni-paderborn.de>
	<CAEz=sonvfDHymUBec0Xw3RqhiANmUvrCjqMvn2eQ4zuOu1rH5A@mail.gmail.com>
	<58da690d-03d4-2c96-469a-35ff8c25ef1d@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58da690d-03d4-2c96-469a-35ff8c25ef1d@mail.uni-paderborn.de>
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
Cc: Samuel Falvo II <sam.falvo@gmail.com>, RISC-V SW Dev <sw-dev@groups.riscv.org>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, Jul 26, 2017 at 02:00:14PM +0200, Bastian Koppelmann wrote:
> Hi Samuel,
> 
> On 07/25/2017 04:31 PM, Samuel Falvo II wrote:
> > For those of us who are not in the know, how does target/s390 decoding work?
> 
> sorry about that. I was going into this with a QEMU-dev mindset :)
> 
> The basic idea of s390x is to have every instruction + instruction
> formats specified in files that are parsed by the preprocessor and then
> used through preprocessor magic to generate switch-case statements for
> insn selection and data structures filled with the decoded data.
> 
> s390x has two files:
>     - insn-data.def -> contains all the instructions, including opcodes,
>                        name, ref to insn specific translate function,
>                        ref to insn format, and some more
>     - insn-format.def -> contains all the instruction formats
> 
> these are then used to automatically generate the switch-case statements
> and decoding code.

I looked at the s390x TCG code for the first time now and this is a
far more sensible way of doing it.  We should do it for all the arches :-)
I wonder if there's a performance penalty?

Rich.

> If you want to extend this, you add your own insn format to the
> insn-format.def files add functions for decoding parameters in
> translate.c. And then add your insn referencing the new format to
> insn-def.data and add translation functions for each of them.
> 
> The main benefit here is that you don't have to bother with writing all
> that boring glue code.
> 
> I hope that helped :)
> 
> Cheers,
> Bastian
> 
> > 
> > I've maintained a 65816 emulator
> > (https://bitbucket.org/kc5tja/lib65816/src) which also uses a giant
> > case construct.  This method is used because it's fast.  Any
> > alternative approaches you decide to take might well work and satisfy
> > extensibility requirements, but it'll likely take a performance hit as
> > well.
> > 
> > On Tue, Jul 25, 2017 at 6:04 AM, Bastian Koppelmann
> > <kbastian@mail.uni-paderborn.de> wrote:
> >> Hi QEMU devs, hi risc-v-sw devs,
> >>
> >> I'm posting this cross mailing list since I'd like to get feedback from
> >> the both sides.
> >>
> >> Right now the RISC-V port for QEMU uses the classic decoding scheme of
> >> one function decoding the first opcode (and prefixes) and then branches
> >> to different functions for decoding the rest (as in target/arm or most
> >> of the other targets). This is all done using switch, case statements.
> >>
> >> This is a little bit tricky to extend, especially for third parties. I
> >> don't think it's too bad, but it can definitely be improved and I really
> >> like the way target/s390x does it, but I'm not sure about it's drawbacks.
> >>
> >> I see three options to proceed from here:
> >>
> >>     1) Completely move to a decoding scheme similar to target/s390x in
> >>        QEMU. On the plus side it make it super easy to add new
> >>        instructions and/or new instruction formats, and reduces decoding
> >>        errors. I don't know the major drawbacks to this approach, maybe
> >>        performance. Does anyone know? Other than that it needs a major
> >>        rewrite of the decoder, which will take some time and thus delay
> >>        the development of RISC-V QEMU upstream. (I think RV32/64I can
> >>        be left as is, since everybody has to implement it anyways)
> >>
> >>     2) The compromise: Leave the core as is, i.e. RV32GC, and provide a
> >>        nice interface for any other extension similar to target/s390.
> >>        The big plus here is that no code needs to be changed and only
> >>        the interface needs to be added. We don't add any performance
> >>        overhead (if s390x-style decoding adds any), but this might
> >>        result in nobody using it, since they don't know about the
> >>        interface and they just hack their stuff in. Then it was a waste
> >>        of our time to implement the interface.
> >>
> >>     3) The status quo. Just leave it as is.
> >>
> >> Any comments?
> >>
> >> Cheers,
> >> Bastian
> >>
> >>
> >>
> >> --
> >> You received this message because you are subscribed to the Google Groups "RISC-V SW Dev" group.
> >> To unsubscribe from this group and stop receiving emails from it, send an email to sw-dev+unsubscribe@groups.riscv.org.
> >> To post to this group, send email to sw-dev@groups.riscv.org.
> >> Visit this group at https://groups.google.com/a/groups.riscv.org/group/sw-dev/.
> >> To view this discussion on the web visit https://groups.google.com/a/groups.riscv.org/d/msgid/sw-dev/e071dd23-8d19-93ba-7962-b2e2df69a6ee%40mail.uni-paderborn.de.
> > 
> > 
> > 
> 
> -- 
> You received this message because you are subscribed to the Google Groups "RISC-V SW Dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to sw-dev+unsubscribe@groups.riscv.org.
> To post to this group, send email to sw-dev@groups.riscv.org.
> Visit this group at https://groups.google.com/a/groups.riscv.org/group/sw-dev/.
> To view this discussion on the web visit https://groups.google.com/a/groups.riscv.org/d/msgid/sw-dev/58da690d-03d4-2c96-469a-35ff8c25ef1d%40mail.uni-paderborn.de.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW
