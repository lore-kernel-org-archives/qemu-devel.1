Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20644C5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:44:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E733E21479
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E733E21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi8mt-00010K-62
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 22:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52892)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hi6Rk-00018B-OV
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 20:14:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hi6Ri-0006vb-7v
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 20:14:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36494)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hi6RR-0006fq-I2; Mon, 01 Jul 2019 20:14:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 215B530872CC;
 Tue,  2 Jul 2019 00:14:25 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-21.brq.redhat.com [10.40.204.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A9881001B01;
 Tue,  2 Jul 2019 00:14:06 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 02:12:55 +0200
Message-Id: <20190702001301.4768-4-philmd@redhat.com>
In-Reply-To: <20190702001301.4768-1-philmd@redhat.com>
References: <20190702001301.4768-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 02 Jul 2019 00:14:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 3/9] hw/block/pflash_cfi01: Extract
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair23@gmail.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
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

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi01.c | 36 ++++++++++++++++++++----------------
 hw/block/trace-events   |  1 +
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 743b5d5794..33c77f6569 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -112,6 +112,14 @@ static const VMStateDescription vmstate_pflash =3D {
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
@@ -470,7 +478,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
         case 0x50: /* Clear status bits */
             DPRINTF("%s: Clear status bits\n", __func__);
             pfl->status =3D 0x0;
-            goto reset_flash;
+            goto mode_read_array;
         case 0x60: /* Block (un)lock */
             DPRINTF("%s: Block unlock\n", __func__);
             break;
@@ -495,10 +503,10 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr o=
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
@@ -525,7 +533,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
                 pfl->wcycle =3D 0;
                 pfl->status |=3D 0x80;
             } else if (cmd =3D=3D 0xff) { /* Read Array */
-                goto reset_flash;
+                goto mode_read_array;
             } else
                 goto error_flash;
=20
@@ -552,15 +560,15 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr o=
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
@@ -620,7 +628,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
                     " the data is already written to storage!\n"
                     "Flash device reset into READ mode.\n",
                     __func__);
-                goto reset_flash;
+                goto mode_read_array;
             }
             break;
         default:
@@ -630,7 +638,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
     default:
         /* Should never happen */
         DPRINTF("%s: invalid write state\n",  __func__);
-        goto reset_flash;
+        goto mode_read_array;
     }
     return;
=20
@@ -639,11 +647,8 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr of=
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
@@ -758,8 +763,7 @@ static void pflash_cfi01_realize(DeviceState *dev, Er=
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
index 97a17838ed..d627cfc3f5 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -7,6 +7,7 @@ fdc_ioport_write(uint8_t reg, uint8_t value) "write reg 0=
x%02x val 0x%02x"
 # pflash_cfi02.c
 # pflash_cfi01.c
 pflash_reset(void) "reset"
+pflash_mode_read_array(void) "mode: read array"
 pflash_read(uint64_t offset, uint8_t cmd, int width, uint8_t wcycle) "of=
fset:0x%04"PRIx64" cmd:0x%02x width:%d wcycle:%u"
 pflash_write(uint64_t offset, uint32_t value, int width, uint8_t wcycle)=
 "offset:0x%04"PRIx64" value:0x%03x width:%d wcycle:%u"
 pflash_timer_expired(uint8_t cmd) "command 0x%02x done"
--=20
2.20.1


