Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97AFC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 15:22:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B213920734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 15:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="p+1qR0IX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B213920734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj2Yf-00042s-Ej
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 11:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jj2Gx-0002kI-Ow; Wed, 10 Jun 2020 11:04:11 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:58281)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jj2Gs-0006wq-Mv; Wed, 10 Jun 2020 11:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=Qe8I4xk45KAyMdchAgwImV8pKbTbnwpzMgDYFtz3Iqc=; 
 b=p+1qR0IXTMWAgO6q0mJqmsde7oZZcbstg6rcU1wnjYDgi6L/tL/3bZbfMJ0/IlIlfka91aGUI5yDTy5C1VRnZxEWK6T8q+L3/5WicPi4L6rnCoTIYJAx8HC0XOTl6RG+RRagx5wqONcNXuzTY+tbeftkvqEn+grjzwgMR+MiXGL6+EAkkc1TPlI08b3BqUpDXL6AiVcfBupc/emGWNp4BTW00uylDntJiPcghoC9c+QczhXtZwg8Zat6j3Wmydco7a55E6LNNB7jAvHhIbhwfX60INhzLY7eomrljssoubQEzICpIyOlVD0I6ZhrQH6idihKhgNVhgHuWeaxWL/cVw==;
Received: from [81.0.38.199] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jj2GR-0007hK-S7; Wed, 10 Jun 2020 17:03:39 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jj2GC-0007Nu-KL; Wed, 10 Jun 2020 17:03:24 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 32/34] qcow2: Allow preallocation and backing files if
 extended_l2 is set
Date: Wed, 10 Jun 2020 17:03:10 +0200
Message-Id: <7720a7da26c206570bc5aa7ee6a9cd9124438778.1591801197.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1591801197.git.berto@igalia.com>
References: <cover.1591801197.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 11:03:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Derek Su <dereksu@qnap.com>, Max Reitz <mreitz@redhat.com>
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
index 37bfae823c..1ea8d3b87e 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3451,10 +3451,11 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
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
index 363c5abe35..a100849fcb 100644
--- a/tests/qemu-iotests/206.out
+++ b/tests/qemu-iotests/206.out
@@ -203,7 +203,7 @@ Job failed: Different refcount widths than 16 bits require compatibility level 1
 === Invalid backing file options ===
 {"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"backing-file": "/dev/null", "driver": "qcow2", "file": "node0", "preallocation": "full", "size": 67108864}}}
 {"return": {}}
-Job failed: Backing file and preallocation cannot be used at the same time
+Job failed: Backing file and preallocation can only be used at the same time if extended_l2 is on
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
 
-- 
2.20.1


