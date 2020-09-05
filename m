Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35F5C433E2
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 10:37:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1899B2074B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 10:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="GNv/4Gak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1899B2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEVZf-0007Cf-94
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 06:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kEVXt-00053B-94
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 06:35:45 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33063)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kEVXr-00041z-Rk
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 06:35:45 -0400
Received: by mail-pl1-x644.google.com with SMTP id h2so2311863plr.0
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 03:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fmZ0zShxvpsHgpLnoq8aruXTkYTNo4xgCabQ1KXMZUo=;
 b=GNv/4GakHIzP0UYs+89vsbQLMiG+I1PEwyy/SVBA+BBsdzYvv2CXPbgInk9P98ALp7
 +xRxU4E0KOgtb5nDsKDV8sK2IknCc1NaXya5Any+yjTPPHJaJZUw4T4G4HpSpU31Xyrd
 EPLcuXppCEXVbAq0A0SSiFv4VfJZjJRn8RzTM+b+DIVClDl8CBNCKUL8NGuy9PDojWVK
 vBbFHF430t6zA3MYc+sU29CT2GBk/rBGMoAYm618IInUUGMChZOSA5Smn7USjFYE2nlv
 kqt4S9HmVyR0KHnkswQ/6ydFSXYg4wyrCU1N/lN78Q2N2gCvXcMw5rwi2Wb4I4kjz+oU
 K7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fmZ0zShxvpsHgpLnoq8aruXTkYTNo4xgCabQ1KXMZUo=;
 b=BG7zleimr2UWz5RmEIX78FdBAEUctOdl6lJZ3ciaTuvGAYNy8hm42kkcGj8ul8Y2hN
 iCEPqALQj8XrFwEYGT6TLD0gJF6x0Vng8Y7li2nzohNEMn4NnETW8+fpOZU8eWbaPCv3
 7YGSc6HrjWtml9SdKdMmUar3AhvZjEmxykomLviSggBtV+q+WzCvIM18uyTUpjcM/YjF
 W6/gm0p/xP3LRMLFOMvTtFf8ePGNi9mhS2oH2oxpTtXVogzlNSI9EykRY8Od5gBvTeum
 IqD+n9JZBFNcaUGMpKa2eTf9/OBXqBgrBFLSG3yTvHoKaWMq7xXAoqQkIBOb3iHoY5qo
 G1Sg==
X-Gm-Message-State: AOAM533IIiTl2G92Q1uJBHjt3JRNTRfW48QGWeYpoHp4SjGnElNkrcnd
 Kne1lUh2LE8PNwfMeTbi1yKkgsg3p0ZRjg==
X-Google-Smtp-Source: ABdhPJz8ZVPoZo0p9wogDfcPgi+q3MWP/0XucRiLUaKY4uVzzLPjmgoogjhltd5VMXNEsBBXoMG+tw==
X-Received: by 2002:a17:902:b085:: with SMTP id
 p5mr12496411plr.266.1599302142137; 
 Sat, 05 Sep 2020 03:35:42 -0700 (PDT)
Received: from localhost.localdomain ([115.96.135.214])
 by smtp.googlemail.com with ESMTPSA id k24sm9200643pfg.148.2020.09.05.03.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2020 03:35:41 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/3] tests/acpi: list added acpi table binary file for pci
 bridge hotplug test
Date: Sat,  5 Sep 2020 16:05:18 +0530
Message-Id: <20200905103520.12626-2-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200905103520.12626-1-ani@anisinha.ca>
References: <20200905103520.12626-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::644;
 envelope-from=ani@anisinha.ca; helo=mail-pl1-x644.google.com
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
Cc: Ani Sinha <ani@anisinha.ca>, Igor Mammedov <imammedo@redhat.com>,
 jusual@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The file 'tests/data/acpi/pc/DSDT.hpbridge' is a newly added acpi table file for
testing the pci bridge option 'acpi-pci-hotplug-with-bridge-support' under i440fx.
This change documents this fact.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
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


