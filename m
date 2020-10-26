Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A42BC55178
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:58:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F151722400
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FUQwdCs3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F151722400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX31W-00060p-2f
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 09:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX2uf-0005gb-Mk
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:51:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29675)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX2uS-0001l1-Qv
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603720298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fyb5wCq1HEOQzF67kfL8pkWNWQWj8D5itmbp6XOoDN8=;
 b=FUQwdCs34xcXXboWTyKvNl7juh3cScI/pZbVA/tyDjyNEjGcLBfvhbKEVDUO+W98D5MMNj
 lMIgXGHYar5IYbZg3hEc0/JL/St2xzA/oMMqNcSwhNuvRyQ+tP/J2U0J0iYv+aFSRWv/tE
 0JrudSb18vxUzT2rt/Ak6PNxMoXF06s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-unJU3KchO1SHIJHFhViZuQ-1; Mon, 26 Oct 2020 09:51:36 -0400
X-MC-Unique: unJU3KchO1SHIJHFhViZuQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D928804338;
 Mon, 26 Oct 2020 13:51:34 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D40696EF40;
 Mon, 26 Oct 2020 13:51:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/17] qtest: unbreak non-TCG builds in bios-tables-test
Date: Mon, 26 Oct 2020 09:51:19 -0400
Message-Id: <20201026135131.3006712-6-pbonzini@redhat.com>
In-Reply-To: <20201026135131.3006712-1-pbonzini@redhat.com>
References: <20201026135131.3006712-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Claudio Fontana <cfontana@suse.de>

the tests assume TCG is available, thus breaking
for TCG-only tests, where only the TCG accelerator option
is passed to the QEMU binary.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Claudio Fontana <cfontana@suse.de>
Message-Id: <20201013192123.22632-3-cfontana@suse.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qtest/bios-tables-test.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 3830a40d10..f23a5335a8 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -127,6 +127,9 @@ static void free_test_data(test_data *data)
 {
     int i;
 
+    if (!data->tables) {
+        return;
+    }
     for (i = 0; i < data->tables->len; ++i) {
         cleanup_table_descriptor(&g_array_index(data->tables, AcpiSdtTable, i));
     }
@@ -656,6 +659,13 @@ static void test_acpi_one(const char *params, test_data *data)
     char *args;
     bool use_uefi = data->uefi_fl1 && data->uefi_fl2;
 
+#ifndef CONFIG_TCG
+    if (data->tcg_only) {
+        g_test_skip("TCG disabled, skipping ACPI tcg_only test");
+        return;
+    }
+#endif /* CONFIG_TCG */
+
     if (use_uefi) {
         /*
          * TODO: convert '-drive if=pflash' to new syntax (see e33763be7cd3)
-- 
2.26.2



