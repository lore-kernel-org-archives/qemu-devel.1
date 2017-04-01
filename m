Received: from eggs.gnu.org ([2001:4830:134:3::10]:57593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJdJ-0002s0-63
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:04:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJdH-0007zQ-KE
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:04:01 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:35509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJdH-0007yz-CM
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:03:59 -0400
Received: by mail-oi0-x244.google.com with SMTP id d2so5892834oig.2
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 07:03:59 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 17:03:58 +0300
Message-ID: <CA+KKJYCXF2qnDzfyUPWxoCNxoJC4UyqXRsi0SLHWp36k=bBgtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 33/43] i2c: made printf always compile in debug
 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

>From 0372d38e66070fefc5f65573dc7fe7bce4cbb9fd Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:40:31 +0300
Subject: [PATCH 33/43] i2c: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 hw/i2c/bitbang_i2c.c | 16 ++++++++++------
 hw/i2c/pm_smbus.c    | 15 ++++++++++-----
 hw/i2c/smbus.c       | 28 ++++++++++++++++++----------
 3 files changed, 38 insertions(+), 21 deletions(-)

diff --git a/hw/i2c/bitbang_i2c.c b/hw/i2c/bitbang_i2c.c
index 8be88ee..55a5f85 100644
--- a/hw/i2c/bitbang_i2c.c
+++ b/hw/i2c/bitbang_i2c.c
@@ -16,12 +16,16 @@

 //#define DEBUG_BITBANG_I2C

-#ifdef DEBUG_BITBANG_I2C
-#define DPRINTF(fmt, ...) \
-do { printf("bitbang_i2c: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#endif
+#ifndef DEBUG_BITBANG_I2C
+#define DEBUG_BITBANG_I2C 0
+#endif
+
+#define DPRINTF(fmt, ...)                                         \
+    do {                                                          \
+        if (DEBUG_BITBANG_I2C) {                                  \
+            fprintf(stderr, "bitbang_i2c: " fmt, ## __VA_ARGS__); \
+        }                                                         \
+    } while (0)

 typedef enum bitbang_i2c_state {
     STOPPED = 0,
diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 6fc3923..b36a460 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -47,11 +47,16 @@

 //#define DEBUG

-#ifdef DEBUG
-# define SMBUS_DPRINTF(format, ...)     printf(format, ## __VA_ARGS__)
-#else
-# define SMBUS_DPRINTF(format, ...)     do { } while (0)
-#endif
+#ifndef DEBUG
+#define DEBUG 0
+#endif
+
+#define SMBUS_DPRINTF(fmt, ...)                   \
+    do {                                          \
+        if (DEBUG) {                              \
+            fprintf(stderr, fmt, ## __VA_ARGS__); \
+        }                                         \
+    } while (0)


 static void smb_transaction(PMSMBus *s)
diff --git a/hw/i2c/smbus.c b/hw/i2c/smbus.c
index 2d1b79a..a81445b 100644
--- a/hw/i2c/smbus.c
+++ b/hw/i2c/smbus.c
@@ -16,16 +16,24 @@

 //#define DEBUG_SMBUS 1

-#ifdef DEBUG_SMBUS
-#define DPRINTF(fmt, ...) \
-do { printf("smbus(%02x): " fmt , dev->i2c.address, ## __VA_ARGS__); }
while (0)
-#define BADF(fmt, ...) \
-do { fprintf(stderr, "smbus: error: " fmt , ## __VA_ARGS__); exit(1);}
while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#define BADF(fmt, ...) \
-do { fprintf(stderr, "smbus: error: " fmt , ## __VA_ARGS__);} while (0)
-#endif
+#ifndef DEBUG_SMBUS
+#define DEBUG_SMBUS 0
+#endif
+
+#define DPRINTF(fmt,
...)                                                            \
+    do
{
\
+        if (DEBUG_SMBUS)
{                                                           \
+            fprintf(stderr, "smbus(%02x): " fmt , dev->i2c.address, ##
__VA_ARGS__); \
+
}
\
+    } while (0)
+
+#define BADF(fmt, ...)                                          \
+    do {                                                        \
+        fprintf(stderr, "smbus: error: " fmt , ## __VA_ARGS__); \
+        if (DEBUG_SMBUS) {                                      \
+            exit(1);                                            \
+        }                                                       \
+    } while (0)

 enum {
     SMBUS_IDLE,
-- 
2.8.0.rc3
