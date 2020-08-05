Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65993C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:13:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 396F12177B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 396F12177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3GQ6-0005Os-HT
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 06:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1k3GLZ-0007p5-7L; Wed, 05 Aug 2020 06:08:33 -0400
Received: from relay.sw.ru ([185.231.240.75]:59672 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1k3GLV-0001JR-Pz; Wed, 05 Aug 2020 06:08:32 -0400
Received: from [192.168.15.207] (helo=iris.lishka.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <den@openvz.org>)
 id 1k3GLQ-0004tP-7i; Wed, 05 Aug 2020 13:08:24 +0300
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 3/3] block: enable long IO requests report by default
Date: Wed,  5 Aug 2020 13:08:24 +0300
Message-Id: <20200805100824.16817-4-den@openvz.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805100824.16817-1-den@openvz.org>
References: <20200805100824.16817-1-den@openvz.org>
Received-SPF: pass client-ip=185.231.240.75; envelope-from=den@openvz.org;
 helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 06:08:25
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Latency threshold is set to 10 seconds following guest request timeout
on legacy storage controller.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
---
 blockdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index 66158d1292..9eb58efc2b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -623,7 +623,8 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
         bs->detect_zeroes = detect_zeroes;
 
         block_acct_setup(blk_get_stats(blk), account_invalid, account_failed,
-                qemu_opt_get_number(opts, "latency-log-threshold", 0));
+                qemu_opt_get_number(opts, "latency-log-threshold",
+                                    10000 /* ms */));
 
         if (!parse_stats_intervals(blk_get_stats(blk), interval_list, errp)) {
             blk_unref(blk);
-- 
2.17.1


