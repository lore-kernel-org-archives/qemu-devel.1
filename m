Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51040C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 15:59:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28F5820820
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 15:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F5820820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxCjE-000742-Ci
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 11:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49442)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hxCic-0005j8-Dg
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:58:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hxCib-0007u7-6t
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:58:46 -0400
Received: from relay.sw.ru ([185.231.240.75]:46394)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hxCia-0007sh-W4
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:58:45 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hxCiW-0001HP-4F; Mon, 12 Aug 2019 18:58:40 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org
Date: Mon, 12 Aug 2019 18:58:28 +0300
Message-Id: <1565625509-404969-2-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1565625509-404969-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1565625509-404969-1-git-send-email-andrey.shinkevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v4 1/2] main-loop: Fix GSource leak in
 qio_task_thread_worker()
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
Cc: vsementsov@virtuozzo.com, berrange@redhat.com, berto@igalia.com,
 marcandre.lureau@redhat.com, andrey.shinkevich@virtuozzo.com,
 pbonzini@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

After g_source_attach() the GMainContext holds a reference to the
GSource, so the caller does not need to keep it.

qio_task_thread_worker() is not releasing its reference so the GSource
is being leaked since a17536c594bfed94d05667b419f747b692f5fc7f.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 io/task.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io/task.c b/io/task.c
index 64c4c71..1ae7b86 100644
--- a/io/task.c
+++ b/io/task.c
@@ -136,6 +136,7 @@ static gpointer qio_task_thread_worker(gpointer opaque)
                           qio_task_thread_result, task, NULL);
     g_source_attach(task->thread->completion,
                     task->thread->context);
+    g_source_unref(task->thread->completion);
     trace_qio_task_thread_source_attach(task, task->thread->completion);
 
     qemu_cond_signal(&task->thread_cond);
-- 
1.8.3.1


