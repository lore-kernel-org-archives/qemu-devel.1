Received: from eggs.gnu.org ([2001:4830:134:3::10]:41927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gIAoL-00069k-7W
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 07:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gIAoE-00043N-UJ
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 07:06:46 -0400
Received: from mail-eopbgr690117.outbound.protection.outlook.com
	([40.107.69.117]:11041
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gIAoD-0003vy-0t
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 07:06:42 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 1 Nov 2018 11:06:30 +0000
Message-ID: <BN6PR2201MB125116B5479010DB326DCCFCC6CE0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] Correction needed for R5900 instruction decoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Petar Jovanovic <pjovanovic@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

Hi, Fridrik,

I did some closer code inspection of R5900 in last few days, and I noticed =
some sub-optimal implementation in the area where R5900-specific opcodes ov=
erlap with the rest-of-MIPS-CPUs opcodes.

The right implementation should be based on the principle that all such cas=
es are covered with if statements involving INSN_R5900 flag, like this:

        if (ctx->insn_flags & INSN_R5900) {
            <R5900-specific handling>
        } else {
            <rest-of-MIPS-handling>
        }

You followed that principle for OPC_SPECIAL2 and OPC_SPECIAL3, but for some=
 other opcodes not. For example, there are lines:

    if (reg =3D=3D 0 && (opc =3D=3D OPC_MFHI || opc =3D=3D TX79_MMI_MFHI1 |=
|
                     opc =3D=3D OPC_MFLO || opc =3D=3D TX79_MMI_MFLO1)) {

or

     switch (opc) {
     case OPC_MFHI:
     case TX79_MMI_MFHI1:

Such implementation makes it difficult to discern R5900 and non-R5900 cases=
. Potentialy allows bugs to sneak in and affect non-R5900 support.

The correction is not that difficult, I gather. Worse comme to worst, you c=
an remove R5900 MFLO1 and MFHI1 altogether, they are not that essential at =
this moment, but do try correcting the decoding stuff as I described. Can y=
ou please make these changes in next few days or so (given that 3.1 release=
 is getting closer and closer), and send them to the list?

It is my bad that I didn't spot this during review, but in any case, I thin=
k this should be fixed in 3.1 to make sure that non-R5900 functionalities a=
re intact.

Thanks,
Aleksandar
