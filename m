Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94851C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 18:09:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A990206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 18:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="bvU7WDdy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A990206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGnUC-0003xZ-8n
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 14:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kGnTH-0002SY-BJ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 14:08:27 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:37134)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kGnTF-0005xD-SM
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 14:08:27 -0400
Received: by mail-pj1-x1042.google.com with SMTP id kk9so2058727pjb.2
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 11:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cy7jtmkUUHvcw0+QvBletz9ezeL9whuTVJlIAXVHHp0=;
 b=bvU7WDdykIBqjEWoH0J3gzp9P/l6l8dunm1lDPaQgGcSt2+y+OMhsfNBOElUJdOAhP
 DG+TaSMJg/EhXEKrgiRa9N4+P/Ph7ct7mUkQhS5o2ymiK7cKCgJ6Au6YnGhXyj1cGpAE
 CQv4NhjrXw/Vu1ItXUOLkd7EWq81qnz3mgvP/ippvx1RRsLJ82krzUZo49aUEMUi4sOD
 8B3WjiukzoJd6wl6uuEzWiBIYLwMBl/+5qqwfkxWuLDXYdsMFDknLZXQNrSG2BnB/6u6
 +XklJKMZwZrBuBT7hhDaRYiyWlooCCoZxPoWO3ftchpbJy49GkE5Rw8wSTkqKOQc5Owh
 Mo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=cy7jtmkUUHvcw0+QvBletz9ezeL9whuTVJlIAXVHHp0=;
 b=jAafs+CUduPBR8j+r/DcDXQiSb7bCBTi+aL38FFSBj4VPedKOifLNn69ogHQpB0C24
 7yHENu6WXfnn28T3iolbsfRbOalvTu3WcpO48/ee1jXZfxz1dDdyLCtXG8THsq2wpENo
 YItFnWeiI1+Fm7yaVt7GE1X25rwa291ZQgJK99WDABk4Q9KQaxMFU5H2GnO1FSx8pvgO
 2Lm6UfVKbrQJBtF8DcZsC7qLqjGXnUvplDF402kgV4WCKM8VHlnqz6S2KdACifDK8gXE
 fjJQnfcnypjkZc6sC8Ci+vEnN1QRLIgoZlhUodqGQ40FwwNgMxESORlenulX3PAn4PU0
 WG1A==
X-Gm-Message-State: AOAM533mJxK2UO5KkR1VAL2aYuuNxTfbFiFoSxwY1eE0OsiyycevVkwP
 O5bG4BXsTuIUrRfnuu3efPVBxfHi8JorJA==
X-Google-Smtp-Source: ABdhPJxfyCcAMbC5WKxAac6ahr5x1VllHHKtibVUVNkpH2d7xF7dTbB9oQXx61Fh75ZEmfmZFbSmDg==
X-Received: by 2002:a17:90b:1b03:: with SMTP id
 nu3mr3266242pjb.148.1599847704321; 
 Fri, 11 Sep 2020 11:08:24 -0700 (PDT)
Received: from localhost.localdomain ([115.96.135.201])
 by smtp.googlemail.com with ESMTPSA id n9sm2929135pfu.163.2020.09.11.11.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 11:08:23 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/9] tests/acpi: add a new unit test to test hotplug off/on
 feature on the root pci bus
Date: Fri, 11 Sep 2020 23:37:48 +0530
Message-Id: <20200911180755.28409-2-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911180755.28409-1-ani@anisinha.ca>
References: <20200911180755.28409-1-ani@anisinha.ca>
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
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ability to turn hotplug off on the pci root bus for i440fx was added in commit:
3d7e78aa7777f0 ("Introduce a new flag for i440fx to disable PCI hotplug on the root bus")

This change adds a unit test in order to test this feature.

This change has been tested against upstream qemu master branch on top of tag v5.1.0.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 tests/qtest/bios-tables-test.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 504b810af5..d8c7d57557 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -740,6 +740,20 @@ static void test_acpi_piix4_tcg_bridge(void)
     free_test_data(&data);
 }
 
+static void test_acpi_piix4_root_hotplug(void)
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
@@ -1144,6 +1158,7 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/q35/tpm-tis", test_acpi_q35_tcg_tpm_tis);
         qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
         qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
+        qtest_add_func("acpi/piix4/hotplug", test_acpi_piix4_root_hotplug);
         qtest_add_func("acpi/q35", test_acpi_q35_tcg);
         qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
         qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
-- 
2.17.1


