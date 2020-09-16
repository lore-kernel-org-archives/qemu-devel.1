Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7342C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:21:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3422E2083B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="BBWwhelQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3422E2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kISge-0000tw-3o
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 04:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kISf8-0007yH-4s
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:19:34 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kISf6-0004nq-Jg
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:19:33 -0400
Received: by mail-pl1-x644.google.com with SMTP id k13so2788466plk.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 01:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bZd0tScbIjsYO1uHlFG643OQJ2ymwZgmk5pjXqf987A=;
 b=BBWwhelQSbdvYcpIIuxPRB0/YK1mKlptQ000FEu/h+z9AL7yp7mVI3e91Hvr97bvdD
 Fz15NnHURagaGtJQ7Ju7Y/wxJ4XkK1Vp8divs3sWsKJovgOmhXwThXZvfZwyjgOdB0ZY
 pq0w7/j+cr65Qm7qQAR211KH51gcYKvPTsGNlBk8EOK1ELNqGwHhLH306CDgdGvFdhdT
 yLVJHiFcrZjR+hPWeGXSe0J51Dwu9iHDglWvASKoxg5bUbmF4PI6B8r8SOa5sD69qTtq
 4NM7tBLM57WBGiDQeXq2jokhrFKMFBRKS19z76H9Ml14TIhQBIfb2vNTU1z0bzzxPyt0
 nL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=bZd0tScbIjsYO1uHlFG643OQJ2ymwZgmk5pjXqf987A=;
 b=ZcVuAhKQ0R4HnSsTxyxVWT6sLD2sqE+K5ZwTcZpLrohYiOx8dNWQelbP7HBYZml+EZ
 N87Heahl4m/YW/DGaKCaFNMS3G+3P8NK4LZj5b13hhP8MS2c4Q04NihoNR0SjKbGz4hZ
 uS++omWxN62kt/1OI8dn8Xasg0ohXadhhw9KF4zVEvUiZHbDhOb6aef1WqjNe1LhzTx8
 FLRM19NogblHGFBBHDvn/xJLW0iZ0+bKljZ4uygS1mCOxszmX2+zeDYqmmzXz2dmO85n
 rJDCuECdXWKWKVyuR+l7108GDx54h66SBo+Ys0FM7ArsXlGoMvzhTD0B85ADxc4EZCu/
 IZyg==
X-Gm-Message-State: AOAM533O0VbRrgcNJT2U2vveLlSi/qo9t7kUfKzO+37I2+suODsArv5X
 7JymUerLCuTnibxSuHM/kFTUTDxOqpCdkwHv
X-Google-Smtp-Source: ABdhPJwob5rnOLlNhQf1YlMQ+wj5pDZ/lOo+pKuR4zdeTAdSmrNw+Rniq1IM6AJpwQjh62mth7O0qw==
X-Received: by 2002:a17:90b:364c:: with SMTP id
 nh12mr2821017pjb.182.1600244371045; 
 Wed, 16 Sep 2020 01:19:31 -0700 (PDT)
Received: from localhost.localdomain ([203.163.234.244])
 by smtp.googlemail.com with ESMTPSA id nl10sm1658254pjb.11.2020.09.16.01.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 01:19:30 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 02/11] tests/acpi: add a new unit test to test hotplug
 off/on feature on the root pci bus
Date: Wed, 16 Sep 2020 13:49:01 +0530
Message-Id: <20200916081910.977-3-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916081910.977-1-ani@anisinha.ca>
References: <20200916081910.977-1-ani@anisinha.ca>
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 jusual@redhat.com, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ability to turn hotplug off on the pci root bus for i440fx was added in commit:
3d7e78aa7777f0 ("Introduce a new flag for i440fx to disable PCI hotplug on the root bus")

This change adds a unit test in order to test this feature.

This change has been tested against upstream qemu master branch tip.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 504b810af5..75d99f08e5 100644
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
+        qtest_add_func("acpi/piix4/no_root_hotplug",
+                       test_acpi_piix4_no_root_hotplug);
         qtest_add_func("acpi/q35", test_acpi_q35_tcg);
         qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
         qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
-- 
2.17.1


