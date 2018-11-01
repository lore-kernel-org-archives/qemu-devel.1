Received: from eggs.gnu.org ([2001:4830:134:3::10]:50406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gIHN8-0004dk-Lc
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 14:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gIHN5-0003GE-Ef
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 14:07:10 -0400
Received: from mail-eopbgr680109.outbound.protection.outlook.com
	([40.107.68.109]:34640
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gIHN5-0003Fo-87
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 14:07:07 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 1 Nov 2018 18:07:03 +0000
Message-ID: <BN6PR2201MB12511109AD96E8B7E824811EC6CE0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <BN6PR2201MB125116B5479010DB326DCCFCC6CE0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<51a26700-5da5-0a15-0e0e-6405ce5e65d4@redhat.com>,
	<20181101172353.GA2316@sx9>
In-Reply-To: <20181101172353.GA2316@sx9>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] Correction needed for R5900 instruction decoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, "Emilio G.
	Cota" <cota@braap.org>
Cc: Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, "Maciej W. Rozycki" <macro@linux-mips.org>, =?iso-8859-1?Q?J=FCrgen_Urban?= <JuergenUrban@gmx.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Fredrik, please do not include handling of any opcode other than those curr=
ently in the tree.

There are good and bad patterns in the code, and not every pattern is OK to=
 follow.

Thanks,
Aleksandar

________________________________________
From: Fredrik Noring <noring@nocrew.org>
Sent: Thursday, November 1, 2018 6:23:53 PM
To: Philippe Mathieu-Daud=E9; Emilio G. Cota; Aleksandar Markovic
Cc: Stefan Markovic; Petar Jovanovic; Aleksandar Rikalo; Maciej W. Rozycki;=
 J=FCrgen Urban; qemu-devel@nongnu.org
Subject: Re: [Qemu-devel] Correction needed for R5900 instruction decoding

[ Philippe and Emilio -- thank you for cc-ing me. Good catch, since I'm
not subscribed to the QEMU mailing list. Changes to the R5900 emulation
are certainly of interest. ]

Hi Aleksandar, Philippe,

On Thu, Nov 01, 2018 at 03:31:54PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Cc'ing Fredrik.
>
> On 1/11/18 12:06, Aleksandar Markovic wrote:
> > Hi, Fridrik,
> >
> > I did some closer code inspection of R5900 in last few days, and I
> > noticed some sub-optimal implementation in the area where R5900-specifi=
c
> > opcodes overlap with the rest-of-MIPS-CPUs opcodes.
> >
> > The right implementation should be based on the principle that all such
> > cases are covered with if statements involving INSN_R5900 flag, like
> > this:
> >
> >          if (ctx->insn_flags & INSN_R5900) {
> >              <R5900-specific handling>
> >          } else {
> >              <rest-of-MIPS-handling>
> >          }
> >
> > You followed that principle for OPC_SPECIAL2 and OPC_SPECIAL3, but for
> > some other opcodes not. For example, there are lines:
> >
> >      if (reg =3D=3D 0 && (opc =3D=3D OPC_MFHI || opc =3D=3D TX79_MMI_MF=
HI1 ||
> >                       opc =3D=3D OPC_MFLO || opc =3D=3D TX79_MMI_MFLO1)=
) {
> >
> > or
> >
> >       switch (opc) {
> >       case OPC_MFHI:
> >       case TX79_MMI_MFHI1:
> >
> > Such implementation makes it difficult to discern R5900 and non-R5900
> > cases. Potentialy allows bugs to sneak in and affect non-R5900 support.

MFLO1, MFHI1, MTLO1 and MTHI1 for the TX79 and the R5900 are already
decoded in the ISA specific decode_tx79_mmi function, and thereby follow
your first suggested pattern. They do however reuse the gen_HILO function,
but it is a simpel matter to post a patch to make a new gen_tx79_HILO1
variant that is almost identical to the original gen_HILO.

The only other case is gen_muldiv that is used for DIV1 and DIVU1. The
same argument applies and a TX79 specific variant would be similar to the
original, but I can certainly post a variant for that one too.

> > The correction is not that difficult, I gather. Worse comme to worst,
> > you can remove R5900 MFLO1 and MFHI1 altogether, they are not that
> > essential at this moment, but do try correcting the decoding stuff as I
> > described. Can you please make these changes in next few days or so
> > (given that 3.1 release is getting closer and closer), and send them to
> > the list?

MFLO1 and MFHI1 are essential for MULT1, MULTU1, DIV1 and DIVU1 as well as
MADD1 and MADDU1 in the patch series I posted 25 October "[PATCH 00/11]
target/mips: Amend R5900 support". I will post updated patches shortly!

> > It is my bad that I didn't spot this during review, but in any case, I
> > think this should be fixed in 3.1 to make sure that non-R5900
> > functionalities are intact.

It is a common pattern in target/mips/translate.c to cover several ISAs
in the same gen_* and decode_* functions, especially when there are only
minor differences between them.

Fredrik
