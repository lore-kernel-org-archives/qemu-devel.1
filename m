Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B529CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:02:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D27520691
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEv91cuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D27520691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjlCB-00075j-Lk
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl2F-0006h6-B8
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:51:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31409
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl2D-0001Rv-Fb
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+G0ztL5ZOa2ltkVXVEVXOCaX0sVGPo+GC+RC0/cszug=;
 b=fEv91cuUkqr7K+NTwRlX8Qkz2e3gGTTCISyduoE/phOsjfJquT1CTApuzKxSHs21XLT/xT
 IbF3s2/xFooO54WCaBxdYxqHG6te5+GgngGeNXm/F85ugjtih7Vw7yYNPbe3MmmC7MSuUu
 EH1HsoCw8VZBfimI20TduA00gjRN99Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-YubPt45WNXS7Tw7jvoeqrA-1; Fri, 12 Jun 2020 10:51:52 -0400
X-MC-Unique: YubPt45WNXS7Tw7jvoeqrA-1
Received: by mail-wr1-f69.google.com with SMTP id o1so3960655wrm.17
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+G0ztL5ZOa2ltkVXVEVXOCaX0sVGPo+GC+RC0/cszug=;
 b=CCff2eEfwBlwT+mE5K33y690s74gqHWSdVqGgBGjJP720d5cYVjIwn7CBVy6XeLAdL
 W/PkgaPMDR3X+YX1flHH/uutxeoq5026r7/0BLX/kUffaR7MGf1Yy2cQ0AmLxbH6BpoK
 krsrJcmyrWMkl3Q1HvTo/HVB949NapHC5sRXPhQAj4Co3iQPHVFmd5s82KVzAz7bnTKx
 FmVmiz6Bzn5jiynNpTepC0bgnI7W4CZufGZTYwgjFmttvcNYrT/bzldn96Fo2qADpPYJ
 goIl2igyp4oq9U8fenX31Lvap8qdZg/ATjEJq3QY7T/XlqaFIdFHp8f42XJxR0dPT+kM
 PE/w==
X-Gm-Message-State: AOAM533sVVTdW0Iw48LYOQrSE4QjrKunKGAyhrzldVxpqi/blkJu2EH4
 CkGP/VaNj3wvkxA/0DgqQ5pHIlmEtY4H4X76uqejo9cAcyNmOi0s3B+6cFrATM+DwSByPMBFOD0
 Cp5MBiYsW1B0cI0A=
X-Received: by 2002:a05:6000:90:: with SMTP id
 m16mr15896951wrx.191.1591973508750; 
 Fri, 12 Jun 2020 07:51:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIMx3ri4Z1ASPPfZghATkqTFJPaLuRgs0Y7/7C32K5//DWFaK0QxJsn+F/tKwbxKq4m6DM8Q==
X-Received: by 2002:a05:6000:90:: with SMTP id
 m16mr15896926wrx.191.1591973508517; 
 Fri, 12 Jun 2020 07:51:48 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id z206sm9557291wmg.30.2020.06.12.07.51.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:51:48 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:51:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 20/58] bios-tables-test: Add Q35/TPM-TIS test
Message-ID: <20200612141917.9446-21-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:07:26
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
 Eric Auger <eric.auger@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

Test tables specific to the TPM-TIS instantiation.
The TPM2 is added in the framework. Also the DSDT
is updated with the TPM. The new function should be
be usable for CRB as well, later one.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

Message-Id: <20200609125409.24179-5-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST


