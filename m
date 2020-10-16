Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372ABC43467
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 05:58:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABFFA207F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 05:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFFA207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTIkY-0002dh-Nr
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 01:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kTIhY-0006Ow-9b
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 01:54:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:36632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kTIhW-0005GT-Ge
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 01:54:51 -0400
IronPort-SDR: D2wDGU1Bb7Lm3TaBHYjQhlUPzdtMgBhVr3JTb3unvjHs7qrFvhEIFrGN0W1mXOYk3Lo8ce6DZG
 5kr3lQRY83Gw==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="184094660"
X-IronPort-AV: E=Sophos;i="5.77,381,1596524400"; d="scan'208";a="184094660"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2020 22:54:48 -0700
IronPort-SDR: oJXi2SHz6/EuetqkrfUnkUy7Hm/9H6gfXxDfDJYeYZvCiyOe2xbXo+MzDqRhvrxVTY638TFZzX
 JDeU4wixV2ww==
X-IronPort-AV: E=Sophos;i="5.77,381,1596524400"; d="scan'208";a="464572840"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2020 22:54:46 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Jason Wang <jasowang@redhat.com>,
	qemu-dev <qemu-devel@nongnu.org>
Subject: [PATCH V2 06/10] colo-compare: check mark in mutual exclusion
Date: Fri, 16 Oct 2020 13:52:04 +0800
Message-Id: <20201016055208.7969-7-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201016055208.7969-1-chen.zhang@intel.com>
References: <20201016055208.7969-1-chen.zhang@intel.com>
Received-SPF: pass client-ip=192.55.52.88; envelope-from=chen.zhang@intel.com;
 helo=mga01.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 01:54:36
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, FROM_ADDR_WS=2.996,
 FROM_WSP_TRAIL=1, HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Derek Su <dereksu@qnap.com>, Zhang Chen <chen.zhang@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Zhijian <lizhijian@cn.fujitsu.com>

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
---
 net/colo-compare.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index a35c10fb59..8d476bbd99 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -477,13 +477,11 @@ sec:
             colo_release_primary_pkt(s, ppkt);
             g_queue_push_head(&conn->secondary_list, spkt);
             goto pri;
-        }
-        if (mark == COLO_COMPARE_FREE_SECONDARY) {
+        } else if (mark == COLO_COMPARE_FREE_SECONDARY) {
             conn->compare_seq = spkt->seq_end;
             packet_destroy(spkt, NULL);
             goto sec;
-        }
-        if (mark == (COLO_COMPARE_FREE_PRIMARY | COLO_COMPARE_FREE_SECONDARY)) {
+        } else if (mark == (COLO_COMPARE_FREE_PRIMARY | COLO_COMPARE_FREE_SECONDARY)) {
             conn->compare_seq = ppkt->seq_end;
             colo_release_primary_pkt(s, ppkt);
             packet_destroy(spkt, NULL);
-- 
2.17.1


