Received: from eggs.gnu.org ([2001:4830:134:3::10]:35122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1ew6UE-0004QT-0p
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 09:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1ew6U8-0001wB-77
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 09:30:34 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196]:55868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1ew6U7-0001ll-L3
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 09:30:27 -0400
Received: from unknown (HELO localhost.localdomain)
	(Authenticated_SSL:abouassida@[41.224.44.126])
	(envelope-sender <abdallah.bouassida@lauterbach.com>)
	by smtp1.lauterbach.com (qmail-ldap-1.03) with ECDHE-RSA-AES256-SHA
	encrypted SMTP
	for <qemu-devel@nongnu.org>; 14 Mar 2018 13:30:10 -0000
From: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Date: Wed, 14 Mar 2018 14:28:02 +0100
Message-Id: <1521034084-17344-2-git-send-email-abdallah.bouassida@lauterbach.com>
In-Reply-To: <1521034084-17344-1-git-send-email-abdallah.bouassida@lauterbach.com>
References: <1521034084-17344-1-git-send-email-abdallah.bouassida@lauterbach.com>
Subject: [Qemu-devel] [PATCH v5 1/3] target/arm: Add "ARM_CP_NO_GDB" as a
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
index 1e7e1f8..5a6ea24 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1815,10 +1815,11 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
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
index 09893e3..db8c925 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5664,7 +5664,7 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
     if (((r->crm == CP_ANY) && crm != 0) ||
         ((r->opc1 == CP_ANY) && opc1 != 0) ||
         ((r->opc2 == CP_ANY) && opc2 != 0)) {
-        r2->type |= ARM_CP_ALIAS;
+        r2->type |= ARM_CP_ALIAS | ARM_CP_NO_GDB;
     }
 
     /* Check that raw accesses are either forbidden or handled. Note that
-- 
2.7.4
