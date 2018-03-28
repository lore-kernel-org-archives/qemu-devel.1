Received: from eggs.gnu.org ([2001:4830:134:3::10]:57740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f0zBO-000688-7l
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 20:43:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f0zBM-00016E-Vq
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 20:43:18 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:37344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1f0zBM-00015a-RW
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 20:43:16 -0400
Received: by mail-pf0-x243.google.com with SMTP id t16so313103pfh.4
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 17:43:16 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Tue, 27 Mar 2018 17:42:26 -0700
Message-Id: <1522197746-26020-3-git-send-email-mjc@sifive.com>
In-Reply-To: <1522197746-26020-1-git-send-email-mjc@sifive.com>
References: <1522197746-26020-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/1] RISC-V: Workaround for critical
 mstatus.FS bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

This change is a workaround for a bug where mstatus.FS
is not correctly reporting dirty after operations that
modify floating point registers. This a critical bug
or RISC-V in QEMU as it results in floating point
register file corruption when running SMP Linux due to
task migration and possibly uniprocessor Linux if
more than one process is using the FPU.

This workaround will return dirty if mstatus.FS is
switched from off to initial or clean. According to
the specification it is legal for an implementation
to return only off, or dirty.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 target/riscv/op_helper.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index e34715d..7c6068b 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -144,8 +144,21 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
         }
 
         mstatus = (mstatus & ~mask) | (val_to_write & mask);
-        int dirty = (mstatus & MSTATUS_FS) == MSTATUS_FS;
-        dirty |= (mstatus & MSTATUS_XS) == MSTATUS_XS;
+
+        /* Note: this is a workaround for an issue where mstatus.FS
+           does not report dirty after floating point operations
+           that modify floating point state. This workaround is
+           technically compliant with the RISC-V Privileged
+           specification as it is legal to return only off, or dirty.
+           at the expense of extra floating point save/restore. */
+
+        /* FP is always dirty or off */
+        if (mstatus & MSTATUS_FS) {
+            mstatus |= MSTATUS_FS;
+        }
+
+        int dirty = ((mstatus & MSTATUS_FS) == MSTATUS_FS) |
+                    ((mstatus & MSTATUS_XS) == MSTATUS_XS);
         mstatus = set_field(mstatus, MSTATUS_SD, dirty);
         env->mstatus = mstatus;
         break;
-- 
2.7.0
