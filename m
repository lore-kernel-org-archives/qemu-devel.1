Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EFFC004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 22:27:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75343205ED
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 22:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75343205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47080 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNPbT-0006Zw-My
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 18:27:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPR8-0004UM-P0
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:16:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPR7-0000Dr-RL
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:16:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hNPR4-000076-O2; Sun, 05 May 2019 18:16:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF19A85A07;
	Sun,  5 May 2019 22:16:40 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-58.brq.redhat.com [10.40.204.58])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A0F385D739;
	Sun,  5 May 2019 22:16:37 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>
Date: Mon,  6 May 2019 00:15:40 +0200
Message-Id: <20190505221544.31568-10-philmd@redhat.com>
In-Reply-To: <20190505221544.31568-1-philmd@redhat.com>
References: <20190505221544.31568-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Sun, 05 May 2019 22:16:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 09/13] hw/block/pflash_cfi02: Use the ldst API
 in pflash_read()
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
Message-ID: <20190505221540.nn-7Lj7VFTKOr9orwPRJWZK4Cr8tXfOffu70UAEN804@z>

The load/store API eases code review.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Message-Id: <20190426162624.55977-3-stephen.checkoway@oberlin.edu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
[PMD: Extracted from bigger patch]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi02.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 69e0086324e..2777167af11 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -196,34 +196,20 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwadd=
r offset,
     case 0x00:
     flash_read:
         /* Flash area read */
-        p =3D pfl->storage;
+        p =3D (uint8_t *)pfl->storage + offset;
+        if (pfl->be) {
+            ret =3D ldn_be_p(p, width);
+        } else {
+            ret =3D ldn_le_p(p, width);
+        }
         switch (width) {
         case 1:
-            ret =3D p[offset];
             trace_pflash_data_read8(offset, ret);
             break;
         case 2:
-            if (be) {
-                ret =3D p[offset] << 8;
-                ret |=3D p[offset + 1];
-            } else {
-                ret =3D p[offset];
-                ret |=3D p[offset + 1] << 8;
-            }
             trace_pflash_data_read16(offset, ret);
             break;
         case 4:
-            if (be) {
-                ret =3D p[offset] << 24;
-                ret |=3D p[offset + 1] << 16;
-                ret |=3D p[offset + 2] << 8;
-                ret |=3D p[offset + 3];
-            } else {
-                ret =3D p[offset];
-                ret |=3D p[offset + 1] << 8;
-                ret |=3D p[offset + 2] << 16;
-                ret |=3D p[offset + 3] << 24;
-            }
             trace_pflash_data_read32(offset, ret);
             break;
         }
--=20
2.20.1


