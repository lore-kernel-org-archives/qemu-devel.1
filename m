Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C84C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:44:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59460206DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJOOacNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59460206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNAIu-0000lv-Ca
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9yG-0004ME-5W
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9yA-0001np-5c
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:43 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V8Xci8HnNkfgeQV1Okxnuws7AtEIZPnWRoO72+kZyuo=;
 b=dJOOacNHwQCFcsIiMHF967a2lgIzAGa3aI6IluBTnxvSCKzImerRvDXdYuo1U8Yf6hckJ8
 5RWVkuvaMnCn/CEqVYGMltE38/R7cOxIPzBOuyZRuPveG1T70mWKtjiUOjUJSE1YTnnhfK
 IyBsx5I7NdmD3KJRVQhJxKIr46SV9mA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-bUlQJ4ZXPWSo-bPWS4Nyiw-1; Tue, 29 Sep 2020 03:22:32 -0400
X-MC-Unique: bUlQJ4ZXPWSo-bPWS4Nyiw-1
Received: by mail-wr1-f69.google.com with SMTP id d9so1356199wrv.16
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=V8Xci8HnNkfgeQV1Okxnuws7AtEIZPnWRoO72+kZyuo=;
 b=ScePLuIIMO9rZlihaO1dxrkVzGC2rANSaf6FPh0L8Zr67r9Keju/IXS/QUgFJRr6kQ
 oy3AHx4azMed71JKLX4MQUK1ia788DfNm+aoE3zHhJOkRRqIuWg0lML1PFRiL4ISNTJx
 gCemDLT/rw2T6yv/y4Z7KKnqhA+7EO5B928eoSfXXTQ5Dfauk84JGJYNpr1QkJDnMaIT
 A52ftrVwJIwA/MyUzemZywCzNwoBNXqusr61IqbhL6elNxjOy+Mu7wJrtdxg5UyMv5v3
 O8MH0kYbaq1DfG+oBDTB1yen/9xeY+oW4ORapSXSLFiVTQWeS5QlHreX3aV5tNiD/CKv
 9e2Q==
X-Gm-Message-State: AOAM5339sx/waVyb3HLZAXovZ5zcfvGlisTEcGRXUpgyvLk4xqELl+z6
 6kmL5HsMOeo5fNmcO5+ZUkth0d+6abtTiYOOibRG66dBKzU1G1czPq+4RkZXuB0piS6wL5kCXkG
 ZfkF8b0mLSmn1+k0=
X-Received: by 2002:a7b:c84a:: with SMTP id c10mr2943730wml.139.1601364150937; 
 Tue, 29 Sep 2020 00:22:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtPc7cVi5KpkCB0m3RlGR7hA4yvw4BikMZePW/sdUVVYU+CepNgS0+llTi5uWF6No6EQL9dw==
X-Received: by 2002:a7b:c84a:: with SMTP id c10mr2943710wml.139.1601364150774; 
 Tue, 29 Sep 2020 00:22:30 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id u186sm4212160wmu.34.2020.09.29.00.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:22:30 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:22:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 36/48] tests/acpi: add new unit test to test hotplug off/on
 feature on the root pci bus
Message-ID: <20200929071948.281157-37-mst@redhat.com>
References: <20200929071948.281157-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ani Sinha <ani@anisinha.ca>

Ability to turn hotplug off on the pci root bus for i440fx was added in commit:
3d7e78aa7777f0 ("Introduce a new flag for i440fx to disable PCI hotplug on the
root bus")

This change adds a unit test in order to test this feature.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200918084111.15339-3-ani@anisinha.ca>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index a9c8d478ae..bc932d0b9f 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -742,6 +742,20 @@ static void test_acpi_piix4_tcg_bridge(void)
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
@@ -1160,6 +1174,8 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/q35/tpm-tis", test_acpi_q35_tcg_tpm_tis);
         qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
         qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
+        qtest_add_func("acpi/piix4/pci-hotplug/no_root_hotplug",
+                       test_acpi_piix4_no_root_hotplug);
         qtest_add_func("acpi/q35", test_acpi_q35_tcg);
         qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
         qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
-- 
MST


