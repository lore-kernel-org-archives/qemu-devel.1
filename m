Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261A0C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 07:27:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C624C2075B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 07:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="zaR7zOG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C624C2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJAnT-00075Z-VB
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 03:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJAkI-0002dG-G5
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 03:23:50 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39271)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJAkG-0003Hq-SE
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 03:23:50 -0400
Received: by mail-pg1-x542.google.com with SMTP id d13so2950135pgl.6
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 00:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YfALMwALzeYbzwckrxN8lzSGcpwno9FZ6SZJMeQ9frI=;
 b=zaR7zOG/708BHLdjfi6Ueyionwq0jQP+zrq6oagDqPWmYNw3GDqG+6JOZLgg8LRGFM
 +n5TWqwXxtsA+Nfr/DlBAI0Hjmr9fX4CYjSbjDq3MvL2DmW+U9lCKlKQThn/AA99Kj0c
 pzMZl3O4cRJWf07XnHV5PkQ48lq92kaOq2JSgfBEdO0ssfisUDojIwPcTFl4h2WNjBQ8
 GrLK2sKGNlqbg+zXD+lrF2jjAHoDgq+K3bpPzlqibZ36z992DG6PZX6icIJHxv6sfpbJ
 qvIjFVil4x3j4Vi1JS7jfErd7OrEfjXMZFfWha4MUtjkBIodhweMkVomcX7JFqyEXlia
 Ze6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YfALMwALzeYbzwckrxN8lzSGcpwno9FZ6SZJMeQ9frI=;
 b=kdrVrZaEc4ozyRFqTyl0fxzJv2Rk9ZxeteQeA87AxRqK/oQUbBmcsmifTNgXKuKke9
 cj5KMZDjUj9NuMZX3NqP35+vidCGn1y+5Busy4V2PjRMxByo9J/aT1rALweudL6++8Tk
 BkJNJJlFQ+7kVLUwNxf4IEM4qh6MoEtsnbAnhbAl7QtT3ijNzc2m4XKNHAh43bHH4tXK
 LUmml73uqtQRmC4qLjhYkIHUz6K51cESNj5GRsX9DbKloW+WJ+FHVqPpmzSjX6/Ph3mb
 kUkPD3edK/TY9YHjmFN1QFbHzOauE5eTgmug8sDS9k/EqcSce7volBEZZu2EiPxhk41Q
 VZmQ==
X-Gm-Message-State: AOAM530VP5vzNBAi7bwid/X1eknorbEEQ/ppwkQFuGS4Ky82DBGo6xWO
 U2LZz1CiqEpkiCxVtc/JqTkllg7emVewMq1J
X-Google-Smtp-Source: ABdhPJzj+8pUByAN8T+KFt4JPXfe7KyGhJ3IdOC2lybRvlLCWmnPlvUBFN1pwdJ8A0qVS5wJlXiG7w==
X-Received: by 2002:a63:c40d:: with SMTP id h13mr25626491pgd.185.1600413827114; 
 Fri, 18 Sep 2020 00:23:47 -0700 (PDT)
Received: from localhost.localdomain ([115.96.124.157])
 by smtp.googlemail.com with ESMTPSA id b18sm2010782pfr.4.2020.09.18.00.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 00:23:46 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 02/13] tests/acpi: add new unit test to test hotplug off/on
 feature on the root pci bus
Date: Fri, 18 Sep 2020 12:53:14 +0530
Message-Id: <20200918072325.9933-3-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918072325.9933-1-ani@anisinha.ca>
References: <20200918072325.9933-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::542;
 envelope-from=ani@anisinha.ca; helo=mail-pg1-x542.google.com
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


