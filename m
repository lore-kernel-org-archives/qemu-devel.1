Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB959C10F14
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 15:26:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4393D2133D
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 15:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="MtXVCco4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4393D2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33257 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEF7I-0002sE-Dm
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 11:26:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hEF67-0001n5-MN
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:25:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hEF66-0003rk-PC
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:25:11 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:40401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hEF66-0003fP-3v; Wed, 10 Apr 2019 11:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Message-Id:Date:Subject:Cc:To:From;
	bh=NiiZmZYoiKLqKCOmTx7ABlStDDvDLIoMY/T9jpTUQNI=; 
	b=MtXVCco4y7+4K8ToetNE6fSR/isNMiLbxQKFfcF/ysMWl5gAxiTDHszmNXAlXfmb7AdB+Zu5rq4cMyaS2rHZJF71KUBPrZf4X3bz9z1/9PIpTRAMq8XukxztMDI3WtyE1LgQdUVHMmqgAlzR8aOjT9DwlYl75SJ7TueumQ5Jkpe88KNwM1rtHAHN2cbzEM6H12kioqINHIhQogdMdMxwma3TSeJJni98XAeyPuE0m2uW0kAqAl/aVmkHtetuX8TB97UwTgGRzbvOBq2oYbUaF5b1UYobps0JwDldXRXSzhvSFz3OpdfyZ6iw7nZI9ElY2gfAV5fDEQDPm+3W89jueg==;
Received: from 178-55-128-240.bb.dnainternet.fi ([178.55.128.240]
	helo=perseus.local) by fanzine.igalia.com with esmtpsa 
	(Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
	id 1hEF5l-0001la-OW; Wed, 10 Apr 2019 17:24:49 +0200
Received: from berto by perseus.local with local (Exim 4.89)
	(envelope-from <berto@igalia.com>)
	id 1hEF5W-00026z-G3; Wed, 10 Apr 2019 18:24:34 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Date: Wed, 10 Apr 2019 18:24:29 +0300
Message-Id: <20190410152429.8076-1-berto@igalia.com>
X-Mailer: git-send-email 2.11.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: [Qemu-devel] [PATCH for-4.1] commit: Make base read-only if there
 is an early failure
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
	qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190410152429.6uDIxyyeGNtBkltCW4k-OjLlm4bNm4ExOt2eKeJqTu4@z>

You can reproduce this by passing an invalid filter-node-name (like
"1234") to block-commit. In this case the base image is put in
read-write mode but is never reset back to read-only.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/commit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/commit.c b/block/commit.c
index ba60fef58a..698eda1dfe 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -384,6 +384,9 @@ fail:
     if (s->top) {
         blk_unref(s->top);
     }
+    if (s->base_read_only) {
+        bdrv_reopen_set_read_only(base, true, NULL);
+    }
     job_early_fail(&s->common.job);
     /* commit_top_bs has to be replaced after deleting the block job,
      * otherwise this would fail because of lack of permissions. */
-- 
2.11.0


