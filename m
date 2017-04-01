Received: from eggs.gnu.org ([2001:4830:134:3::10]:47995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJD2-0004ZO-HY
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:36:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJD1-0008MV-FT
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:36:52 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:36298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJD1-0008MG-9Q
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:36:51 -0400
Received: by mail-oi0-x242.google.com with SMTP id b187so13168156oif.3
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 06:36:51 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 16:36:49 +0300
Message-ID: <CA+KKJYDiPB+BkVoQQ5EEbLa+oMDfkT6CCtf0hAt5dMcgoO1pKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 06/43] unicore32: made printf always compile in
 debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, gxt@mprc.pku.edu.cn

>From e7a576c46bcdaeb49c1c4fdbb59d38944df340ae Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 02:14:49 +0300
Subject: [PATCH 06/43] unicore32: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 target/unicore32/helper.c  | 16 +++++++++-------
 target/unicore32/softmmu.c | 14 ++++++++------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/target/unicore32/helper.c b/target/unicore32/helper.c
index f9239dc..5df8de0 100644
--- a/target/unicore32/helper.c
+++ b/target/unicore32/helper.c
@@ -19,13 +19,15 @@
 #include "ui/console.h"
 #endif

-#undef DEBUG_UC32
-
-#ifdef DEBUG_UC32
-#define DPRINTF(fmt, ...) printf("%s: " fmt , __func__, ## __VA_ARGS__)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
-#endif
+#ifndef DEBUG_UC32
+#define DEBUG_UC32 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                                 \
+    if (DEBUG_UC32) {                                          \
+        fprintf(stderr, "%s: " fmt, __func__, ## __VA_ARGS__); \
+    }                                                          \
+} while (0);

 UniCore32CPU *uc32_cpu_init(const char *cpu_model)
 {
diff --git a/target/unicore32/softmmu.c b/target/unicore32/softmmu.c
index e7152e7..173875b 100644
--- a/target/unicore32/softmmu.c
+++ b/target/unicore32/softmmu.c
@@ -16,13 +16,15 @@
 #include "cpu.h"
 #include "exec/exec-all.h"

-#undef DEBUG_UC32
+#ifndef DEBUG_UC32
+#define DEBUG_UC32 0
+#endif

-#ifdef DEBUG_UC32
-#define DPRINTF(fmt, ...) printf("%s: " fmt , __func__, ## __VA_ARGS__)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
-#endif
+#define DPRINTF(fmt, ...) do {                                 \
+    if (DEBUG_UC32) {                                          \
+        fprintf(stderr, "%s: " fmt, __func__, ## __VA_ARGS__); \
+    }                                                          \
+} while (0);

 #define SUPERPAGE_SIZE             (1 << 22)
 #define UC32_PAGETABLE_READ        (1 << 8)
-- 
2.8.0.rc3
