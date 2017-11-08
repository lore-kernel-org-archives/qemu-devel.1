Received: from eggs.gnu.org ([2001:4830:134:3::10]:34113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZLR-0007rX-Se
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:01:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZLO-0003Bw-Kh
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:01:17 -0500
Received: from mail-sn1nam01on0082.outbound.protection.outlook.com
	([104.47.32.82]:44213
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eCZLO-0003BK-BU
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:01:14 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 8 Nov 2017 14:56:52 -0800
Message-ID: <c7bb3a7e058e2e5f4f41c7e4544978f2c16cbb24.1510181732.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1510181732.git.alistair.francis@xilinx.com>
References: <cover.1510181732.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 09/45] hw/core: Replace fprintf(stderr,
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
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

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

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
V3:
 - Fix white space error
V2:
 - Split hw patch into individual directories

 hw/core/loader.c | 43 ++++++++++++++++++++++---------------------
 hw/core/ptimer.c |  7 ++++---
 2 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 91669d65aa..75f3d4301c 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -43,6 +43,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "disas/disas.h"
@@ -82,8 +83,8 @@ int load_image(const char *filename, uint8_t *addr)
         return -1;
     size =3D lseek(fd, 0, SEEK_END);
     if (size =3D=3D -1) {
-        fprintf(stderr, "file %-20s: get size error: %s\n",
-                filename, strerror(errno));
+        error_report("file %-20s: get size error: %s",
+                     filename, strerror(errno));
         close(fd);
         return -1;
     }
@@ -623,8 +624,8 @@ static int load_uboot_image(const char *filename, hwadd=
r *ep, hwaddr *loadaddr,
         goto out;
=20
     if (hdr->ih_type !=3D image_type) {
-        fprintf(stderr, "Wrong image type %d, expected %d\n", hdr->ih_type=
,
-                image_type);
+        error_report("Wrong image type %d, expected %d", hdr->ih_type,
+                     image_type);
         goto out;
     }
=20
@@ -670,14 +671,14 @@ static int load_uboot_image(const char *filename, hwa=
ddr *ep, hwaddr *loadaddr,
         address =3D *loadaddr;
         break;
     default:
-        fprintf(stderr, "Unsupported u-boot image type %d\n", hdr->ih_type=
);
+        error_report("Unsupported u-boot image type %d", hdr->ih_type);
         goto out;
     }
=20
     data =3D g_malloc(hdr->ih_size);
=20
     if (read(fd, data, hdr->ih_size) !=3D hdr->ih_size) {
-        fprintf(stderr, "Error reading file\n");
+        error_report("Error reading file");
         goto out;
     }
=20
@@ -693,7 +694,7 @@ static int load_uboot_image(const char *filename, hwadd=
r *ep, hwaddr *loadaddr,
         bytes =3D gunzip(data, max_bytes, compressed_data, hdr->ih_size);
         g_free(compressed_data);
         if (bytes < 0) {
-            fprintf(stderr, "Unable to decompress gzipped image!\n");
+            error_report("Unable to decompress gzipped image!");
             goto out;
         }
         hdr->ih_size =3D bytes;
@@ -763,8 +764,8 @@ int load_image_gzipped_buffer(const char *filename, uin=
t64_t max_sz,
     data =3D g_malloc(max_sz);
     bytes =3D gunzip(data, max_sz, compressed_data, len);
     if (bytes < 0) {
-        fprintf(stderr, "%s: unable to decompress gzipped kernel file\n",
-                filename);
+        error_report("%s: unable to decompress gzipped kernel file",
+                     filename);
         goto out;
     }
=20
@@ -893,8 +894,8 @@ int rom_add_file(const char *file, const char *fw_dir,
     char devpath[100];
=20
     if (as && mr) {
-        fprintf(stderr, "Specifying an Address Space and Memory Region is =
" \
-                "not valid when loading a rom\n");
+        error_report("Specifying an Address Space and Memory Region is " \
+                     "not valid when loading a rom");
         /* We haven't allocated anything so we don't need any cleanup */
         return -1;
     }
@@ -909,8 +910,8 @@ int rom_add_file(const char *file, const char *fw_dir,
=20
     fd =3D open(rom->path, O_RDONLY | O_BINARY);
     if (fd =3D=3D -1) {
-        fprintf(stderr, "Could not open option rom '%s': %s\n",
-                rom->path, strerror(errno));
+        error_report("Could not open option rom '%s': %s",
+                     rom->path, strerror(errno));
         goto err;
     }
=20
@@ -921,8 +922,8 @@ int rom_add_file(const char *file, const char *fw_dir,
     rom->addr     =3D addr;
     rom->romsize  =3D lseek(fd, 0, SEEK_END);
     if (rom->romsize =3D=3D -1) {
-        fprintf(stderr, "rom: file %-20s: get size error: %s\n",
-                rom->name, strerror(errno));
+        error_report("rom: file %-20s: get size error: %s",
+                     rom->name, strerror(errno));
         goto err;
     }
=20
@@ -931,8 +932,8 @@ int rom_add_file(const char *file, const char *fw_dir,
     lseek(fd, 0, SEEK_SET);
     rc =3D read(fd, rom->data, rom->datasize);
     if (rc !=3D rom->datasize) {
-        fprintf(stderr, "rom: file %-20s: read error: rc=3D%d (expected %z=
d)\n",
-                rom->name, rc, rom->datasize);
+        error_report("rom: file %-20s: read error: rc=3D%d (expected %zd)"=
,
+                     rom->name, rc, rom->datasize);
         goto err;
     }
     close(fd);
@@ -1105,10 +1106,10 @@ int rom_check_and_register_reset(void)
             continue;
         }
         if ((addr > rom->addr) && (as =3D=3D rom->as)) {
-            fprintf(stderr, "rom: requested regions overlap "
-                    "(rom %s. free=3D0x" TARGET_FMT_plx
-                    ", addr=3D0x" TARGET_FMT_plx ")\n",
-                    rom->name, addr, rom->addr);
+            error_report("rom: requested regions overlap "
+                         "(rom %s. free=3D0x" TARGET_FMT_plx
+                         ", addr=3D0x" TARGET_FMT_plx ")",
+                         rom->name, addr, rom->addr);
             return -1;
         }
         addr  =3D rom->addr;
diff --git a/hw/core/ptimer.c b/hw/core/ptimer.c
index 7221c68a98..514e177de2 100644
--- a/hw/core/ptimer.c
+++ b/hw/core/ptimer.c
@@ -6,6 +6,7 @@
  * This code is licensed under the GNU LGPL.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
@@ -56,7 +57,7 @@ static void ptimer_reload(ptimer_state *s, int delta_adju=
st)
=20
     if (s->period =3D=3D 0) {
         if (!qtest_enabled()) {
-            fprintf(stderr, "Timer with period zero, disabling\n");
+            error_report("Timer with period zero, disabling");
         }
         timer_del(s->timer);
         s->enabled =3D 0;
@@ -89,7 +90,7 @@ static void ptimer_reload(ptimer_state *s, int delta_adju=
st)
=20
     if (delta =3D=3D 0) {
         if (!qtest_enabled()) {
-            fprintf(stderr, "Timer with delta zero, disabling\n");
+            error_report("Timer with delta zero, disabling");
         }
         timer_del(s->timer);
         s->enabled =3D 0;
@@ -263,7 +264,7 @@ void ptimer_run(ptimer_state *s, int oneshot)
=20
     if (was_disabled && s->period =3D=3D 0) {
         if (!qtest_enabled()) {
-            fprintf(stderr, "Timer with period zero, disabling\n");
+            error_report("Timer with period zero, disabling");
         }
         return;
     }
--=20
2.14.1
