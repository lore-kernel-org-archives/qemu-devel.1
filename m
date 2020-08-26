Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D89DC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:16:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5B672071E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B672071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAsU9-00043u-6J
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 06:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kAsTN-0002uM-Uz
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 06:16:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4269 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kAsTM-0004zk-9w
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 06:16:05 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 58686A781E1CE4EBD91A;
 Wed, 26 Aug 2020 18:16:00 +0800 (CST)
Received: from [127.0.0.1] (10.174.187.160) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0;
 Wed, 26 Aug 2020 18:15:53 +0800
Message-ID: <5F463659.8080101@huawei.com>
Date: Wed, 26 Aug 2020 18:15:53 +0800
From: AlexChen <alex.chen@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64;
 rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Subject: elf2dmp: Fix memory leak on main() error paths
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.160]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=alex.chen@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 06:03:24
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
Cc: zhengchuan@huawei.com, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: AlexChen <alex.chen@huawei.com>

The 'kdgb' is allocating memory in get_kdbg(), but it is not freed
in both fill_header() and fill_context() failed branches, fix it.

Signed-off-by: AlexChen <alex.chen@huawei.com>
---
 contrib/elf2dmp/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 9a2dbc2902..ac746e49e0 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -568,12 +568,12 @@ int main(int argc, char *argv[])
     if (fill_header(&header, &ps, &vs, KdDebuggerDataBlock, kdbg,
             KdVersionBlock, qemu_elf.state_nr)) {
         err = 1;
-        goto out_pdb;
+        goto out_kdbg;
     }

     if (fill_context(kdbg, &vs, &qemu_elf)) {
         err = 1;
-        goto out_pdb;
+        goto out_kdbg;
     }

     if (write_dump(&ps, &header, argv[2])) {
-- 
2.19.1


