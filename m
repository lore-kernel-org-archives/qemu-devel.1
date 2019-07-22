Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C846AC76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 04:00:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B5D42190F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 04:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5D42190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpPUx-0004cD-Hq
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 00:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47263)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.kiszka@siemens.com>) id 1hpPUm-0004Dy-3s
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 00:00:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@siemens.com>) id 1hpPUj-00019z-L9
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 00:00:16 -0400
Received: from david.siemens.de ([192.35.17.14]:35058)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
 id 1hpPUj-00016P-Am
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 00:00:13 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
 by david.siemens.de (8.15.2/8.15.2) with ESMTPS id x6M408Yj028717
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2019 06:00:09 +0200
Received: from [167.87.0.229] ([167.87.0.229])
 by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id x6M408s3025988;
 Mon, 22 Jul 2019 06:00:08 +0200
To: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <bdd53f40-4e60-f3ae-7ec6-162198214953@siemens.com>
Date: Mon, 22 Jul 2019 06:00:08 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 192.35.17.14
Subject: [Qemu-devel] [PATCH] i386/kvm: Do not sync nested state during
 runtime
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
Cc: Liran Alon <liran.alon@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Writing the nested state e.g. after a vmport access can invalidate
important parts of the kernel-internal state, and it is not needed as
well. So leave this out from KVM_PUT_RUNTIME_STATE.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 target/i386/kvm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index ec7870c6af..da98b2cbca 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -3577,12 +3577,12 @@ int kvm_arch_put_registers(CPUState *cpu, int level)
 
     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
 
-    ret = kvm_put_nested_state(x86_cpu);
-    if (ret < 0) {
-        return ret;
-    }
-
     if (level >= KVM_PUT_RESET_STATE) {
+        ret = kvm_put_nested_state(x86_cpu);
+        if (ret < 0) {
+            return ret;
+        }
+
         ret = kvm_put_msr_feature_control(x86_cpu);
         if (ret < 0) {
             return ret;
-- 
2.16.4

