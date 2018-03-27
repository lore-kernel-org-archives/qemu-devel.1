Received: from eggs.gnu.org ([2001:4830:134:3::10]:45292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f0uh2-0004M0-0p
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 15:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f0ugy-0005Aq-3Z
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 15:55:40 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:38945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1f0ugx-0005AN-Ti
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 15:55:36 -0400
Received: by mail-pl0-x243.google.com with SMTP id s24-v6so64847plq.6
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 12:55:35 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Tue, 27 Mar 2018 12:54:47 -0700
Message-Id: <1522180487-22899-2-git-send-email-mjc@sifive.com>
In-Reply-To: <1522180487-22899-1-git-send-email-mjc@sifive.com>
References: <1522180487-22899-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 1/1] RISC-V: Workaround for critical
 mstatus.FS MTTCG bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peter Maydell <peter.maydell@linaro.org>

This change is a workaround for a bug where mstatus.FS
is not correctly reporting dirty when MTTCG and SMP are
enabled which results in the floating point register file
not being saved during context switches. This a critical
bug for RISC-V in QEMU as it results in floating point
register file corruption when running SMP Linux in the
RISC-V 'virt' machine.

This workaround will return dirty if mstatus.FS is
switched from off to initial or clean. We have checked
the specification and it is legal for an implementation
to return either off, or dirty, if set to initial or clean.

This workaround will result in unnecessary floating point
save restore. When mstatus.FS is off, floating point
instruction trap to indicate the process is using the FPU.
The OS can then save floating-point state of the previous
process using the FPU and set mstatus.FS to initial or
clean. With this workaround, mstatus.FS will always return
dirty if set to a non-zero value, indicating floating point
save restore is necessary, versus misreporting mstatus.FS
resulting in floating point register file corruption.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 target/riscv/op_helper.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index e34715d..7281b98 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -144,8 +144,23 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
         }
 
         mstatus = (mstatus & ~mask) | (val_to_write & mask);
-        int dirty = (mstatus & MSTATUS_FS) == MSTATUS_FS;
-        dirty |= (mstatus & MSTATUS_XS) == MSTATUS_XS;
+
+        /* Note: this is a workaround for an issue where mstatus.FS
+           does not report dirty when SMP and MTTCG is enabled. This
+           workaround is technically compliant with the RISC-V Privileged
+           specification as it is legal to return only off, or dirty,
+           however this may cause unnecessary saves of floating point state.
+           Without this workaround, floating point state is not saved and
+           restored correctly when SMP and MTTCG is enabled, */
+        if (qemu_tcg_mttcg_enabled()) {
+            /* FP is always dirty or off */
+            if (mstatus & MSTATUS_FS) {
+                mstatus |= MSTATUS_FS;
+            }
+        }
+
+        int dirty = ((mstatus & MSTATUS_FS) == MSTATUS_FS) |
+                    ((mstatus & MSTATUS_XS) == MSTATUS_XS);
         mstatus = set_field(mstatus, MSTATUS_SD, dirty);
         env->mstatus = mstatus;
         break;
-- 
2.7.0
