Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDCDC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 12:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62D382173E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 12:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FC5smtAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D382173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwPwq-0001LX-LQ
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 08:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jwPtq-0004t8-F2
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:55:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50402
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jwPto-0008Nr-QF
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594990536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=176bmdEuvMrg1lCHTVJS3+4pNrYOIDKZBuVZSCBxM1k=;
 b=FC5smtAYYnOfkzd+/7itGkCGIi7z2hWmE12e5ntqI3NeZto6Q3FzDUHZyt1K9sEuWT69C5
 DmXAVWpbVMooPOBgCpTXIfrI0Krmnx119eJPZOTm+gtBrVGnUAvygXNp5fE65F5yb5J15Q
 iZCzDbgPRkCeykSRlFPpFIU9d2hucU8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-gVTc5EiaOy-oG4RMnRGGcw-1; Fri, 17 Jul 2020 08:55:31 -0400
X-MC-Unique: gVTc5EiaOy-oG4RMnRGGcw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED9A28C5A8E;
 Fri, 17 Jul 2020 12:55:24 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-80.ams2.redhat.com [10.36.113.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05886710C8;
 Fri, 17 Jul 2020 12:55:23 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 06/12] nbd: make nbd_export_close_all() synchronous
Date: Fri, 17 Jul 2020 14:55:04 +0200
Message-Id: <20200717125510.238374-7-kwolf@redhat.com>
In-Reply-To: <20200717125510.238374-1-kwolf@redhat.com>
References: <20200717125510.238374-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 03:33:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Consider nbd_export_close_all(). The call-stack looks like this:
 nbd_export_close_all() -> nbd_export_close -> call client_close() for
each client.

client_close() doesn't guarantee that client is closed: nbd_trip()
keeps reference to it. So, nbd_export_close_all() just reduce
reference counter on export and removes it from the list, but doesn't
guarantee that nbd_trip() finished neither export actually removed.

Let's wait for all exports actually removed.

Without this fix, the following crash is possible:

- export bitmap through internal Qemu NBD server
- connect a client
- shutdown Qemu

On shutdown nbd_export_close_all is called, but it actually don't wait
for nbd_trip() to finish and to release its references. So, export is
not release, and exported bitmap remains busy, and on try to remove the
bitmap (which is part of bdrv_close()) the assertion fails:

bdrv_release_dirty_bitmap_locked: Assertion `!bdrv_dirty_bitmap_busy(bitmap)' failed

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200714162234.13113-2-vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 nbd/server.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/nbd/server.c b/nbd/server.c
index 5357f588f0..4752a6c8bc 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -102,6 +102,8 @@ struct NBDExport {
 };
 
 static QTAILQ_HEAD(, NBDExport) exports = QTAILQ_HEAD_INITIALIZER(exports);
+static QTAILQ_HEAD(, NBDExport) closed_exports =
+        QTAILQ_HEAD_INITIALIZER(closed_exports);
 
 /* NBDExportMetaContexts represents a list of contexts to be exported,
  * as selected by NBD_OPT_SET_META_CONTEXT. Also used for
@@ -1659,6 +1661,7 @@ void nbd_export_close(NBDExport *exp)
         g_free(exp->name);
         exp->name = NULL;
         QTAILQ_REMOVE(&exports, exp, next);
+        QTAILQ_INSERT_TAIL(&closed_exports, exp, next);
     }
     g_free(exp->description);
     exp->description = NULL;
@@ -1722,7 +1725,9 @@ void nbd_export_put(NBDExport *exp)
             g_free(exp->export_bitmap_context);
         }
 
+        QTAILQ_REMOVE(&closed_exports, exp, next);
         g_free(exp);
+        aio_wait_kick();
     }
 }
 
@@ -1742,6 +1747,9 @@ void nbd_export_close_all(void)
         nbd_export_close(exp);
         aio_context_release(aio_context);
     }
+
+    AIO_WAIT_WHILE(NULL, !(QTAILQ_EMPTY(&exports) &&
+                           QTAILQ_EMPTY(&closed_exports)));
 }
 
 static int coroutine_fn nbd_co_send_iov(NBDClient *client, struct iovec *iov,
-- 
2.25.4


