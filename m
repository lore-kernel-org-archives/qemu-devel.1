Received: from eggs.gnu.org ([2001:4830:134:3::10]:57453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUz5f-0003ZG-Bx
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUz5d-0004yO-VI
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:41:23 -0400
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:34540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fUz5d-0004xK-Pj
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:41:21 -0400
Received: by mail-pf0-x231.google.com with SMTP id a63-v6so8613279pfl.1
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 11:41:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Jun 2018 08:40:41 -1000
Message-Id: <20180618184046.6270-18-richard.henderson@linaro.org>
In-Reply-To: <20180618184046.6270-1-richard.henderson@linaro.org>
References: <20180618184046.6270-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 17/22] target/openrisc: Increase the TLB size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: shorne@gmail.com

The architecture supports 128 TLB entries.  There is no reason
not to provide all of them.  In the process we need to fix a
bug that failed to parameterize the configuration register that
tells the operating system the number of entries.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

---
v2:
  - Change VMState version.
---
 target/openrisc/cpu.h     | 2 +-
 target/openrisc/cpu.c     | 6 ++++--
 target/openrisc/machine.c | 5 ++---
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 53abe965e8..8035654087 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -222,7 +222,7 @@ enum {
 
 /* TLB size */
 enum {
-    TLB_SIZE = 64,
+    TLB_SIZE = 128,
     TLB_MASK = TLB_SIZE - 1,
 };
 
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 4c166c6329..677f02efa4 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -52,8 +52,10 @@ static void openrisc_cpu_reset(CPUState *s)
 
     cpu->env.upr = UPR_UP | UPR_DMP | UPR_IMP | UPR_PICP | UPR_TTP |
                    UPR_PMP;
-    cpu->env.dmmucfgr = (DMMUCFGR_NTW & (0 << 2)) | (DMMUCFGR_NTS & (6 << 2));
-    cpu->env.immucfgr = (IMMUCFGR_NTW & (0 << 2)) | (IMMUCFGR_NTS & (6 << 2));
+    cpu->env.dmmucfgr = (DMMUCFGR_NTW & (0 << 2))
+                      | (DMMUCFGR_NTS & (ctz32(TLB_SIZE) << 2));
+    cpu->env.immucfgr = (IMMUCFGR_NTW & (0 << 2))
+                      | (IMMUCFGR_NTS & (ctz32(TLB_SIZE) << 2));
 
 #ifndef CONFIG_USER_ONLY
     cpu->env.picmr = 0x00000000;
diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index 3fc837b925..1eedbf3dbe 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -38,9 +38,8 @@ static const VMStateDescription vmstate_tlb_entry = {
 
 static const VMStateDescription vmstate_cpu_tlb = {
     .name = "cpu_tlb",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .minimum_version_id_old = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (VMStateField[]) {
         VMSTATE_STRUCT_ARRAY(itlb, CPUOpenRISCTLBContext, TLB_SIZE, 0,
                              vmstate_tlb_entry, OpenRISCTLBEntry),
-- 
2.17.1
