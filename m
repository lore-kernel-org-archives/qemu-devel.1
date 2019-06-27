Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3BCC48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 20:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BC382146E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 20:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC382146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgbM9-000662-Ng
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 16:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45548)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hgb0h-0001fE-Ni
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 16:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hgb0d-00085g-Oa
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 16:28:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39386)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hgb0O-0007qO-4G; Thu, 27 Jun 2019 16:28:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 180F8307CDD5;
 Thu, 27 Jun 2019 20:28:27 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-69.brq.redhat.com [10.40.204.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E311C6012D;
 Thu, 27 Jun 2019 20:28:20 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 22:26:57 +0200
Message-Id: <20190627202719.17739-7-philmd@redhat.com>
In-Reply-To: <20190627202719.17739-1-philmd@redhat.com>
References: <20190627202719.17739-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 27 Jun 2019 20:28:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 06/28] hw/block/pflash_cfi02: Add helpers to
 manipulate the status bits
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
 hw/block/pflash_cfi02.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 303d225f23..e9eea0ec08 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -101,6 +101,31 @@ struct PFlashCFI02 {
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
@@ -130,7 +155,7 @@ static void pflash_timer (void *opaque)
=20
     trace_pflash_timer_expired(pfl->cmd);
     /* Reset flash */
-    pfl->status ^=3D 0x80;
+    toggle_dq7(pfl);
     if (pfl->bypass) {
         pfl->wcycle =3D 2;
     } else {
@@ -229,8 +254,7 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr =
offset,
         /* Status register read */
         ret =3D pfl->status;
         DPRINTF("%s: status %" PRIx32 "\n", __func__, ret);
-        /* Toggle bit 6 */
-        pfl->status ^=3D 0x40;
+        toggle_dq6(pfl);
         break;
     case 0x98:
         /* CFI query mode */
@@ -374,7 +398,11 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr of=
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
@@ -422,7 +450,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr off=
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
@@ -437,7 +465,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr off=
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


