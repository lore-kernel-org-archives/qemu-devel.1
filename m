Received: from eggs.gnu.org ([2001:4830:134:3::10]:47903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fCvih-0003yz-Ah
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 19:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fCvif-0001No-QI
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 19:27:03 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:37705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fCvif-0001Nb-IZ
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 19:27:01 -0400
Received: by mail-oi0-x231.google.com with SMTP id f63-v6so6079877oic.4
	for <qemu-devel@nongnu.org>; Sun, 29 Apr 2018 16:27:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8sadsm3SkoZLVk0qWWxfnGAHFbofpxV08QxVpyjZTZkA@mail.gmail.com>
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
	<1519998711-73430-5-git-send-email-mjc@sifive.com>
	<CAFEAcA8sadsm3SkoZLVk0qWWxfnGAHFbofpxV08QxVpyjZTZkA@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Mon, 30 Apr 2018 11:27:00 +1200
Message-ID: <CAHNT7NtRWSibw__EjDdeq7pkd7xe595odxZAxwe2TuQ4OqZ3Nw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 04/23] RISC-V Disassembler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Sat, Apr 28, 2018 at 12:26 AM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 2 March 2018 at 13:51, Michael Clark <mjc@sifive.com> wrote:
> > The RISC-V disassembler has no dependencies outside of the 'disas'
> > directory so it can be applied independently. The majority of the
> > disassembler is machine-generated from instruction set metadata:
> >
> > - https://github.com/michaeljclark/riscv-meta
>
> > +        case 5:
> > +            if (isa == rv128) {
> > +                op = rv_op_c_sqsp;
> > +            } else {
> > +                op = rv_op_c_fsdsp; break;
> > +            }
> > +        case 6: op = rv_op_c_swsp; break;
>
> Coverity (CID1390575) points out that for the
> case 5 / isa == rv128 codepath, we set op, and
> then fall through into case 6 which overwrites it.
>
> Is there a missing "break" statement here? (If the
> fallthrough is deliberate it should be marked with a
> /* fallthrough */ comment.)
>

Thanks!

The disassembler is largely machine generated but the generator has an
issue with ISAs > 2 on a single set of encodings i.e. RVC. The generator
was originally coded for 1 or 2 encodings but I later added rv128 to the
opcodes metadata. I manually edited the generated code to add rv128
disassembly support for compressed instructions, and obviously made a
mistake in hand transcription (the reason I went to the effort of making
the generator). The compressed instructions overload the same encodings
with different meanings for the 3 ISAs, and this is where the generator
fell down, so it was only rv128 compressed instructions that I hand edited.
My own propensity to make mistakes is what attracts me to machine generated
code and of course lots of testing.

128-bit support would be interesting. Fabrice's RISCVEMU supports RV128
however it is an interpreter. If the large guest code is factored
correctly, then we could support RV128 on 64-bit hosts much like we can
support 64-bit targets on 32-bit hosts.

I've just spun and sent a patch for review. Given it's only broken on rv128
I'll just add it to the existing series.

Regards,
Michael.
