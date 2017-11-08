Received: from eggs.gnu.org ([2001:4830:134:3::10]:34761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZMY-0000Vp-99
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:02:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZMV-0003aZ-7c
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:02:26 -0500
Received: from mail-by2nam01on0082.outbound.protection.outlook.com
	([104.47.34.82]:44277
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eCZMU-0003Za-So
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:02:23 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 8 Nov 2017 14:58:13 -0800
Message-ID: <1dc70f25d82fc829cf85b9be45cb77d88d8f3af9.1510181732.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1510181732.git.alistair.francis@xilinx.com>
References: <cover.1510181732.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 28/45] hw/nvram: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com

Replace a large number of the fprintf(stderr, "*\n" calls with
error_report(). The functions were renamed with these commands and then
compiler issues where manually fixed.

find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +

Some lines where then manually tweaked to pass checkpatch.

Some of the message in put_unused() was removed and replaced with
g_assert_not_reached().

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---
V3:
 - Add g_assert_not_reached() in unused function
V2:
 - Split hw patch into individual directories

 hw/nvram/eeprom93xx.c | 5 +++--
 hw/nvram/fw_cfg.c     | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/nvram/eeprom93xx.c b/hw/nvram/eeprom93xx.c
index 2fd0e3c29f..5cad031eba 100644
--- a/hw/nvram/eeprom93xx.c
+++ b/hw/nvram/eeprom93xx.c
@@ -36,6 +36,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/nvram/eeprom93xx.h"
 
@@ -105,8 +106,8 @@ static int get_uint16_from_uint8(QEMUFile *f, void *pv, size_t size,
 static int put_unused(QEMUFile *f, void *pv, size_t size, VMStateField *field,
                       QJSON *vmdesc)
 {
-    fprintf(stderr, "uint16_from_uint8 is used only for backwards compatibility.\n");
-    fprintf(stderr, "Never should be used to write a new state.\n");
+    error_report("uint16_from_uint8 is used only for backwards compatibility.");
+    error_report("Never should be used to write a new state.");
     exit(0);
 
     return 0;
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 753ac0e4ea..1c66052f1f 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -518,8 +518,9 @@ static int get_uint32_as_uint16(QEMUFile *f, void *pv, size_t size,
 static int put_unused(QEMUFile *f, void *pv, size_t size, VMStateField *field,
                       QJSON *vmdesc)
 {
-    fprintf(stderr, "uint32_as_uint16 is only used for backward compatibility.\n");
-    fprintf(stderr, "This functions shouldn't be called.\n");
+    error_report("uint32_as_uint16 is only used for backward compatibility.");
+
+    g_assert_not_reached();
 
     return 0;
 }
-- 
2.14.1
