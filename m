Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEFDC004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 22:24:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5B21205C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 22:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B21205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47012 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNPYh-0002F4-4B
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 18:24:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPRE-0004ea-M2
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPRD-0000NO-ET
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:16:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hNPRA-0000Hh-NV; Sun, 05 May 2019 18:16:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 11E68309264B;
	Sun,  5 May 2019 22:16:48 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-58.brq.redhat.com [10.40.204.58])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E81405D739;
	Sun,  5 May 2019 22:16:44 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>
Date: Mon,  6 May 2019 00:15:42 +0200
Message-Id: <20190505221544.31568-12-philmd@redhat.com>
In-Reply-To: <20190505221544.31568-1-philmd@redhat.com>
References: <20190505221544.31568-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Sun, 05 May 2019 22:16:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 11/13] hw/block/pflash_cfi02: Unify the
 MemoryRegionOps
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
	Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505221542.FdnhMHI_FFyS8V4-JSc7jiSvsq2EVkf8kHgyMP7utEI@z>

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
 hw/block/pflash_cfi02.c | 62 +++++++++++------------------------------
 1 file changed, 16 insertions(+), 46 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index adfa39f9b5e..59daade2ee6 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -186,11 +186,11 @@ static uint64_t pflash_data_read(PFlashCFI02 *pfl, =
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
     trace_pflash_read(offset, pfl->cmd, width, pfl->wcycle);
@@ -238,14 +238,14 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwadd=
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
         /* Toggle bit 6 */
         toggle_dq6(pfl);
         break;
@@ -263,8 +263,7 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr =
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
@@ -277,9 +276,10 @@ static void pflash_update(PFlashCFI02 *pfl, int offs=
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
@@ -295,7 +295,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr off=
set,
     trace_pflash_write(offset, value, width, pfl->wcycle);
     offset &=3D pfl->chip_len - 1;
=20
-    DPRINTF("%s: offset " TARGET_FMT_plx " %08" PRIx32 " %d\n", __func__=
,
+    DPRINTF("%s: offset " TARGET_FMT_plx " %08" PRIx64 " %d\n", __func__=
,
             offset, value, width);
     boff =3D offset & (pfl->sector_len - 1);
     if (pfl->width =3D=3D 2)
@@ -492,39 +492,9 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr of=
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
@@ -552,9 +522,9 @@ static void pflash_cfi02_realize(DeviceState *dev, Er=
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


