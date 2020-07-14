Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990D9C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 15:36:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61E0322285
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 15:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RouM385D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E0322285
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvMzF-0008Cx-Ag
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 11:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1jvMyR-0007bS-I8
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 11:36:04 -0400
Received: from mail-m975.mail.163.com ([123.126.97.5]:57914)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1jvMyL-0003vj-Dl
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 11:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=Y589VGsIHepmMFtkg2
 pAkmdTBHzhjZzxv5EfJm+cZTo=; b=RouM385DK8oxGWD8l4INXW9AI6/z3c5j47
 wGp4aBQQYs2BwzW7eBtd8zfnPZMAtycZJG5J4yDNCOs33p4VfSRSshRtl/AIufZt
 Yezo9regwkXXGkivRnWw8w7//9a7/7WuslZ9BEaodIjVEFzpANsQsAClr0VCV8Ae
 O9JUHGoOY=
Received: from localhost.localdomain (unknown [183.159.72.144])
 by smtp5 (Coremail) with SMTP id HdxpCgCnmYXK0A1fyHpxBw--.6846S4;
 Tue, 14 Jul 2020 23:35:39 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: eric.auger@redhat.com, imammedo@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH] qtest: bios-tables-test: fix a memory leak
Date: Tue, 14 Jul 2020 08:35:36 -0700
Message-Id: <20200714153536.66060-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: HdxpCgCnmYXK0A1fyHpxBw--.6846S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrAw45Kr4rtry5Kr45ArWxXrb_yoWxArbEv3
 W2qrn7CFWDA34kAa1UA3Wvvr18C3W5ta1fury2kF4rAay0qw4UG3Z7Zrn5Aa4rWr45GFya
 9w4kArW7tFWUCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRksqtUUUUU==
X-Originating-IP: [183.159.72.144]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/xtbBoQthbVQHKzVRYQAAsb
Received-SPF: pass client-ip=123.126.97.5; envelope-from=liq3ea@163.com;
 helo=mail-m975.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 11:35:40
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Li Qiang <liq3ea@163.com>, liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes: 5da7c35e25a("bios-tables-test: Add Q35/TPM-TIS test")
Signed-off-by: Li Qiang <liq3ea@163.com>
---
 tests/qtest/bios-tables-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index c315156858..d49b3988ec 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -924,6 +924,7 @@ static void test_acpi_tcg_tpm(const char *machine, const char *tpm_if,
     g_free(variant);
     g_free(tmp_path);
     g_free(tmp_dir_name);
+    g_free(args);
     free_test_data(&data);
 #else
     g_test_skip("TPM disabled");
-- 
2.17.1


