Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6539C0650E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 03:35:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1A5521479
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 03:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A5521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi9ZW-0007GO-Ng
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 23:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35452)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hi7DJ-0003bZ-7a
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 21:04:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hi7DB-00045N-BT
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 21:04:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42320)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hi7Ct-0001YY-8Q; Mon, 01 Jul 2019 21:03:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 66BE330C7470;
 Tue,  2 Jul 2019 01:00:20 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-21.brq.redhat.com [10.40.204.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D946B1001B2D;
 Tue,  2 Jul 2019 01:00:15 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 21:58:55 -0300
Message-Id: <20190702005912.15905-11-philmd@redhat.com>
In-Reply-To: <20190702005912.15905-1-philmd@redhat.com>
References: <20190702005912.15905-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 02 Jul 2019 01:00:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 10/27] hw/block/pflash_cfi02: Extract the
 pflash_data_read() function
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
 Thomas Huth <thuth@redhat.com>,
 Stephen Checkoway <stephen.checkoway@oberlin.edu>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extract the code block in a new function, remove a goto statement.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Message-Id: <20190426162624.55977-3-stephen.checkoway@oberlin.edu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
[PMD: Extracted from bigger patch, remove the XXX tracing comment]
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi02.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 49afecb921..c079a63880 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -165,12 +165,23 @@ static void pflash_timer (void *opaque)
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
+    trace_pflash_data_read(offset, width << 1, ret);
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
     /* Lazy reset to ROMD mode after a certain amount of read accesses *=
/
@@ -194,15 +205,8 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr=
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
-        trace_pflash_data_read(offset, width << 1, ret);
+        ret =3D pflash_data_read(pfl, offset, width);
         break;
     case 0x90:
         /* flash ID read */
@@ -222,7 +226,7 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr =
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


