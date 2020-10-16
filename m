Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E548CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 05:59:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 643CA207DE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 05:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643CA207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTImT-0005Ac-Cf
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 01:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kTIhb-0006T6-KT
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 01:54:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:36617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kTIhY-0005C7-Rj
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 01:54:55 -0400
IronPort-SDR: 9+EeAK4TpHfpBdWsFnnpz5+pCj4Tf7/MZf8qq5ERN9apJLr6KZ2jEpQiykCmGjHb65hm1NxtCE
 hjst1FNKz/AQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="184094672"
X-IronPort-AV: E=Sophos;i="5.77,381,1596524400"; d="scan'208";a="184094672"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2020 22:54:51 -0700
IronPort-SDR: jLsYW2IXI9kbNuT30BT4XRmFWsiKrCWx5Gxs/IRXrEcBx7UcH76Al+1DVTATS6Y9oq55y2ToQZ
 GAsILxeh4FqQ==
X-IronPort-AV: E=Sophos;i="5.77,381,1596524400"; d="scan'208";a="464572855"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2020 22:54:50 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Jason Wang <jasowang@redhat.com>,
	qemu-dev <qemu-devel@nongnu.org>
Subject: [PATCH V2 08/10] net/colo-compare.c: Change the timer clock type
Date: Fri, 16 Oct 2020 13:52:06 +0800
Message-Id: <20201016055208.7969-9-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201016055208.7969-1-chen.zhang@intel.com>
References: <20201016055208.7969-1-chen.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
 Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhang Chen <chen.zhang@intel.com>

The virtual clock only runs during the emulation. It stops
when the virtual machine is stopped.
The host clock should be used for device models that emulate accurate
real time sources. It will continue to run when the virtual machine
is suspended. COLO need to know the host time here.

Fixes: dd321ecfc2e ("colo-compare: Use IOThread to Check old packet
regularly and Process packets of the primary")

Reported-by: Derek Su <dereksu@qnap.com>
Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Reviewed-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 net/colo-compare.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 76b83a9ca0..1263203e7f 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -900,7 +900,7 @@ static void check_old_packet_regular(void *opaque)
 
     /* if have old packet we will notify checkpoint */
     colo_old_packet_check(s);
-    timer_mod(s->packet_check_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
+    timer_mod(s->packet_check_timer, qemu_clock_get_ms(QEMU_CLOCK_HOST) +
               s->expired_scan_cycle);
 }
 
@@ -934,10 +934,10 @@ static void colo_compare_timer_init(CompareState *s)
 {
     AioContext *ctx = iothread_get_aio_context(s->iothread);
 
-    s->packet_check_timer = aio_timer_new(ctx, QEMU_CLOCK_VIRTUAL,
+    s->packet_check_timer = aio_timer_new(ctx, QEMU_CLOCK_HOST,
                                 SCALE_MS, check_old_packet_regular,
                                 s);
-    timer_mod(s->packet_check_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
+    timer_mod(s->packet_check_timer, qemu_clock_get_ms(QEMU_CLOCK_HOST) +
               s->expired_scan_cycle);
 }
 
-- 
2.17.1


