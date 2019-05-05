Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4578EC004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 22:24:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12E9E205C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 22:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E9E205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47010 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNPYR-00022Y-7N
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 18:24:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPRA-0004XY-Hz
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPR9-0000Gv-Jx
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:16:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hNPR7-0000Bm-6T; Sun, 05 May 2019 18:16:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C3E43091740;
	Sun,  5 May 2019 22:16:44 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-58.brq.redhat.com [10.40.204.58])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7442F7C386;
	Sun,  5 May 2019 22:16:41 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>
Date: Mon,  6 May 2019 00:15:41 +0200
Message-Id: <20190505221544.31568-11-philmd@redhat.com>
In-Reply-To: <20190505221544.31568-1-philmd@redhat.com>
References: <20190505221544.31568-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Sun, 05 May 2019 22:16:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 10/13] hw/block/pflash_cfi02: Extract the
 pflash_data_read() function
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
Message-ID: <20190505221541.DXEvHbgY9FFfy4BPSX7tX8axL3wlV1Sg51wRXhBTiJo@z>

Extract the code block in a new function, remove a goto statement.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Message-Id: <20190426162624.55977-3-stephen.checkoway@oberlin.edu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
[PMD: Extracted from bigger patch, remove the XXX tracing comment]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi02.c | 44 ++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 2777167af11..adfa39f9b5e 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -164,12 +164,33 @@ static void pflash_timer (void *opaque)
     pfl->cmd =3D 0;
 }
=20
+/*
+ * Read data from flash.
+ */
+static uint64_t pflash_data_read(PFlashCFI02 *pfl, hwaddr offset,
+                                 unsigned int width)
+{
+    uint8_t *p =3D (uint8_t *)pfl->storage + offset;
+    uint64_t ret =3D pfl->be ? ldn_be_p(p, width) : ldn_le_p(p, width);
+    switch (width) {
+    case 1:
+        trace_pflash_data_read8(offset, ret);
+        break;
+    case 2:
+        trace_pflash_data_read16(offset, ret);
+        break;
+    case 4:
+        trace_pflash_data_read32(offset, ret);
+        break;
+    }
+    return ret;
+}
+
 static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr offset,
                             int width, int be)
 {
     hwaddr boff;
     uint32_t ret;
-    uint8_t *p;
=20
     ret =3D -1;
     trace_pflash_read(offset, pfl->cmd, width, pfl->wcycle);
@@ -194,25 +215,8 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr=
 offset,
     case 0x80:
         /* We accept reads during second unlock sequence... */
     case 0x00:
-    flash_read:
         /* Flash area read */
-        p =3D (uint8_t *)pfl->storage + offset;
-        if (pfl->be) {
-            ret =3D ldn_be_p(p, width);
-        } else {
-            ret =3D ldn_le_p(p, width);
-        }
-        switch (width) {
-        case 1:
-            trace_pflash_data_read8(offset, ret);
-            break;
-        case 2:
-            trace_pflash_data_read16(offset, ret);
-            break;
-        case 4:
-            trace_pflash_data_read32(offset, ret);
-            break;
-        }
+        ret =3D pflash_data_read(pfl, offset, width);
         break;
     case 0x90:
         /* flash ID read */
@@ -232,7 +236,7 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr =
offset,
             }
             /* Fall through to data read. */
         default:
-            goto flash_read;
+            ret =3D pflash_data_read(pfl, offset, width);
         }
         DPRINTF("%s: ID " TARGET_FMT_plx " %" PRIx32 "\n", __func__, bof=
f, ret);
         break;
--=20
2.20.1


