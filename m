Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FA9C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 07:32:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 311DF2076D
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 07:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="GrfwdEFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311DF2076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJAsM-0005a4-88
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 03:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJAkd-0003En-3l
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 03:24:12 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:36697)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJAkb-0003Km-Jt
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 03:24:10 -0400
Received: by mail-pj1-x1042.google.com with SMTP id b17so2561590pji.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 00:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=V/i6UARRudUJoRdXtPW9d7XXfNZPRvXdDsElEekj7OA=;
 b=GrfwdEFk+ZuvPE/OL1GCyC+YEzeGMYuU7SXVaKjHVFezsqUQx9n2aYWOhpxT7bssuH
 i0lvWTx3E7i4tUeaCtFWhukkNx5C6pj1e+PGkDS3YMNEBqnmjNRiJCH2BMkm/G3lg+S1
 t25b/4TyaqLj2xWMbKdLfRSWyObh4gyJiu6jMqGgCpYBd1sZVqFLQbePcaTKGLAJKxJQ
 Inq0Ma6pwdOZcyJrDMKBf0BDzwQnM5OyAZBYqgqBNgGUNLJ1DxXIllS8xbV9s/VsDbtg
 uz8WaFPZP27AKNN4kJ7Uy7YMccNxOa3NYdQhnviK+ObqCSWSowNrF70cUejJUeO/IDGS
 d9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=V/i6UARRudUJoRdXtPW9d7XXfNZPRvXdDsElEekj7OA=;
 b=Tkq3o4psX56ebsh2C3JW3iTJKMcEIoJrNs5FuaPUFXCfoRyp8lEDxOTffk72k5s662
 UMu+/CKtadteMUPVLXIggs6tR3ScRYsWw590Z9o3nZ/cXlO0Pru8qF/ZeVSQpVsSUxK9
 eAM7w7fudx0E/2K6EpJ2ojOvoPsXy2G0P3KSUV9oWFUIl4gFyKwtE5UQ/G8HGr031TE5
 VpBdShy3ar06OieMZ+V7vRf27fkX9KsWZOcqBgK2Ll0vlfHeYYIEdEqC4GhrOpNtHSxB
 ZX9e4m/Di431pmboHaLnGPKpCYE8x4HYdhJYy87uAQ7Nlodjxx6jGGbgY9tj9dHFcK+8
 t9zg==
X-Gm-Message-State: AOAM5335zjf3FBivOuvyiPJGjHSwHl1is0X5BTr1VE7vkb8E6AFLi0MR
 P2Izt0ZF3PScDCx5F5JpogLCG9hcFdbRDSi0
X-Google-Smtp-Source: ABdhPJy3KApRPIhlXki48+yuOjEHDralBk0AkVLeIz09K+F5zOVhP1nTP665jxnMmohACjqzY/jHww==
X-Received: by 2002:a17:90a:dc13:: with SMTP id
 i19mr12146051pjv.18.1600413847786; 
 Fri, 18 Sep 2020 00:24:07 -0700 (PDT)
Received: from localhost.localdomain ([115.96.124.157])
 by smtp.googlemail.com with ESMTPSA id b18sm2010782pfr.4.2020.09.18.00.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 00:24:06 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 06/13] tests/acpi: list added acpi table binary file for
 pci bridge hotplug test
Date: Fri, 18 Sep 2020 12:53:18 +0530
Message-Id: <20200918072325.9933-7-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918072325.9933-1-ani@anisinha.ca>
References: <20200918072325.9933-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::1042;
 envelope-from=ani@anisinha.ca; helo=mail-pj1-x1042.google.com
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

The file 'tests/data/acpi/pc/DSDT.hpbridge' is a newly added acpi table file
for testing the pci bridge option 'acpi-pci-hotplug-with-bridge-support' under
i440fx. This change documents this fact.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..96a9237355 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/pc/DSDT.hpbridge",
-- 
2.17.1


