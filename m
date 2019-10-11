Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BA6C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:59:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB4C521835
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4C521835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIyGi-0002Mr-Ge
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 12:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIxQp-00063a-7q
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIxQo-0004Kn-9D
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:06:19 -0400
Received: from relay.sw.ru ([185.231.240.75]:47918)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIxQo-00048h-1U
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:06:18 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIxQa-0003XG-Rs; Fri, 11 Oct 2019 19:06:05 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [RFC v5 022/126] backends/cryptodev: drop local_err from
 cryptodev_backend_complete()
Date: Fri, 11 Oct 2019 19:04:08 +0300
Message-Id: <20191011160552.22907-23-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011160552.22907-1-vsementsov@virtuozzo.com>
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: "Gonglei \(Arei\)" <arei.gonglei@huawei.com>, vsementsov@virtuozzo.com,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No reason for local_err here, use errp directly instead.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 backends/cryptodev.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 3c071eab95..5a9735684e 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -176,19 +176,10 @@ cryptodev_backend_complete(UserCreatable *uc, Error **errp)
 {
     CryptoDevBackend *backend = CRYPTODEV_BACKEND(uc);
     CryptoDevBackendClass *bc = CRYPTODEV_BACKEND_GET_CLASS(uc);
-    Error *local_err = NULL;
 
     if (bc->init) {
-        bc->init(backend, &local_err);
-        if (local_err) {
-            goto out;
-        }
+        bc->init(backend, errp);
     }
-
-    return;
-
-out:
-    error_propagate(errp, local_err);
 }
 
 void cryptodev_backend_set_used(CryptoDevBackend *backend, bool used)
-- 
2.21.0


