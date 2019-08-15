Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD18C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:01:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF66C20656
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF66C20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyK42-0001UP-I2
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 14:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1hyK2D-00087e-Pc
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 13:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1hyK2B-0001Hr-LM
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 13:59:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52450)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hyK2B-0001G0-GT
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 13:59:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D1C742A09B2;
 Thu, 15 Aug 2019 17:59:34 +0000 (UTC)
Received: from thuth.com (ovpn-116-65.ams2.redhat.com [10.36.116.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2105E17CF8;
 Thu, 15 Aug 2019 17:59:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 19:59:15 +0200
Message-Id: <20190815175922.3475-3-thuth@redhat.com>
In-Reply-To: <20190815175922.3475-1-thuth@redhat.com>
References: <20190815175922.3475-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 15 Aug 2019 17:59:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/9] libqos: Account for the ctrl queue in
 virtio-net
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Oleinik, Alexander" <alxndr@bu.edu>

The number of queues is 2n+1, where n == 1 when multiqueue is disabled

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
Message-Id: <20190805032400.8054-1-alxndr@bu.edu>
[thuth: fixed "intefaces" typo]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqos/virtio-net.c | 1 +
 tests/libqos/virtio-net.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/libqos/virtio-net.c b/tests/libqos/virtio-net.c
index 66405b646e..6567beb553 100644
--- a/tests/libqos/virtio-net.c
+++ b/tests/libqos/virtio-net.c
@@ -53,6 +53,7 @@ static void virtio_net_setup(QVirtioNet *interface)
     } else {
         interface->n_queues = 2;
     }
+    interface->n_queues++; /* Account for the ctrl queue */
 
     interface->queues = g_new(QVirtQueue *, interface->n_queues);
     for (i = 0; i < interface->n_queues; i++) {
diff --git a/tests/libqos/virtio-net.h b/tests/libqos/virtio-net.h
index a5697d7326..855c67d00f 100644
--- a/tests/libqos/virtio-net.h
+++ b/tests/libqos/virtio-net.h
@@ -29,7 +29,7 @@ typedef struct QVirtioNetDevice QVirtioNetDevice;
 
 struct QVirtioNet {
     QVirtioDevice *vdev;
-    int n_queues;
+    int n_queues; /* total number of virtqueues (rx, tx, ctrl) */
     QVirtQueue **queues;
 };
 
-- 
2.18.1


