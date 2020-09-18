Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3770EC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 07:26:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A11E12075B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 07:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="LUSaKIvn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11E12075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJAmX-0005pB-JT
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 03:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJAkl-0003I1-2Z
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 03:24:20 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:54606)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJAkh-0003LT-1V
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 03:24:18 -0400
Received: by mail-pj1-x1042.google.com with SMTP id mm21so2689356pjb.4
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 00:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=djDyPCHV2KQRcs6lHtT3AJbP4Jr32BITnAiU+WVBllU=;
 b=LUSaKIvnNS+yomUFtJKpW84M18ZM7gZicD7u9bcjNE2Q+quZQK82al4BgwUYVh+Gl2
 nzxnG9rFQs1Df9U6lQMpNWabq1hI/AF7IRSa1lSR+jUh/98YgSdZECyZuH+N6DnDBZ2x
 dcMCNKe8gtissGWq/POYzGvO8tTk6ZCMiFbpaPszV9hh94I2qeLFk7j6dZjtrPCXz8ot
 eh6VFhaTWOSPvJPBIjio/Gxk35fB6Vz0gqXDT7QgIA374Kgwtj+SEC57dq//ZNmfO+FP
 Rcvl/MGafR83Bm6QjqXjbKNvsBWLJdh4o5NijAld1dmB0ZVnYFk8KMyOpBs+YdkGFtZs
 Wv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=djDyPCHV2KQRcs6lHtT3AJbP4Jr32BITnAiU+WVBllU=;
 b=HrYGPNOLAW/ziQq9rDKVPbGxzICedWfqZWXszOmbQZ7TaKqH+GGgHZwpCpljcCr+S1
 qxbqpAcvCnqp58RQnrOpFuvR5p6lcrbTWkgyWx7vlCYrctilQXX1SMr1oaj9WI48IzII
 orOviOl7VpCX12sPjz56snjANUfKuq6hn2TXR7fX/CjukDUaI6mkD+Vel6p0lVO6t20P
 OOse5oBxy1NEU0x8A6RJdzVJnSLKlVP0gowhoBn83R9/xazS+Mp3CBjrO97eXneNPPdv
 hQgUMs6YCpF8LwO3n3l1Gw/4VEtQm/vZ3RZUg3nF5G6x5K9jLt0pcJg04jrwHKnvhJFR
 jsVQ==
X-Gm-Message-State: AOAM5311x1Le+D/tSzN+Xi27JBAz92tNNBwConAaX2Ld/C8zKA0yxLku
 bUkCcFMeu/Ou7UTJ07loaxWLPQvTE2aUkGcN
X-Google-Smtp-Source: ABdhPJzTUne4J1zDbRqLMSPbiOcnmv9jjoSQsSjkXr2ZbEWKzLLfG0hJ3wwJEjdVCtQE0QwOrfkNpg==
X-Received: by 2002:a17:902:7614:b029:d1:e603:1bf2 with SMTP id
 k20-20020a1709027614b02900d1e6031bf2mr14057775pll.71.1600413853464; 
 Fri, 18 Sep 2020 00:24:13 -0700 (PDT)
Received: from localhost.localdomain ([115.96.124.157])
 by smtp.googlemail.com with ESMTPSA id b18sm2010782pfr.4.2020.09.18.00.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 00:24:12 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 07/13] tests/acpi: unit test for
 'acpi-pci-hotplug-with-bridge-support' bridge flag
Date: Fri, 18 Sep 2020 12:53:19 +0530
Message-Id: <20200918072325.9933-8-ani@anisinha.ca>
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

This change adds a new unit test for the global flag
'acpi-pci-hotplug-with-bridge-support' which is available for cold plugged pci
bridges in i440fx. The flag can be used to turn off ACPI based hotplug support
on all pci bridges.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index ad157ef05d..c970556795 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -754,6 +754,20 @@ static void test_acpi_piix4_no_root_hotplug(void)
     free_test_data(&data);
 }
 
+static void test_acpi_piix4_no_bridge_hotplug(void)
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
@@ -1160,6 +1174,8 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
         qtest_add_func("acpi/piix4/pci-hotplug/no_root_hotplug",
                        test_acpi_piix4_no_root_hotplug);
+        qtest_add_func("acpi/piix4/pci-hotplug/no_bridge_hotplug",
+                       test_acpi_piix4_no_bridge_hotplug);
         qtest_add_func("acpi/q35", test_acpi_q35_tcg);
         qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
         qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
-- 
2.17.1


