Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218CAC74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 15:58:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E544620644
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 15:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E544620644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlbSM-0005wX-Ij
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 11:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33389)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hlbRs-0004Jg-PX
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 11:57:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hlbRq-0006YX-4u
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 11:57:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45528)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hlbRk-0006Pf-2s; Thu, 11 Jul 2019 11:57:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 370DC2CD801;
 Thu, 11 Jul 2019 15:57:22 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-150.brq.redhat.com [10.40.204.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BAE815D9CC;
 Thu, 11 Jul 2019 15:57:16 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 17:57:00 +0200
Message-Id: <20190711155703.15627-3-philmd@redhat.com>
In-Reply-To: <20190711155703.15627-1-philmd@redhat.com>
References: <20190711155703.15627-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 11 Jul 2019 15:57:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.1 v4 2/5] hw/block/pflash_cfi01: Use the
 correct READ_ARRAY value
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

In the "Read Array Flowchart" the command has a value of 0xFF.

In the document [*] the "Read Array Flowchart", the READ_ARRAY
command has a value of 0xff.

Use the correct value in the pflash model.

There is no change of behavior in the guest, because:
- when the guest were sending 0xFF, the reset_flash label
  was setting the command value as 0x00
- 0x00 was used internally for READ_ARRAY

To keep migration with older versions behaving correctly, we
decide to always migrate the READ_ARRAY as 0x00.

[*] "Common Flash Interface (CFI) and Command Sets"
    (Intel Application Note 646)
    Appendix B "Basic Command Set"

Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Regression-tested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v3: Handle migrating the 'cmd' field.
v4: Handle migrating to older QEMU (Dave)

Since Laszlo stated he did not test migration [*], I'm keeping his
test tag, because the change with v2 has no impact in the tests
he ran.

Likewise I'm keeping John and Alistair tags, but I'd like an extra
review for the migration change, thanks!

[*] https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg00679.html
---
 hw/block/pflash_cfi01.c | 57 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 9 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 9e34fd4e82..85bb2132c0 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -96,6 +96,37 @@ struct PFlashCFI01 {
     bool old_multiple_chip_handling;
 };
=20
+static int pflash_pre_save(void *opaque)
+{
+    PFlashCFI01 *s =3D opaque;
+
+    /*
+     * Previous to QEMU v4.1 an incorrect value of 0x00 was used for the
+     * READ_ARRAY command. To preserve migrating to these older version,
+     * always migrate the READ_ARRAY command as 0x00.
+     */
+    if (s->cmd =3D=3D 0xff) {
+        s->cmd =3D 0x00;
+    }
+
+    return 0;
+}
+
+static int pflash_post_save(void *opaque)
+{
+    PFlashCFI01 *s =3D opaque;
+
+    /*
+     * If migration failed, the guest will continue to run.
+     * Restore the correct READ_ARRAY value.
+     */
+    if (s->cmd =3D=3D 0x00) {
+        s->cmd =3D 0xff;
+    }
+
+    return 0;
+}
+
 static int pflash_post_load(void *opaque, int version_id);
=20
 static const VMStateDescription vmstate_pflash =3D {
@@ -103,6 +134,8 @@ static const VMStateDescription vmstate_pflash =3D {
     .version_id =3D 1,
     .minimum_version_id =3D 1,
     .post_load =3D pflash_post_load,
+    .pre_save =3D pflash_pre_save,
+    .post_save =3D pflash_post_save,
     .fields =3D (VMStateField[]) {
         VMSTATE_UINT8(wcycle, PFlashCFI01),
         VMSTATE_UINT8(cmd, PFlashCFI01),
@@ -277,10 +310,9 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hwaddr=
 offset,
         /* This should never happen : reset state & treat it as a read *=
/
         DPRINTF("%s: unknown command state: %x\n", __func__, pfl->cmd);
         pfl->wcycle =3D 0;
-        pfl->cmd =3D 0;
+        pfl->cmd =3D 0xff;
         /* fall through to read code */
-    case 0x00:
-        /* Flash area read */
+    case 0xff: /* Read Array */
         ret =3D pflash_data_read(pfl, offset, width, be);
         break;
     case 0x10: /* Single byte program */
@@ -448,8 +480,6 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
     case 0:
         /* read mode */
         switch (cmd) {
-        case 0x00: /* ??? */
-            goto reset_flash;
         case 0x10: /* Single Byte Program */
         case 0x40: /* Single Byte Program */
             DPRINTF("%s: Single Byte Program\n", __func__);
@@ -526,7 +556,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
             if (cmd =3D=3D 0xd0) { /* confirm */
                 pfl->wcycle =3D 0;
                 pfl->status |=3D 0x80;
-            } else if (cmd =3D=3D 0xff) { /* read array mode */
+            } else if (cmd =3D=3D 0xff) { /* Read Array */
                 goto reset_flash;
             } else
                 goto error_flash;
@@ -553,7 +583,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
             } else if (cmd =3D=3D 0x01) {
                 pfl->wcycle =3D 0;
                 pfl->status |=3D 0x80;
-            } else if (cmd =3D=3D 0xff) {
+            } else if (cmd =3D=3D 0xff) { /* read array mode */
                 goto reset_flash;
             } else {
                 DPRINTF("%s: Unknown (un)locking command\n", __func__);
@@ -645,7 +675,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
     trace_pflash_reset();
     memory_region_rom_device_set_romd(&pfl->mem, true);
     pfl->wcycle =3D 0;
-    pfl->cmd =3D 0;
+    pfl->cmd =3D 0xff;
 }
=20
=20
@@ -761,7 +791,7 @@ static void pflash_cfi01_realize(DeviceState *dev, Er=
ror **errp)
     }
=20
     pfl->wcycle =3D 0;
-    pfl->cmd =3D 0;
+    pfl->cmd =3D 0xff;
     pfl->status =3D 0;
     /* Hardcoded CFI table */
     /* Standard "QRY" string */
@@ -1001,5 +1031,14 @@ static int pflash_post_load(void *opaque, int vers=
ion_id)
         pfl->vmstate =3D qemu_add_vm_change_state_handler(postload_updat=
e_cb,
                                                         pfl);
     }
+
+    /*
+     * Previous to QEMU v4.1 an incorrect value of 0x00 was used for the
+     * READ_ARRAY command.
+     */
+    if (pfl->cmd =3D=3D 0x00) {
+        pfl->cmd =3D 0xff;
+    }
+
     return 0;
 }
--=20
2.20.1


