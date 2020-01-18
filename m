Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25C9C33CB6
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 19:11:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75A222468B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 19:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="j0okyTSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A222468B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1istVj-0003Hd-89
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 14:11:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48519)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1istTs-0001S0-9J
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:10:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1istTr-0004Od-7S
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:10:00 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:48332)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1istTq-0004N6-5G; Sat, 18 Jan 2020 14:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=m9u8SBcxUh+7uhuAIPbMfHUfenn9UwZvCzhHkBhyjA8=; 
 b=j0okyTSf3Wyt1lgbyvesdjmiZe49WNahJpOBPpnRee5yLq3MIkPC//swAuGIcuYm8XJIKf5/BSzGhhusIgEEqvBsVDxdJG11QrMmYrvKqPxAcmPfzZ2K3ZjafVdq56xsGVKBz073eMCTLQQ0YgwwUgge0epBKJvIhzqycyZYEpq6OG5sU8SrJNUQS0JqLUS/SlXf5/PN2oZSahp7yszKbXfdZqK1xSXhMO1V7NN5slOKQh9nESyR5juEVPgmR5RdBU6f7z0KnHc6WmyB9vjp7dXpXI0XKi6hMJ7o8SJNI0mDGtv8OGKtfvVfqUU/T7sHr4six1GNzl2ViGanHhDOZQ==;
Received: from [80.30.177.7] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1istTn-000658-4r; Sat, 18 Jan 2020 20:09:55 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1istTW-0002JX-PY; Sat, 18 Jan 2020 20:09:38 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/5] qcow2: Tighten cluster_offset alignment assertions
Date: Sat, 18 Jan 2020 20:09:27 +0100
Message-Id: <558ba339965f858bede4c73ce3f50f0c0493597d.1579374329.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1579374329.git.berto@igalia.com>
References: <cover.1579374329.git.berto@igalia.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qcow2_alloc_cluster_offset() and qcow2_get_cluster_offset() always
return offsets that are cluster-aligned so don't just check that they
are sector-aligned.

The check in qcow2_co_preadv_task() is also replaced by an assertion
for the same reason.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index ba71a815b6..100393fd3b 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2168,10 +2168,7 @@ static coroutine_fn int qcow2_co_preadv_task(BlockDriverState *bs,
                                           offset, bytes, qiov, qiov_offset);
 
     case QCOW2_CLUSTER_NORMAL:
-        if ((file_cluster_offset & 511) != 0) {
-            return -EIO;
-        }
-
+        assert(offset_into_cluster(s, file_cluster_offset) == 0);
         if (bs->encrypted) {
             return qcow2_co_preadv_encrypted(bs, file_cluster_offset,
                                              offset, bytes, qiov, qiov_offset);
@@ -2507,7 +2504,7 @@ static coroutine_fn int qcow2_co_pwritev_part(
             goto out_locked;
         }
 
-        assert((cluster_offset & 511) == 0);
+        assert(offset_into_cluster(s, cluster_offset) == 0);
 
         ret = qcow2_pre_write_overlap_check(bs, 0,
                                             cluster_offset + offset_in_cluster,
@@ -3897,7 +3894,7 @@ qcow2_co_copy_range_to(BlockDriverState *bs,
             goto fail;
         }
 
-        assert((cluster_offset & 511) == 0);
+        assert(offset_into_cluster(s, cluster_offset) == 0);
 
         ret = qcow2_pre_write_overlap_check(bs, 0,
                 cluster_offset + offset_in_cluster, cur_bytes, true);
-- 
2.20.1


