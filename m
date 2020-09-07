Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49917C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:42:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD169207C3
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTM4QYnU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD169207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFFXK-0008QH-MV
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 07:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kFFFj-0005Gp-JG
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:24:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37951
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kFFFh-0001OK-Q5
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599477841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F8R3RVawSIm8OmJ5LeYmowDznkJl7w8B8Dhm7a4s96c=;
 b=aTM4QYnUVPW3ImlhdnIUEHS+RNaFN7dE9lpXferQhtSdBG0WFUOlMoawclIQtxwgoSsfNl
 hHj29z+7KVfzG9Vbg+CPFqg/20cCZmzhTLBMpa8accJnOkAPF6d4USnZtM+clpgJj67JMp
 FjHhfSVtlk11Zu9y1h7rFfSZD4hDXcg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-4cVfvmWjNFKm6QovhKbATA-1; Mon, 07 Sep 2020 07:23:57 -0400
X-MC-Unique: 4cVfvmWjNFKm6QovhKbATA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E32F805EE4;
 Mon,  7 Sep 2020 11:23:56 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3CA8F5D9D2;
 Mon,  7 Sep 2020 11:23:55 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 04/10] acpi: add aml_land() and aml_break() primitives
Date: Mon,  7 Sep 2020 07:23:42 -0400
Message-Id: <20200907112348.530921-5-imammedo@redhat.com>
In-Reply-To: <20200907112348.530921-1-imammedo@redhat.com>
References: <20200907112348.530921-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:05:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 boris.ostrovsky@oracle.com, lersek@redhat.com, aaron.young@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>
---
v5:
 - fix comment to match spec (Laszlo Ersek <lersek@redhat.com>)
 - reorder aml_lor() and aml_land() in header (Laszlo Ersek <lersek@redhat.com>)
---
 include/hw/acpi/aml-build.h |  2 ++
 hw/acpi/aml-build.c         | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index d27da03d64..fe0055fffb 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -290,6 +290,7 @@ Aml *aml_to_buffer(Aml *src, Aml *dst);
 Aml *aml_store(Aml *val, Aml *target);
 Aml *aml_and(Aml *arg1, Aml *arg2, Aml *dst);
 Aml *aml_or(Aml *arg1, Aml *arg2, Aml *dst);
+Aml *aml_land(Aml *arg1, Aml *arg2);
 Aml *aml_lor(Aml *arg1, Aml *arg2);
 Aml *aml_shiftleft(Aml *arg1, Aml *count);
 Aml *aml_shiftright(Aml *arg1, Aml *count, Aml *dst);
@@ -300,6 +301,7 @@ Aml *aml_increment(Aml *arg);
 Aml *aml_decrement(Aml *arg);
 Aml *aml_index(Aml *arg1, Aml *idx);
 Aml *aml_notify(Aml *arg1, Aml *arg2);
+Aml *aml_break(void);
 Aml *aml_call0(const char *method);
 Aml *aml_call1(const char *method, Aml *arg1);
 Aml *aml_call2(const char *method, Aml *arg1, Aml *arg2);
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index f6fbc9b95d..3792ba96ce 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -556,6 +556,15 @@ Aml *aml_or(Aml *arg1, Aml *arg2, Aml *dst)
     return build_opcode_2arg_dst(0x7D /* OrOp */, arg1, arg2, dst);
 }
 
+/* ACPI 1.0b: 16.2.5.4 Type 2 Opcodes Encoding: DefLAnd */
+Aml *aml_land(Aml *arg1, Aml *arg2)
+{
+    Aml *var = aml_opcode(0x90 /* LAndOp */);
+    aml_append(var, arg1);
+    aml_append(var, arg2);
+    return var;
+}
+
 /* ACPI 1.0b: 16.2.5.4 Type 2 Opcodes Encoding: DefLOr */
 Aml *aml_lor(Aml *arg1, Aml *arg2)
 {
@@ -629,6 +638,13 @@ Aml *aml_notify(Aml *arg1, Aml *arg2)
     return var;
 }
 
+/* ACPI 1.0b: 16.2.5.3 Type 1 Opcodes Encoding: DefBreak */
+Aml *aml_break(void)
+{
+    Aml *var = aml_opcode(0xa5 /* BreakOp */);
+    return var;
+}
+
 /* helper to call method without argument */
 Aml *aml_call0(const char *method)
 {
-- 
2.27.0


