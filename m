Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DEBC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 07:47:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18ECA2222B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 07:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18ECA2222B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZr2a-000868-0e
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 02:47:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kZr1S-0007Ur-PA; Tue, 03 Nov 2020 02:46:30 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2432)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kZr1N-0006Ty-Hs; Tue, 03 Nov 2020 02:46:30 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CQMKX00fgzLqYl;
 Tue,  3 Nov 2020 15:46:07 +0800 (CST)
Received: from [10.174.187.138] (10.174.187.138) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Tue, 3 Nov 2020 15:46:03 +0800
Message-ID: <5FA10ABA.1080109@huawei.com>
Date: Tue, 3 Nov 2020 15:46:02 +0800
From: AlexChen <alex.chen@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64;
 rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To: <edgar.iglesias@gmail.com>
Subject: [PATCH] target/microblaze: Fix possible array out of bounds in
 mmu_write()
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.138]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=alex.chen@huawei.com;
 helo=szxga05-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 20:52:53
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The size of env->mmu.regs is 3, but the range of 'rn' is [0, 5].
To avoid data access out of bounds, only if 'rn' is less than 3, we
can print env->mmu.regs[rn]. In other cases, we can print
env->mmu.regs[MMU_R_TLBX].

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Alex Chen <alex.chen@huawei.com>
---
 target/microblaze/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index 1dbbb271c4..917ad6d69e 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -234,7 +234,8 @@ void mmu_write(CPUMBState *env, bool ext, uint32_t rn, uint32_t v)
     unsigned int i;

     qemu_log_mask(CPU_LOG_MMU,
-                  "%s rn=%d=%x old=%x\n", __func__, rn, v, env->mmu.regs[rn]);
+                  "%s rn=%d=%x old=%x\n", __func__, rn, v,
+                  rn < 3 ? env->mmu.regs[rn] : env->mmu.regs[MMU_R_TLBX]);

     if (cpu->cfg.mmu < 2 || !cpu->cfg.mmu_tlb_access) {
         qemu_log_mask(LOG_GUEST_ERROR, "MMU access on MMU-less system\n");
-- 
2.19.1

