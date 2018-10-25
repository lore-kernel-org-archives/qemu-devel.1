Received: from eggs.gnu.org ([2001:4830:134:3::10]:35721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gFj11-0007Hz-9e
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gFj0x-0008To-83
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:01:47 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:60057)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gFj0w-0008Jg-SC
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:01:43 -0400
Date: Thu, 25 Oct 2018 19:01:28 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181025170128.GA2309@sx9>
References: <20181023203710.GA2239@sx9>
	<9aea2b05-24d7-f845-d899-0c6fec033672@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9aea2b05-24d7-f845-d899-0c6fec033672@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v8 00/38] target/mips: Limited support for
 the R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, "Maciej W. Rozycki" <macro@linux-mips.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

Hi Richard,

> > Option 3: Extend the mips_opcode::membership field.
> 
> It's trivial to extend the field to uint64_t.

Is the membership field intended to be used? The opcodes for CLZ and CLO
clash with the R5900 opcodes for MADD1 and MADDU1, resulting in incorrect
disassembly of MADD1 and MADDU1. For example:

	0x70853020 madd1  a2,a0,a1  disassembles into  clz a2 or a1,a0
	0x70853021 maddu1 a2,a0,a1  disassembles into  clo a2 or a1,a0

(CLZ and CLO are members of I32|N55, whereas MADD1 and MADDU1 are EE.)

Fredrik

--- a/disas/mips.c
+++ b/disas/mips.c
@@ -2549,12 +2553,16 @@ const struct mips_opcode mips_builtin_opcodes[] =
 {"madd",    "s,t",      0x70000000, 0xfc00ffff, RD_s|RD_t|WR_HILO|IS_M,      0,		G1	},
 {"madd",    "7,s,t",	0x70000000, 0xfc00e7ff, MOD_a|RD_s|RD_t,             0,         D33	},
 {"madd",    "d,s,t",    0x70000000, 0xfc0007ff, RD_s|RD_t|WR_HILO|WR_d|IS_M, 0,		G1	},
+{"madd1", "s,t", 0x70000020, 0xfc00ffff, RD_s | RD_t | WR_HILO | IS_M, 0, EE },
+{"madd1",   "d,s,t", 0x70000020, 0xfc0007ff, RD_s | RD_t | WR_HILO | WR_d | IS_M, 0, EE },
 {"maddp",   "s,t",      0x70000441, 0xfc00ffff,	RD_s|RD_t|MOD_HILO,	     0,		SMT	},
 {"maddu",   "s,t",      0x0000001d, 0xfc00ffff, RD_s|RD_t|WR_HILO,           0,		L1	},
 {"maddu",   "s,t",      0x70000001, 0xfc00ffff, RD_s|RD_t|MOD_HILO,          0,		I32|N55	},
 {"maddu",   "s,t",      0x70000001, 0xfc00ffff, RD_s|RD_t|WR_HILO|IS_M,      0,		G1	},
 {"maddu",   "7,s,t",	0x70000001, 0xfc00e7ff, MOD_a|RD_s|RD_t,             0,         D33	},
 {"maddu",   "d,s,t",    0x70000001, 0xfc0007ff, RD_s|RD_t|WR_HILO|WR_d|IS_M, 0,		G1	},
+{"maddu1", "s,t", 0x70000021, 0xfc00ffff, RD_s | RD_t | WR_HILO | IS_M, 0, EE },
+{"maddu1", "d,s,t", 0x70000021, 0xfc0007ff, RD_s | RD_t | WR_HILO | WR_d | IS_M, 0, EE },
 {"madd16",  "s,t",      0x00000028, 0xfc00ffff, RD_s|RD_t|MOD_HILO,	0,		N411    },
 {"max.ob",  "X,Y,Q",	0x78000007, 0xfc20003f,	WR_D|RD_S|RD_T|FP_D,	0,		MX|SB1	},
 {"max.ob",  "D,S,T",	0x4ac00007, 0xffe0003f,	WR_D|RD_S|RD_T,		0,		N54	},
