Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F35C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:24:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A423206A4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="cy9Yx850"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A423206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIQrq-0006En-Cd
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 02:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIQi3-0002H1-28
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:14:27 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44891)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIQi1-0005nW-6G
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:14:26 -0400
Received: by mail-pg1-x541.google.com with SMTP id 7so3277340pgm.11
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 23:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=1HJAcNNwPJS7p1FkxDsM+O9s3xr3SqwAfIoNSM2l/6c=;
 b=cy9Yx850Esuk6FqkO2YoK97gz3jAnNK5OwBTSZJt9CU3Q98taTCvBFBiaYeGSVv2C7
 JboXojTqvbohMxIThjQT+85mEb0klfV23rdPWgv/rAOd1GaGMg72gXcwnoVufMyq9K6L
 qmDrrmOQk9DKSBSOAAAKZ/Q8ahwtT4WplAHhl9PWVbH6vhz0wU04x1XY0T29TMonU3St
 sp/FnBO/ytLibiA3dHLK9cUJOkgrXVNT/Az1lS0dyR9h9HKlJysLNcdKVqonHnpxxcD3
 fjKr1V2cu+KLAMgFtLKr9T7RGyyGXCQkWi/rBfvLxpeVVyqNY+WY1rP3g9kPJ4qZAmpG
 OtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=1HJAcNNwPJS7p1FkxDsM+O9s3xr3SqwAfIoNSM2l/6c=;
 b=hs9HI3Icbh1RxioDtzlVL+baXcoLOp9wwAtHHrR6dfgMmhOJM3heurqfMLX/Lt/1q6
 ynlW1aS5Q7C4+eCeQTQnnX3LExZGhUt0j3CkSmkgVgPFhRYEobC+6NF4LcLy21d/+Bf1
 fonFCRhep8Z+TUuYbef06qKTbLyO36cKDdhKJOJZkzcUTblJfjUIE9C1wlZ6Zk/B4uKt
 RFtZywxIdRTJIRCW4A/YMd/A2ihORvH/jZ5bM0W3ptoib8TKOHT1EbGwV5sChRbj8NHI
 rkzL//eItTf9PHfv8AZtU3uWkQ6bMF/BorkUWfMrIaZ1CjGN4/gaOS/54zYuGVQwCyc1
 8BbA==
X-Gm-Message-State: AOAM532LmjU5hSgbqBaFnN821Q/C68GX3unE7tQLfqryY/ej7YVanNwH
 sTMHdWH8r34RAc/nlBGirPR0dCAKd+VY1GCp
X-Google-Smtp-Source: ABdhPJy4bRObR/pJQ1T2VP6hP5fPrSjiX7CQKNZOYUozR5EIDrL+Pf5iNwL0228upQYYLrkPNDkcuw==
X-Received: by 2002:a65:4984:: with SMTP id r4mr16836797pgs.261.1600236863509; 
 Tue, 15 Sep 2020 23:14:23 -0700 (PDT)
Received: from localhost.localdomain ([203.163.234.244])
 by smtp.googlemail.com with ESMTPSA id c20sm583164pfc.209.2020.09.15.23.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 23:14:22 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 07/11] tests/acpi: unit test for
 'acpi-pci-hotplug-with-bridge-support' bridge flag
Date: Wed, 16 Sep 2020 11:43:31 +0530
Message-Id: <20200916061335.14045-8-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916061335.14045-1-ani@anisinha.ca>
References: <20200916061335.14045-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::541;
 envelope-from=ani@anisinha.ca; helo=mail-pg1-x541.google.com
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
bridges in i440fx. The flag can be used to turn off acpi based hotplug support
for all pci bridges.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 tests/qtest/bios-tables-test.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index d8c7d57557..7632cfe1be 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -754,6 +754,20 @@ static void test_acpi_piix4_root_hotplug(void)
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
@@ -1159,6 +1173,7 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
         qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
         qtest_add_func("acpi/piix4/hotplug", test_acpi_piix4_root_hotplug);
+        qtest_add_func("acpi/piix4/brhotplug", test_acpi_piix4_bridge_hotplug);
         qtest_add_func("acpi/q35", test_acpi_q35_tcg);
         qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
         qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
-- 
2.17.1


