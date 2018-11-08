Received: from eggs.gnu.org ([2001:4830:134:3::10]:54744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <asanchez@kryptoslogic.com>) id 1gKiE5-0000yz-Lk
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:11:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <asanchez@kryptoslogic.com>) id 1gKiE0-0007Ea-Nn
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:11:53 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <asanchez@kryptoslogic.com>)
	id 1gKiDy-0007Ci-Mx
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:11:48 -0500
Received: by mail-wr1-x444.google.com with SMTP id y15-v6so20778993wru.9
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 03:11:45 -0800 (PST)
From: Alexandro Sanchez Bach <asanchez@kryptoslogic.com>
Date: Thu,  8 Nov 2018 03:11:24 -0800
Message-Id: <20181108111124.5851-1-asanchez@kryptoslogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] hax: Support for Linux hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yu.ning@intel.com, Alexandro Sanchez Bach <asanchez@kryptoslogic.com>

Signed-off-by: Alexandro Sanchez Bach <asanchez@kryptoslogic.com>
---
 target/i386/Makefile.objs                 |  5 ++++-
 target/i386/hax-i386.h                    | 10 +++++++++-
 target/i386/{hax-darwin.c => hax-posix.c} |  0
 target/i386/{hax-darwin.h => hax-posix.h} |  0
 4 files changed, 13 insertions(+), 2 deletions(-)
 rename target/i386/{hax-darwin.c => hax-posix.c} (100%)
 rename target/i386/{hax-darwin.h => hax-posix.h} (100%)

diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
index 04678f5503..be36d31d23 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -12,8 +12,11 @@ obj-$(call lnot,$(CONFIG_SEV)) += sev-stub.o
 ifdef CONFIG_WIN32
 obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-windows.o
 endif
+ifdef CONFIG_LINUX
+obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-posix.o
+endif
 ifdef CONFIG_DARWIN
-obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-darwin.o
+obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-posix.o
 obj-$(CONFIG_HVF) += hvf/
 endif
 obj-$(CONFIG_WHPX) += whpx-all.o
diff --git a/target/i386/hax-i386.h b/target/i386/hax-i386.h
index 6abc156f88..f87a64c9df 100644
--- a/target/i386/hax-i386.h
+++ b/target/i386/hax-i386.h
@@ -20,6 +20,10 @@
 typedef int hax_fd;
 #endif
 
+#ifdef CONFIG_LINUX
+typedef int hax_fd;
+#endif
+
 #ifdef CONFIG_WIN32
 typedef HANDLE hax_fd;
 #endif
@@ -83,7 +87,11 @@ void hax_memory_init(void);
 
 
 #ifdef CONFIG_DARWIN
-#include "target/i386/hax-darwin.h"
+#include "target/i386/hax-posix.h"
+#endif
+
+#ifdef CONFIG_LINUX
+#include "target/i386/hax-posix.h"
 #endif
 
 #ifdef CONFIG_WIN32
diff --git a/target/i386/hax-darwin.c b/target/i386/hax-posix.c
similarity index 100%
rename from target/i386/hax-darwin.c
rename to target/i386/hax-posix.c
diff --git a/target/i386/hax-darwin.h b/target/i386/hax-posix.h
similarity index 100%
rename from target/i386/hax-darwin.h
rename to target/i386/hax-posix.h
-- 
2.19.1
