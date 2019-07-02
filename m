Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB313C5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF8672089C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8672089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi8uM-0006dP-0b
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 22:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52737)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hi6RY-0000p0-1a
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 20:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hi6RW-0006na-H7
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 20:14:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56846)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hi6R2-0006Uj-SK; Mon, 01 Jul 2019 20:14:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BE37DC05FBD7;
 Tue,  2 Jul 2019 00:14:05 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-21.brq.redhat.com [10.40.204.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3AEF81001B01;
 Tue,  2 Jul 2019 00:13:46 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 02:12:54 +0200
Message-Id: <20190702001301.4768-3-philmd@redhat.com>
In-Reply-To: <20190702001301.4768-1-philmd@redhat.com>
References: <20190702001301.4768-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 02 Jul 2019 00:14:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 2/9] hw/block/pflash_cfi01: Use the correct
 READ_ARRAY value
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

In the "Read Array Flowchart" the command has a value of 0xFF.

In the document [*] the "Read Array Flowchart", the READ_ARRAY
command has a value of 0xff.

Use the correct value in the pflash model.

There is no change of behavior in the guest, because:
- when the guest were sending 0xFF, the reset_flash label
  was setting the command value as 0x00
- 0x00 was used internally for READ_ARRAY

[*] "Common Flash Interface (CFI) and Command Sets"
    (Intel Application Note 646)
    Appendix B "Basic Command Set"

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi01.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index dcc9885bf0..743b5d5794 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -280,10 +280,9 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hwaddr=
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
@@ -449,8 +448,6 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
     case 0:
         /* read mode */
         switch (cmd) {
-        case 0x00: /* ??? */
-            goto reset_flash;
         case 0x10: /* Single Byte Program */
         case 0x40: /* Single Byte Program */
             DPRINTF("%s: Single Byte Program\n", __func__);
@@ -527,7 +524,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
             if (cmd =3D=3D 0xd0) { /* confirm */
                 pfl->wcycle =3D 0;
                 pfl->status |=3D 0x80;
-            } else if (cmd =3D=3D 0xff) { /* read array mode */
+            } else if (cmd =3D=3D 0xff) { /* Read Array */
                 goto reset_flash;
             } else
                 goto error_flash;
@@ -554,7 +551,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
             } else if (cmd =3D=3D 0x01) {
                 pfl->wcycle =3D 0;
                 pfl->status |=3D 0x80;
-            } else if (cmd =3D=3D 0xff) {
+            } else if (cmd =3D=3D 0xff) { /* read array mode */
                 goto reset_flash;
             } else {
                 DPRINTF("%s: Unknown (un)locking command\n", __func__);
@@ -646,7 +643,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
     trace_pflash_reset();
     memory_region_rom_device_set_romd(&pfl->mem, true);
     pfl->wcycle =3D 0;
-    pfl->cmd =3D 0;
+    pfl->cmd =3D 0xff;
 }
=20
=20
@@ -762,7 +759,7 @@ static void pflash_cfi01_realize(DeviceState *dev, Er=
ror **errp)
     }
=20
     pfl->wcycle =3D 0;
-    pfl->cmd =3D 0;
+    pfl->cmd =3D 0xff;
     pfl->status =3D 0;
     /* Hardcoded CFI table */
     /* Standard "QRY" string */
--=20
2.20.1


