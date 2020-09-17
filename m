Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688B4C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:05:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0B3B2220A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="SH4PA2ee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B3B2220A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIvT8-0005Sy-Ov
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 11:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIvPP-0001WE-Ma
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:01:15 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39264)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIvPB-0000w0-Bs
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:01:12 -0400
Received: by mail-pl1-x641.google.com with SMTP id x18so1271340pll.6
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 08:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+C/GKper9Hc1Rp3TxABDngRg3jAp3GhgbcS73g/TxHk=;
 b=SH4PA2eems2RayMMe7GUXt1fxTCXBXCqon3Pwh+gU0cMmhOcglQi4mEaaXa3jMCXIo
 Hy1CqHM2rsPhcDHEcucfhlQugBxX558gBxvLnUkLilsqyj7EFdrnxMlIospirwB1yDfs
 6rUOV+O1ms8vy6o8T1cLxYbIjLmzod58Pi28c8bAuE4H0Q5dl5AUMJHLmPjupzBRrHac
 guNYbEYmQadnHCheKnh4FB2U1cD4e7/VCxYDODMLR4ve6ZMMcFX5jy+KgHY37xmY3fvF
 AWyBoAIaiXOT2k8RxfOfiwARh/CUseJGzrRDAwj0KUDvI0w76hRG5NwJRYMo7ewYoA2a
 AaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+C/GKper9Hc1Rp3TxABDngRg3jAp3GhgbcS73g/TxHk=;
 b=mbEdYKGPPGRsyRdCjvyuitE9rOle1gmda1sv9I2Mu2SxwhWmJ8Dpw+ML13S74JU3wy
 7KGjfuO/7LN2xweMpf2dcpxs4kLxVlDLAxdssK7qpl1EBq/W2MzAR02oNX+9xiMk6iDN
 jrgRI4H53X9/IP99JSLTvyeg1/P9Qbnd5uS4vlYejh/8V3uiSY70rQJHkSHCFxAh4gWl
 rnR6eA9UQ4Y7kAh6YSw4tWxh7/dLGH7jf1S0gejZZ4d8JgyC186e9kqCu+vf0l4W+HNZ
 gwsokkZ8RY3jxPZKkZHcn+Ri5oFBNccU5567ApS2zWSKCTnJ1XhI0DTYqKwjN3oduUWe
 1Guw==
X-Gm-Message-State: AOAM531cYhhArT03Q7oFBRVByw2f6djaU/UfYDwDZTkyYr16bFo5QGuc
 IBljayAHRPBJrsLXJLaoFAY1LIa/m2N1n61l
X-Google-Smtp-Source: ABdhPJzK8pvgoO/OBTkz/4+53LvFj0si4bKqw0JIqTZ+A+hiXSeqlDxJUIRfxQmoKA0IZXvCSy0TnA==
X-Received: by 2002:a17:902:7083:b029:d2:4ca:281a with SMTP id
 z3-20020a1709027083b02900d204ca281amr837854plk.58.1600354858672; 
 Thu, 17 Sep 2020 08:00:58 -0700 (PDT)
Received: from localhost.localdomain ([115.96.151.231])
 by smtp.googlemail.com with ESMTPSA id e10sm17674374pgb.45.2020.09.17.08.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 08:00:57 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 01/12] tests/acpi: mark addition of table DSDT.roothp for
 unit testing root pci hotplug
Date: Thu, 17 Sep 2020 20:30:33 +0530
Message-Id: <20200917150044.23159-2-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200917150044.23159-1-ani@anisinha.ca>
References: <20200917150044.23159-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::641;
 envelope-from=ani@anisinha.ca; helo=mail-pl1-x641.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A new binary acpi table tests/data/acpi/pc/DSDT.roothp is added in order to
unit test the feature flag that can disable/enable root pci bus hotplug on
i440fx. This feature was added with the commit:
3d7e78aa7777f0 ("Introduce a new flag for i440fx to disable PCI hotplug on
the root bus")

This change documents the fact that this new file addition was made as a part
of the unit test change.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
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


