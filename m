Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D8FC004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 22:21:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD328205C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 22:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD328205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46954 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNPVb-00083v-TK
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 18:21:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPR4-0004Rq-Ni
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPR0-0008Ua-VG
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:16:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hNPQp-0008AQ-HO; Sun, 05 May 2019 18:16:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BBDB6307BCB3;
	Sun,  5 May 2019 22:16:25 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-58.brq.redhat.com [10.40.204.58])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C5D7C7C386;
	Sun,  5 May 2019 22:16:21 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>
Date: Mon,  6 May 2019 00:15:37 +0200
Message-Id: <20190505221544.31568-7-philmd@redhat.com>
In-Reply-To: <20190505221544.31568-1-philmd@redhat.com>
References: <20190505221544.31568-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Sun, 05 May 2019 22:16:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 06/13] hw/block/pflash_cfi02: Add helpers to
 manipulate the status bits
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
Message-ID: <20190505221537.4WB0_rMtfV3uMmtesN6vPCh3EWGZWEsfgs7zzR7wXOI@z>

Pull out all of the code to modify the status into simple helper
functions. Status handling becomes more complex once multiple
chips are interleaved to produce a single device.

No change in functionality is intended with this commit.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Message-Id: <20190426162624.55977-3-stephen.checkoway@oberlin.edu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
[PMD: Extracted from bigger patch]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi02.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index b27796d74d2..9673eee969f 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -100,6 +100,31 @@ struct PFlashCFI02 {
     void *storage;
 };
=20
+/*
+ * Toggle status bit DQ7.
+ */
+static inline void toggle_dq7(PFlashCFI02 *pfl)
+{
+    pfl->status ^=3D 0x80;
+}
+
+/*
+ * Set status bit DQ7 to bit 7 of value.
+ */
+static inline void set_dq7(PFlashCFI02 *pfl, uint8_t value)
+{
+    pfl->status &=3D 0x7F;
+    pfl->status |=3D value & 0x80;
+}
+
+/*
+ * Toggle status bit DQ6.
+ */
+static inline void toggle_dq6(PFlashCFI02 *pfl)
+{
+    pfl->status ^=3D 0x40;
+}
+
 /*
  * Set up replicated mappings of the same region.
  */
@@ -129,7 +154,7 @@ static void pflash_timer (void *opaque)
=20
     trace_pflash_timer_expired(pfl->cmd);
     /* Reset flash */
-    pfl->status ^=3D 0x80;
+    toggle_dq7(pfl);
     if (pfl->bypass) {
         pfl->wcycle =3D 2;
     } else {
@@ -232,7 +257,7 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr =
offset,
         ret =3D pfl->status;
         DPRINTF("%s: status %" PRIx32 "\n", __func__, ret);
         /* Toggle bit 6 */
-        pfl->status ^=3D 0x40;
+        toggle_dq6(pfl);
         break;
     case 0x98:
         /* CFI query mode */
@@ -381,7 +406,11 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr of=
fset,
                     break;
                 }
             }
-            pfl->status =3D 0x00 | ~(value & 0x80);
+            /*
+             * While programming, status bit DQ7 should hold the opposit=
e
+             * value from how it was programmed.
+             */
+            set_dq7(pfl, ~value);
             /* Let's pretend write is immediate */
             if (pfl->bypass)
                 goto do_bypass;
@@ -429,7 +458,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr off=
set,
                 memset(pfl->storage, 0xFF, pfl->chip_len);
                 pflash_update(pfl, 0, pfl->chip_len);
             }
-            pfl->status =3D 0x00;
+            set_dq7(pfl, 0x00);
             /* Let's wait 5 seconds before chip erase is done */
             timer_mod(&pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)=
 +
                       (NANOSECONDS_PER_SECOND * 5));
@@ -444,7 +473,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr off=
set,
                 memset(p + offset, 0xFF, pfl->sector_len);
                 pflash_update(pfl, offset, pfl->sector_len);
             }
-            pfl->status =3D 0x00;
+            set_dq7(pfl, 0x00);
             /* Let's wait 1/2 second before sector erase is done */
             timer_mod(&pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)=
 +
                       (NANOSECONDS_PER_SECOND / 2));
--=20
2.20.1


