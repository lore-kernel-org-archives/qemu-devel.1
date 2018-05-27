Received: from eggs.gnu.org ([2001:4830:134:3::10]:57858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fMwQn-0000FV-6e
	for qemu-devel@nongnu.org; Sun, 27 May 2018 10:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fMwQm-0004TQ-84
	for qemu-devel@nongnu.org; Sun, 27 May 2018 10:13:57 -0400
Received: from mail-pl0-x229.google.com ([2607:f8b0:400e:c01::229]:35998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fMwQm-0004T7-1N
	for qemu-devel@nongnu.org; Sun, 27 May 2018 10:13:56 -0400
Received: by mail-pl0-x229.google.com with SMTP id v24-v6so5735030plo.3
	for <qemu-devel@nongnu.org>; Sun, 27 May 2018 07:13:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 27 May 2018 09:13:21 -0500
Message-Id: <20180527141324.11937-18-richard.henderson@linaro.org>
In-Reply-To: <20180527141324.11937-1-richard.henderson@linaro.org>
References: <20180527141324.11937-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 17/20] target/openrisc: Increase the TLB size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>

The architecture supports 128 TLB entries.  There is no reason
not to provide all of them.  In the process we need to fix a
bug that failed to parameterize the configuration register that
tells the operating system the number of entries.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/cpu.h | 2 +-
 target/openrisc/cpu.c | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

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
index b2711a961e..75c83d15d1 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -53,8 +53,10 @@ static void openrisc_cpu_reset(CPUState *s)
 
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
-- 
2.17.0
