Received: from eggs.gnu.org ([2001:4830:134:3::10]:42449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gL8bC-0001CK-3u
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:21:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gL8b8-0002y2-PD
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:21:29 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:32810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gL8b6-0002Zo-V4
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:21:25 -0500
Received: by mail-wr1-x441.google.com with SMTP id u9-v6so2313312wrr.0
	for <qemu-devel@nongnu.org>; Fri, 09 Nov 2018 07:21:22 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  9 Nov 2018 15:21:13 +0000
Message-Id: <20181109152119.9242-2-alex.bennee@linaro.org>
In-Reply-To: <20181109152119.9242-1-alex.bennee@linaro.org>
References: <20181109152119.9242-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 1/7] target/arm64: properly handle DBGVR
 RESS bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This only fails with some (broken) versions of gdb but we should
treat the top bits of DBGBVR as RESS. Properly sign extend QEMU's
reference copy of dbgbvr and also update the register descriptions in
the comment.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - sanitise register on insertion
  - update reference description
v3
  - fix bogus sextract64
---
 target/arm/kvm64.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 5de8ff0ac5..6351a54b28 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -103,7 +103,7 @@ static void kvm_arm_init_debug(CPUState *cs)
  * capable of fancier matching but that will require exposing that
  * fanciness to GDB's interface
  *
- * D7.3.2 DBGBCR<n>_EL1, Debug Breakpoint Control Registers
+ * DBGBCR<n>_EL1, Debug Breakpoint Control Registers
  *
  *  31  24 23  20 19   16 15 14  13  12   9 8   5 4    3 2   1  0
  * +------+------+-------+-----+----+------+-----+------+-----+---+
@@ -115,12 +115,25 @@ static void kvm_arm_init_debug(CPUState *cs)
  * SSC/HMC/PMC: Security, Higher and Priv access control (Table D-12)
  * BAS: Byte Address Select (RES1 for AArch64)
  * E: Enable bit
+ *
+ * DBGBVR<n>_EL1, Debug Breakpoint Value Registers
+ *
+ *  63  53 52       49 48       2  1 0
+ * +------+-----------+----------+-----+
+ * | RESS | VA[52:49] | VA[48:2] | 0 0 |
+ * +------+-----------+----------+-----+
+ *
+ * Depending on the addressing mode bits the top bits of the register
+ * are a sign extension of the highest applicable VA bit. Some
+ * versions of GDB don't do it correctly so we ensure they are correct
+ * here so future PC comparisons will work properly.
  */
+
 static int insert_hw_breakpoint(target_ulong addr)
 {
     HWBreakpoint brk = {
         .bcr = 0x1,                             /* BCR E=1, enable */
-        .bvr = addr
+        .bvr = sextract64(addr, 0, 53)
     };
 
     if (cur_hw_bps >= max_hw_bps) {
-- 
2.17.1
