Received: from eggs.gnu.org ([2001:4830:134:3::10]:45284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gJemU-0002CZ-5j
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:19:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gJemR-0005rt-2S
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:19:02 -0500
Received: from mail-eopbgr700135.outbound.protection.outlook.com
	([40.107.70.135]:54496
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gJemQ-0005pu-RP
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:18:59 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 5 Nov 2018 13:18:53 +0000
Message-ID: <BN6PR2201MB1251AFA493032E33B49A5376C6CA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <cover.1541174426.git.noring@nocrew.org>
In-Reply-To: <cover.1541174426.git.noring@nocrew.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/2] target/mips: Fix decoding mechanisms
 of R5900 M{F, T}{HI, LO}1 and DIV[U]1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: =?iso-8859-1?Q?J=FCrgen_Urban?= <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> From: Fredrik Noring <noring@nocrew.org>
>
> Subject: [PATCH 0/2] target/mips: Fix decoding mechanisms of R5900 M{F,T}=
{HI,LO}1 and DIV[U]1
>=20
> This series amends the R5900 support with the following changes:
>
> ...

Hi, Fridrek,

The two patches look very good. Yes, there will be some code duplication no=
w, but the overall MIPS code is safer, R5900 code better encapsulated - and=
 you have more flexibility to tweak R5900 functionality.

For LL, SC, LLD and SCD instructions, there is a need to properly insulate =
their R5900 versions too, similar to this:

    case OPC_SC:
        if(ctx->insn_flags & INSN_R5900) {
             check_insn_opc_user_only(ctx, INSN_R5900);
        } else {
            check_insn(ctx, ISA_MIPS2);
        }
        gen_st_cond(ctx, op, rt, rs, imm);
        break;

(the code above is just a form of pseudocode illustrating the idea; I don't=
 guarantee the correctness for build purposes, or if this is the best code =
organization)

Non-R5900 code (for the time being) should never invoke check_insn_opc_user=
_only(). *The only way* of distinguishing R5900 code paths from the other C=
PUs code paths should be by using  "if(ctx->insn_flags & INSN_R5900)"!

For changes in decode_opc_special_legacy(), there shouldn't be there, but t=
here should be a separate function decode_opc_special_tx59() or so.

Thanks,
Aleksandar
