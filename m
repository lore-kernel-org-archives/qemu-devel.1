Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB284C54FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 03:00:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CB7920658
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 03:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB7920658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGwHq-0002lK-Gg
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 23:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jGwGd-00013x-Q3
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 22:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jGwGc-0004zP-Kk
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 22:59:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3212 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1jGwGc-0004x1-9F; Tue, 24 Mar 2020 22:59:42 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id A1D3C60B2E7D08106BF8;
 Wed, 25 Mar 2020 10:59:37 +0800 (CST)
Received: from huawei.com (10.133.205.93) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Wed, 25 Mar 2020
 10:59:28 +0800
From: Chen Qun <kuhn.chenqun@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH v5 2/3] display/blizzard: use extract16() for fix clang
 analyzer warning in blizzard_draw_line16_32()
Date: Wed, 25 Mar 2020 10:59:18 +0800
Message-ID: <20200325025919.21316-3-kuhn.chenqun@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200325025919.21316-1-kuhn.chenqun@huawei.com>
References: <20200325025919.21316-1-kuhn.chenqun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.205.93]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: Peter Maydell <peter.maydell@linaro.org>, zhang.zhanghailiang@huawei.com,
 philmd@redhat.com, laurent@vivier.eu, Euler Robot <euler.robot@huawei.com>,
 Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Clang static code analyzer show warning:
  hw/display/blizzard.c:940:9: warning: Value stored to 'data' is never r=
ead
        data >>=3D 5;
        ^        ~
Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
---
Cc: Andrzej Zaborowski <balrogg@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>

v1->v2: Use extract16() function instead of bit operation(Base on Laurent=
's comments).
---
 hw/display/blizzard.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/display/blizzard.c b/hw/display/blizzard.c
index 359e399c2a..105241577d 100644
--- a/hw/display/blizzard.c
+++ b/hw/display/blizzard.c
@@ -19,6 +19,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/bitops.h"
 #include "ui/console.h"
 #include "hw/display/blizzard.h"
 #include "ui/pixel_ops.h"
@@ -932,12 +933,9 @@ static void blizzard_draw_line16_32(uint32_t *dest,
     const uint16_t *end =3D (const void *) src + width;
     while (src < end) {
         data =3D *src ++;
-        b =3D (data & 0x1f) << 3;
-        data >>=3D 5;
-        g =3D (data & 0x3f) << 2;
-        data >>=3D 6;
-        r =3D (data & 0x1f) << 3;
-        data >>=3D 5;
+        b =3D extract16(data, 0, 5) << 3;
+        g =3D extract16(data, 5, 6) << 2;
+        r =3D extract16(data, 11, 5) << 3;
         *dest++ =3D rgb_to_pixel32(r, g, b);
     }
 }
--=20
2.23.0



