Received: from eggs.gnu.org ([2001:4830:134:3::10]:38972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1evKkI-0004Mj-9c
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:31:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1evKkF-0003aa-CI
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:31:58 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196]:38619)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1evKkF-00034V-2j
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:31:55 -0400
Received: from unknown (HELO localhost.localdomain)
	(Authenticated_SSL:abouassida@[41.224.44.126])
	(envelope-sender <abdallah.bouassida@lauterbach.com>)
	by smtp1.lauterbach.com (qmail-ldap-1.03) with ECDHE-RSA-AES256-SHA
	encrypted SMTP
	for <qemu-devel@nongnu.org>; 12 Mar 2018 10:31:37 -0000
From: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Date: Mon, 12 Mar 2018 11:31:27 +0100
Message-Id: <1520850690-23245-2-git-send-email-abdallah.bouassida@lauterbach.com>
In-Reply-To: <1520850690-23245-1-git-send-email-abdallah.bouassida@lauterbach.com>
References: <1520850690-23245-1-git-send-email-abdallah.bouassida@lauterbach.com>
Subject: [Qemu-devel] [PATCH v4 1/4] target/arm: Add "ARM_CP_NO_GDB" as a
 new bit field for ARMCPRegInfo type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, khaled.jmal@lauterbach.com, Abdallah Bouassida <abdallah.bouassida@lauterbach.com>

This is a preparation for the coming feature of creating dynamically an XML
description for the ARM sysregs.
A register has ARM_CP_NO_GDB enabled will not be shown in the dynamic XML.
This bit is enabled automatically when creating CP_ANY wildcard aliases.
This bit could be enabled manually for any register we want to remove from the
dynamic XML description.

Signed-off-by: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    | 3 ++-
 target/arm/helper.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2b97408..818a98a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1796,10 +1796,11 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
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
index c82f63d..c5d62c8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5663,7 +5663,7 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
     if (((r->crm == CP_ANY) && crm != 0) ||
         ((r->opc1 == CP_ANY) && opc1 != 0) ||
         ((r->opc2 == CP_ANY) && opc2 != 0)) {
-        r2->type |= ARM_CP_ALIAS;
+        r2->type |= ARM_CP_ALIAS | ARM_CP_NO_GDB;
     }
 
     /* Check that raw accesses are either forbidden or handled. Note that
-- 
2.7.4
