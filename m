Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A54C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:02:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C7020678
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CAGhbGeE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C7020678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOxH-0007xZ-Un
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 13:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38085)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOOtr-0003Fh-4V
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:59:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOOtp-0000s6-QI
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:59:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23199
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOLfK-0008MW-6f
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 09:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586871109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=paXjZbPCkV37DDf2O1tNOwKJgrQ4LCbjZD9did5UhGw=;
 b=CAGhbGeEVE5IyK+HvnZYSW7f5eF2gadfvEwuzlPQDNkQLqri0uaa2u0KsLOrBBwckTH6Hv
 9Usw7wPKZpz7b+bSVNnsrVZZDmKN+3pnTfUKqNoH96Pb+r5pZ5CN9nUt6nHKHf423t9mVq
 hCeEd4FOy32vd8Cfe80b8T9B6FAhI7M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-ZiymqHNpMOeHZ2i9ivgSZg-1; Tue, 14 Apr 2020 09:31:48 -0400
X-MC-Unique: ZiymqHNpMOeHZ2i9ivgSZg-1
Received: by mail-wr1-f72.google.com with SMTP id j22so8731086wrb.4
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 06:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VKuurj9MXRedKfmA5ryNgu9rBKfxRZmPvNByOLPGMI4=;
 b=OVMY/b6a+dIxrG1hJ8HbdyxjlYxlweN38AkNMQbhIYlBmXRkOvYjAmZgKb0F2WOltu
 A6ynRqZoXg6vk5foQaDnLDU1G+QXkoATYNBGotKz/LsqE1Nl4D1Th+DTD9R1VLIEwP7Q
 SVRUdhP5buympBdwJlPjTrnP/xeXusZ8XfnE9Akt+SguZ7Q20Ya6iqUD41jrY05RrKMJ
 1qvuy0kTqFcYUTLI7eONSxi1uKWjnKok7SkRwElxJ+aeLBBI1QTsG/DcrhwKhNapO3b4
 8SHJHcdmEmUJrEYoI+IqCfmh2bT8wJxOMhhbKsxJSHtUAr+TtZoJWTdIUBol5yYYqVsx
 Fm1g==
X-Gm-Message-State: AGi0PuZqhJ10coNUdsQ1TqAi9L+Agbt6+D0G70KNnejWPxoCTBKWPqbU
 d/xP5mxbVX2rAWFtgaEdzPxiPDUc523drzOuvcQ2pGgIzjDB8Wa+XnaVQJG2GyoGUxvliyHlRwk
 4dr8v0Mc6ZT3zXIk=
X-Received: by 2002:a1c:bd54:: with SMTP id n81mr22998501wmf.141.1586871107033; 
 Tue, 14 Apr 2020 06:31:47 -0700 (PDT)
X-Google-Smtp-Source: APiQypJVzEvlOYwkSBwVlRPHnYkDX8MfVacv5//9ggyGXKU+OID2YJMC0BXwtMAu7MVAX7f0ZUOUlQ==
X-Received: by 2002:a1c:bd54:: with SMTP id n81mr22998457wmf.141.1586871106571; 
 Tue, 14 Apr 2020 06:31:46 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id n6sm19582479wrs.81.2020.04.14.06.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 06:31:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 10/12] hw/block/pflash: Check return value of
 blk_pwrite()
Date: Tue, 14 Apr 2020 15:30:50 +0200
Message-Id: <20200414133052.13712-11-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200414133052.13712-1-philmd@redhat.com>
References: <20200414133052.13712-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Mansour Ahmadi <mansourweb@gmail.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Fabien Chouteau <chouteau@adacore.com>, Max Filippov <jcmvbkbc@gmail.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stafford Horne <shorne@gmail.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mansour Ahmadi <mansourweb@gmail.com>

When updating the PFLASH file contents, we should check for a
possible failure of blk_pwrite(). Similar to commit 3a688294e.

Signed-off-by: Mansour Ahmadi <mansourweb@gmail.com>
Message-Id: <20200408003552.58095-1-mansourweb@gmail.com>
[PMD: Add missing "qemu/error-report.h" include and TODO comment]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi01.c | 8 +++++++-
 hw/block/pflash_cfi02.c | 8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 24f3bce7ef..be1954c5d8 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -42,6 +42,7 @@
 #include "hw/qdev-properties.h"
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
@@ -399,13 +400,18 @@ static void pflash_update(PFlashCFI01 *pfl, int offse=
t,
                           int size)
 {
     int offset_end;
+    int ret;
     if (pfl->blk) {
         offset_end =3D offset + size;
         /* widen to sector boundaries */
         offset =3D QEMU_ALIGN_DOWN(offset, BDRV_SECTOR_SIZE);
         offset_end =3D QEMU_ALIGN_UP(offset_end, BDRV_SECTOR_SIZE);
-        blk_pwrite(pfl->blk, offset, pfl->storage + offset,
+        ret =3D blk_pwrite(pfl->blk, offset, pfl->storage + offset,
                    offset_end - offset, 0);
+        if (ret < 0) {
+            /* TODO set error bit in status */
+            error_report("Could not update PFLASH: %s", strerror(-ret));
+        }
     }
 }
=20
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 12f18d401a..c6b6f2d082 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -37,6 +37,7 @@
 #include "hw/block/flash.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qemu/bitmap.h"
 #include "qemu/timer.h"
 #include "sysemu/block-backend.h"
@@ -393,13 +394,18 @@ static uint64_t pflash_read(void *opaque, hwaddr offs=
et, unsigned int width)
 static void pflash_update(PFlashCFI02 *pfl, int offset, int size)
 {
     int offset_end;
+    int ret;
     if (pfl->blk) {
         offset_end =3D offset + size;
         /* widen to sector boundaries */
         offset =3D QEMU_ALIGN_DOWN(offset, BDRV_SECTOR_SIZE);
         offset_end =3D QEMU_ALIGN_UP(offset_end, BDRV_SECTOR_SIZE);
-        blk_pwrite(pfl->blk, offset, pfl->storage + offset,
+        ret =3D blk_pwrite(pfl->blk, offset, pfl->storage + offset,
                    offset_end - offset, 0);
+        if (ret < 0) {
+            /* TODO set error bit in status */
+            error_report("Could not update PFLASH: %s", strerror(-ret));
+        }
     }
 }
=20
--=20
2.21.1


