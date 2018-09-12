Received: from eggs.gnu.org ([2001:4830:134:3::10]:55486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g04OT-0005Q1-Dq
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g04OQ-0006pj-AV
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:37:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g04OQ-0006nX-1v
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:37:14 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com
	[10.5.11.27])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 37000C03070D
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 12:37:12 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 12 Sep 2018 14:36:58 +0200
Message-Id: <20180912123700.7708-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] display/edid: add edid generator to qemu.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

EDID is a metadata format to describe monitors.  On physical hardware
the monitor has an eeprom with that data block which can be read over
i2c bus.

On a linux system you can usually find the EDID data block in
/sys/class/drm/$card/$connector/edid.  xorg ships a edid-decode utility
which you can use to turn the blob into readable form.

I think it would be a good idea to use EDID for virtual displays too.
Needs changes in both qemu and guest kms drivers.  This patch is the
first step, it adds an generator for EDID blobs to qemu.  Comes with a
qemu-edid test tool included.

With EDID we can pass more information to the guest.  Names and serial
numbers, so the guests display configuration has no boring "Unknown
Monitor".  List of video modes.  Display resolution, pretty important
in case we want add HiDPI support some day.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure                  |   2 +-
 Makefile                   |   2 +
 include/hw/display/edid.h  |  18 +++
 hw/display/edid-generate.c | 328 +++++++++++++++++++++++++++++++++++++++++++++
 qemu-edid.c                |  86 ++++++++++++
 hw/display/Makefile.objs   |   2 +
 6 files changed, 437 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/display/edid.h
 create mode 100644 hw/display/edid-generate.c
 create mode 100644 qemu-edid.c

diff --git a/configure b/configure
index 58862d2ae8..053facfb68 100755
--- a/configure
+++ b/configure
@@ -5715,7 +5715,7 @@ fi
 
 tools=""
 if test "$want_tools" = "yes" ; then
-  tools="qemu-img\$(EXESUF) qemu-io\$(EXESUF) $tools"
+  tools="qemu-img\$(EXESUF) qemu-io\$(EXESUF) qemu-edid\$(EXESUF) $tools"
   if [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" ] ; then
     tools="qemu-nbd\$(EXESUF) $tools"
   fi
diff --git a/Makefile b/Makefile
index fe623e4634..7bb6675f4a 100644
--- a/Makefile
+++ b/Makefile
@@ -543,6 +543,8 @@ qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)
 
 qemu-keymap$(EXESUF): qemu-keymap.o ui/input-keymap.o $(COMMON_LDADDS)
 
+qemu-edid$(EXESUF): qemu-edid.o hw/display/edid-generate.o $(COMMON_LDADDS)
+
 fsdev/virtfs-proxy-helper$(EXESUF): fsdev/virtfs-proxy-helper.o fsdev/9p-marshal.o fsdev/9p-iov-marshal.o $(COMMON_LDADDS)
 fsdev/virtfs-proxy-helper$(EXESUF): LIBS += -lcap
 
diff --git a/include/hw/display/edid.h b/include/hw/display/edid.h
new file mode 100644
index 0000000000..63b60015c3
--- /dev/null
+++ b/include/hw/display/edid.h
@@ -0,0 +1,18 @@
+#ifndef EDID_H
+#define EDID_H
+
+typedef struct qemu_edid_info {
+    const char *vendor;
+    const char *name;
+    const char *serial;
+    uint32_t    dpi;
+    uint32_t    prefx;
+    uint32_t    prefy;
+    uint32_t    maxx;
+    uint32_t    maxy;
+} qemu_edid_info;
+
+void qemu_edid_generate(uint8_t *edid, size_t size,
+                        qemu_edid_info *info);
+
+#endif /* EDID_H */
diff --git a/hw/display/edid-generate.c b/hw/display/edid-generate.c
new file mode 100644
index 0000000000..a73acf6bc7
--- /dev/null
+++ b/hw/display/edid-generate.c
@@ -0,0 +1,328 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/bswap.h"
+#include "hw/display/edid.h"
+
+static struct edid_mode {
+    uint32_t xres;
+    uint32_t yres;
+    uint32_t byte;
+    uint32_t xtra3;
+    uint32_t bit;
+} modes[] = {
+    /* other */
+    { .xres = 2048,   .yres = 1152 },
+    { .xres = 1920,   .yres = 1440 },
+    { .xres = 1920,   .yres = 1080 },
+
+    /* additional standard timings 3 (all @75Hz) */
+    { .xres = 1920,   .yres = 1200,   .xtra3 = 11,   .bit = 7 },
+    { .xres = 1856,   .yres = 1392,   .xtra3 = 10,   .bit = 2 },
+    { .xres = 1792,   .yres = 1344,   .xtra3 = 10,   .bit = 4 },
+    { .xres = 1600,   .yres = 1200,   .xtra3 = 10,   .bit = 7 },
+    { .xres = 1680,   .yres = 1050,   .xtra3 =  9,   .bit = 4 },
+    { .xres = 1440,   .yres = 1050,   .xtra3 =  8,   .bit = 0 },
+    { .xres = 1440,   .yres =  900,   .xtra3 =  8,   .bit = 4 },
+    { .xres = 1280,   .yres =  768,   .xtra3 =  7,   .bit = 5 },
+
+    /* established timings (all @75Hz) */
+    { .xres = 1280,   .yres = 1024,   .byte  = 36,   .bit = 0 },
+    { .xres = 1024,   .yres =  768,   .byte  = 36,   .bit = 1 },
+    { .xres =  800,   .yres =  600,   .byte  = 36,   .bit = 6 },
+    { .xres =  640,   .yres =  480,   .byte  = 35,   .bit = 2 },
+};
+
+static int edid_std_mode(uint8_t *mode, uint32_t xres, uint32_t yres)
+{
+    uint32_t aspect;
+
+    if (xres == 0 || yres == 0) {
+        mode[0] = 0x01;
+        mode[1] = 0x01;
+        return 0;
+
+    } else if (xres * 10 == yres * 16) {
+        aspect = 0;
+    } else if (xres * 3 == yres * 4) {
+        aspect = 1;
+    } else if (xres * 4 == yres * 5) {
+        aspect = 2;
+    } else if (xres * 9 == yres * 16) {
+        aspect = 3;
+    } else {
+        return -1;
+    }
+
+    mode[0] = (xres / 8) - 31;
+    mode[1] = ((aspect << 6) | (75 - 60));
+    return 0;
+}
+
+static void edid_fill_modes(uint8_t *edid, uint8_t *xtra3,
+                            uint32_t maxx, uint32_t maxy)
+{
+    struct edid_mode *mode;
+    int std = 38;
+    int rc, i;
+
+    for (i = 0; i < ARRAY_SIZE(modes); i++) {
+        mode = modes + i;
+
+        if ((maxx && mode->xres > maxx) ||
+            (maxy && mode->yres > maxy)) {
+            continue;
+        }
+
+        if (mode->byte) {
+            edid[mode->byte] |= (1 << mode->bit);
+        } else if (mode->xtra3 && xtra3) {
+            xtra3[mode->xtra3] |= (1 << mode->bit);
+        } else if (std < 54) {
+            rc = edid_std_mode(edid + std, mode->xres, mode->yres);
+            if (rc == 0) {
+                std += 2;
+            }
+        }
+    }
+
+    while (std < 54) {
+        edid_std_mode(edid + std, 0, 0);
+        std += 2;
+    }
+}
+
+static void edid_checksum(uint8_t *edid)
+{
+    uint32_t sum = 0;
+    int i;
+
+    for (i = 0; i < 127; i++) {
+        sum += edid[i];
+    }
+    sum &= 0xff;
+    if (sum) {
+        edid[127] = 0x100 - sum;
+    }
+}
+
+static void edid_desc_type(uint8_t *desc, uint8_t type)
+{
+    desc[0] = 0;
+    desc[1] = 0;
+    desc[2] = 0;
+    desc[3] = type;
+    desc[4] = 0;
+}
+
+static void edid_desc_text(uint8_t *desc, uint8_t type,
+                           const char *text)
+{
+    size_t len;
+
+    edid_desc_type(desc, type);
+    memset(desc + 5, ' ', 13);
+
+    len = strlen(text);
+    if (len > 12)
+        len = 12;
+    strncpy((char*)(desc + 5), text, len);
+    desc[ 5 + len ] = '\n';
+}
+
+static void edid_desc_ranges(uint8_t *desc)
+{
+    edid_desc_type(desc, 0xfd);
+
+    /* vertical */
+    desc[ 5] =  50;
+    desc[ 6] = 100;
+
+    /* horizontal */
+    desc[ 7] =  30;
+    desc[ 8] = 120;
+
+    /* dot clock */
+    desc[ 9] = 250 / 10;
+
+    /* padding */
+    desc[11] = '\n';
+    memset(desc + 12, ' ', 6);
+}
+
+/* additional standard timings 3 */
+static void edid_desc_xtra3_std(uint8_t *desc)
+{
+    edid_desc_type(desc, 0xf7);
+    desc[5] = 10;
+}
+
+static void edid_desc_dummy(uint8_t *desc)
+{
+    edid_desc_type(desc, 0x10);
+}
+
+static void edid_desc_timing(uint8_t *desc,
+                             uint32_t xres, uint32_t yres,
+                             uint32_t dpi)
+{
+    /* physical display size */
+    uint32_t xmm = xres * dpi / 254;
+    uint32_t ymm = yres * dpi / 254;
+
+    /* pull some realistic looking timings out of thin air */
+    uint32_t xfront = xres * 25 / 100;
+    uint32_t xsync  = xres *  3 / 100;
+    uint32_t xblank = xres * 35 / 100;
+
+    uint32_t yfront = yres *  5 / 1000;
+    uint32_t ysync  = yres *  5 / 1000;
+    uint32_t yblank = yres * 35 / 1000;
+
+    uint32_t clock  = 75 * (xres + xblank) * (yres + yblank);
+
+    *(uint32_t*)(desc) = cpu_to_le32(clock / 10000);
+
+    desc[2] = xres   & 0xff;
+    desc[3] = xblank & 0xff;
+    desc[4] = ((( xres   & 0xf00 ) >> 4) |
+               (( xblank & 0xf00 ) >> 8));
+
+    desc[5] = yres   & 0xff;
+    desc[6] = yblank & 0xff;
+    desc[7] = ((( yres   & 0xf00 ) >> 4) |
+               (( yblank & 0xf00 ) >> 8));
+
+    desc[8] = xfront & 0xff;
+    desc[9] = xsync  & 0xff;
+
+    desc[10] = ((( yfront & 0x00f ) << 4) |
+                (( ysync  & 0x00f ) << 0));
+    desc[11] = ((( xfront & 0x300 ) >> 2) |
+                (( xsync  & 0x300 ) >> 4) |
+                (( yfront & 0x030 ) >> 2) |
+                (( ysync  & 0x030 ) >> 4));
+
+    desc[12] = xmm & 0xff;
+    desc[13] = ymm & 0xff;
+    desc[14] = ((( xmm & 0xf00 ) >> 4) |
+                (( ymm & 0xf00 ) >> 8));
+
+    desc[17] = 0x18;
+}
+
+void qemu_edid_generate(uint8_t *edid, size_t size,
+                        qemu_edid_info *info)
+{
+    uint32_t desc = 54;
+    uint8_t *xtra3 = NULL;
+
+    /* =============== set defaults  =============== */
+
+    if (!info->vendor || strlen(info->vendor) != 3) {
+        info->vendor = "EMU";
+    }
+    if (!info->name) {
+        info->name = "QEMU Monitor";
+    }
+    if (!info->dpi) {
+        info->dpi = 100;
+    }
+    if (!info->prefx) {
+        info->prefx = 1024;
+    }
+    if (!info->prefy) {
+        info->prefy = 768;
+    }
+
+    /* =============== header information =============== */
+
+    /* fixed */
+    edid[0] = 0x00;
+    edid[1] = 0xff;
+    edid[2] = 0xff;
+    edid[3] = 0xff;
+    edid[4] = 0xff;
+    edid[5] = 0xff;
+    edid[6] = 0xff;
+    edid[7] = 0x00;
+
+    /* manufacturer id, product code, serial number */
+    uint16_t vendor_id = ((((info->vendor[0] - '@') & 0x1f) << 10) |
+                          (((info->vendor[1] - '@') & 0x1f) <<  5) |
+                          (((info->vendor[2] - '@') & 0x1f) <<  0));
+    uint16_t model_nr = 0x1234;
+    uint32_t serial_nr = info->serial ? atoi(info->serial) : 0;
+    *(uint16_t*)(edid +  8) = cpu_to_be16(vendor_id);
+    *(uint16_t*)(edid + 10) = cpu_to_le16(model_nr);
+    *(uint32_t*)(edid + 12) = cpu_to_le32(serial_nr);
+
+    /* manufacture week and year */
+    edid[16] = 42;
+    edid[17] = 2014 - 1990;
+
+    /* edid version */
+    edid[18] = 1;
+    edid[19] = 4;
+
+
+    /* =============== basic display parameters =============== */
+
+    /* video input: digital, 8bpc, displayport */
+    edid[20] = 0xa5;
+
+    /* screen size: undefined */
+    edid[21] = info->prefx * info->dpi / 2540;
+    edid[22] = info->prefy * info->dpi / 2540;
+
+    /* display gamma: 1.0 */
+    edid[23] = 0x00;
+
+    /* supported features bitmap: prefered timing */
+    edid[24] = 0x02;
+
+
+    /* =============== chromaticity coordinates =============== */
+
+    /* TODO (bytes 25 -> 34) */
+
+
+    /* =============== established timing bitmap =============== */
+    /* =============== standard timing information =============== */
+
+    /* both filled by edid_fill_modes() */
+
+
+    /* =============== descriptor blocks =============== */
+
+    edid_desc_timing(edid + desc, info->prefx, info->prefy, info->dpi);
+    desc += 18;
+
+    edid_desc_ranges(edid + desc);
+    desc += 18;
+
+    if (info->name) {
+        edid_desc_text(edid + desc, 0xfc, info->name);
+        desc += 18;
+    }
+
+    if (info->serial) {
+        edid_desc_text(edid + desc, 0xff, info->serial);
+        desc += 18;
+    }
+
+    if (desc < 126) {
+        xtra3 = edid + desc;
+        edid_desc_xtra3_std(xtra3);
+        desc += 18;
+    }
+
+    while (desc < 126) {
+        edid_desc_dummy(edid + desc);
+        desc += 18;
+    }
+
+    /* =============== finish up =============== */
+
+    edid_fill_modes(edid, xtra3, info->maxx, info->maxy);
+    edid_checksum(edid);
+}
diff --git a/qemu-edid.c b/qemu-edid.c
new file mode 100644
index 0000000000..8d6f1bbca3
--- /dev/null
+++ b/qemu-edid.c
@@ -0,0 +1,86 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/bswap.h"
+#include "hw/display/edid.h"
+
+static qemu_edid_info info;
+
+static void usage(FILE *out)
+{
+    fprintf(out,
+            "\n"
+            "This is a test tool for the qemu edid generator.\n"
+            "\n"
+            "Typically you'll pipe the output into edid-decode\n"
+            "to check if the generator works correctly.\n"
+            "\n"
+            "usage: qemu-edid <options>\n"
+            "options:\n"
+            "    -h             print this text\n"
+            "    -o <file>      set output file (stdout by default)\n"
+            "    -v <vendor>    set monitor vendor (three letters)\n"
+            "    -n <name>      set monitor name\n"
+            "    -s <serial>    set monitor serial\n"
+            "    -d <dpi>       set display resolution\n"
+            "    -x <prefx>     set preferred width\n"
+            "    -y <prefy>     set preferred height\n"
+            "\n");
+}
+
+int main(int argc, char *argv[])
+{
+    FILE *outfile = NULL;
+    uint8_t blob[128];
+    int rc;
+
+    for (;;) {
+        rc = getopt(argc, argv, "ho:x:y:d:v:n:s:");
+        if (rc == -1) {
+            break;
+        }
+        switch (rc) {
+        case 'o':
+            outfile = fopen(optarg, "w");
+            if (outfile == NULL) {
+                fprintf(stderr, "open %s: %s\n", optarg, strerror(errno));
+                exit(1);
+            }
+            break;
+        case 'x':
+            info.prefx = atoi(optarg);
+            break;
+        case 'y':
+            info.maxy = atoi(optarg);
+            break;
+        case 'd':
+            info.dpi = atoi(optarg);
+            break;
+        case 'v':
+            info.vendor = optarg;
+            break;
+        case 'n':
+            info.name = optarg;
+            break;
+        case 's':
+            info.serial = optarg;
+            break;
+        case 'h':
+            usage(stdout);
+            exit(0);
+        default:
+            usage(stderr);
+            exit(1);
+        }
+    }
+
+    if (outfile == NULL) {
+        outfile = stdout;
+    }
+
+    memset(blob, 0, sizeof(blob));
+    qemu_edid_generate(blob, sizeof(blob), &info);
+    fwrite(blob, sizeof(blob), 1, outfile);
+    fflush(outfile);
+
+    exit(0);
+}
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index a606fb7404..492404c09e 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -1,3 +1,5 @@
+common-obj-y += edid-generate.o
+
 common-obj-$(CONFIG_FW_CFG_DMA) += ramfb.o
 common-obj-$(CONFIG_FW_CFG_DMA) += ramfb-standalone.o
 
-- 
2.9.3
