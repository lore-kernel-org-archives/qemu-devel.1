Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73381C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 09:21:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F2DE208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 09:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=inbox.lv header.i=@inbox.lv header.b="f0bBNKCm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F2DE208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=inbox.lv
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSGUu-0004Kd-Er
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 05:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kherman@inbox.lv>)
 id 1kSGTv-0003Io-DG; Tue, 13 Oct 2020 05:20:31 -0400
Received: from shark2.inbox.lv ([194.152.32.82]:34351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kherman@inbox.lv>)
 id 1kSGTr-0002fA-MZ; Tue, 13 Oct 2020 05:20:30 -0400
Received: from shark2.inbox.lv (localhost [127.0.0.1])
 by shark2-out.inbox.lv (Postfix) with ESMTP id 56F7242D92;
 Tue, 13 Oct 2020 12:20:23 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv; s=30062014;
 t=1602580823; bh=k3S397z/Qm1HzfxxEdSY5HNCjKU5sz8r8JhVSecFSYE=;
 h=From:To:Cc:Subject:Date;
 b=f0bBNKCmqpU5TS7cFgn7X9UC9M1MYz1PH6jEZatK6hWSNCV1iAnqQwTgjSm5vvYxr
 y7VGzAMu77y1LliBrPmRRMJocvWGjFFu2NLXic3NU6uls1gDN1Snp8kQtSEb5CBQTr
 B7Vdkr8Kp0YvUbZS5swbROInJ1jPBw357o8Nh/Mo=
Received: from localhost (localhost [127.0.0.1])
 by shark2-in.inbox.lv (Postfix) with ESMTP id 39CAA42D8D;
 Tue, 13 Oct 2020 12:20:23 +0300 (EEST)
Received: from shark2.inbox.lv ([127.0.0.1])
 by localhost (shark2.inbox.lv [127.0.0.1]) (spamfilter, port 35)
 with ESMTP id qhulorEEqZNS; Tue, 13 Oct 2020 12:20:23 +0300 (EEST)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
 by shark2-in.inbox.lv (Postfix) with ESMTP id E496142D8C;
 Tue, 13 Oct 2020 12:20:22 +0300 (EEST)
Received: from localhost.localdomain (unknown [94.177.228.81])
 (Authenticated sender: kherman@inbox.lv)
 by mail.inbox.lv (Postfix) with ESMTPA id DF8233D9829;
 Tue, 13 Oct 2020 12:20:21 +0300 (EEST)
From: Klaus Herman <kherman@inbox.lv>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Klaus Herman <kherman@inbox.lv>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH v3] hw/core/qdev-properties-system: Fix pci bus range in
 set_pci_host_devaddr()
Date: Tue, 13 Oct 2020 09:20:14 +0000
Message-Id: <20201013092014.34059-1-kherman@inbox.lv>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: G4mES30DmH5BpsK8I5pk5v+XtdvHI0ZBySr7z7457XNesrrGr60LfS/KW5iNag+/bg==
Received-SPF: pass client-ip=194.152.32.82; envelope-from=kherman@inbox.lv;
 helo=shark2.inbox.lv
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 05:20:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes: bccb20c49df ("hw/core/qdev-properties: Use qemu_strtoul() in set_pci_host_devaddr()")
Signed-off-by: Klaus Herman <kherman@inbox.lv>
---
 hw/core/qdev-properties-system.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 49bdd12..e3dca56 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -903,7 +903,7 @@ static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
     bus = val;
 
     p = (char *)e + 1;
-    if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0x1f || e == p) {
+    if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0xff || e == p) {
         goto inval;
     }
     if (*e == ':') {
-- 
2.28.0


