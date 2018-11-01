Received: from eggs.gnu.org ([2001:4830:134:3::10]:41544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gIGtk-0003nD-FA
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gIGtg-0002YD-0I
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:36:48 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:42354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gIGtf-0002Ws-Bp
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:36:43 -0400
Date: Thu, 1 Nov 2018 18:36:25 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <23e04ec9f8046c358e12046882e8a98a24ed35e5.1541093316.git.noring@nocrew.org>
References: <cover.1541093316.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1541093316.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v2 12/12] disas/mips: Disassemble R5900 DIV[U]1, M{F,
 T}{LO, HI}1 and MULT[U]1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, qemu-devel@nongnu.org

Disassemble the R5900 instructions DIV1, DIVU1, MFLO1, MTLO1, MFHI1,
MTHI1, MULT1 and MULTU1. The opcodes for MADD1 and MADDU1 clash with
the opcodes for CLZ and CLO, resulting in incorrect disassembly. They
are therefore omitted here.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 disas/mips.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/disas/mips.c b/disas/mips.c
index 9f01fda8bd..eddfb59325 100644
--- a/disas/mips.c
+++ b/disas/mips.c
@@ -2323,6 +2323,8 @@ const struct mips_opcode mips_builtin_opcodes[] =
 {"div",     "z,t",      0x0000001a, 0xffe0ffff, RD_s|RD_t|WR_HILO,      0,		I1      },
 {"div",     "d,v,t",	0,    (int) M_DIV_3,	INSN_MACRO,		0,		I1	},
 {"div",     "d,v,I",	0,    (int) M_DIV_3I,	INSN_MACRO,		0,		I1	},
+{"div1",    "z,s,t",  0x7000001a, 0xfc00ffff, RD_s | RD_t | WR_HILO, 0, EE },
+{"div1",    "z,t",    0x7000001a, 0xffe0ffff, RD_s | RD_t | WR_HILO, 0, EE },
 {"div.d",   "D,V,T",	0x46200003, 0xffe0003f,	WR_D|RD_S|RD_T|FP_D,	0,		I1	},
 {"div.s",   "D,V,T",	0x46000003, 0xffe0003f,	WR_D|RD_S|RD_T|FP_S,	0,		I1	},
 {"div.ps",  "D,V,T",	0x46c00003, 0xffe0003f,	WR_D|RD_S|RD_T|FP_D,	0,		SB1	},
@@ -2331,6 +2333,8 @@ const struct mips_opcode mips_builtin_opcodes[] =
 {"divu",    "z,t",      0x0000001b, 0xffe0ffff, RD_s|RD_t|WR_HILO,      0,		I1      },
 {"divu",    "d,v,t",	0,    (int) M_DIVU_3,	INSN_MACRO,		0,		I1	},
 {"divu",    "d,v,I",	0,    (int) M_DIVU_3I,	INSN_MACRO,		0,		I1	},
+{"divu1",   "z,s,t",  0x7000001b, 0xfc00ffff, RD_s | RD_t | WR_HILO, 0, EE },
+{"divu1",   "z,t",    0x7000001b, 0xffe0ffff, RD_s | WR_HILO       , 0, EE },
 {"dla",     "t,A(b)",	0,    (int) M_DLA_AB,	INSN_MACRO,		0,		I3	},
 {"dlca",    "t,A(b)",	0,    (int) M_DLCA_AB,	INSN_MACRO,		0,		I3	},
 {"dli",     "t,j",      0x24000000, 0xffe00000, WR_t,			0,		I3	}, /* addiu */
@@ -2594,8 +2598,10 @@ const struct mips_opcode mips_builtin_opcodes[] =
 {"mfdr",    "t,G",	0x7000003d, 0xffe007ff,	LCD|WR_t|RD_C0,		0,		N5      },
 {"mfhi",    "d",	0x00000010, 0xffff07ff,	WR_d|RD_HI,		0,		I1	},
 {"mfhi",    "d,9",	0x00000010, 0xff9f07ff, WR_d|RD_HI,		0,		D32	},
+{"mfhi1",   "d",  0x70000010, 0xffff07ff, WR_d | RD_HI, 0, EE},
 {"mflo",    "d",	0x00000012, 0xffff07ff,	WR_d|RD_LO,		0,		I1	},
 {"mflo",    "d,9",	0x00000012, 0xff9f07ff, WR_d|RD_LO,		0,		D32	},
+{"mflo1",   "d",  0x70000012, 0xffff07ff, WR_d | RD_LO, 0, EE},
 {"mflhxu",  "d",	0x00000052, 0xffff07ff,	WR_d|MOD_HILO,		0,		SMT	},
 {"min.ob",  "X,Y,Q",	0x78000006, 0xfc20003f,	WR_D|RD_S|RD_T|FP_D,	0,		MX|SB1	},
 {"min.ob",  "D,S,T",	0x4ac00006, 0xffe0003f,	WR_D|RD_S|RD_T,		0,		N54	},
@@ -2661,8 +2667,10 @@ const struct mips_opcode mips_builtin_opcodes[] =
 {"mtdr",    "t,G",	0x7080003d, 0xffe007ff,	COD|RD_t|WR_C0,		0,		N5	},
 {"mthi",    "s",	0x00000011, 0xfc1fffff,	RD_s|WR_HI,		0,		I1	},
 {"mthi",    "s,7",	0x00000011, 0xfc1fe7ff, RD_s|WR_HI,		0,		D32	},
+{"mthi1",   "s",  0x70000011, 0xfc1fffff, RD_s | WR_HI, 0, EE },
 {"mtlo",    "s",	0x00000013, 0xfc1fffff,	RD_s|WR_LO,		0,		I1	},
 {"mtlo",    "s,7",	0x00000013, 0xfc1fe7ff, RD_s|WR_LO,		0,		D32	},
+{"mtlo1",   "s",  0x70000013, 0xfc1fffff, RD_s | WR_LO, 0, EE },
 {"mtlhx",   "s",	0x00000053, 0xfc1fffff,	RD_s|MOD_HILO,		0,		SMT	},
 {"mttc0",   "t,G",	0x41800000, 0xffe007ff, TRAP|COD|RD_t|WR_C0|WR_CC, 0,		MT32	},
 {"mttc0",   "t,+D",	0x41800000, 0xffe007f8, TRAP|COD|RD_t|WR_C0|WR_CC, 0,		MT32	},
@@ -2728,10 +2736,14 @@ const struct mips_opcode mips_builtin_opcodes[] =
 {"mult",    "s,t",      0x00000018, 0xfc00ffff, RD_s|RD_t|WR_HILO|IS_M, 0,		I1	},
 {"mult",    "7,s,t",	0x00000018, 0xfc00e7ff, WR_a|RD_s|RD_t,         0,              D33	},
 {"mult",    "d,s,t",    0x00000018, 0xfc0007ff, RD_s|RD_t|WR_HILO|WR_d|IS_M, 0,		G1	},
+{"mult1",   "s,t",      0x70000018, 0xfc00ffff, RD_s | RD_t | WR_HILO | IS_M, 0, EE },
+{"mult1",   "d,s,t", 0x70000018, 0xfc0007ff, WR_d | RD_s | RD_t | WR_HILO | IS_M, 0, EE },
 {"multp",   "s,t",	0x00000459, 0xfc00ffff,	RD_s|RD_t|MOD_HILO,	0,		SMT	},
 {"multu",   "s,t",      0x00000019, 0xfc00ffff, RD_s|RD_t|WR_HILO|IS_M, 0,		I1	},
 {"multu",   "7,s,t",	0x00000019, 0xfc00e7ff, WR_a|RD_s|RD_t,         0,              D33	},
 {"multu",   "d,s,t",    0x00000019, 0xfc0007ff, RD_s|RD_t|WR_HILO|WR_d|IS_M, 0,		G1	},
+{"multu1",  "s,t",      0x70000019, 0xfc00ffff, RD_s | RD_t | WR_HILO | IS_M, 0, EE },
+{"multu1",  "d,s,t", 0x70000019, 0xfc0007ff, WR_d | RD_s | RD_t | WR_HILO | IS_M, 0, EE },
 {"mulu",    "d,s,t",	0x00000059, 0xfc0007ff,	RD_s|RD_t|WR_HILO|WR_d,	0,		N5	},
 {"neg",     "d,w",	0x00000022, 0xffe007ff,	WR_d|RD_t,		0,		I1	}, /* sub 0 */
 {"negu",    "d,w",	0x00000023, 0xffe007ff,	WR_d|RD_t,		0,		I1	}, /* subu 0 */
-- 
2.18.1
