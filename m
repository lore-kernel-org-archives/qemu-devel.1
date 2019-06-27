Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D6EC48BE3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 20:40:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF432075E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 20:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF432075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgbBf-0003Ls-7J
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 16:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45815)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hgb1E-0001x8-Lh
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 16:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hgb1C-0000RJ-PC
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 16:29:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56592)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hgb12-00006W-Lk; Thu, 27 Jun 2019 16:29:09 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0F7F13058F5B;
 Thu, 27 Jun 2019 20:29:06 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-69.brq.redhat.com [10.40.204.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA31B600CC;
 Thu, 27 Jun 2019 20:29:00 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 22:27:02 +0200
Message-Id: <20190627202719.17739-12-philmd@redhat.com>
In-Reply-To: <20190627202719.17739-1-philmd@redhat.com>
References: <20190627202719.17739-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 27 Jun 2019 20:29:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 11/28] hw/block/pflash_cfi02: Unify the
 MemoryRegionOps
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Walle <michael@walle.cc>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Antony Pavlov <antonynpavlov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The pflash_read()/pflash_write() can check the device endianess
via the pfl->be variable, so remove the 'int be' argument.

Since the big/little MemoryRegionOps are now identical, it is
pointless to declare them both. Unify them.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Message-Id: <20190426162624.55977-3-stephen.checkoway@oberlin.edu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
[PMD: Extracted from bigger patch to ease review]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi02.c | 60 +++++++++++------------------------------
 1 file changed, 15 insertions(+), 45 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index c079a63880..e64dc69c6c 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -177,11 +177,11 @@ static uint64_t pflash_data_read(PFlashCFI02 *pfl, =
hwaddr offset,
     return ret;
 }
=20
-static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr offset,
-                            int width, int be)
+static uint64_t pflash_read(void *opaque, hwaddr offset, unsigned int wi=
dth)
 {
+    PFlashCFI02 *pfl =3D opaque;
     hwaddr boff;
-    uint32_t ret;
+    uint64_t ret;
=20
     ret =3D -1;
     /* Lazy reset to ROMD mode after a certain amount of read accesses *=
/
@@ -228,14 +228,14 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwadd=
r offset,
         default:
             ret =3D pflash_data_read(pfl, offset, width);
         }
-        DPRINTF("%s: ID " TARGET_FMT_plx " %" PRIx32 "\n", __func__, bof=
f, ret);
+        DPRINTF("%s: ID " TARGET_FMT_plx " %" PRIx64 "\n", __func__, bof=
f, ret);
         break;
     case 0xA0:
     case 0x10:
     case 0x30:
         /* Status register read */
         ret =3D pfl->status;
-        DPRINTF("%s: status %" PRIx32 "\n", __func__, ret);
+        DPRINTF("%s: status %" PRIx64 "\n", __func__, ret);
         toggle_dq6(pfl);
         break;
     case 0x98:
@@ -253,8 +253,7 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr =
offset,
 }
=20
 /* update flash content on disk */
-static void pflash_update(PFlashCFI02 *pfl, int offset,
-                          int size)
+static void pflash_update(PFlashCFI02 *pfl, int offset, int size)
 {
     int offset_end;
     if (pfl->blk) {
@@ -267,9 +266,10 @@ static void pflash_update(PFlashCFI02 *pfl, int offs=
et,
     }
 }
=20
-static void pflash_write(PFlashCFI02 *pfl, hwaddr offset,
-                         uint32_t value, int width, int be)
+static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
+                         unsigned int width)
 {
+    PFlashCFI02 *pfl =3D opaque;
     hwaddr boff;
     uint8_t *p;
     uint8_t cmd;
@@ -477,39 +477,9 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr of=
fset,
     pfl->cmd =3D 0;
 }
=20
-static uint64_t pflash_be_readfn(void *opaque, hwaddr addr, unsigned siz=
e)
-{
-    return pflash_read(opaque, addr, size, 1);
-}
-
-static void pflash_be_writefn(void *opaque, hwaddr addr,
-                              uint64_t value, unsigned size)
-{
-    pflash_write(opaque, addr, value, size, 1);
-}
-
-static uint64_t pflash_le_readfn(void *opaque, hwaddr addr, unsigned siz=
e)
-{
-    return pflash_read(opaque, addr, size, 0);
-}
-
-static void pflash_le_writefn(void *opaque, hwaddr addr,
-                              uint64_t value, unsigned size)
-{
-    pflash_write(opaque, addr, value, size, 0);
-}
-
-static const MemoryRegionOps pflash_cfi02_ops_be =3D {
-    .read =3D pflash_be_readfn,
-    .write =3D pflash_be_writefn,
-    .valid.min_access_size =3D 1,
-    .valid.max_access_size =3D 4,
-    .endianness =3D DEVICE_NATIVE_ENDIAN,
-};
-
-static const MemoryRegionOps pflash_cfi02_ops_le =3D {
-    .read =3D pflash_le_readfn,
-    .write =3D pflash_le_writefn,
+static const MemoryRegionOps pflash_cfi02_ops =3D {
+    .read =3D pflash_read,
+    .write =3D pflash_write,
     .valid.min_access_size =3D 1,
     .valid.max_access_size =3D 4,
     .endianness =3D DEVICE_NATIVE_ENDIAN,
@@ -537,9 +507,9 @@ static void pflash_cfi02_realize(DeviceState *dev, Er=
ror **errp)
=20
     chip_len =3D pfl->sector_len * pfl->nb_blocs;
=20
-    memory_region_init_rom_device(&pfl->orig_mem, OBJECT(pfl), pfl->be ?
-                                  &pflash_cfi02_ops_be : &pflash_cfi02_o=
ps_le,
-                                  pfl, pfl->name, chip_len, &local_err);
+    memory_region_init_rom_device(&pfl->orig_mem, OBJECT(pfl),
+                                  &pflash_cfi02_ops, pfl, pfl->name,
+                                  chip_len, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
--=20
2.20.1


