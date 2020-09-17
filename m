Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E61C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:13:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C652078D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="OzUDEI7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C652078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIvbb-0002X4-7D
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 11:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIvQ3-00022h-US
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:01:55 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40544)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIvPv-00014k-Bz
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:01:55 -0400
Received: by mail-pl1-x643.google.com with SMTP id bd2so1268817plb.7
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 08:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=AWrCdAS9YrXdNthcKajxbUJ0zahd1eQ0Rfl6scNbHz8=;
 b=OzUDEI7Gv75rdIJnkoFyg5mBCyEAHMEWkKYn7kEMChWgSVfIhiiXTHNyjgh3MwFsoI
 +T8jP/soCEPNkBDyJqQ2Y2/h66uyyHAxtkosA3nwDdsMYyCFYzCtq9onwz74uAibSa/w
 6kvH3W5L5lMhpLRya2fifiN+Mh+UT20UpaldAyp17a5SNaMItl0xX3vp/xpxPJ8NxVUw
 1ZyEChVc4UTILiG9rkDrVwqw9mgzC0V7RL1CiBjdskymJZEVLY6dBsvC7RHHcIkq0H8i
 RrtPOzd8H3D7aqXHKPt8kVbJ+e8eoLQLPwRx4QhcA/C6/zXlgoevRwPdT1olYv3PQbuC
 5ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=AWrCdAS9YrXdNthcKajxbUJ0zahd1eQ0Rfl6scNbHz8=;
 b=qmNU3Fp9896+6TVqavk3r1udqeqHx3NSoO5KWvVn0Nfrk8Bm+hIpq4yzqXyWMq5wZU
 tkuP5fdm85y1Gg9WFaaEbiY2f43y6p4PGq6i2Y2U1e7QqJ/HbBFkmrjgo/AQnfPMh/bw
 Jy1JzHv8EoLVHQ94B3IE21ZS2lk9d9MnMxdNS0TihDOW3l0TJadLDa59AUI2LF7w2shs
 T3GyAczy+7ztzRulk/cmhRqB229OQK5pGpkNtmoEFxVg7Md/f+IvoCidL8JTNDB5ObhX
 GegADuEiOAnMcDimqFomlXWhOJ4r9jiSWE2VSUkcywdoM8QgnmV7dENglTQhBwrDo6D2
 p/Xg==
X-Gm-Message-State: AOAM532Jl1yoWYN7tFHLA5qc8KF8QZEcyIp5qiu22EycNsJOfJ/EeP57
 GcghFefheNtZh5x/W9K9d7MqNRFSfhXk94J1
X-Google-Smtp-Source: ABdhPJx9WFpAsWXfILgjpERpMFXAc8TfI3/QVPZlQy+82wp6fVeZ48rHnEuOPAej3tbIOHub4neltg==
X-Received: by 2002:a17:902:9f84:b029:d1:cc21:9a49 with SMTP id
 g4-20020a1709029f84b02900d1cc219a49mr17442678plq.9.1600354903920; 
 Thu, 17 Sep 2020 08:01:43 -0700 (PDT)
Received: from localhost.localdomain ([115.96.151.231])
 by smtp.googlemail.com with ESMTPSA id e10sm17674374pgb.45.2020.09.17.08.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 08:01:43 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 11/12] tests/acpi: unit test exercising global pci hotplug
 off for i440fx
Date: Thu, 17 Sep 2020 20:30:43 +0530
Message-Id: <20200917150044.23159-12-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200917150044.23159-1-ani@anisinha.ca>
References: <20200917150044.23159-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::643;
 envelope-from=ani@anisinha.ca; helo=mail-pl1-x643.google.com
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

This change adds a unit test to exercise the case when hotplug is disabled
both for pci root bus and the pci bridges by passing the following two
switches to qemu:

  -global PIIX4_PM.acpi-root-pci-hotplug=off
  -global PIIX4_PM.acpi-pci-hotplug-with-bridge-support=off

bios-tables-test-allowed-diff.h documents the fact that a new DSDT acpi gold
master binary blob we need to be added to test this. We will do the actual
addition in the next patch in the series.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |  1 +
 tests/qtest/bios-tables-test.c              | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..dea61d94f1 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/pc/DSDT.hpbrroot",
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index c970556795..3f7f1a8107 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -768,6 +768,21 @@ static void test_acpi_piix4_no_bridge_hotplug(void)
     free_test_data(&data);
 }
 
+static void test_acpi_piix4_no_acpi_pci_hotplug(void)
+{
+    test_data data;
+
+    memset(&data, 0, sizeof(data));
+    data.machine = MACHINE_PC;
+    data.variant = ".hpbrroot";
+    data.required_struct_types = base_required_struct_types;
+    data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
+    test_acpi_one("-global PIIX4_PM.acpi-root-pci-hotplug=off "
+                  "-global PIIX4_PM.acpi-pci-hotplug-with-bridge-support=off "
+                  "-device pci-bridge,chassis_nr=1", &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_q35_tcg(void)
 {
     test_data data;
@@ -1176,6 +1191,8 @@ int main(int argc, char *argv[])
                        test_acpi_piix4_no_root_hotplug);
         qtest_add_func("acpi/piix4/pci-hotplug/no_bridge_hotplug",
                        test_acpi_piix4_no_bridge_hotplug);
+        qtest_add_func("acpi/piix4/pci-hotplug/off",
+                       test_acpi_piix4_no_acpi_pci_hotplug);
         qtest_add_func("acpi/q35", test_acpi_q35_tcg);
         qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
         qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
-- 
2.17.1


