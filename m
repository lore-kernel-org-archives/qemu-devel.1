Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA91C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:23:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C51206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4c+pe52"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C51206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfhbc-0002ko-Vy
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 06:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jfhZy-0000f7-1C
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:22:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58969
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jfhZv-00008x-Sb
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:22:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591006918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/NpTU5zlaOPP5faG9sGOrDhbPa5zzlwMZvrXG9/B+A8=;
 b=g4c+pe52LWiukR9GeuVHID3pYird3Y4cD7mQoqHI2AF8rDsnqb0orTdPpt3O4F02YE6eKe
 x0vN7iANNF+xBYqa8tTCpN/K07FDjOXOf2GvK7RoU4D5UB2LVOimDnNbSEDAvJWvvtRL7u
 AEidaL3ao8niRjf4LAMH1mu2SBRXSjw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-vfBdJMV3OXWrEBSydX1zBA-1; Mon, 01 Jun 2020 06:21:55 -0400
X-MC-Unique: vfBdJMV3OXWrEBSydX1zBA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE5F8A0BD7;
 Mon,  1 Jun 2020 10:21:53 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-56.ams2.redhat.com [10.36.113.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD742D01E3;
 Mon,  1 Jun 2020 10:21:50 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, stefanb@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 mst@redhat.com, shannon.zhaosl@gmail.com, imammedo@redhat.com
Subject: [RFC 5/6] bios-tables-test: Add Q35/TPM-TIS test
Date: Mon,  1 Jun 2020 12:21:12 +0200
Message-Id: <20200601102113.1207-6-eric.auger@redhat.com>
In-Reply-To: <20200601102113.1207-1-eric.auger@redhat.com>
References: <20200601102113.1207-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 02:05:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: marcandre.lureau@redhat.com, drjones@redhat.com, lersek@redhat.com,
 ardb@kernel.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Test tables specific to the TPM-TIS instantiation.
The TPM2 is added in the framework. Also the DSDT
is updated with the TPM. The new function should be
be usable for CRB as well, later one.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 tests/qtest/bios-tables-test.c | 60 ++++++++++++++++++++++++++++++++++
 tests/qtest/Makefile.include   |  1 +
 2 files changed, 61 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index c9843829b3..bbba98342c 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -57,6 +57,9 @@
 #include "qemu/bitmap.h"
 #include "acpi-utils.h"
 #include "boot-sector.h"
+#include "tpm-emu.h"
+#include "hw/acpi/tpm.h"
+
 
 #define MACHINE_PC "pc"
 #define MACHINE_Q35 "q35"
@@ -874,6 +877,60 @@ static void test_acpi_piix4_tcg_numamem(void)
     free_test_data(&data);
 }
 
+uint64_t tpm_tis_base_addr;
+
+struct tpm_test_data {
+    const char *machine;
+    const char *tpm_if;
+};
+
+static void test_acpi_tcg_tpm(const void *context)
+{
+    struct tpm_test_data *c = (struct tpm_test_data *)context;
+    gchar *tmp_dir_name = g_strdup_printf("qemu-test_acpi_%s_tcg_%s.XXXXXX",
+                                          c->machine, c->tpm_if);
+    char *tmp_path = g_dir_make_tmp(tmp_dir_name, NULL);
+    TestState test;
+    test_data data;
+    GThread *thread;
+    char *args, *variant = g_strdup_printf(".%s", c->tpm_if);
+
+    tpm_tis_base_addr = TPM_TIS_ADDR_BASE;
+
+    module_call_init(MODULE_INIT_QOM);
+
+    test.addr = g_new0(SocketAddress, 1);
+    test.addr->type = SOCKET_ADDRESS_TYPE_UNIX;
+    test.addr->u.q_unix.path = g_build_filename(tmp_path, "sock", NULL);
+    g_mutex_init(&test.data_mutex);
+    g_cond_init(&test.data_cond);
+    test.data_cond_signal = false;
+
+    thread = g_thread_new(NULL, tpm_emu_ctrl_thread, &test);
+    tpm_emu_test_wait_cond(&test);
+
+    memset(&data, 0, sizeof(data));
+    data.machine = c->machine;
+    data.variant = variant;
+
+    args = g_strdup_printf(
+        " -chardev socket,id=chr,path=%s"
+        " -tpmdev emulator,id=dev,chardev=chr"
+        " -device tpm-%s,tpmdev=dev",
+        test.addr->u.q_unix.path, c->tpm_if);
+
+    test_acpi_one(args, &data);
+
+    g_thread_join(thread);
+    g_unlink(test.addr->u.q_unix.path);
+    qapi_free_SocketAddress(test.addr);
+    g_rmdir(tmp_path);
+    g_free(variant);
+    g_free(tmp_path);
+    g_free(tmp_dir_name);
+    free_test_data(&data);
+}
+
 static void test_acpi_tcg_dimm_pxm(const char *machine)
 {
     test_data data;
@@ -1028,6 +1085,7 @@ int main(int argc, char *argv[])
 {
     const char *arch = qtest_get_arch();
     int ret;
+    struct tpm_test_data tpm_q35_tis = {MACHINE_Q35, "tis"};
 
     g_test_init(&argc, &argv, NULL);
 
@@ -1037,6 +1095,8 @@ int main(int argc, char *argv[])
             return ret;
         }
 
+        qtest_add_data_func("acpi/q35/tpm-tis",
+                            &tpm_q35_tis, test_acpi_tcg_tpm);
         qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
         qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
         qtest_add_func("acpi/q35", test_acpi_q35_tcg);
diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
index 9e5a51d033..5023fa413d 100644
--- a/tests/qtest/Makefile.include
+++ b/tests/qtest/Makefile.include
@@ -262,6 +262,7 @@ tests/qtest/hd-geo-test$(EXESUF): tests/qtest/hd-geo-test.o $(libqos-obj-y)
 tests/qtest/boot-order-test$(EXESUF): tests/qtest/boot-order-test.o $(libqos-obj-y)
 tests/qtest/boot-serial-test$(EXESUF): tests/qtest/boot-serial-test.o $(libqos-obj-y)
 tests/qtest/bios-tables-test$(EXESUF): tests/qtest/bios-tables-test.o \
+        tests/qtest/tpm-emu.o $(test-io-obj-y) \
 	tests/qtest/boot-sector.o tests/qtest/acpi-utils.o $(libqos-obj-y)
 tests/qtest/pxe-test$(EXESUF): tests/qtest/pxe-test.o tests/qtest/boot-sector.o $(libqos-obj-y)
 tests/qtest/microbit-test$(EXESUF): tests/qtest/microbit-test.o
-- 
2.20.1


