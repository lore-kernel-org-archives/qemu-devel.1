Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFCCC76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 12:15:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 867AA2080A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 12:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867AA2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmzsk-0002MF-6A
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 08:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32816)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hmzsH-0000ck-RO
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 08:14:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hmzsG-000254-FC
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 08:14:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49604)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hmzsC-00022f-L3; Mon, 15 Jul 2019 08:14:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B5A483DE0E;
 Mon, 15 Jul 2019 12:14:26 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BB61B5C232;
 Mon, 15 Jul 2019 12:14:17 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>
Date: Mon, 15 Jul 2019 14:13:38 +0200
Message-Id: <20190715121338.20600-6-philmd@redhat.com>
In-Reply-To: <20190715121338.20600-1-philmd@redhat.com>
References: <20190715121338.20600-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 15 Jul 2019 12:14:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 5/5] hw/block/pflash_cfi01: Add the
 DeviceReset() handler
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
 qemu-block@nongnu.org, Laszlo Ersek <lersek@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A "system reset" sets the device state machine in READ_ARRAY mode
and, after some delay, set the SR.7 READY bit.

We do not model timings, so we set the SR.7 bit directly.

The TYPE_DEVICE interface provides a DeviceReset handler.
This pflash device is a subclass of TYPE_SYS_BUS_DEVICE (which
is a subclass of TYPE_DEVICE).
SYS_BUS devices are automatically plugged into the 'main system
bus', which is the root of the qbus tree.
Devices in the qbus tree are guaranteed to have their reset()
handler called after realize() and before we try to run the guest.

To avoid incoherent states when the machine resets (see but report
below), factor out the reset code into pflash_cfi01_system_reset,
and register the method as a device reset callback.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1678713
Reported-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Regression-tested-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v3: reword description
---
 hw/block/pflash_cfi01.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index aa2126f6dc..dd2ace92a8 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -795,8 +795,6 @@ static void pflash_cfi01_realize(DeviceState *dev, Er=
ror **errp)
         pfl->max_device_width =3D pfl->device_width;
     }
=20
-    pflash_mode_read_array(pfl);
-    pfl->status =3D 0x80; /* WSM ready */
     /* Hardcoded CFI table */
     /* Standard "QRY" string */
     pfl->cfi_table[0x10] =3D 'Q';
@@ -884,6 +882,18 @@ static void pflash_cfi01_realize(DeviceState *dev, E=
rror **errp)
     pfl->cfi_table[0x3f] =3D 0x01; /* Number of protection fields */
 }
=20
+static void pflash_cfi01_system_reset(DeviceState *dev)
+{
+    PFlashCFI01 *pfl =3D PFLASH_CFI01(dev);
+
+    pflash_mode_read_array(pfl);
+    /*
+     * The WSM ready timer occurs at most 150ns after system reset.
+     * This model deliberately ignores this delay.
+     */
+    pfl->status =3D 0x80;
+}
+
 static Property pflash_cfi01_properties[] =3D {
     DEFINE_PROP_DRIVE("drive", PFlashCFI01, blk),
     /* num-blocks is the number of blocks actually visible to the guest,
@@ -928,6 +938,7 @@ static void pflash_cfi01_class_init(ObjectClass *klas=
s, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
+    dc->reset =3D pflash_cfi01_system_reset;
     dc->realize =3D pflash_cfi01_realize;
     dc->props =3D pflash_cfi01_properties;
     dc->vmsd =3D &vmstate_pflash;
--=20
2.20.1


