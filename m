Received: from eggs.gnu.org ([2001:4830:134:3::10]:48971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fa0UD-0004Sn-G9
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:11:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fa0UA-0008FZ-LF
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:11:29 -0400
Received: from mail-pl0-x22b.google.com ([2607:f8b0:400e:c01::22b]:44643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fa0UA-0008F2-Fh
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:11:26 -0400
Received: by mail-pl0-x22b.google.com with SMTP id m16-v6so8093629pls.11
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 08:11:26 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Tue,  3 Jul 2018 00:10:17 +0900
Message-Id: <20180702151023.24532-20-shorne@gmail.com>
In-Reply-To: <20180702151023.24532-1-shorne@gmail.com>
References: <20180702151023.24532-1-shorne@gmail.com>
Subject: [Qemu-devel] [PULL v2 19/25] target/openrisc: Increase the TLB size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Development <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Stafford Horne <shorne@gmail.com>

From: Richard Henderson <richard.henderson@linaro.org>

The architecture supports 128 TLB entries.  There is no reason
not to provide all of them.  In the process we need to fix a
bug that failed to parameterize the configuration register that
tells the operating system the number of entries.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>

---
v2:
  - Change VMState version.
---
 target/openrisc/cpu.c     | 6 ++++--
 target/openrisc/cpu.h     | 2 +-
 target/openrisc/machine.c | 5 ++---
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index b92de51ecf..e01ce9ed1c 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -57,8 +57,10 @@ static void openrisc_cpu_reset(CPUState *s)
 
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
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 47e94659e1..b180e30e9e 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -222,7 +222,7 @@ enum {
 
 /* TLB size */
 enum {
-    TLB_SIZE = 64,
+    TLB_SIZE = 128,
     TLB_MASK = TLB_SIZE - 1,
 };
 
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
2.17.0
