Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C65C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 12:43:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5911208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 12:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5911208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53659 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVxvp-0002MB-RK
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 08:43:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hVxu4-0001EC-4Q
	for qemu-devel@nongnu.org; Wed, 29 May 2019 08:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hVxu3-0004ba-8a
	for qemu-devel@nongnu.org; Wed, 29 May 2019 08:42:00 -0400
Received: from mail.ispras.ru ([83.149.199.45]:56908)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hVxu3-0004aN-2R
	for qemu-devel@nongnu.org; Wed, 29 May 2019 08:41:59 -0400
Received: from [127.0.1.1] (unknown [85.142.117.226])
	by mail.ispras.ru (Postfix) with ESMTPSA id C71DF540081;
	Wed, 29 May 2019 15:41:56 +0300 (MSK)
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 29 May 2019 15:41:56 +0300
Message-ID: <155913371654.8429.1659082639780315242.stgit@pasha-Precision-3630-Tower>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: [Qemu-devel] [PATCH] target/i386: save EFER for 32-bit targets
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pbonzini@redhat.com, dovgaluk@ispras.ru, ehabkost@redhat.com,
	pavel.dovgaluk@ispras.ru, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

i386 (32 bit) emulation uses EFER in wrmsr and in MMU fault
processing.
But it does not included in VMState, because "efer" field is disabled with
#ifdef TARGET_X86_64

This patch adds a section for 32-bit targets which saves EFER when
it's value is non-zero.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 target/i386/machine.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/target/i386/machine.c b/target/i386/machine.c
index 225b5d433b..b5bfc5803e 100644
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
+   .needed = intel_efer32_needed,
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


