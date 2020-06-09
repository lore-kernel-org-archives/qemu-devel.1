Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA49C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 12:57:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C82F2064C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 12:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YkM+XmcB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C82F2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jidoO-0007IW-JM
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 08:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jidn5-0004zb-Er
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 08:55:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39658
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jidn4-0002Wr-Kc
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 08:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591707341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YFqdxsqxrQcpKcHDthetomjSp2XNH0N3qTf+jzelhLI=;
 b=YkM+XmcBMpCopnKJkhn33SXhVbeopHtJGp0fbfhrfLvNycXFA2FshfllUZPZSRDrxPLJB0
 xoD3Avzns9Ga6BOpTG99SajuHOVqIWO66SqfyuSHUpE1v+suYfqb+UZ1D0DPhiFHSp1Myw
 +k2pYbzDRA8VdlIxslqHjRSjVuSR6s4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470--lV7IxsdNNOBjso2eOALQQ-1; Tue, 09 Jun 2020 08:55:35 -0400
X-MC-Unique: -lV7IxsdNNOBjso2eOALQQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FF37872FED;
 Tue,  9 Jun 2020 12:55:34 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A4245C1BD;
 Tue,  9 Jun 2020 12:55:28 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, stefanb@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 mst@redhat.com, shannon.zhaosl@gmail.com, imammedo@redhat.com
Subject: [PATCH v2 4/5] bios-tables-test: Add Q35/TPM-TIS test
Date: Tue,  9 Jun 2020 14:54:08 +0200
Message-Id: <20200609125409.24179-5-eric.auger@redhat.com>
In-Reply-To: <20200609125409.24179-1-eric.auger@redhat.com>
References: <20200609125409.24179-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:44:16
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

v2 -> v3:
- use test_acpi_tcg_tpm() helper and stick to the current
  qtest_add_func model
- hardcode TPM_TIS_ADDR_BASE
---
 tests/qtest/bios-tables-test.c | 58 ++++++++++++++++++++++++++++++++++
 tests/qtest/Makefile.include   |  1 +
 2 files changed, 59 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index c9843829b3..53f104a9c5 100644
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
+static void test_acpi_tcg_tpm(const char *machine, const char *tpm_if,
+                              uint64_t base)
+{
+    gchar *tmp_dir_name = g_strdup_printf("qemu-test_acpi_%s_tcg_%s.XXXXXX",
+                                          machine, tpm_if);
+    char *tmp_path = g_dir_make_tmp(tmp_dir_name, NULL);
+    TestState test;
+    test_data data;
+    GThread *thread;
+    char *args, *variant = g_strdup_printf(".%s", tpm_if);
+
+    tpm_tis_base_addr = base;
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
+    data.machine = machine;
+    data.variant = variant;
+
+    args = g_strdup_printf(
+        " -chardev socket,id=chr,path=%s"
+        " -tpmdev emulator,id=dev,chardev=chr"
+        " -device tpm-%s,tpmdev=dev",
+        test.addr->u.q_unix.path, tpm_if);
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
+static void test_acpi_q35_tcg_tpm_tis(void)
+{
+    test_acpi_tcg_tpm("q35", "tis", 0xFED40000);
+}
+
 static void test_acpi_tcg_dimm_pxm(const char *machine)
 {
     test_data data;
@@ -1037,6 +1094,7 @@ int main(int argc, char *argv[])
             return ret;
         }
 
+        qtest_add_func("acpi/q35/tpm-tis", test_acpi_q35_tcg_tpm_tis);
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


