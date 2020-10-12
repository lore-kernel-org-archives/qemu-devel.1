Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2133C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 01:03:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CD8A20870
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 01:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=inbox.lv header.i=@inbox.lv header.b="lY339KaC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD8A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=inbox.lv
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS8j3-0007R8-L3
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 21:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kherman@inbox.lv>)
 id 1kS6mJ-0004pd-PW; Mon, 12 Oct 2020 18:58:52 -0400
Received: from shark3.inbox.lv ([194.152.32.83]:60426)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kherman@inbox.lv>)
 id 1kS6mH-0002eF-N3; Mon, 12 Oct 2020 18:58:51 -0400
Received: from shark3.inbox.lv (localhost [127.0.0.1])
 by shark3-out.inbox.lv (Postfix) with ESMTP id E7667280497;
 Tue, 13 Oct 2020 01:58:41 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv; s=30062014;
 t=1602543521; bh=YURXcdd3KixEF1JRsw7xcPaqVLvQhhrS2Ji7AWyby/c=;
 h=From:To:Cc:Subject:Date;
 b=lY339KaCq+88J75H225bQjuxJuYv/waZ2GKYvB9dJQHtBNLRF/sOkepWYqkv8KppV
 aOeRtvRy0nJC+uQ4U7LuZPzTm4OPgHuoFXe7O371+DfnoyqQgAUjfY1Wck8SW2TG8d
 DZ+CGqFXX6UOAkWSNq9tRmHwZtUoKj6OFGbL154I=
Received: from localhost (localhost [127.0.0.1])
 by shark3-in.inbox.lv (Postfix) with ESMTP id E1C4928049E;
 Tue, 13 Oct 2020 01:58:41 +0300 (EEST)
Received: from shark3.inbox.lv ([127.0.0.1])
 by localhost (shark3.inbox.lv [127.0.0.1]) (spamfilter, port 35)
 with ESMTP id D1X3p9Y2KjnD; Tue, 13 Oct 2020 01:58:41 +0300 (EEST)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
 by shark3-in.inbox.lv (Postfix) with ESMTP id A8EFD280497;
 Tue, 13 Oct 2020 01:58:41 +0300 (EEST)
Received: from localhost.localdomain (net-93-145-34-111.cust.vodafonedsl.it
 [93.145.34.111]) (Authenticated sender: kherman@inbox.lv)
 by mail.inbox.lv (Postfix) with ESMTPA id 7B9F545B033;
 Tue, 13 Oct 2020 01:58:38 +0300 (EEST)
From: Klaus Herman <kherman@inbox.lv>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Klaus Herman <kherman@inbox.lv>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH] hw/core/qdev-properties: Fix pci bus range in
 set_pci_host_devaddr()
Date: Mon, 12 Oct 2020 22:58:31 +0000
Message-Id: <20201012225831.72920-1-kherman@inbox.lv>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: G4mES3oDmH1DpsO6NYVt5v+GstuyV1kquSb9yrQ39QEqu8qlr7wGfWmJaPriWV35bg==
Received-SPF: pass client-ip=194.152.32.83; envelope-from=kherman@inbox.lv;
 helo=shark3.inbox.lv
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 18:58:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 12 Oct 2020 20:56:49 -0400
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


