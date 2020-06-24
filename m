Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6E0C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:20:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51805206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C3JT2nP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51805206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joEgS-00045y-KM
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 19:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joEUG-00010w-NT
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:07:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50652
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joEUD-0001iW-UD
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593040041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O1Pk0uuKND2QavcxSvQGg35kYy9TBUCkwDwrM5cX6Tw=;
 b=C3JT2nP8cXRzRRIdxPn6Qhi40ayUiXBlF+js6U+2AkcUUdv+6lvZiXUGTzOT2hhX7i01mD
 xeQkj+nLJBG6P2slnQAWdS4TT37+T72S6nmLKXYozdx5nFfOAZwAJrIaR+0RK1VHDNsiU0
 sewW6mqvOqZxn9rI4wS4oy6iIHz5+jM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-l9ig1ZxqNXm2V0eMMTKsHQ-1; Wed, 24 Jun 2020 19:07:19 -0400
X-MC-Unique: l9ig1ZxqNXm2V0eMMTKsHQ-1
Received: by mail-wm1-f69.google.com with SMTP id o13so4787495wmh.9
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 16:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=O1Pk0uuKND2QavcxSvQGg35kYy9TBUCkwDwrM5cX6Tw=;
 b=LSWTe2UfcvoUi5ttR4hRk9WkQ/b3UgBeM4nQnosuIrxfsqVP8k0yPKmZLfW4L5ud5O
 fnLtn7k4lH4F8y9UB+3Bln+53xiAaglid78lpXRt+XDLsvIZNPDP5oYYD2aNOzlG2Pul
 L9I0MQED+YASunT2uZ4odCkzsPN+FsOx2Wtva8ekdaFgmWzo3wO81+4sxxRY+RNyCgVk
 wIQfPHYnWP8dFBn6Eipod7PG8cJ9c4rcnGxbO6klrTAMko3R3OOZr/KmkQQwCzDWgKO1
 8EskdIqLLtrhpL2O+CZc4+SnAD61X6Ka+4WV7PYzgv0OYZxrGw/3IhHoICIVt5zM8oRx
 oWRQ==
X-Gm-Message-State: AOAM5325kudeVl4GJd8S8ISvdH6ygQ2zzr46C8UezqXgDRg5TJFPvT/m
 QM9rJyVRmS19CyKEnQWq4ylIJ8kq3a2zbzZnI05W3sfVXVnGh4meLfTrSGHN4gatznpLTacpMDj
 8yP8z3592Ndue2Xk=
X-Received: by 2002:a1c:9ad8:: with SMTP id c207mr100879wme.45.1593040038028; 
 Wed, 24 Jun 2020 16:07:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5k3ZVx6jwJ4pTZntrtJ2ymfH21rA0QK7PB/58sNX0lJBZnypz7rwZtBxI6hxb/y30pTX+PA==
X-Received: by 2002:a1c:9ad8:: with SMTP id c207mr100852wme.45.1593040037802; 
 Wed, 24 Jun 2020 16:07:17 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 l17sm10210326wmh.14.2020.06.24.16.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 16:07:17 -0700 (PDT)
Date: Wed, 24 Jun 2020 19:07:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/19] tests/qtest/bios-tables: Only run the TPM test with
 CONFIG_TPM enabled
Message-ID: <20200624230609.703104-19-mst@redhat.com>
References: <20200624230609.703104-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200624230609.703104-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 eric.auger@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

"make check-qtest" currently fails if configure has been run with
"--disable-tpm" - the TPM-related tests can only work if the TPM is
enabled in the build. So let's use the CONFIG_TPM switch to disable
the test if TPM is not available.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200615125402.12898-1-thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Fixes: 5da7c35e25 ("bios-tables-test: Add Q35/TPM-TIS test")
Cc: eric.auger@redhat.com
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/qtest/bios-tables-test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index c315156858..3bd57b830d 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -877,6 +877,8 @@ static void test_acpi_piix4_tcg_numamem(void)
     free_test_data(&data);
 }
 
+#ifdef CONFIG_TPM
+
 uint64_t tpm_tis_base_addr;
 
 static void test_acpi_tcg_tpm(const char *machine, const char *tpm_if,
@@ -935,6 +937,8 @@ static void test_acpi_q35_tcg_tpm_tis(void)
     test_acpi_tcg_tpm("q35", "tis", 0xFED40000);
 }
 
+#endif /* CONFIG_TPM */
+
 static void test_acpi_tcg_dimm_pxm(const char *machine)
 {
     test_data data;
@@ -1098,7 +1102,9 @@ int main(int argc, char *argv[])
             return ret;
         }
 
+#ifdef CONFIG_TPM
         qtest_add_func("acpi/q35/tpm-tis", test_acpi_q35_tcg_tpm_tis);
+#endif
         qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
         qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
         qtest_add_func("acpi/q35", test_acpi_q35_tcg);
-- 
MST


