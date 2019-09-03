Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC95C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:56:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03317233A1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03317233A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i59IB-0001RQ-Dp
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 09:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i59CY-0002yC-Pz
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:50:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i59CX-0003dU-PT
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:50:30 -0400
Received: from relay.sw.ru ([185.231.240.75]:39660)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i59CV-0003Zb-7u; Tue, 03 Sep 2019 09:50:27 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1i59CS-0003gY-92; Tue, 03 Sep 2019 16:50:24 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Tue,  3 Sep 2019 16:50:24 +0300
Message-Id: <20190903135024.498239-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v2] iotests: skip 232 when run tests as root
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

chmod a-w don't help under root, so skip the test in such case.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

v2: move new check under TEST_IMG=TEST_IMG_FILE workaround [Kevin]

 tests/qemu-iotests/232 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/qemu-iotests/232 b/tests/qemu-iotests/232
index 2063f78876..65b0e42063 100755
--- a/tests/qemu-iotests/232
+++ b/tests/qemu-iotests/232
@@ -74,6 +74,12 @@ if [ -n "$TEST_IMG_FILE" ]; then
     TEST_IMG=$TEST_IMG_FILE
 fi
 
+chmod a-w $TEST_IMG
+(echo test > $TEST_IMG) 2>/dev/null && \
+    _notrun "Readonly attribute is ignored, probably you run this test as" \
+            "root, which is unsupported."
+chmod a+w $TEST_IMG
+
 echo
 echo "=== -drive with read-write image: read-only/auto-read-only combinations ==="
 echo
-- 
2.18.0


