Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB302C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:22:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C15B2083B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="huSUM5B8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C15B2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kISiA-0003nK-Ke
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 04:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kISf2-0007s3-P8
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:19:28 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38628)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kISf1-0004nM-9J
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:19:28 -0400
Received: by mail-pf1-x444.google.com with SMTP id l126so3531040pfd.5
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 01:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=HHdiOGLkXts4NNVu4SCMzFcJi56aYTGQpkW5PEoj6js=;
 b=huSUM5B8i5TO5CqJU+LtCvYLvQ6j6aYS1CMPJgMZ5rgKnq8UEvy32CzrPSXJEw0Y/L
 IDNbzelWFZ0ol6MpzMs8w5YwRUmsOEnXO9uucftqXVNqIhacuaJ73tXaksmGK8paLUMh
 +EIw35C5ZFGC7qrBgQu35jTRdolURxxqZgne9CplEboHdaBsPOLT3zspVq9VHNRws26T
 fFuM09UzauKEr4sxKxg1fKwFlqdIsF5IfEeus+ojgMNiB1YgvNgnpLt9NT0DODHc+f/5
 DNDTDRCWp6rmRD7+kWcsV3B0q4VkS6Pbs/uG9Ry1IzxOezDI+5+yzh5iXdXiwLPgaXze
 znwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=HHdiOGLkXts4NNVu4SCMzFcJi56aYTGQpkW5PEoj6js=;
 b=ue1PdsOO0hgp3sWkQsiCzIougYBM+SN//n7OOvrSk+2ECFYGPDSMSCGWFkLP96ZUFy
 9Vd3TJzfNuQRbtP5o0Y8HZKKHpzAoSpVEV4Kl6hrA2HAXtNAJzG27NfGpxCoMat2SfnQ
 BiKZYTBwwtQwRXP61ssqXC4YE39nJlRHkzqQF8xFQ2dOGINtrtTOT1R2SbXmY7ZgZWf9
 QTG8LsV1Kvw0Om3ugvE0XciTZ3FtgJkUoYYHC543/qtwLpRc1boDeWtvgKm2M2oJ+QG2
 xDTPOjG1Buhm487Mc3IC78uI0BtptMi3uqOdmuTqjpDoexJtA7tYhRfMjNPKOXwey8tA
 E5oQ==
X-Gm-Message-State: AOAM532o/tiUjnOErFRUd36LS/FbasoBlgNEAPmSd6xL4kDMfYVARYzj
 9ggXpPXI/G5ThcGjZAKoC+lZNpnTPkvv5ibc
X-Google-Smtp-Source: ABdhPJwKiBZZqYQS9wUY0TShcB5skefuIezf8OmtyUSEEKeGSQLKRU9WTlzn6qnCoGdU63ZvebWAIg==
X-Received: by 2002:a62:7f13:0:b029:13e:d13d:a087 with SMTP id
 a19-20020a627f130000b029013ed13da087mr21282405pfd.30.1600244365531; 
 Wed, 16 Sep 2020 01:19:25 -0700 (PDT)
Received: from localhost.localdomain ([203.163.234.244])
 by smtp.googlemail.com with ESMTPSA id nl10sm1658254pjb.11.2020.09.16.01.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 01:19:24 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 01/11] tests/acpi: document addition of table DSDT.roothp
 for unit testing root pci hotplug on/off
Date: Wed, 16 Sep 2020 13:49:00 +0530
Message-Id: <20200916081910.977-2-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916081910.977-1-ani@anisinha.ca>
References: <20200916081910.977-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::444;
 envelope-from=ani@anisinha.ca; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A new binary acpi table tests/data/acpi/pc/DSDT.roothp is added in order to unit test
the feature flag that can disable/enable root pci bus hotplug on i440fx. This feature was
added with the commit:
3d7e78aa7777f0 ("Introduce a new flag for i440fx to disable PCI hotplug on the root bus")

This change documents the fact that this new file addition was made as a part of the
unit test change.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..ac864fc982 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/pc/DSDT.roothp",
-- 
2.17.1


