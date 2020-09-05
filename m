Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98188C43461
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 10:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 232932074B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 10:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="a8ZGmBhC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232932074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEVaU-00085V-9D
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 06:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kEVY1-0005C7-QA
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 06:35:53 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:37599)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kEVY0-00042B-9b
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 06:35:53 -0400
Received: by mail-pj1-x1041.google.com with SMTP id kk9so1805318pjb.2
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 03:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/DDut6vT/pt3uZ1rqDVocx4JKcwLTZtNcMXerL/hnGA=;
 b=a8ZGmBhCvPjafN33caFNZoAmtwtFrIrrUIYtMDeybwhKttG4Jpo7IDD4LWnt/gUJJC
 HaAa0ANFV8m3gdA94QqSxpGSBNAEBhOMdN5iCQ8f+KdEGAwWkZvxwTevrxSIcs14enBf
 MJS1905ZeYdeK3hVmpDcV0RSXkt2vmRO4JlV73whn9vhUpJD6U0rp+O2JziG9SUBr2iG
 771Ai2VMBw1TZEBjzWdFu3ZNP6it0em/rq3vnXc/pZxXpOjEXLCW2r377RLuKvuvqm0h
 YZSm68bY4Dlyv9sYNFtbQoWhvW9I8ipFeARss7f5E3GV9K2jJkdYsubcT+9FGETe2K1T
 di7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/DDut6vT/pt3uZ1rqDVocx4JKcwLTZtNcMXerL/hnGA=;
 b=bZCXlWxXSYReUjZT1dbGMUAG7YJouTqmhlsJ6ML2GelShAA/CT0zIP+kutnY2Qy6gb
 TefVHm966wRcrBCjakls07G3SU+F2D7W6fxS81+rGzUpFpWBmbdmTzQvfW55maYH3iq1
 vO1kBkmFX3F1YJkOTcb7Y/PVgJrOI94/6JnNf4Qqm3zgTkl4P6bOfuNw7CgCrAQeaCKk
 uDIAC0m0/MdQGhtpKFV4dWq/DqdeFiwup3S1K4CoubxJdQlZJO+gdOO3kX0+jMwQm2mS
 3WvG0tqPiPH5/lKfRwrTyLiOZTgJSN/7JucjMcY+Fhw2g2VqSTFIFBnYwxrhR64QKBqS
 ojxg==
X-Gm-Message-State: AOAM533Iz4f5FYsMoG/dA9sW+7oLX01yiyMpYmCHf4ypqDMGZiMnQepL
 1mL76X1CP+w7Mms3c2P/mM1pzE8HiLumjKM9
X-Google-Smtp-Source: ABdhPJwxooY75+UA4OFC0sELsNrFQxrauxYCI3rbt4q8NH8QBCXbj0nSWZQ3YgTmEgLScBlBGBlZjg==
X-Received: by 2002:a17:90b:33ca:: with SMTP id
 lk10mr11464657pjb.233.1599302150663; 
 Sat, 05 Sep 2020 03:35:50 -0700 (PDT)
Received: from localhost.localdomain ([115.96.135.214])
 by smtp.googlemail.com with ESMTPSA id k24sm9200643pfg.148.2020.09.05.03.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2020 03:35:49 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 2/3] tests/acpi: unit test for
 'acpi-pci-hotplug-with-bridge-support' bridge flag
Date: Sat,  5 Sep 2020 16:05:19 +0530
Message-Id: <20200905103520.12626-3-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200905103520.12626-1-ani@anisinha.ca>
References: <20200905103520.12626-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::1041;
 envelope-from=ani@anisinha.ca; helo=mail-pj1-x1041.google.com
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

This change adds a new unit test for the global flag
'acpi-pci-hotplug-with-bridge-support' which is available for cold plugged pci
bridges in i440fx. The flag can be used to turn off acpi based hotplug support
for all the slots of the pci bus.

Tested on the upstream qemu master branch on top of tag v5.1.0

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 tests/qtest/bios-tables-test.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index a2c0070306..e52a36e775 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -723,6 +723,20 @@ static void test_acpi_piix4_root_hotplug(void)
     free_test_data(&data);
 }
 
+static void test_acpi_piix4_bridge_hotplug(void)
+{
+    test_data data;
+
+    memset(&data, 0, sizeof(data));
+    data.machine = MACHINE_PC;
+    data.variant = ".hpbridge";
+    data.required_struct_types = base_required_struct_types;
+    data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
+    test_acpi_one("-global PIIX4_PM.acpi-pci-hotplug-with-bridge-support=off "
+                  "-device pci-bridge,chassis_nr=1", &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_q35_tcg(void)
 {
     test_data data;
@@ -1117,6 +1131,7 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
         qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
         qtest_add_func("acpi/piix4/hotplug", test_acpi_piix4_root_hotplug);
+        qtest_add_func("acpi/piix4/brhotplug", test_acpi_piix4_bridge_hotplug);
         qtest_add_func("acpi/q35", test_acpi_q35_tcg);
         qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
         qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
-- 
2.17.1


