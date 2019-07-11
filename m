Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209E1C74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 15:58:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8CCD20644
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 15:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8CCD20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlbSm-00089l-3f
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 11:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33415)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hlbRu-0004Rk-UR
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 11:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hlbRt-0006cJ-Ee
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 11:57:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59796)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hlbRo-0006U2-40; Thu, 11 Jul 2019 11:57:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 500AF3086220;
 Thu, 11 Jul 2019 15:57:26 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-150.brq.redhat.com [10.40.204.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A24D95D9CC;
 Thu, 11 Jul 2019 15:57:22 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 17:57:01 +0200
Message-Id: <20190711155703.15627-4-philmd@redhat.com>
In-Reply-To: <20190711155703.15627-1-philmd@redhat.com>
References: <20190711155703.15627-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 11 Jul 2019 15:57:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.1 v4 3/5] hw/block/pflash_cfi01: Extract
 pflash_mode_read_array()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The same pattern is used when setting the flash in READ_ARRAY mode:
- Set the state machine command to READ_ARRAY
- Reset the write_cycle counter
- Reset the memory region in ROMD

Refactor the current code by extracting this pattern.
It is used twice:
- On a write access (on command failure, error, or explicitly asked)
- When the device is initialized. Here the ROMD mode is hidden
  by the memory_region_init_rom_device() call.

Rename the 'reset_flash' as 'mode_read_array' to make explicit we
do not reset the device, we simply set its internal state machine
in the READ_ARRAY mode. We do not reset the status register error
bits, as a device reset would do.

Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Regression-tested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi01.c | 36 ++++++++++++++++++++----------------
 hw/block/trace-events   |  1 +
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 85bb2132c0..6c3fefcd2d 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -145,6 +145,14 @@ static const VMStateDescription vmstate_pflash =3D {
     }
 };
=20
+static void pflash_mode_read_array(PFlashCFI01 *pfl)
+{
+    trace_pflash_mode_read_array();
+    pfl->cmd =3D 0xff; /* Read Array */
+    pfl->wcycle =3D 0;
+    memory_region_rom_device_set_romd(&pfl->mem, true);
+}
+
 /* Perform a CFI query based on the bank width of the flash.
  * If this code is called we know we have a device_width set for
  * this flash.
@@ -502,7 +510,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
         case 0x50: /* Clear status bits */
             DPRINTF("%s: Clear status bits\n", __func__);
             pfl->status =3D 0x0;
-            goto reset_flash;
+            goto mode_read_array;
         case 0x60: /* Block (un)lock */
             DPRINTF("%s: Block unlock\n", __func__);
             break;
@@ -527,10 +535,10 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr o=
ffset,
             break;
         case 0xf0: /* Probe for AMD flash */
             DPRINTF("%s: Probe for AMD flash\n", __func__);
-            goto reset_flash;
+            goto mode_read_array;
         case 0xff: /* Read array mode */
             DPRINTF("%s: Read array mode\n", __func__);
-            goto reset_flash;
+            goto mode_read_array;
         default:
             goto error_flash;
         }
@@ -557,7 +565,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
                 pfl->wcycle =3D 0;
                 pfl->status |=3D 0x80;
             } else if (cmd =3D=3D 0xff) { /* Read Array */
-                goto reset_flash;
+                goto mode_read_array;
             } else
                 goto error_flash;
=20
@@ -584,15 +592,15 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr o=
ffset,
                 pfl->wcycle =3D 0;
                 pfl->status |=3D 0x80;
             } else if (cmd =3D=3D 0xff) { /* read array mode */
-                goto reset_flash;
+                goto mode_read_array;
             } else {
                 DPRINTF("%s: Unknown (un)locking command\n", __func__);
-                goto reset_flash;
+                goto mode_read_array;
             }
             break;
         case 0x98:
             if (cmd =3D=3D 0xff) {
-                goto reset_flash;
+                goto mode_read_array;
             } else {
                 DPRINTF("%s: leaving query mode\n", __func__);
             }
@@ -652,7 +660,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
                     " the data is already written to storage!\n"
                     "Flash device reset into READ mode.\n",
                     __func__);
-                goto reset_flash;
+                goto mode_read_array;
             }
             break;
         default:
@@ -662,7 +670,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
     default:
         /* Should never happen */
         DPRINTF("%s: invalid write state\n",  __func__);
-        goto reset_flash;
+        goto mode_read_array;
     }
     return;
=20
@@ -671,11 +679,8 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr of=
fset,
                   "(offset " TARGET_FMT_plx ", wcycle 0x%x cmd 0x%x valu=
e 0x%x)"
                   "\n", __func__, offset, pfl->wcycle, pfl->cmd, value);
=20
- reset_flash:
-    trace_pflash_reset();
-    memory_region_rom_device_set_romd(&pfl->mem, true);
-    pfl->wcycle =3D 0;
-    pfl->cmd =3D 0xff;
+ mode_read_array:
+    pflash_mode_read_array(pfl);
 }
=20
=20
@@ -790,8 +795,7 @@ static void pflash_cfi01_realize(DeviceState *dev, Er=
ror **errp)
         pfl->max_device_width =3D pfl->device_width;
     }
=20
-    pfl->wcycle =3D 0;
-    pfl->cmd =3D 0xff;
+    pflash_mode_read_array(pfl);
     pfl->status =3D 0;
     /* Hardcoded CFI table */
     /* Standard "QRY" string */
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 13d1b21dd4..91a8a106c0 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -7,6 +7,7 @@ fdc_ioport_write(uint8_t reg, uint8_t value) "write reg 0=
x%02x val 0x%02x"
 # pflash_cfi02.c
 # pflash_cfi01.c
 pflash_reset(void) "reset"
+pflash_mode_read_array(void) "mode: read array"
 pflash_timer_expired(uint8_t cmd) "command 0x%02x done"
 pflash_io_read(uint64_t offset, int width, int fmt_width, uint32_t value=
, uint8_t cmd, uint8_t wcycle) "offset:0x%04"PRIx64" width:%d value:0x%0*=
x cmd:0x%02x wcycle:%u"
 pflash_io_write(uint64_t offset, int width, int fmt_width, uint32_t valu=
e, uint8_t wcycle) "offset:0x%04"PRIx64" width:%d value:0x%0*x wcycle:%u"
--=20
2.20.1


