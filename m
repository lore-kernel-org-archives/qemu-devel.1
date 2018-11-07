Received: from eggs.gnu.org ([2001:4830:134:3::10]:55796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gKTKj-0003vs-PV
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:17:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gKTKg-00046j-V1
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:17:45 -0500
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:60491)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gKTKg-00045e-MU
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:17:42 -0500
Date: Wed, 7 Nov 2018 20:17:35 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <cover.1541616663.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH v2 0/6] Fix decoding mechanisms of the R5900
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

This series amends the R5900 support with the following changes:

- MFLO1, MFHI1, MTLO1 and MTHI1 are generated in gen_HILO1_tx79 instead
  of the generic gen_HILO.

- DIV1 and DIVU1 are generated in gen_div1_tx79 instead of the generic
  gen_muldiv.

- MOVN, MOVZ, MFHI, MFLO, MTHI, MTLO, MULT, MULTU, DIV, DIVU, DMULT,
  DMULTU, DDIV, DDIVU and JR are decoded in decode_opc_special_tx79
  instead of the generic decode_opc_special_legacy.

- Guard check_insn_opc_user_only with INSN_R5900 check.

- Guard check_insn with INSN_R5900 check.

- Fix HI[ac] and LO[ac] 32-bit truncation with the MIPS64 DSP ASE.

This series has been successfully built with the 8 different build
configurations

    {gcc,clang} x -m64 x mips{,64}el-{linux-user,softmmu}

in addition successfully completing the R5900 test suite

    cd tests/tcg/mips/mipsr5900 && make check

Changes in v2:
- Fix HI and LO 32-bit truncation with the MIPS64 DSP ASE
- Decode special R5900 opcodes in decode_opc_special_tx79
- Guard check_insn_opc_user_only with INSN_R5900 check
- Guard check_insn with INSN_R5900 check

Fredrik Noring (6):
  target/mips: Fix decoding mechanism of R5900 MFLO1, MFHI1, MTLO1 and MTHI1
  target/mips: Fix decoding mechanism of R5900 DIV1 and DIVU1
  target/mips: Fix HI[ac] and LO[ac] 32-bit truncation with MIPS64 DSP ASE
  target/mips: Fix decoding mechanism of special R5900 opcodes
  target/mips: Guard check_insn_opc_user_only with INSN_R5900 check
  target/mips: Guard check_insn with INSN_R5900 check

 target/mips/translate.c | 229 +++++++++++++++++++++++++++++-----------
 1 file changed, 170 insertions(+), 59 deletions(-)

-- 
2.18.1
