Received: from eggs.gnu.org ([2001:4830:134:3::10]:56554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eENNn-00029X-NV
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 17:39:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eENNl-0006wh-Vk
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 17:39:11 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 13 Nov 2017 14:34:51 -0800
Message-ID: <55d08bd4870237b4853fc13d7bd71d4d2eb7aa20.1510612380.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1510612380.git.alistair.francis@xilinx.com>
References: <cover.1510612380.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 05/29] hw/dma: Replace fprintf(stderr,
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

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
V3:
 - Remove ""s
V2:
 - Split hw patch into individual directories

 hw/dma/omap_dma.c | 26 ++++++++++++++------------
 hw/dma/soc_dma.c  | 36 ++++++++++++++++++------------------
 2 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index abd18c67ea..5d7fe06d98 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -18,6 +18,7 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "qemu/timer.h"
 #include "hw/arm/omap.h"
@@ -1898,13 +1899,13 @@ static void omap_dma4_write(void *opaque, hwaddr ad=
dr,
             omap_dma_reset(s->dma);
         s->ocp =3D value & 0x3321;
         if (((s->ocp >> 12) & 3) =3D=3D 3)				/* MIDLEMODE */
-            fprintf(stderr, "%s: invalid DMA power mode\n", __func__);
+            error_report("%s: invalid DMA power mode", __func__);
         return;
=20
     case 0x78:	/* DMA4_GCR */
         s->gcr =3D value & 0x00ff00ff;
 	if ((value & 0xff) =3D=3D 0x00)		/* MAX_CHANNEL_FIFO_DEPTH */
-            fprintf(stderr, "%s: wrong FIFO depth in GCR\n", __func__);
+            error_report("%s: wrong FIFO depth in GCR", __func__);
         return;
=20
     case 0x80 ... 0xfff:
@@ -1934,8 +1935,8 @@ static void omap_dma4_write(void *opaque, hwaddr addr=
,
         ch->buf_disable =3D (value >> 25) & 1;
         ch->src_sync =3D (value >> 24) & 1;	/* XXX For CamDMA must be 1 */
         if (ch->buf_disable && !ch->src_sync)
-            fprintf(stderr, "%s: Buffering disable is not allowed in "
-                            "destination synchronised mode\n", __func__);
+            error_report("%s: Buffering disable is not allowed in "
+                         "destination synchronised mode", __func__);
         ch->prefetch =3D (value >> 23) & 1;
         ch->bs =3D (value >> 18) & 1;
         ch->transparent_copy =3D (value >> 17) & 1;
@@ -1946,8 +1947,8 @@ static void omap_dma4_write(void *opaque, hwaddr addr=
,
         ch->priority =3D (value & 0x0040) >> 6;
         ch->fs =3D (value & 0x0020) >> 5;
         if (ch->fs && ch->bs && ch->mode[0] && ch->mode[1])
-            fprintf(stderr, "%s: For a packet transfer at least one port "
-                            "must be constant-addressed\n", __func__);
+            error_report("%s: For a packet transfer at least one port "
+                         "must be constant-addressed", __func__);
         ch->sync =3D (value & 0x001f) | ((value >> 14) & 0x0060);
         /* XXX must be 0x01 for CamDMA */
=20
@@ -1977,8 +1978,8 @@ static void omap_dma4_write(void *opaque, hwaddr addr=
,
         ch->endian[1] =3D(value >> 19) & 1;
         ch->endian_lock[1] =3D(value >> 18) & 1;
         if (ch->endian[0] !=3D ch->endian[1])
-            fprintf(stderr, "%s: DMA endianness conversion enable attempt\=
n",
-                            __func__);
+            error_report("%s: DMA endianness conversion enable attempt",
+                          __func__);
         ch->write_mode =3D (value >> 16) & 3;
         ch->burst[1] =3D (value & 0xc000) >> 14;
         ch->pack[1] =3D (value & 0x2000) >> 13;
@@ -1986,12 +1987,13 @@ static void omap_dma4_write(void *opaque, hwaddr ad=
dr,
         ch->burst[0] =3D (value & 0x0180) >> 7;
         ch->pack[0] =3D (value & 0x0040) >> 6;
         ch->translate[0] =3D (value & 0x003c) >> 2;
-        if (ch->translate[0] | ch->translate[1])
-            fprintf(stderr, "%s: bad MReqAddressTranslate sideband signal\=
n",
-                            __func__);
+        if (ch->translate[0] | ch->translate[1]) {
+            error_report("%s: bad MReqAddressTranslate sideband signal",
+                         __func__);
+        }
         ch->data_type =3D 1 << (value & 3);
         if ((value & 3) =3D=3D 3) {
-            printf("%s: bad data_type for DMA channel\n", __func__);
+            error_report("%s: bad data_type for DMA channel", __func__);
             ch->data_type >>=3D 1;
         }
         break;
diff --git a/hw/dma/soc_dma.c b/hw/dma/soc_dma.c
index 9bb499bf9c..45516241c6 100644
--- a/hw/dma/soc_dma.c
+++ b/hw/dma/soc_dma.c
@@ -18,6 +18,7 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "qemu/timer.h"
 #include "hw/arm/soc_dma.h"
@@ -270,11 +271,11 @@ void soc_dma_port_add_fifo(struct soc_dma_s *soc, hwa=
ddr virt_base,
         if (entry->type =3D=3D soc_dma_port_mem) {
             if (entry->addr <=3D virt_base &&
                             entry->addr + entry->u.mem.size > virt_base) {
-                fprintf(stderr, "%s: FIFO at %"PRIx64
-                                " collides with RAM region at %"PRIx64
-                                "-%"PRIx64 "\n", __func__,
-                                virt_base, entry->addr,
-                                (entry->addr + entry->u.mem.size));
+                error_report("%s: FIFO at %"PRIx64
+                             " collides with RAM region at %"PRIx64
+                             "-%"PRIx64, __func__,
+                             virt_base, entry->addr,
+                             (entry->addr + entry->u.mem.size));
                 exit(-1);
             }
=20
@@ -284,9 +285,9 @@ void soc_dma_port_add_fifo(struct soc_dma_s *soc, hwadd=
r virt_base,
             while (entry < dma->memmap + dma->memmap_size &&
                             entry->addr <=3D virt_base) {
                 if (entry->addr =3D=3D virt_base && entry->u.fifo.out =3D=
=3D out) {
-                    fprintf(stderr, "%s: FIFO at %"PRIx64
-                                    " collides FIFO at %"PRIx64 "\n",
-                                    __func__, virt_base, entry->addr);
+                    error_report("%s: FIFO at %"PRIx64
+                                 " collides FIFO at %"PRIx64,
+                                 __func__, virt_base, entry->addr);
                     exit(-1);
                 }
=20
@@ -321,11 +322,11 @@ void soc_dma_port_add_mem(struct soc_dma_s *soc, uint=
8_t *phys_base,
             if ((entry->addr >=3D virt_base && entry->addr < virt_base + s=
ize) ||
                             (entry->addr <=3D virt_base &&
                              entry->addr + entry->u.mem.size > virt_base))=
 {
-                fprintf(stderr, "%s: RAM at %"PRIx64 "-%"PRIx64
-                                " collides with RAM region at %"PRIx64
-                                "-%"PRIx64 "\n", __func__,
-                                virt_base, virt_base + size,
-                                entry->addr, entry->addr + entry->u.mem.si=
ze);
+                error_report("%s: RAM at %"PRIx64 "-%"PRIx64
+                             " collides with RAM region at %"PRIx64
+                             "-%"PRIx64, __func__,
+                             virt_base, virt_base + size,
+                             entry->addr, entry->addr + entry->u.mem.size)=
;
                 exit(-1);
             }
=20
@@ -334,11 +335,10 @@ void soc_dma_port_add_mem(struct soc_dma_s *soc, uint=
8_t *phys_base,
         } else {
             if (entry->addr >=3D virt_base &&
                             entry->addr < virt_base + size) {
-                fprintf(stderr, "%s: RAM at %"PRIx64 "-%"PRIx64
-                                " collides with FIFO at %"PRIx64
-                                "\n", __func__,
-                                virt_base, virt_base + size,
-                                entry->addr);
+                error_report("%s: RAM at %"PRIx64 "-%"PRIx64
+                             " collides with FIFO at %"PRIx64,
+                             __func__, virt_base, virt_base + size,
+                             entry->addr);
                 exit(-1);
             }
=20
--=20
2.14.1
