Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B22CC004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 20:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5A4204EC
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 20:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5A4204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45382 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNNTu-0006AB-C6
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 16:11:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNNPt-0002n8-MI
	for qemu-devel@nongnu.org; Sun, 05 May 2019 16:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNNPq-00066p-Dl
	for qemu-devel@nongnu.org; Sun, 05 May 2019 16:07:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hNNPZ-0004rM-UP; Sun, 05 May 2019 16:07:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 055F881F0D;
	Sun,  5 May 2019 20:06:58 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-58.brq.redhat.com [10.40.204.58])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3648960851;
	Sun,  5 May 2019 20:06:46 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
Date: Sun,  5 May 2019 22:06:01 +0200
Message-Id: <20190505200602.12412-5-philmd@redhat.com>
In-Reply-To: <20190505200602.12412-1-philmd@redhat.com>
References: <20190505200602.12412-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Sun, 05 May 2019 20:06:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 4/5] hw/block/pflash_cfi02: Extract the
 pflash_reset() code
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-block@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
	Laszlo Ersek <lersek@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505200601.2xb52ddCDGqHMrkMiMs76-MbJ40muT6NjvtygEd_s9M@z>

The reset() code is used in various places, refactor it.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi02.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index f2c6201f813..f321b74433c 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -120,6 +120,17 @@ static void pflash_register_memory(PFlashCFI02 *pfl,=
 int rom_mode)
     pfl->rom_mode =3D rom_mode;
 }
=20
+static void pflash_reset(PFlashCFI02 *pfl)
+{
+    trace_pflash_reset();
+    timer_del(&pfl->timer);
+    pfl->bypass =3D 0;
+    pfl->wcycle =3D 0;
+    pfl->cmd =3D 0;
+    pfl->status =3D 0;
+    pflash_register_memory(pfl, 1);
+}
+
 static void pflash_timer (void *opaque)
 {
     PFlashCFI02 *pfl =3D opaque;
@@ -129,11 +140,10 @@ static void pflash_timer (void *opaque)
     pfl->status ^=3D 0x80;
     if (pfl->bypass) {
         pfl->wcycle =3D 2;
+        pfl->cmd =3D 0;
     } else {
-        pflash_register_memory(pfl, 1);
-        pfl->wcycle =3D 0;
+        pflash_reset(pfl);
     }
-    pfl->cmd =3D 0;
 }
=20
 static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr offset,
@@ -481,10 +491,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr of=
fset,
=20
     /* Reset flash */
  reset_flash:
-    trace_pflash_reset();
-    pfl->bypass =3D 0;
-    pfl->wcycle =3D 0;
-    pfl->cmd =3D 0;
+    pflash_reset(pfl);
     return;
=20
  do_bypass:
@@ -588,9 +595,7 @@ static void pflash_cfi02_realize(DeviceState *dev, Er=
ror **errp)
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &pfl->mem);
=20
     timer_init_ns(&pfl->timer, QEMU_CLOCK_VIRTUAL, pflash_timer, pfl);
-    pfl->wcycle =3D 0;
-    pfl->cmd =3D 0;
-    pfl->status =3D 0;
+    pflash_reset(pfl);
     /* Hardcoded CFI table (mostly from SG29 Spansion flash) */
     /* Standard "QRY" string */
     pfl->cfi_table[0x10] =3D 'Q';
--=20
2.20.1


