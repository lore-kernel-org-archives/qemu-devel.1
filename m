Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA87C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 17:58:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99EF62400B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 17:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99EF62400B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58673 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW2pt-0005d3-R8
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 13:58:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hW2oL-0004Va-2Y
	for qemu-devel@nongnu.org; Wed, 29 May 2019 13:56:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hW2oK-00073T-63
	for qemu-devel@nongnu.org; Wed, 29 May 2019 13:56:25 -0400
Received: from relay.sw.ru ([185.231.240.75]:48116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
	id 1hW2oJ-00072O-U7; Wed, 29 May 2019 13:56:24 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <andrey.shinkevich@virtuozzo.com>)
	id 1hW2oD-0006Rz-Sz; Wed, 29 May 2019 20:56:17 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Wed, 29 May 2019 20:56:15 +0300
Message-Id: <1559152576-281803-3-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559152576-281803-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1559152576-281803-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v7 2/3] block/stream: refactor stream_run: drop
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
	berto@igalia.com, wencongyang2@huawei.com,
	xiechanglong.d@gmail.com, mreitz@redhat.com, stefanha@redhat.com,
	andrey.shinkevich@virtuozzo.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The goto is unnecessary in the stream_run() since the common exit
code was removed in the commit eb23654dbe43b549ea2a9ebff9d8e:
"jobs: utilize job_exit shim".

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/stream.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index 97fddb2..65b13b2 100644
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
1.8.3.1


