Received: from eggs.gnu.org ([208.118.235.92]:47741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcoP3-0000Vw-1l
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 04:26:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcoP1-00035o-4O
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 04:26:00 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:49209 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gcoP0-00034c-SD
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 04:25:59 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 28 Dec 2018 10:25:18 +0100
Message-Id: <1545989148-13582-12-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1545989148-13582-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1545989148-13582-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 11/41] disas: nanoMIPS: Fix types and format
 strings
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

From: Stefan Weil <sw@weilnetz.de>

Use POSIX types and format strings.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Weil <sw@weilnetz.de>
---
 disas/nanomips.cpp | 20 ++++++++++++--------
 disas/nanomips.h   | 10 +++++-----
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index 1238c2f..28d78d6 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -258,7 +258,7 @@ namespace img
 std::string to_string(img::address a)
 {
     char buffer[256];
-    sprintf(buffer, "0x%08llx", a);
+    sprintf(buffer, "0x%" PRIx64, a);
     return buffer;
 }
 
@@ -284,7 +284,8 @@ uint64 NMD::renumber_registers(uint64 index, uint64 *register_list,
     }
 
     throw std::runtime_error(img::format(
-                   "Invalid register mapping index %d, size of list = %d",
+                   "Invalid register mapping index %" PRIu64
+                   ", size of list = %zu",
                    index, register_list_size));
 }
 
@@ -501,7 +502,8 @@ std::string NMD::GPR(uint64 reg)
         return gpr_reg[reg];
     }
 
-    throw std::runtime_error(img::format("Invalid GPR register index %d", reg));
+    throw std::runtime_error(img::format("Invalid GPR register index %" PRIu64,
+                                         reg));
 }
 
 
@@ -518,7 +520,8 @@ std::string NMD::FPR(uint64 reg)
         return fpr_reg[reg];
     }
 
-    throw std::runtime_error(img::format("Invalid FPR register index %d", reg));
+    throw std::runtime_error(img::format("Invalid FPR register index %" PRIu64,
+                                         reg));
 }
 
 
@@ -532,26 +535,27 @@ std::string NMD::AC(uint64 reg)
         return ac_reg[reg];
     }
 
-    throw std::runtime_error(img::format("Invalid AC register index %d", reg));
+    throw std::runtime_error(img::format("Invalid AC register index %" PRIu64,
+                                         reg));
 }
 
 
 std::string NMD::IMMEDIATE(uint64 value)
 {
-    return img::format("0x%x", value);
+    return img::format("0x%" PRIx64, value);
 }
 
 
 std::string NMD::IMMEDIATE(int64 value)
 {
-    return img::format("%d", value);
+    return img::format("%" PRId64, value);
 }
 
 
 std::string NMD::CPR(uint64 reg)
 {
     /* needs more work */
-    return img::format("CP%d", reg);
+    return img::format("CP%" PRIu64, reg);
 }
 
 
diff --git a/disas/nanomips.h b/disas/nanomips.h
index 84cc9a6..71428b3 100644
--- a/disas/nanomips.h
+++ b/disas/nanomips.h
@@ -24,14 +24,14 @@
 
 #include <string>
 
-typedef unsigned short uint16;
-typedef unsigned int uint32;
-typedef long long int64;
-typedef unsigned long long uint64;
+typedef int64_t int64;
+typedef uint64_t uint64;
+typedef uint32_t uint32;
+typedef uint16_t uint16;
 
 namespace img
 {
-    typedef unsigned long long address;
+    typedef uint64_t address;
 }
 
 
-- 
2.7.4
