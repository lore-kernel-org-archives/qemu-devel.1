Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3C7C004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 22:24:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF44D205C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 22:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF44D205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47014 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNPYv-0002Yl-TO
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 18:24:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPR8-0004UO-P6
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:16:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPR7-0000Dd-Pz
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:16:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hNPR2-0008SH-Qq; Sun, 05 May 2019 18:16:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 320733082B71;
	Sun,  5 May 2019 22:16:37 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-58.brq.redhat.com [10.40.204.58])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DCC4E7C386;
	Sun,  5 May 2019 22:16:30 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>
Date: Mon,  6 May 2019 00:15:39 +0200
Message-Id: <20190505221544.31568-9-philmd@redhat.com>
In-Reply-To: <20190505221544.31568-1-philmd@redhat.com>
References: <20190505221544.31568-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Sun, 05 May 2019 22:16:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 08/13] hw/block/pflash_cfi02: Use the ldst API
 in pflash_write()
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
Message-ID: <20190505221539.QztxktFBUIxTrLlKiKtEyzqdm4Jy1Lepng2ywqhZV18@z>

The load/store API eases code review.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Message-Id: <20190426162624.55977-3-stephen.checkoway@oberlin.edu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
[PMD: Extracted from bigger patch]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi02.c | 38 ++++++++------------------------------
 1 file changed, 8 insertions(+), 30 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 1e006e7bf3a..69e0086324e 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -373,38 +373,16 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr o=
ffset,
             goto check_unlock0;
         case 0xA0:
             trace_pflash_data_write(offset, value, width, 0);
-            p =3D pfl->storage;
             if (!pfl->ro) {
-                switch (width) {
-                case 1:
-                    p[offset] &=3D value;
-                    pflash_update(pfl, offset, 1);
-                    break;
-                case 2:
-                    if (be) {
-                        p[offset] &=3D value >> 8;
-                        p[offset + 1] &=3D value;
-                    } else {
-                        p[offset] &=3D value;
-                        p[offset + 1] &=3D value >> 8;
-                    }
-                    pflash_update(pfl, offset, 2);
-                    break;
-                case 4:
-                    if (be) {
-                        p[offset] &=3D value >> 24;
-                        p[offset + 1] &=3D value >> 16;
-                        p[offset + 2] &=3D value >> 8;
-                        p[offset + 3] &=3D value;
-                    } else {
-                        p[offset] &=3D value;
-                        p[offset + 1] &=3D value >> 8;
-                        p[offset + 2] &=3D value >> 16;
-                        p[offset + 3] &=3D value >> 24;
-                    }
-                    pflash_update(pfl, offset, 4);
-                    break;
+                p =3D (uint8_t *)pfl->storage + offset;
+                if (pfl->be) {
+                    uint64_t current =3D ldn_be_p(p, width);
+                    stn_be_p(p, width, current & value);
+                } else {
+                    uint64_t current =3D ldn_le_p(p, width);
+                    stn_le_p(p, width, current & value);
                 }
+                pflash_update(pfl, offset, width);
             }
             /*
              * While programming, status bit DQ7 should hold the opposit=
e
--=20
2.20.1


