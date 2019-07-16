Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706DDC7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 22:17:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40F272173B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 22:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F272173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52641 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnVl6-0000Pa-Re
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 18:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41733)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hnVkX-0007Cp-5Q
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 18:16:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hnVkV-0002YR-O0
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 18:16:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41908)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hnVkS-0002Sq-RL; Tue, 16 Jul 2019 18:16:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 46A713092640;
 Tue, 16 Jul 2019 22:16:33 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-58.brq.redhat.com [10.40.204.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD8115D96F;
 Tue, 16 Jul 2019 22:16:21 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 00:15:53 +0200
Message-Id: <20190716221555.11145-4-philmd@redhat.com>
In-Reply-To: <20190716221555.11145-1-philmd@redhat.com>
References: <20190716221555.11145-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 16 Jul 2019 22:16:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.1 v6 3/5] hw/block/pflash_cfi01: Extract
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laszlo Ersek <lersek@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, John Snow <jsnow@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The same pattern is used when setting the flash in READ_ARRAY mode:
- Set the state machine command to READ_ARRAY
- Reset the write_cycle counter
- Reset the memory region in ROMD

Refactor the current code by extracting this pattern.
It is used three times:

- On a read access (on invalid command).

  Note this default case is not reachable by the state machine
  updates in pflash_data_write(). However we might reach this
  case migrating from a future QEMU version that would implement
  newer commands, without incrementing the migration version.
  Since we never know, we keep this default case.

  Previous to this patch, an invalid read command would not reset
  the memory region in ROMD mode, so:

  . A further read access would keep going into I/O mode, calling
  the same switch in pflash_read(). Undefined behaviour, probably
  unexpected.
  . A further write access in I/O mode. Since the default case set
  (wcycle=3D0, cmd=3D0x00), we jump to reset_flash which set the flash
  in READ_ARRAY.

  After this patch, if we get an invalid read command we directly
  set (wcycle=3D0, cmd=3D0x00) and put the device in ROMD mode.
  Further I/O access are now properly handled.

- On a write access (on command failure, error, or explicitly asked)

- When the device is initialized. Here the ROMD mode is hidden
  by the memory_region_init_rom_device() call.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v6: split of the label rename to ease review
    the pattern is used 3 times (was 2 times previously)
    describe the 3rd time and reset the review tags :(
---
 hw/block/pflash_cfi01.c | 31 +++++++++++++++----------------
 hw/block/trace-events   |  1 +
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 6838e8a1ab..a28d0f8cc7 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -112,6 +112,18 @@ static const VMStateDescription vmstate_pflash =3D {
     }
 };
=20
+static void pflash_mode_read_array(PFlashCFI01 *pfl)
+{
+    trace_pflash_mode_read_array();
+    /*
+     * The command 0x00 is not assigned by the CFI open standard,
+     * but QEMU historically uses it for the READ_ARRAY command (0xff).
+     */
+    pfl->cmd =3D 0x00;
+    pfl->wcycle =3D 0;
+    memory_region_rom_device_set_romd(&pfl->mem, true);
+}
+
 /* Perform a CFI query based on the bank width of the flash.
  * If this code is called we know we have a device_width set for
  * this flash.
@@ -276,12 +288,7 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hwaddr=
 offset,
     default:
         /* This should never happen : reset state & treat it as a read *=
/
         DPRINTF("%s: unknown command state: %x\n", __func__, pfl->cmd);
-        pfl->wcycle =3D 0;
-        /*
-         * The command 0x00 is not assigned by the CFI open standard,
-         * but QEMU historically uses it for the READ_ARRAY command (0xf=
f).
-         */
-        pfl->cmd =3D 0x00;
+        pflash_mode_read_array(pfl);
         /* fall through to read code */
     case 0x00: /* This model reset value for READ_ARRAY (not CFI complia=
nt) */
         /* Flash area read */
@@ -646,10 +653,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr of=
fset,
                   "\n", __func__, offset, pfl->wcycle, pfl->cmd, value);
=20
  reset_flash:
-    trace_pflash_reset();
-    memory_region_rom_device_set_romd(&pfl->mem, true);
-    pfl->wcycle =3D 0;
-    pfl->cmd =3D 0x00; /* This model reset value for READ_ARRAY (not CFI=
) */
+    pflash_mode_read_array(pfl);
 }
=20
=20
@@ -764,12 +768,7 @@ static void pflash_cfi01_realize(DeviceState *dev, E=
rror **errp)
         pfl->max_device_width =3D pfl->device_width;
     }
=20
-    pfl->wcycle =3D 0;
-    /*
-     * The command 0x00 is not assigned by the CFI open standard,
-     * but QEMU historically uses it for the READ_ARRAY command (0xff).
-     */
-    pfl->cmd =3D 0x00;
+    pflash_mode_read_array(pfl);
     pfl->status =3D 0x80; /* WSM ready */
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


