Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6875CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 15:26:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 380792063A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 15:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Y6dzKxN5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380792063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj2cP-0001MO-Dw
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 11:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jj2H4-0002pE-NX; Wed, 10 Jun 2020 11:04:19 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:58279)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jj2Gs-0006wr-Oa; Wed, 10 Jun 2020 11:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=rYtb2FYfGO+eQGiZ0oQYJSWRUo7OpthnEHRNgAuR++M=; 
 b=Y6dzKxN59T24mSf5AOCApQQw/jWrRhJJhMcGdeoxIUaAoUtttc23v5J3FzWVD9PejyOryH+gcq+Tab4N0/mXd50OoAAXjkp8/Vnrta4822KIpdwUr+l9V5lg/fGAwD3pKR8/YsmntCqnnU5+cXLVjQL77OOgKjcRdlqsrofKgk/PDH71Tkjo/RW5F/eD1h0LeNpksw3XG9r+sQvyOTiNR/+aer48UodZlw49lCF+DkqYJQ04+2QbIy+u04roccN5hEPeCjnZoLBy9SSgkBIfKUVBMio1V6dajj2oHjBJ0aSNEZJt3Di1uJfeDQd+QU/8mOp1ecUafIt7YiGXCBkGCQ==;
Received: from [81.0.38.199] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jj2GR-0007hA-OO; Wed, 10 Jun 2020 17:03:39 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jj2GC-0007NW-Ce; Wed, 10 Jun 2020 17:03:24 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 24/34] qcow2: Add subcluster support to check_refcounts_l2()
Date: Wed, 10 Jun 2020 17:03:02 +0200
Message-Id: <bd18df5282c3e4b4290d38f028ac649b5bdaae7e.1591801197.git.berto@igalia.com>
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

Setting the QCOW_OFLAG_ZERO bit of the L2 entry is forbidden if an
image has subclusters. Instead, the individual 'all zeroes' bits must
be used.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2-refcount.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 770c5dbc83..696e4dad07 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1686,8 +1686,13 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
                         int ign = active ? QCOW2_OL_ACTIVE_L2 :
                                            QCOW2_OL_INACTIVE_L2;
 
-                        l2_entry = QCOW_OFLAG_ZERO;
-                        set_l2_entry(s, l2_table, i, l2_entry);
+                        if (has_subclusters(s)) {
+                            set_l2_entry(s, l2_table, i, 0);
+                            set_l2_bitmap(s, l2_table, i,
+                                          QCOW_L2_BITMAP_ALL_ZEROES);
+                        } else {
+                            set_l2_entry(s, l2_table, i, QCOW_OFLAG_ZERO);
+                        }
                         ret = qcow2_pre_write_overlap_check(bs, ign,
                                 l2e_offset, l2_entry_size(s), false);
                         if (ret < 0) {
-- 
2.20.1


