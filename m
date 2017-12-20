Received: from eggs.gnu.org ([2001:4830:134:3::10]:60987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eRiAx-0007kP-0i
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:29:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eRiAv-00078J-RK
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:29:03 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 20 Dec 2017 09:24:26 -0800
Message-ID: <9a855de62a1da7499c589c4984b4673a9312aa7f.1513790495.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1513790494.git.alistair.francis@xilinx.com>
References: <cover.1513790494.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 17/29] hw/nvram: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com

Replace a large number of the fprintf(stderr, "*\n" calls with
error_report(). The functions were renamed with these commands and then
compiler issues where manually fixed.

find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_=
report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_re=
port("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report=
("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("=
\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1=
"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\=
2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2)=
;|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|=
Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig=
}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}'=
 \
    {} +
find ./* -type f -exec sed -i \
    'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +

Some lines where then manually tweaked to pass checkpatch.

Some of the message in put_unused() was removed and replaced with
g_assert_not_reached() and some of the messages were updated.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
V3:
 - Add g_assert_not_reached() in unused function
V2:
 - Split hw patch into individual directories

 hw/nvram/eeprom93xx.c | 7 ++++---
 hw/nvram/fw_cfg.c     | 4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/nvram/eeprom93xx.c b/hw/nvram/eeprom93xx.c
index 2fd0e3c29f..6ffce745ae 100644
--- a/hw/nvram/eeprom93xx.c
+++ b/hw/nvram/eeprom93xx.c
@@ -36,6 +36,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/nvram/eeprom93xx.h"
=20
@@ -105,9 +106,9 @@ static int get_uint16_from_uint8(QEMUFile *f, void *pv,=
 size_t size,
 static int put_unused(QEMUFile *f, void *pv, size_t size, VMStateField *fi=
eld,
                       QJSON *vmdesc)
 {
-    fprintf(stderr, "uint16_from_uint8 is used only for backwards compatib=
ility.\n");
-    fprintf(stderr, "Never should be used to write a new state.\n");
-    exit(0);
+    error_report("uint16_from_uint8 is used only for backwards compatibili=
ty.");
+    error_report("It should never be used to write a new state.");
+    g_assert_not_reached();
=20
     return 0;
 }
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 753ac0e4ea..49375485ef 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -518,8 +518,8 @@ static int get_uint32_as_uint16(QEMUFile *f, void *pv, =
size_t size,
 static int put_unused(QEMUFile *f, void *pv, size_t size, VMStateField *fi=
eld,
                       QJSON *vmdesc)
 {
-    fprintf(stderr, "uint32_as_uint16 is only used for backward compatibil=
ity.\n");
-    fprintf(stderr, "This functions shouldn't be called.\n");
+    error_report("uint32_as_uint16 is only used for backward compatibility=
.");
+    g_assert_not_reached();
=20
     return 0;
 }
--=20
2.14.1
