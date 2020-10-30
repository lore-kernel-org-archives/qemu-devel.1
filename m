Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1B7C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:17:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 000D2206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 000D2206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYW9V-0004Ss-P5
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 11:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <remi@remlab.net>)
 id 1kYW83-0003Fd-VR; Fri, 30 Oct 2020 11:15:47 -0400
Received: from poy.remlab.net ([2001:41d0:2:5a1a::]:54018
 helo=ns207790.ip-94-23-215.eu)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <remi@remlab.net>)
 id 1kYW81-00079D-0y; Fri, 30 Oct 2020 11:15:47 -0400
Received: from basile.remlab.net (ip6-localhost [IPv6:::1])
 by ns207790.ip-94-23-215.eu (Postfix) with ESMTP id CD3295FC12;
 Fri, 30 Oct 2020 16:15:41 +0100 (CET)
From: remi@remlab.net
To: qemu-arm@nongnu.org
Subject: [PATCH] hw/arm/boot: fix SVE for EL3 direct kernel boot
Date: Fri, 30 Oct 2020 17:15:41 +0200
Message-Id: <20201030151541.11976-1-remi@remlab.net>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:2:5a1a::; envelope-from=remi@remlab.net;
 helo=ns207790.ip-94-23-215.eu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 11:15:42
X-ACL-Warn: Detected OS   = ???
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>

When booting a CPU with EL3 using the -kernel flag, set up CPTR_EL3 so
that SVE will not trap to EL3.

Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
---
 hw/arm/boot.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 3e9816af80..cf97600a91 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -742,6 +742,9 @@ static void do_cpu_reset(void *opaque)
                     if (cpu_isar_feature(aa64_mte, cpu)) {
                         env->cp15.scr_el3 |= SCR_ATA;
                     }
+                    if (cpu_isar_feature(aa64_sve, cpu)) {
+                        env->cp15.cptr_el[3] |= CPTR_EZ;
+                    }
                     /* AArch64 kernels never boot in secure mode */
                     assert(!info->secure_boot);
                     /* This hook is only supported for AArch32 currently:
-- 
2.29.1


