Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2078EC10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 14:26:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C6120825
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 14:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C6120825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51023 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG2ZE-0000mz-5r
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 10:26:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hG2YB-0008UC-Qe
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 10:25:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hG2YA-0000Vz-Tr
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 10:25:35 -0400
Received: from relay.sw.ru ([185.231.240.75]:47676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hG2Y9-0000LS-BO
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 10:25:34 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hG2Xw-0001tW-D0; Mon, 15 Apr 2019 17:25:20 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Apr 2019 17:25:19 +0300
Message-Id: <20190415142519.73060-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v2] util/error: do not free error on error_abort
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
Cc: vsementsov@virtuozzo.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190415142519.REl84wXnbhJDgptKQGYwmpGeDjmfkPnGJlj5yKZeKzE@z>

It would be nice to have Error object not freed away when debugging a
coredump.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

v2: don't change error output format

 util/error.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/util/error.c b/util/error.c
index 934a78e1b1..22f8a7924f 100644
--- a/util/error.c
+++ b/util/error.c
@@ -34,7 +34,10 @@ static void error_handle_fatal(Error **errp, Error *err)
     if (errp == &error_abort) {
         fprintf(stderr, "Unexpected error in %s() at %s:%d:\n",
                 err->func, err->src, err->line);
-        error_report_err(err);
+        error_report("%s", error_get_pretty(err));
+        if (err->hint) {
+            error_printf_unless_qmp("%s", err->hint->str);
+        }
         abort();
     }
     if (errp == &error_fatal) {
-- 
2.18.0


