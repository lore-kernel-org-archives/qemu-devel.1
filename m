Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006FFC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:46:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41B5720C56
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="qy2p3xb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B5720C56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJC2J-0006rh-5B
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJBxV-0001YS-Ui
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:41:33 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:56278)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJBxU-0007nz-8E
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:41:33 -0400
Received: by mail-pj1-x1044.google.com with SMTP id q4so2789166pjh.5
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 01:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YfALMwALzeYbzwckrxN8lzSGcpwno9FZ6SZJMeQ9frI=;
 b=qy2p3xb/w49q6XC71NJI6TUni9B2Cra13qLlerHCJhedbo+ZpfCRfE4ZuaEwaYz8ky
 StGbkMKUt+WgRnSXxwpNVzY8jPaDQP3w6BZsxDbxtT19QcJNeTdzFJl4EyN5mfanTaf3
 8hD+jSkMEwKqqqMPjQ7822E8XKR6PZFdW02j3CMVVcJcAUaUUqFc+fVO3c1SQKD8NaT4
 cJaIVqyvl1CTCmt9IQ9eT1lSLLqUp6irnfz1XUMryJsuHVr/le2BoeWQKzd3enlFXLlM
 ANZJ4lsyqn75u3mekgo9vJPE0xVAfTweNsNXXL4FVlacm4A/HsTCDu182QgbsG1Q0zcX
 M74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YfALMwALzeYbzwckrxN8lzSGcpwno9FZ6SZJMeQ9frI=;
 b=EaKmXls7PmX0P/Lo/KhBBkPMKRTSnzicpwBGUW5DCVb+uG87gHI7oxwSlXARZMPOHL
 I+NFYnLgoqC9jKcz3qoOoch2qZ467rxdHb0W5rSTFnuZuV2TrcXsIFxENlIJCbm1wRXW
 tGebQ/3NKPIl+HQw2e6Zic4VVzyx4XaYnGRD0DtfEdTRuP4VENVu2rVairvSIxVFqL6g
 J3xwWW+GcKGkNGnVof4iXfjroja7gWWGgYzR1kRCn+laygmHIjvNe8yq6XmmyQvQw6of
 arJKoVq/LSCyONKDZ/PXF6FgSJwNSd27TW2+TOy6AEeIl0iljDNiMmTRq+I64ulE+rT8
 ET3A==
X-Gm-Message-State: AOAM532tGrXvALPzvdwcY4obsQ+bVtscgq20pfOgV/pbo4imlQEDjJOg
 AFZC7w21rs4XZ+MNXoJaXnJI4w==
X-Google-Smtp-Source: ABdhPJxPWgRbSg08b9P8mL6GNlmyZntJatlU4lL+0/uQQVhstjaETBhRdU4wU7vFhiR7wRbWFakrkQ==
X-Received: by 2002:a17:90a:d488:: with SMTP id
 s8mr12562270pju.176.1600418490971; 
 Fri, 18 Sep 2020 01:41:30 -0700 (PDT)
Received: from localhost.localdomain ([115.96.124.157])
 by smtp.googlemail.com with ESMTPSA id gi20sm2120603pjb.28.2020.09.18.01.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 01:41:30 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v10 02/13] tests/acpi: add new unit test to test hotplug
 off/on feature on the root pci bus
Date: Fri, 18 Sep 2020 14:11:00 +0530
Message-Id: <20200918084111.15339-3-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918084111.15339-1-ani@anisinha.ca>
References: <20200918084111.15339-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::1044;
 envelope-from=ani@anisinha.ca; helo=mail-pj1-x1044.google.com
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
 Eduardo Habkost <ehabkost@redhat.com>, jusual@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ability to turn hotplug off on the pci root bus for i440fx was added in commit:
3d7e78aa7777f0 ("Introduce a new flag for i440fx to disable PCI hotplug on the
root bus")

This change adds a unit test in order to test this feature.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 504b810af5..ad157ef05d 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -740,6 +740,20 @@ static void test_acpi_piix4_tcg_bridge(void)
     free_test_data(&data);
 }
 
+static void test_acpi_piix4_no_root_hotplug(void)
+{
+    test_data data;
+
+    memset(&data, 0, sizeof(data));
+    data.machine = MACHINE_PC;
+    data.variant = ".roothp";
+    data.required_struct_types = base_required_struct_types;
+    data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
+    test_acpi_one("-global PIIX4_PM.acpi-root-pci-hotplug=off "
+                  "-device pci-bridge,chassis_nr=1", &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_q35_tcg(void)
 {
     test_data data;
@@ -1144,6 +1158,8 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/q35/tpm-tis", test_acpi_q35_tcg_tpm_tis);
         qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
         qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
+        qtest_add_func("acpi/piix4/pci-hotplug/no_root_hotplug",
+                       test_acpi_piix4_no_root_hotplug);
         qtest_add_func("acpi/q35", test_acpi_q35_tcg);
         qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
         qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
-- 
2.17.1


