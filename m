Received: from eggs.gnu.org ([209.51.188.92]:53140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gkCBZ-00086f-NJ
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:14:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gkCBW-0004Ry-03
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:14:35 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:50153 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gkCBM-0002Sn-MU
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:14:28 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 17 Jan 2019 19:12:57 +0100
Message-Id: <1547748785-14030-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1547748785-14030-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1547748785-14030-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 04/12] target/mips: Add fields for SAARI and
 SAAR CP0 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Yongbok Kim <yongbok.kim@mips.com>

Add fields for SAARI and SAAR CP0 registers.

Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h     | 10 ++++++++--
 target/mips/machine.c |  6 ++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index b095422..1c2c682 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -164,8 +164,8 @@ typedef struct mips_def_t mips_def_t;
  * 3   BadInstrX
  * 4                                       GuestCtl1         GuestCtl0Ext
  * 5                                       GuestCtl2
- * 6                                       GuestCtl3
- * 7
+ * 6                     SAARI             GuestCtl3
+ * 7                     SAAR
  *
  *
  *     Register 12       Register 13       Register 14       Register 15
@@ -546,6 +546,12 @@ struct CPUMIPSState {
  * CP0 Register 9
  */
     int32_t CP0_Count;
+    uint32_t CP0_SAARI;
+#define CP0SAARI_TARGET 0    /*  5..0  */
+    uint64_t CP0_SAAR[2];
+#define CP0SAAR_BASE    12   /* 43..12 */
+#define CP0SAAR_SIZE    1    /*  5..1  */
+#define CP0SAAR_EN      0
 /*
  * CP0 Register 10
  */
diff --git a/target/mips/machine.c b/target/mips/machine.c
index 704e9c0..111d7c3 100644
--- a/target/mips/machine.c
+++ b/target/mips/machine.c
@@ -214,8 +214,8 @@ const VMStateDescription vmstate_tlb = {
 
 const VMStateDescription vmstate_mips_cpu = {
     .name = "cpu",
-    .version_id = 15,
-    .minimum_version_id = 15,
+    .version_id = 16,
+    .minimum_version_id = 16,
     .post_load = cpu_post_load,
     .fields = (VMStateField[]) {
         /* Active TC */
@@ -274,6 +274,8 @@ const VMStateDescription vmstate_mips_cpu = {
         VMSTATE_UINT32(env.CP0_BadInstrP, MIPSCPU),
         VMSTATE_UINT32(env.CP0_BadInstrX, MIPSCPU),
         VMSTATE_INT32(env.CP0_Count, MIPSCPU),
+        VMSTATE_UINT32(env.CP0_SAARI, MIPSCPU),
+        VMSTATE_UINT64_ARRAY(env.CP0_SAAR, MIPSCPU, 2),
         VMSTATE_UINTTL(env.CP0_EntryHi, MIPSCPU),
         VMSTATE_INT32(env.CP0_Compare, MIPSCPU),
         VMSTATE_INT32(env.CP0_Status, MIPSCPU),
-- 
2.7.4
