Return-Path: <SRS0=QItv=AX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0303CC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 01:48:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C67D82078B
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 01:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67D82078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emindsoft.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juR6H-0000LJ-0k
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 21:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1juR5g-0008KR-Ey
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 21:47:40 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:41054)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1juR5d-0005j9-SW
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 21:47:40 -0400
Received: from localhost (unknown [192.168.167.209])
 by lucky1.263xmail.com (Postfix) with ESMTP id 5F9C4AFDAF;
 Sun, 12 Jul 2020 09:47:26 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [223.72.94.78])
 by smtp.263.net (postfix) whith ESMTP id
 P9170T139648110163712S1594518440206160_; 
 Sun, 12 Jul 2020 09:47:26 +0800 (CST)
X-UNIQUE-TAG: <09f71800d8b843ef05390035df41848d>
X-RL-SENDER: chengang@emindsoft.com.cn
X-SENDER: chengang@emindsoft.com.cn
X-LOGIN-NAME: chengang@emindsoft.com.cn
X-FST-TO: pbonzini@redhat.com
X-SENDER-IP: 223.72.94.78
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From: chengang@emindsoft.com.cn
To: pbonzini@redhat.com,
	rth@twiddle.net,
	ehabkost@redhat.com
Subject: [PATCH] target: i386: mem_helper: Fix ldaxr instruction 64 bit
 alignment issue temporarily for stable-4.1
Date: Sun, 12 Jul 2020 09:47:17 +0800
Message-Id: <20200712014717.10858-1-chengang@emindsoft.com.cn>
X-Mailer: git-send-email 2.24.0.308.g228f53135a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=211.157.147.131;
 envelope-from=chengang@emindsoft.com.cn; helo=lucky1.263xmail.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/11 21:47:29
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: chengang@emindsoft.com.cn, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Gang <chengang@emindsoft.com.cn>

This fix does not consider about the lock feature which may cause
another issues, but excuse me, I don't know how to fix it. At present,
the fix runs OK for my case in windows oledb32.dll in wine.

Welcome anyone to fix it, thanks.

Signed-off-by: Chen Gang <chengang@emindsoft.com.cn>
---
 target/i386/mem_helper.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/i386/mem_helper.c b/target/i386/mem_helper.c
index d50d4b0c40..8c37b05fae 100644
--- a/target/i386/mem_helper.c
+++ b/target/i386/mem_helper.c
@@ -68,7 +68,13 @@ void helper_cmpxchg8b(CPUX86State *env, target_ulong a0)
         uint64_t *haddr = g2h(a0);
         cmpv = cpu_to_le64(cmpv);
         newv = cpu_to_le64(newv);
-        oldv = atomic_cmpxchg__nocheck(haddr, cmpv, newv);
+        if ((unsigned long)haddr % 8) {
+            volatile uint64_t tmp = *haddr; /* avoid compiler optimization */
+            oldv = atomic_cmpxchg__nocheck(&tmp, cmpv, newv);
+            *haddr = tmp;
+        } else {
+            oldv = atomic_cmpxchg__nocheck(haddr, cmpv, newv);
+        }
         oldv = le64_to_cpu(oldv);
     }
 #else
-- 
2.24.0.308.g228f53135a




