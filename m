Received: from eggs.gnu.org ([2001:4830:134:3::10]:46676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fBU93-0005Gv-Ha
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:48:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fBU92-0005GH-Oy
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:48:17 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:45581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fBU92-0005Fs-I1
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:48:16 -0400
Received: by mail-pf0-x241.google.com with SMTP id l27so16584514pfk.12
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 16:48:16 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Thu, 26 Apr 2018 11:45:22 +1200
Message-Id: <1524699938-6764-20-git-send-email-mjc@sifive.com>
In-Reply-To: <1524699938-6764-1-git-send-email-mjc@sifive.com>
References: <1524699938-6764-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v8 19/35] RISC-V: Allow S-mode mxr access when
 priv ISA >= v1.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>

The mstatus.MXR alias in sstatus should only be writable
by S-mode if the privileged ISA version >= v1.10. Also MXR
was masked in sstatus CSR read but not sstatus CSR writes.
Now we correctly mask sstatus.mxr in both read and write.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 target/riscv/op_helper.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index b81b9b6..88c263a 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -236,7 +236,10 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
         target_ulong ms = env->mstatus;
         target_ulong mask = SSTATUS_SIE | SSTATUS_SPIE | SSTATUS_UIE
             | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS
-            | SSTATUS_SUM | SSTATUS_MXR | SSTATUS_SD;
+            | SSTATUS_SUM | SSTATUS_SD;
+        if (env->priv_ver >= PRIV_VERSION_1_10_0) {
+            mask |= SSTATUS_MXR;
+        }
         ms = (ms & ~mask) | (val_to_write & mask);
         csr_write_helper(env, ms, CSR_MSTATUS);
         break;
@@ -439,7 +442,7 @@ target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno)
     case CSR_SSTATUS: {
         target_ulong mask = SSTATUS_SIE | SSTATUS_SPIE | SSTATUS_UIE
             | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS
-            | SSTATUS_SUM |  SSTATUS_SD;
+            | SSTATUS_SUM | SSTATUS_SD;
         if (env->priv_ver >= PRIV_VERSION_1_10_0) {
             mask |= SSTATUS_MXR;
         }
-- 
2.7.0
