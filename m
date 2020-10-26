Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D97C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:19:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC40622242
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFvmWAmL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC40622242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWzaw-0001lJ-AB
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzPG-0002k8-HT
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:07:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56337)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzPA-0006jg-E3
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603706825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=gJZy3kz//wBAQSHK401ir7KhMFQGorLzyO/DPPZAjnI=;
 b=PFvmWAmLpwl3yVFpYePgLqQq4+UF7B0fIpQ0NH7pp5+EXkx2/rh0FHbrlBAl+8Jubnpm9p
 KPfiC2G1Uk9Lq3vkW6mkgkvULrrGciOe3XdsKIvfUKgM6hc2PSB1cmj/kKQbdFsjNwJ1kq
 58xtjNriA3H0nS1nCTusG5rPy2r1uBg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-mOGKAc7ZMduH5s_mzQI80w-1; Mon, 26 Oct 2020 06:07:03 -0400
X-MC-Unique: mOGKAc7ZMduH5s_mzQI80w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D9281009E3D;
 Mon, 26 Oct 2020 10:07:02 +0000 (UTC)
Received: from thuth.com (ovpn-112-104.ams2.redhat.com [10.36.112.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A2328B842;
 Mon, 26 Oct 2020 10:07:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 17/31] fuzz: add a crossover function to generic-fuzzer
Date: Mon, 26 Oct 2020 11:06:18 +0100
Message-Id: <20201026100632.212530-18-thuth@redhat.com>
In-Reply-To: <20201026100632.212530-1-thuth@redhat.com>
References: <20201026100632.212530-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Bulekov <alxndr@bu.edu>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20201023150746.107063-10-alxndr@bu.edu>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/fuzz/generic_fuzz.c | 86 +++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index 6ec20464bd..592b78ffe2 100644
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -810,6 +810,91 @@ static void generic_pre_fuzz(QTestState *s)
     counter_shm_init();
 }
 
+/*
+ * When libfuzzer gives us two inputs to combine, return a new input with the
+ * following structure:
+ *
+ * Input 1 (data1)
+ * SEPARATOR
+ * Clear out the DMA Patterns
+ * SEPARATOR
+ * Disable the pci_read/write instructions
+ * SEPARATOR
+ * Input 2 (data2)
+ *
+ * The idea is to collate the core behaviors of the two inputs.
+ * For example:
+ * Input 1: maps a device's BARs, sets up three DMA patterns, and triggers
+ *          device functionality A
+ * Input 2: maps a device's BARs, sets up one DMA pattern, and triggers device
+ *          functionality B
+ *
+ * This function attempts to produce an input that:
+ * Ouptut: maps a device's BARs, set up three DMA patterns, triggers
+ *          functionality A device, replaces the DMA patterns with a single
+ *          patten, and triggers device functionality B.
+ */
+static size_t generic_fuzz_crossover(const uint8_t *data1, size_t size1, const
+                                     uint8_t *data2, size_t size2, uint8_t *out,
+                                     size_t max_out_size, unsigned int seed)
+{
+    size_t copy_len = 0, size = 0;
+
+    /* Check that we have enough space for data1 and at least part of data2 */
+    if (max_out_size <= size1 + strlen(SEPARATOR) * 3 + 2) {
+        return 0;
+    }
+
+    /* Copy_Len in the first input */
+    copy_len = size1;
+    memcpy(out + size, data1, copy_len);
+    size += copy_len;
+    max_out_size -= copy_len;
+
+    /* Append a separator */
+    copy_len = strlen(SEPARATOR);
+    memcpy(out + size, SEPARATOR, copy_len);
+    size += copy_len;
+    max_out_size -= copy_len;
+
+    /* Clear out the DMA Patterns */
+    copy_len = 1;
+    if (copy_len) {
+        out[size] = OP_CLEAR_DMA_PATTERNS;
+    }
+    size += copy_len;
+    max_out_size -= copy_len;
+
+    /* Append a separator */
+    copy_len = strlen(SEPARATOR);
+    memcpy(out + size, SEPARATOR, copy_len);
+    size += copy_len;
+    max_out_size -= copy_len;
+
+    /* Disable PCI ops. Assume data1 took care of setting up PCI */
+    copy_len = 1;
+    if (copy_len) {
+        out[size] = OP_DISABLE_PCI;
+    }
+    size += copy_len;
+    max_out_size -= copy_len;
+
+    /* Append a separator */
+    copy_len = strlen(SEPARATOR);
+    memcpy(out + size, SEPARATOR, copy_len);
+    size += copy_len;
+    max_out_size -= copy_len;
+
+    /* Copy_Len over the second input */
+    copy_len = MIN(size2, max_out_size);
+    memcpy(out + size, data2, copy_len);
+    size += copy_len;
+    max_out_size -= copy_len;
+
+    return  size;
+}
+
+
 static GString *generic_fuzz_cmdline(FuzzTarget *t)
 {
     GString *cmd_line = g_string_new(TARGET_NAME);
@@ -830,6 +915,7 @@ static void register_generic_fuzz_targets(void)
             .get_init_cmdline = generic_fuzz_cmdline,
             .pre_fuzz = generic_pre_fuzz,
             .fuzz = generic_fuzz,
+            .crossover = generic_fuzz_crossover
     });
 }
 
-- 
2.18.2


