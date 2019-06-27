Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9159CC004E6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 20:45:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F6922075E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 20:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F6922075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgbGQ-0000Kg-OT
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 16:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45813)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hgb1E-0001x6-LM
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 16:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hgb1C-0000Qx-Je
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 16:29:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60962)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hgb13-000859-Bp; Thu, 27 Jun 2019 16:29:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D05545277D;
 Thu, 27 Jun 2019 20:28:42 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-69.brq.redhat.com [10.40.204.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A980D600CC;
 Thu, 27 Jun 2019 20:28:37 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 22:26:59 +0200
Message-Id: <20190627202719.17739-9-philmd@redhat.com>
In-Reply-To: <20190627202719.17739-1-philmd@redhat.com>
References: <20190627202719.17739-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 27 Jun 2019 20:28:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 08/28] hw/block/pflash_cfi02: Use the ldst
 API in pflash_write()
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
index 9e8c28af8f..ae38ed0bae 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -365,38 +365,16 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr o=
ffset,
             goto check_unlock0;
         case 0xA0:
             trace_pflash_data_write(offset, width << 1, value, 0);
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


