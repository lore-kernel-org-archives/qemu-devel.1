Received: from eggs.gnu.org ([2001:4830:134:3::10]:34850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbtC-0002Vr-CE
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:07:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbt8-0003Jp-De
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:07:06 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:33281)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Yongbok.Kim@mips.com>)
	id 1fVbt8-0003HG-7L
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:07:02 -0400
From: Yongbok Kim <yongbok.kim@mips.com>
Date: Wed, 20 Jun 2018 13:05:46 +0100
Message-ID: <20180620120620.12806-2-yongbok.kim@mips.com>
In-Reply-To: <20180620120620.12806-1-yongbok.kim@mips.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 01/35] target/mips: Raise a RI when given fs is
 n/a from CTC1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, Aleksandar.Markovic@mips.com, James.Hogan@mips.com, Paul.Burton@mips.com, Matthew.Fortune@mips.com, Stefan.Markovic@mips.com

From: Yongbok Kim <yongbok.kim@imgtec.com>

Fix to raise a Reserved Instruction exception when given fs is not
available from CTC1.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
---
 target/mips/op_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 9025f42..41d3634 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -2627,6 +2627,9 @@ void helper_ctc1(CPUMIPSState *env, target_ulong arg1, uint32_t fs, uint32_t rt)
                (env->active_fpu.fcr31 & ~(env->active_fpu.fcr31_rw_bitmask));
         break;
     default:
+        if (env->insn_flags & ISA_MIPS32R6) {
+            do_raise_exception(env, EXCP_RI, GETPC());
+        }
         return;
     }
     restore_fp_status(env);
-- 
1.9.1
