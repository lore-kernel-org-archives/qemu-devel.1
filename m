Received: from eggs.gnu.org ([2001:4830:134:3::10]:36563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emOPE-0006Hl-3w
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:37:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emOPD-0004Jk-8q
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:37:16 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1emOPD-0004I6-1b
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:37:15 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1emOPB-000282-Hn
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 18:37:13 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 18:36:57 +0000
Message-Id: <20180215183700.26101-18-peter.maydell@linaro.org>
In-Reply-To: <20180215183700.26101-1-peter.maydell@linaro.org>
References: <20180215183700.26101-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 17/20] target/arm: Migrate v7m.other_sp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In commit abc24d86cc0364f we accidentally broke migration of
the stack pointer value for the mode (process, handler) the CPU
is not currently running as. (The commit correctly removed the
no-longer-used v7m.current_sp flag from the VMState but also
deleted the still very much in use v7m.other_sp SP value field.)

Add a subsection to migrate it again. (We don't need to care
about trying to retain compatibility with pre-abc24d86cc0364f
versions of QEMU, because that commit bumped the version_id
and we've since bumped it again a couple of times.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180209165810.6668-11-peter.maydell@linaro.org
---
 target/arm/machine.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index 25cdf4d581..1a20d6c36c 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -236,6 +236,16 @@ static const VMStateDescription vmstate_m_scr = {
     }
 };
 
+static const VMStateDescription vmstate_m_other_sp = {
+    .name = "cpu/m/other-sp",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(env.v7m.other_sp, ARMCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_m = {
     .name = "cpu/m",
     .version_id = 4,
@@ -259,6 +269,7 @@ static const VMStateDescription vmstate_m = {
         &vmstate_m_faultmask_primask,
         &vmstate_m_csselr,
         &vmstate_m_scr,
+        &vmstate_m_other_sp,
         NULL
     }
 };
-- 
2.16.1
