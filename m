Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534CCC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF8622076A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kvx3fgFL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8622076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL1QT-0003DH-2d
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 05:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kL1Mn-0006hw-CW
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:47:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34040)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kL1Ml-0007Vv-Kc
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600854431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F8R3RVawSIm8OmJ5LeYmowDznkJl7w8B8Dhm7a4s96c=;
 b=Kvx3fgFLut5AC+kdbMWQ69Xf17ZxnC9WzcICiTX8a6HqrBYDw7MKCijC2hteZvPLcVp2dt
 4Pw9fhQ4rleihpAHf2NdMw3S7R7Ddaw08J9k8UlJOCn1xGtiypDipQzPuz1ISX3NwXGqy2
 tFmHRKo5W+cgqrfcXbhR6mkWf7yxHA4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-KRh45rnuPTCy5KQjLeRCjw-1; Wed, 23 Sep 2020 05:47:09 -0400
X-MC-Unique: KRh45rnuPTCy5KQjLeRCjw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07D98801FDA;
 Wed, 23 Sep 2020 09:47:08 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D451455778;
 Wed, 23 Sep 2020 09:47:06 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 04/11] acpi: add aml_land() and aml_break() primitives
Date: Wed, 23 Sep 2020 05:46:43 -0400
Message-Id: <20200923094650.1301166-5-imammedo@redhat.com>
In-Reply-To: <20200923094650.1301166-1-imammedo@redhat.com>
References: <20200923094650.1301166-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 lersek@redhat.com, ankur.a.arora@oracle.com, mst@redhat.com
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


