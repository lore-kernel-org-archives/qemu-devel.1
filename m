Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0464C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 12:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A6752078A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 12:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eaPzJpjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6752078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkodj-0007e1-Os
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 08:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jkod0-00076L-72
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 08:54:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52567
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jkocy-0006Yt-Hn
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 08:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592225655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=AEyfBnmJ/VEPijawTe1iuhGxAWeiCfA2+WsQaJTo3Ns=;
 b=eaPzJpjTiSZWAbCxwn5LWAedldpKNdAOKsHMsF/ouRMljN4Rl4VhiaEccGOoOBcaB4g2Ju
 SOj/bZFTeZXVf1C+qUJxpVp355Ji0zOvAUDVzlUOLYBUn8frHdL/tBW6rqmsGWwxna3aRc
 O5ne8RVplzREmmgABaCncsjSTRecZpQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-xDRf086NPlqnwSfw-Rjd0Q-1; Mon, 15 Jun 2020 08:54:13 -0400
X-MC-Unique: xDRf086NPlqnwSfw-Rjd0Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9E61107B470
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 12:54:12 +0000 (UTC)
Received: from thuth.com (ovpn-112-111.ams2.redhat.com [10.36.112.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A86967CAA0;
 Mon, 15 Jun 2020 12:54:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Auger Eric <eric.auger@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH] tests/qtest/bios-tables: Only run the TPM test with
 CONFIG_TPM enabled
Date: Mon, 15 Jun 2020 14:54:02 +0200
Message-Id: <20200615125402.12898-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:12:36
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"make check-qtest" currently fails if configure has been run with
"--disable-tpm" - the TPM-related tests can only work if the TPM is
enabled in the build. So let's use the CONFIG_TPM switch to disable
the test if TPM is not available.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/bios-tables-test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 53f104a9c5..d170a617d8 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -877,6 +877,8 @@ static void test_acpi_piix4_tcg_numamem(void)
     free_test_data(&data);
 }
 
+#ifdef CONFIG_TPM
+
 uint64_t tpm_tis_base_addr;
 
 static void test_acpi_tcg_tpm(const char *machine, const char *tpm_if,
@@ -931,6 +933,8 @@ static void test_acpi_q35_tcg_tpm_tis(void)
     test_acpi_tcg_tpm("q35", "tis", 0xFED40000);
 }
 
+#endif /* CONFIG_TPM */
+
 static void test_acpi_tcg_dimm_pxm(const char *machine)
 {
     test_data data;
@@ -1094,7 +1098,9 @@ int main(int argc, char *argv[])
             return ret;
         }
 
+#ifdef CONFIG_TPM
         qtest_add_func("acpi/q35/tpm-tis", test_acpi_q35_tcg_tpm_tis);
+#endif
         qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
         qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
         qtest_add_func("acpi/q35", test_acpi_q35_tcg);
-- 
2.18.1


