Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2BAC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 15:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3876B205C9
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 15:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3876B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58360 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNfhY-0001Xl-IQ
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 11:38:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hNfdY-0006wJ-DG
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:34:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hNfdV-0005x0-P3
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:34:40 -0400
Received: from relay.sw.ru ([185.231.240.75]:48342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hNfdV-0005vm-Gt; Mon, 06 May 2019 11:34:37 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hNfdO-0004Z1-UM; Mon, 06 May 2019 18:34:31 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Mon,  6 May 2019 18:34:28 +0300
Message-Id: <20190506153429.52737-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190506153429.52737-1-vsementsov@virtuozzo.com>
References: <20190506153429.52737-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v6 2/3] block/stream: refactor stream_run: drop
 goto
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
	berto@igalia.com, wencongyang2@huawei.com,
	xiechanglong.d@gmail.com, mreitz@redhat.com, stefanha@redhat.com,
	den@openvz.org, andrey.shinkevich@virtuozzo.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The goto is unnecessary in the stream_run() since the common exit
code was removed in the commit eb23654dbe43b549ea2a9ebff9d8e:
"jobs: utilize job_exit shim".

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/stream.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index 97fddb2608..65b13b27e0 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -120,13 +120,12 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
     void *buf;
 
     if (!bs->backing) {
-        goto out;
+        return 0;
     }
 
     len = bdrv_getlength(bs);
     if (len < 0) {
-        ret = len;
-        goto out;
+        return len;
     }
     job_progress_set_remaining(&s->common.job, len);
 
@@ -203,14 +202,10 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
         bdrv_disable_copy_on_read(bs);
     }
 
-    /* Do not remove the backing file if an error was there but ignored.  */
-    ret = error;
-
     qemu_vfree(buf);
 
-out:
-    /* Modify backing chain and close BDSes in main loop */
-    return ret;
+    /* Do not remove the backing file if an error was there but ignored. */
+    return error;
 }
 
 static const BlockJobDriver stream_job_driver = {
-- 
2.18.0


