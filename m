Received: from eggs.gnu.org ([2001:4830:134:3::10]:55681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gKTKB-00035x-HI
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:17:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gKTK8-0003uH-Mx
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:17:11 -0500
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:60462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gKTK8-0003tV-Ez
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:17:08 -0500
Date: Wed, 7 Nov 2018 20:17:05 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181107191705.GB31580@sx9>
References: <cover.1541174426.git.noring@nocrew.org>
	<BN6PR2201MB1251AFA493032E33B49A5376C6CA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20181105181242.GB2383@sx9>
	<BN6PR2201MB12516F764B497EEF0C81DF9FC6CA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR2201MB12516F764B497EEF0C81DF9FC6CA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
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
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, qemu-devel@nongnu.org

Hi Aleksandar,

> I think the following code would be even better:
> 
>     case OPC_SC:
>         check_insn(ctx, ISA_MIPS2);
>         check_insn_opc_removed(ctx, ISA_MIPS32R6);
>         if (ctx->insn_flags & INSN_R5900) {
>             check_insn_opc_user_only(ctx, INSN_R5900);
>         }
>         gen_st_cond(ctx, op, rt, rs, imm);
>         break;

Done.

> I don't mind. Later on, we can drop the second argument of
> check_insn_opc_user_only() altogether, and the code would expand to the
> minimal and clear:
> 
>         if (ctx->insn_flags & INSN_R5900) {
> #ifndef CONFIG_USER_ONLY
>             generate_exception_end(ctx, EXCP_RI);
> #endif
>         }
> 
> but at this moment this is not a source of concern to me at all.

OK.

> No, no, you don't need to copy 82 lines. First, you can assume that you
> are already in INSN_R5900 case - no need for frequent check_insn()s.
> Further, you can omit everything that is not needed for R5900 (for
> example, entire OPC_MOVCI case).

Yes, of course. I've made some general updates as well, for example
making use of extract32. I will post v2 in a moment.

Fredrik
