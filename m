Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615D4C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:44:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E1DA24650
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3CNsr9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1DA24650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYgJ-0004qV-SL
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58105)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY41-0007W6-Ce
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY40-00040l-4y
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:25 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:44249)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY3z-0003xl-SE
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:24 -0500
Received: by mail-wr1-x436.google.com with SMTP id q10so1987069wrm.11
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EfCRPrfO2biQWPtpACUiz6MHo21mxHWi/LuYvOKz/io=;
 b=l3CNsr9XVQOvGzo+iTNPndyIiTg9tSm+V9fvgqXzwbTavnPr3MgW6EtpOGvHajk9x8
 vIzBDaEQj0uN+QGUajjohzwjdf0C1D7vrRuNildl9hy+oSTRfklw9OFAYDXNE4+B/yjH
 oUdGNM/C3MmGisj1Mw3xCNVUQVuOyxD2mq2NPmd+o/S+ASEpQWelCjGFAbJUWeU/uH1h
 RlEOIzaC4o/TqDlRnJMyrpEa0ZEdPW1jMN1YA1owYM+RtybZlU4q6rd4GnBdZwPfA/nE
 w7aqRfzfZWJ8LVLJ18EJnYp8pApjA7NxzVVuH+3ZsOz86D/Qsuc9zAwTLYy2ACCeAij6
 CqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=EfCRPrfO2biQWPtpACUiz6MHo21mxHWi/LuYvOKz/io=;
 b=ivgJmyL4EsDd5+tm+luNIQbpozveaQbDO8qosCQJWzmn+FFB75zduttVRsMvAnTLee
 OG0val/1ckb/krIMe1McwVJnLbTUvHnbb9wGroMezD7QhBiQvWJdO2ibPEQZpS8qc5jS
 ZIOlM4Dd/T95w8vIPyEizOSNdQkEXdCrcUtKwkFcclsMcg7oIp1vUubT9rnqJ19KwbZh
 bGxJiAz/D1KLJYouWxRMMIP9/1HzXFhytZJ7qRorVkSIfj7+5qXxxoIgJ0CP5nXZrmSi
 bYFzIOM/bzlPMxV8hENrl7bMIBK69m75b3pdCX7GPM4+JdEUptyHRjPq5x4WpZzULs0w
 VzwQ==
X-Gm-Message-State: APjAAAU52R1o2C/OnUhExVL1LK5miqPR6184MvFeALQNyTOUj//3Q+Em
 lF8YFW1ZyF76kodPmQRacyNG2feI
X-Google-Smtp-Source: APXvYqxZUO2zDWWn/2bnhkHn1xZi6ua1ZMHUpSRgwk1f+sbPdc2jn6Q2LGM05qEVusJIxTEA7c7iBA==
X-Received: by 2002:a5d:6ac5:: with SMTP id u5mr2436728wrw.271.1576670662551; 
 Wed, 18 Dec 2019 04:04:22 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.04.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:04:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 80/87] hw/pci-host/i440fx: Use definitions instead of magic
 values
Date: Wed, 18 Dec 2019 13:02:46 +0100
Message-Id: <1576670573-48048-81-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Use definitions from "hw/pci/pci_regs.h".
This also helps when using git-grep.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191209095002.32194-5-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/pci-host/i440fx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 0cc80b2..4141385 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -376,13 +376,13 @@ typedef struct {
 
 /* Here we just expose minimal host bridge offset subset. */
 static const IGDHostInfo igd_host_bridge_infos[] = {
-    {0x08, 2},  /* revision id */
-    {0x2c, 2},  /* sybsystem vendor id */
-    {0x2e, 2},  /* sybsystem id */
-    {0x50, 2},  /* SNB: processor graphics control register */
-    {0x52, 2},  /* processor graphics control register */
-    {0xa4, 4},  /* SNB: graphics base of stolen memory */
-    {0xa8, 4},  /* SNB: base of GTT stolen memory */
+    {PCI_REVISION_ID,         2},
+    {PCI_SUBSYSTEM_VENDOR_ID, 2},
+    {PCI_SUBSYSTEM_ID,        2},
+    {0x50,                    2}, /* SNB: processor graphics control register */
+    {0x52,                    2}, /* processor graphics control register */
+    {0xa4,                    4}, /* SNB: graphics base of stolen memory */
+    {0xa8,                    4}, /* SNB: base of GTT stolen memory */
 };
 
 static void host_pci_config_read(int pos, int len, uint32_t *val, Error **errp)
-- 
1.8.3.1



