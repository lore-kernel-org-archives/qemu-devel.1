Received: from eggs.gnu.org ([2001:4830:134:3::10]:35905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3A-0000ZH-To
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj39-0007Qw-N1
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:16 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fJj39-0007NV-GJ
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:15 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj35-0004jh-1u
	for qemu-devel@nongnu.org; Fri, 18 May 2018 18:20:11 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 18:19:38 +0100
Message-Id: <20180518172009.14416-2-peter.maydell@linaro.org>
In-Reply-To: <20180518172009.14416-1-peter.maydell@linaro.org>
References: <20180518172009.14416-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/32] target/arm: Add "ARM_CP_NO_GDB" as a new
 bit field for ARMCPRegInfo type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>

This is a preparation for the coming feature of creating dynamically an XML
description for the ARM sysregs.
A register has ARM_CP_NO_GDB enabled will not be shown in the dynamic XML.
This bit is enabled automatically when creating CP_ANY wildcard aliases.
This bit could be enabled manually for any register we want to remove from the
dynamic XML description.

Signed-off-by: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 1524153386-3550-2-git-send-email-abdallah.bouassida@lauterbach.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    | 3 ++-
 target/arm/helper.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 3b086be570..c78ccabded 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1821,10 +1821,11 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
 #define ARM_LAST_SPECIAL         ARM_CP_DC_ZVA
 #define ARM_CP_FPU               0x1000
 #define ARM_CP_SVE               0x2000
+#define ARM_CP_NO_GDB            0x4000
 /* Used only as a terminator for ARMCPRegInfo lists */
 #define ARM_CP_SENTINEL          0xffff
 /* Mask of only the flag bits in a type field */
-#define ARM_CP_FLAG_MASK         0x30ff
+#define ARM_CP_FLAG_MASK         0x70ff
 
 /* Valid values for ARMCPRegInfo state field, indicating which of
  * the AArch32 and AArch64 execution states this register is visible in.
diff --git a/target/arm/helper.c b/target/arm/helper.c
index db8bbe52a6..118422b92c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5678,7 +5678,7 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
     if (((r->crm == CP_ANY) && crm != 0) ||
         ((r->opc1 == CP_ANY) && opc1 != 0) ||
         ((r->opc2 == CP_ANY) && opc2 != 0)) {
-        r2->type |= ARM_CP_ALIAS;
+        r2->type |= ARM_CP_ALIAS | ARM_CP_NO_GDB;
     }
 
     /* Check that raw accesses are either forbidden or handled. Note that
-- 
2.17.0
