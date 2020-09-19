Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC49AC43463
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 07:56:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FAF921707
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 07:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FAF921707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJXjN-0004lW-Jk
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 03:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei.rao@intel.com>) id 1kJTXj-00029l-2d
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 23:28:07 -0400
Received: from mga12.intel.com ([192.55.52.136]:53067)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei.rao@intel.com>) id 1kJTXg-0007bq-FS
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 23:28:06 -0400
IronPort-SDR: xhlcBaM95wlrcXLsJsyxm9c8bU7evrY0a0AqXGM/Umr4GFJl2XfnA3Em40fpDOBztybc+8LkLf
 AGz6euUHdo5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9748"; a="139574088"
X-IronPort-AV: E=Sophos;i="5.77,277,1596524400"; d="scan'208";a="139574088"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2020 20:27:58 -0700
IronPort-SDR: 0YEHprWei7MsfjqfQdiJhkzVg3B6cUVg/3fzjiAzlzn9bT8lB51LhsVnjZae5TK+4Uwfyi48+1
 cqq3eGlqCptA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,277,1596524400"; d="scan'208";a="303579316"
Received: from unknown (HELO localhost.localdomain.bj.intel.com)
 ([10.240.192.103])
 by orsmga003.jf.intel.com with ESMTP; 18 Sep 2020 20:27:56 -0700
From: leirao <lei.rao@intel.com>
To: chen.zhang@intel.com, lizhijian@cn.fujitsu.com, jasowang@redhat.com,
 quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com
Subject: [PATCH 1/3] Optimize seq_sorter function for colo-compare
Date: Fri, 18 Sep 2020 23:10:21 -0400
Message-Id: <1600485023-263643-2-git-send-email-lei.rao@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1600485023-263643-1-git-send-email-lei.rao@intel.com>
References: <1600485023-263643-1-git-send-email-lei.rao@intel.com>
Received-SPF: pass client-ip=192.55.52.136; envelope-from=lei.rao@intel.com;
 helo=mga12.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 23:27:59
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 19 Sep 2020 03:55:08 -0400
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
Cc: leirao <lei.rao@intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The seq of tcp has been filled in fill_pkt_tcp_info, it
can be used directly here.

Signed-off-by: leirao <lei.rao@intel.com>
---
 net/colo-compare.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 3a45d64..86980ce 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -196,11 +196,7 @@ static void colo_compare_inconsistency_notify(CompareState *s)
 
 static gint seq_sorter(Packet *a, Packet *b, gpointer data)
 {
-    struct tcp_hdr *atcp, *btcp;
-
-    atcp = (struct tcp_hdr *)(a->transport_header);
-    btcp = (struct tcp_hdr *)(b->transport_header);
-    return ntohl(atcp->th_seq) - ntohl(btcp->th_seq);
+    return a->tcp_seq - b->tcp_seq;
 }
 
 static void fill_pkt_tcp_info(void *data, uint32_t *max_ack)
-- 
1.8.3.1


