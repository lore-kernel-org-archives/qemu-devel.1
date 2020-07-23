Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10325C433E8
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 14:27:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3FD620771
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 14:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ha9sQUbc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3FD620771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jycCM-0006OH-Vt
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 10:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1jycBl-0005un-MS
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 10:27:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26262
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1jycBi-0006ua-SD
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 10:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595514429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SbiK5khyVMBu78/mEyApTcqJIqrCQgVVgiOOhaI9VrU=;
 b=Ha9sQUbcpfpQhRJ5ZvFY+FBBlxLHsrKzi1gRXd4q74qwvyuHgcSWXuFgUhqbk9Ksytin5K
 z/SzFAmVtr+tTZXLusQ8JpYkAKHSDQHa9CFuVCXZ58CzQ6kj+WNTPxf2IQZJuo25jTWOBk
 xEypVrSh7tND806Ec0boThPjwKlvEQM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-1wggAiB-PKW_8A4ymTirXw-1; Thu, 23 Jul 2020 10:27:07 -0400
X-MC-Unique: 1wggAiB-PKW_8A4ymTirXw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A991F185BE06;
 Thu, 23 Jul 2020 14:27:05 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 66E9075558;
 Thu, 23 Jul 2020 14:27:03 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] KVM: fix CPU reset wrt HF2_GIF_MASK
Date: Thu, 23 Jul 2020 16:27:01 +0200
Message-Id: <20200723142701.2521161-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 06:04:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

HF2_GIF_MASK is set in env->hflags2 unconditionally on CPU reset
(see x86_cpu_reset()) but when calling KVM_SET_NESTED_STATE,
KVM_STATE_NESTED_GIF_SET is only valid for nSVM as e.g. nVMX code
looks like

if (kvm_state->hdr.vmx.vmxon_pa == -1ull) {
    if (kvm_state->flags & ~KVM_STATE_NESTED_EVMCS)
        return -EINVAL;
}

Also, when adjusting the environment after KVM_GET_NESTED_STATE we
need not reset HF2_GIF_MASK on VMX as e.g. x86_cpu_pending_interrupt()
expects it to be set.

Alternatively, we could've made env->hflags2 SVM-only.

Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
Fixes: b16c0e20c742 ("KVM: add support for AMD nested live migration")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/kvm.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 2b6b7443d273..3c4647fbfbf6 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -3883,7 +3883,9 @@ static int kvm_put_nested_state(X86CPU *cpu)
     } else {
         env->nested_state->flags &= ~KVM_STATE_NESTED_GUEST_MODE;
     }
-    if (env->hflags2 & HF2_GIF_MASK) {
+
+    /* Don't set KVM_STATE_NESTED_GIF_SET on VMX as it is illegal */
+    if (cpu_has_svm(env) && (env->hflags2 & HF2_GIF_MASK)) {
         env->nested_state->flags |= KVM_STATE_NESTED_GIF_SET;
     } else {
         env->nested_state->flags &= ~KVM_STATE_NESTED_GIF_SET;
@@ -3925,10 +3927,14 @@ static int kvm_get_nested_state(X86CPU *cpu)
     } else {
         env->hflags &= ~HF_GUEST_MASK;
     }
-    if (env->nested_state->flags & KVM_STATE_NESTED_GIF_SET) {
-        env->hflags2 |= HF2_GIF_MASK;
-    } else {
-        env->hflags2 &= ~HF2_GIF_MASK;
+
+    /* Keep HF2_GIF_MASK set on !SVM as x86_cpu_pending_interrupt() needs it */
+    if (cpu_has_svm(env)) {
+        if (env->nested_state->flags & KVM_STATE_NESTED_GIF_SET) {
+            env->hflags2 |= HF2_GIF_MASK;
+        } else {
+            env->hflags2 &= ~HF2_GIF_MASK;
+        }
     }
 
     return ret;
-- 
2.25.4


