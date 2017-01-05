Received: from eggs.gnu.org ([2001:4830:134:3::10]:39888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cP0Ec-0001yM-0u
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 00:05:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cP0EY-0005as-Tp
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 00:05:06 -0500
Received: from [114.242.206.163] (port=60205 helo=mail.loongson.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cP0EY-0005WC-2J
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 00:05:02 -0500
From: Jin Guojie <jinguojie@loongson.cn>
Date: Thu,  5 Jan 2017 12:57:45 +0800
Message-Id: <1483592275-4496-1-git-send-email-jinguojie@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 RESEND 00/10] tcg mips64 and mips r6
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, James Hogan <james.hogan@imgtec.com>, YunQiang Su <wzssyqa@gmail.com>, Richard Henderson <rth@twiddle.net>, Jin Guojie <jinguojie@loongson.cn>

Resend for review.  All modifications have been made according to 
Henderson's review comments, and all tests passed.

Changes in v6:
  * Update against master(v2.8.0-rc3)
  * Fix two bugs according to Richard Henderson's review comments
    (1) mask: extend TARGET_PAGE_MASK to the proper type
    (2) zero-extend the guest address, not the address loaded from CMP_OFF
  * MIPS R6: tested successfully on a qemu mipsel64r6 host (emulating I6400)
    - Debian amd64 with qemu-system-x86_64

Changes in v5:
  * Update against master(v2.8.0-rc2)
  * Fix a bug: 64-bit big-endian guests hang on mips64 little-endian
      hosts, and vice versa. This bug was first introduced in v2 patch,
      due to obvious misuse of ret/arg registers in tcg_out_bswap64().

        tcg_out_opc_reg(s, OPC_DSBH, ret, 0, arg);
      - tcg_out_opc_reg(s, OPC_DSHD, ret, 0, arg);
      + tcg_out_opc_reg(s, OPC_DSHD, ret, 0, ret);

  * Fix a style problem: checkpatch.pl forbids 'extern' to be used in .c.

      ERROR: externs should be avoided in .c files
      #28: FILE: tcg/mips/tcg-target.inc.c:39:
      +extern int link_error(void);

      Simply comment the type identifier to pass the check.

  * Tested successfully on following machines:
  
    | HOST        | qemu-system | Debian ISO  |
    |-----------------------------------------|
    | mips 32 le  |    i386     |    i386     |
    | mips 32 le  |    x86_64   |    i386     |
    | mips 32 le  |    x86_64   |    amd64    |
    | mips 64 le  |    i386     |    i386     |
    | mips 64 le  |    x86_64   |    i386     |
    | mips 64 le  |    x86_64   |    amd64    |
    | mips 64 le  |  mips 64 be |  mips 64 be |
    |-----------------------------------------|
    | mips 32 be  |    i386     |     i386    |
    | mips 32 be  |    x86_64   |     i386    |
    | mips 32 be  |    x86_64   |     amd64   |
    | mips 64 be  |    i386     |     i386    |
    | mips 64 be  |    x86_64   |     i386    |
    | mips 64 be  |    x86_64   |     amd64   |
    | mips n32 be |    386      |     i386    |
    | mips n32 be |    x86_64   |     i386    |
    | mips n32 be |    x86_64   |     amd64   |

    (No plan to test MIPS R6 in this patch.)

  Summary of changes from v4:

  | tcg-mips: Support 64-bit opcodes       | Fix tcg_out_bswap64() |
  | tcg-mips: Adjust qemu_ld/st for mips64 | Fix a style problem   |


Changes in v4:
  * tcg_out_qemu_ld_slow_path: always sign-extend 32-bit loads.
    Provide a better solution than patch11 in v3.
    Fix the blocking bug when emulating i386 kernel on mips64el.
  * Redefine LO_OFF/HI_OFF as v2.
    On mips64 host, they are defined as link_error, to ensure that
    all paths that lead to the use of the symbol are eliminated by
    the compiler.

Changes in v3:
  * Update against master(v2.8.0-rc1)
  * Tested on Loongson as mips32r2(el) and mips64r2(el) hosts.
    Loongson only implements little-endian mips32/mips64 ISA.
  * Fully work for 32-bit and 64-bit guests.
    Fix two bugs：segmentation fault on mips64el with 32-bit guests,
                  blocking when emulating i386 kernel on mips64el.
  * Fix some minor style problems.
  * PATCH v2 12~16 are not examined due to the lack of R6 machine. 

Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Tested-by: James Hogan <james.hogan@imgtec.com>
Tested-by: YunQiang Su <wzssyqa@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Jin Guojie <jinguojie@loongson.cn>

Jin Guojie (10):
  tcg-mips: Move bswap code to a subroutine
  tcg-mips: Add mips64 opcodes
  tcg-mips: Support 64-bit opcodes
  tcg-mips: Add bswap32u and bswap64
  tcg-mips: Adjust move functions for mips64
  tcg-mips: Adjust load/store functions for mips64
  tcg-mips: Adjust prologue for mips64
  tcg-mips: Add tcg unwind info
  tcg-mips: Adjust calling conventions for mips64
  tcg-mips: Adjust qemu_ld/st for mips64

 tcg/mips/tcg-target.h     |   60 ++-
 tcg/mips/tcg-target.inc.c | 1170 +++++++++++++++++++++++++++++++++++----------
 2 files changed, 977 insertions(+), 253 deletions(-)

-- 
2.1.0
