Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B31BC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:14:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E22A2087D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="as/ipO9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E22A2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIqwA-0005BU-Rq
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 06:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIqs1-0000Qm-17
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 06:10:29 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34513)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIqrc-0003Nv-1G
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 06:10:28 -0400
Received: by mail-pg1-x541.google.com with SMTP id u13so1096134pgh.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 03:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+C/GKper9Hc1Rp3TxABDngRg3jAp3GhgbcS73g/TxHk=;
 b=as/ipO9LNi9oDgyqXMrnLlPFwiZJdZtKhQtp9nNZE1FoBK/zF5USqHp6yNXYGS04GL
 +fJ7FEFflXbUuj+43KaHzcpseq/HoRIhQbqBBoVFmRW02Pkc4hQ8Zu55axjT2osNNWF0
 WbsA5oDBu0zfOwhjCbpvv382dqI5mSPL5C657a1OxUy2n3THl9jXl88HOzKWUYxjP7fz
 p7sL5JQ3ksP3Ppq4C+Ub+P6L0lfMmfD46lm6nZJ78nZ6fsVWCBcdcWo+5x4LLiQtrKdJ
 2C16Ae5g7KS71F0weHgHZjK+QJ5foG+i6GEeKGmvMKKLrP0puM3vb39tRrwCDEV8RZYH
 dtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+C/GKper9Hc1Rp3TxABDngRg3jAp3GhgbcS73g/TxHk=;
 b=P9t9c7eNhnTstafWwqtsh/l1+/v8lM7qFrG6GmLBkTrQD0Nt/ITl6gHkk3KGiJ0AKa
 8WLSNs0d7uHQv+m/K+Ke0nMpwvUsVl1Hnz+b0B4ML75U1uBUrIv1k2kAG83XqwPfOWqQ
 TJx3YBMF6bq8PYt/ocTajxATDXzX3OCpzOyKwd/CJCvNsb8c9gM0GSY5Os3yu6s2dONh
 e+ZMkPJaWTJQqE/PVpS5ZZOviiyp6h3MW2jVU0KiIm2o8gA/r1w9vTJnRZcqsOIgfzOw
 LUAF9zGzZAYDv9Z3+RhLS0nVM7ugaMwOJ/0ia5DI83Q25YTorD6jtlroPHkbxTO5Krk9
 o9RQ==
X-Gm-Message-State: AOAM533WtRenhGb2sAAI8Uf9Ylp8lJs57MGAX2xn+Che1xQboEZArQgu
 rX9BxD8AcpJfqElJHhWwVx+d8zap9LCBQZjX
X-Google-Smtp-Source: ABdhPJwrxsfQCc0HJhiaAsDeu5uQ6GytXyPVwkEjAhCbJrcZquYK+wAbp+foQLl8qvS+CLEteED5Cw==
X-Received: by 2002:a63:4b63:: with SMTP id k35mr22227518pgl.142.1600337401838; 
 Thu, 17 Sep 2020 03:10:01 -0700 (PDT)
Received: from localhost.localdomain ([115.96.122.113])
 by smtp.googlemail.com with ESMTPSA id d20sm5241559pjv.39.2020.09.17.03.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 03:10:00 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 01/12] tests/acpi: mark addition of table DSDT.roothp for
 unit testing root pci hotplug
Date: Thu, 17 Sep 2020 15:39:36 +0530
Message-Id: <20200917100947.21106-2-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200917100947.21106-1-ani@anisinha.ca>
References: <20200917100947.21106-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::541;
 envelope-from=ani@anisinha.ca; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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


