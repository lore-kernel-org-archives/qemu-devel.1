Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC793CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 21:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA392070B
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 21:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="U9rRWQ8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA392070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOTcD-0003ER-Mp
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 17:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iOTZk-00007B-Fk
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iOTZi-0005MY-GJ
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:26:20 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:42489)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iOTZg-0005Er-99; Sat, 26 Oct 2019 17:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=zZzQnFPNZo26UDeXp5FufenA8jUFgfP9E3m3TefOdis=; 
 b=U9rRWQ8YLuRLUsR4u9I5uV9iJd91plJEEtSdhvvJSVnb2gFkdFhO89YF0X34Q0Y+4gLCB40AT59ZNF9mPM/jhx34DrARU2XxkWFFYn7H5zh0+Db/dy20zCxRHlNpgVQd8BfFFULSX+zFBoVP+WxuXR3dhdc4U4j6Wd5BJTlVkSEmH3WGllwwZad9AEscAM+HgyABAMNzKjcEcMBzEH3DFc9N2imNqaORTXUNOIOZHdw5g1D4WSGuwF1hv4llGKoQBHseB131GPoPJmaHYXsxiqOtdTRa2QngWeX26e5YpG2QH56uIvhCb0WFfKtc1RsQOzoOVtr6Un8IBxVqtRLPIQ==;
Received: from 87-100-137-117.bb.dnainternet.fi ([87.100.137.117]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1iOTZJ-00046D-As; Sat, 26 Oct 2019 23:25:53 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1iOTZ1-0001Pp-65; Sun, 27 Oct 2019 00:25:35 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 25/26] qcow2: Allow preallocation and backing files if
 extended_l2 is set
Date: Sun, 27 Oct 2019 00:25:27 +0300
Message-Id: <3b868557f35fbdbc9cc8d962c23be4d2daa9c2b2.1572125022.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1572125022.git.berto@igalia.com>
References: <cover.1572125022.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Traditional qcow2 images don't allow preallocation if a backing file
is set. This is because once a cluster is allocated there is no way to
tell that its data should be read from the backing file.

Extended L2 entries have individual allocation bits for each
subcluster, and therefore it is perfectly possible to have an
allocated cluster with all its subclusters unallocated.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c              | 7 ++++---
 tests/qemu-iotests/206.out | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index b1fa7ab5da..8cf51c5d64 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3307,10 +3307,11 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         qcow2_opts->preallocation = PREALLOC_MODE_OFF;
     }
     if (qcow2_opts->has_backing_file &&
-        qcow2_opts->preallocation != PREALLOC_MODE_OFF)
+        qcow2_opts->preallocation != PREALLOC_MODE_OFF &&
+        !qcow2_opts->extended_l2)
     {
-        error_setg(errp, "Backing file and preallocation cannot be used at "
-                   "the same time");
+        error_setg(errp, "Backing file and preallocation can only be used at "
+                   "the same time if extended_l2 is on");
         ret = -EINVAL;
         goto out;
     }
diff --git a/tests/qemu-iotests/206.out b/tests/qemu-iotests/206.out
index d2efc0394a..cfddfbfaa4 100644
--- a/tests/qemu-iotests/206.out
+++ b/tests/qemu-iotests/206.out
@@ -198,7 +198,7 @@ Job failed: Different refcount widths than 16 bits require compatibility level 1
 === Invalid backing file options ===
 {"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"backing-file": "/dev/null", "driver": "qcow2", "file": "node0", "preallocation": "full", "size": 67108864}}}
 {"return": {}}
-Job failed: Backing file and preallocation cannot be used at the same time
+Job failed: Backing file and preallocation can only be used at the same time if extended_l2 is on
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
 
-- 
2.20.1


