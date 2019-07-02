Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E51C5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 03:14:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D81A206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 03:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D81A206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi9FJ-0004E8-M8
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 23:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58550)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hi6v4-0007Ya-KI
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 20:45:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hi6VJ-0008JI-Fy
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 20:18:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53582)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hi6TL-0007ZO-7s; Mon, 01 Jul 2019 20:16:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 39F236EB96;
 Tue,  2 Jul 2019 00:16:32 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-21.brq.redhat.com [10.40.204.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DC2361001B32;
 Tue,  2 Jul 2019 00:16:10 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 02:13:01 +0200
Message-Id: <20190702001301.4768-10-philmd@redhat.com>
In-Reply-To: <20190702001301.4768-1-philmd@redhat.com>
References: <20190702001301.4768-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 02 Jul 2019 00:16:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 9/9] hw/block/pflash_cfi01: Hold the PRI
 table offset in a variable
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

Manufacturers are allowed to move the PRI table, this is why the
offset is queryable via fixed offsets 0x15/0x16.
Add a variable to hold the offset, so it will be easier to later
move the PRI table.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi01.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index e891112b67..f65840eb2b 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -762,6 +762,7 @@ static void pflash_cfi01_realize(DeviceState *dev, Er=
ror **errp)
     }
=20
     /* Hardcoded CFI table */
+    const uint16_t pri_ofs =3D 0x31;
     /* Standard "QRY" string */
     pfl->cfi_table[0x10] =3D 'Q';
     pfl->cfi_table[0x11] =3D 'R';
@@ -770,14 +771,17 @@ static void pflash_cfi01_realize(DeviceState *dev, =
Error **errp)
     pfl->cfi_table[0x13] =3D 0x01;
     pfl->cfi_table[0x14] =3D 0x00;
     /* Primary extended table address (none) */
-    pfl->cfi_table[0x15] =3D 0x31;
-    pfl->cfi_table[0x16] =3D 0x00;
+    pfl->cfi_table[0x15] =3D pri_ofs;
+    pfl->cfi_table[0x16] =3D pri_ofs >> 8;
     /* Alternate command set (none) */
     pfl->cfi_table[0x17] =3D 0x00;
     pfl->cfi_table[0x18] =3D 0x00;
     /* Alternate extended table (none) */
     pfl->cfi_table[0x19] =3D 0x00;
     pfl->cfi_table[0x1A] =3D 0x00;
+
+    /* CFI: System Interface Information */
+
     /* Vcc min */
     pfl->cfi_table[0x1B] =3D 0x45;
     /* Vcc max */
@@ -802,6 +806,9 @@ static void pflash_cfi01_realize(DeviceState *dev, Er=
ror **errp)
     pfl->cfi_table[0x25] =3D 0x04;
     /* Max timeout for chip erase */
     pfl->cfi_table[0x26] =3D 0x00;
+
+    /* CFI: Device Geometry Definition */
+
     /* Device size */
     pfl->cfi_table[0x27] =3D ctz32(device_len); /* + 1; */
     /* Flash device interface (8 & 16 bits) */
@@ -826,26 +833,30 @@ static void pflash_cfi01_realize(DeviceState *dev, =
Error **errp)
     pfl->cfi_table[0x2E] =3D (blocks_per_device - 1) >> 8;
     pfl->cfi_table[0x2F] =3D sector_len_per_device >> 8;
     pfl->cfi_table[0x30] =3D sector_len_per_device >> 16;
+    assert(0x30 < pri_ofs);
+
+    /* CFI: Primary-Vendor Specific */
=20
     /* Extended */
-    pfl->cfi_table[0x31] =3D 'P';
-    pfl->cfi_table[0x32] =3D 'R';
-    pfl->cfi_table[0x33] =3D 'I';
+    pfl->cfi_table[0x00 + pri_ofs] =3D 'P';
+    pfl->cfi_table[0x01 + pri_ofs] =3D 'R';
+    pfl->cfi_table[0x02 + pri_ofs] =3D 'I';
=20
-    pfl->cfi_table[0x34] =3D '1';
-    pfl->cfi_table[0x35] =3D '0';
+    pfl->cfi_table[0x03 + pri_ofs] =3D '1';
+    pfl->cfi_table[0x04 + pri_ofs] =3D '0';
=20
-    pfl->cfi_table[0x36] =3D 0x00;
-    pfl->cfi_table[0x37] =3D 0x00;
-    pfl->cfi_table[0x38] =3D 0x00;
-    pfl->cfi_table[0x39] =3D 0x00;
+    pfl->cfi_table[0x05 + pri_ofs] =3D 0x00; /* Optional features */
+    pfl->cfi_table[0x06 + pri_ofs] =3D 0x00;
+    pfl->cfi_table[0x07 + pri_ofs] =3D 0x00;
+    pfl->cfi_table[0x08 + pri_ofs] =3D 0x00;
=20
-    pfl->cfi_table[0x3a] =3D 0x00;
+    pfl->cfi_table[0x09 + pri_ofs] =3D 0x00; /* Func. supported after su=
spend */
=20
-    pfl->cfi_table[0x3b] =3D 0x00;
-    pfl->cfi_table[0x3c] =3D 0x00;
+    pfl->cfi_table[0x0a + pri_ofs] =3D 0x00; /* Block status register ma=
sk */
+    pfl->cfi_table[0x0b + pri_ofs] =3D 0x00;
=20
-    pfl->cfi_table[0x3f] =3D 0x01; /* Number of protection fields */
+    pfl->cfi_table[0x0e + pri_ofs] =3D 0x01; /* Number of protection fie=
lds */
+    assert(0x0e + pri_ofs < ARRAY_SIZE(pfl->cfi_table));
 }
=20
 static void pflash_cfi01_system_reset(DeviceState *dev)
--=20
2.20.1


