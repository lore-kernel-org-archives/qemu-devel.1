Received: from eggs.gnu.org ([2001:4830:134:3::10]:35587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSs5u-0007ok-GY
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:12:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSs5r-00030f-BU
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:12:06 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1cSs5r-00030U-5k
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:12:03 -0500
Received: by mail-pg0-x242.google.com with SMTP id 194so3587309pgd.0
	for <qemu-devel@nongnu.org>; Sun, 15 Jan 2017 13:12:03 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 15 Jan 2017 13:11:47 -0800
Message-Id: <1484514707-11781-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] target/xtensa: fix ICACHE/DCACHE options
 detection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Configuration overlay does not explicitly say whether there are ICACHE
and DCACHE in the core. Current code uses XCHAL_[ID]CACHE_WAYS to detect
if corresponding cache option is enabled, but that's not correct: on
cores without cache these macros are defined as 1, not as 0.
Check XCHAL_[ID]CACHE_SIZE instead.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/overlay_tool.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/overlay_tool.h b/target/xtensa/overlay_tool.h
index 5357142..b73fd14 100644
--- a/target/xtensa/overlay_tool.h
+++ b/target/xtensa/overlay_tool.h
@@ -92,10 +92,10 @@
         XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT) | \
     XCHAL_OPTION(XCHAL_HAVE_CCOUNT, XTENSA_OPTION_TIMER_INTERRUPT) | \
     /* Local memory, TODO */ \
-    XCHAL_OPTION(XCHAL_ICACHE_WAYS, XTENSA_OPTION_ICACHE) | \
+    XCHAL_OPTION(XCHAL_ICACHE_SIZE, XTENSA_OPTION_ICACHE) | \
     XCHAL_OPTION(XCHAL_ICACHE_LINE_LOCKABLE, \
             XTENSA_OPTION_ICACHE_INDEX_LOCK) | \
-    XCHAL_OPTION(XCHAL_DCACHE_WAYS, XTENSA_OPTION_DCACHE) | \
+    XCHAL_OPTION(XCHAL_DCACHE_SIZE, XTENSA_OPTION_DCACHE) | \
     XCHAL_OPTION(XCHAL_DCACHE_LINE_LOCKABLE, \
             XTENSA_OPTION_DCACHE_INDEX_LOCK) | \
     XCHAL_OPTION(XCHAL_UNALIGNED_LOAD_HW, XTENSA_OPTION_HW_ALIGNMENT) | \
-- 
2.1.4
