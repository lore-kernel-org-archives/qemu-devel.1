Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10FAC43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 14:01:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3306C206BB
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 14:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3306C206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59268 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hahKp-000635-6A
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 10:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56707)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hah3H-0007No-3z
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hah3G-00020k-1S
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:43:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46396)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hah3F-0001eh-S7
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:43:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A33DD75725;
 Tue, 11 Jun 2019 13:42:35 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 33431600CD;
 Tue, 11 Jun 2019 13:42:35 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 10:42:24 -0300
Message-Id: <20190611134224.6683-4-ehabkost@redhat.com>
In-Reply-To: <20190611134224.6683-1-ehabkost@redhat.com>
References: <20190611134224.6683-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 11 Jun 2019 13:42:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 3/3] i386: Save EFER for 32-bit targets
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>

i386 (32 bit) emulation uses EFER in wrmsr and in MMU fault
processing.
But it does not included in VMState, because "efer" field is disabled with

This patch adds a section for 32-bit targets which saves EFER when
it's value is non-zero.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Message-Id: <155913371654.8429.1659082639780315242.stgit@pasha-Precision-3630-Tower>
Reviewed-by: Peter Xu <peterx@redhat.com>
[ehabkost: indentation fix]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/machine.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/target/i386/machine.c b/target/i386/machine.c
index 225b5d433b..2c96cfc9a2 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -964,6 +964,27 @@ static const VMStateDescription vmstate_svm_npt = {
     }
 };
 
+#ifndef TARGET_X86_64
+static bool intel_efer32_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return env->efer != 0;
+}
+
+static const VMStateDescription vmstate_efer32 = {
+    .name = "cpu/efer32",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = intel_efer32_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.efer, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+#endif
+
 VMStateDescription vmstate_x86_cpu = {
     .name = "cpu",
     .version_id = 12,
@@ -1089,6 +1110,9 @@ VMStateDescription vmstate_x86_cpu = {
         &vmstate_msr_intel_pt,
         &vmstate_msr_virt_ssbd,
         &vmstate_svm_npt,
+#ifndef TARGET_X86_64
+        &vmstate_efer32,
+#endif
         NULL
     }
 };
-- 
2.18.0.rc1.1.g3f1ff2140


