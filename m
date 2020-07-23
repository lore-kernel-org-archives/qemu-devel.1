Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF8BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 19:15:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02408206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 19:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLtn9Yjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02408206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyggV-0008PC-5s
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 15:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jygey-00078m-UY
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 15:13:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48247
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jygex-0007Bo-98
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 15:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595531618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nwYiAhxMFkOvsBJX+XqxypmlL4Wu8kSVy3Gu13zZbkw=;
 b=aLtn9Yjy4wayVrkVD4TxuJDHUd+NS66w6Cqx352HhRhQ07gOJ/d4DmTZOj/8dnqpU69LMD
 PGJ0QjEB1JGHG4GPhU5QZ4luNIjRyTKRnGD0CMXBd/Vc5OXYkD+hkesp+mZfPuGc0gv88l
 iw+j0bTnHvm9DerfyFIcVb3NUyypEgs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-S_Fl3wujOCCiSalr8fJhrg-1; Thu, 23 Jul 2020 15:13:34 -0400
X-MC-Unique: S_Fl3wujOCCiSalr8fJhrg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 230FB800688;
 Thu, 23 Jul 2020 19:13:33 +0000 (UTC)
Received: from localhost (unknown [10.10.67.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C121F512FE;
 Thu, 23 Jul 2020 19:13:32 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/1] KVM: fix CPU reset wrt HF2_GIF_MASK
Date: Thu, 23 Jul 2020 15:13:27 -0400
Message-Id: <20200723191327.3003969-2-ehabkost@redhat.com>
In-Reply-To: <20200723191327.3003969-1-ehabkost@redhat.com>
References: <20200723191327.3003969-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:33:29
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
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vitaly Kuznetsov <vkuznets@redhat.com>

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
Message-Id: <20200723142701.2521161-1-vkuznets@redhat.com>
Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/kvm.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index b8455c89ed..6f18d940a5 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -3877,7 +3877,9 @@ static int kvm_put_nested_state(X86CPU *cpu)
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
@@ -3919,10 +3921,14 @@ static int kvm_get_nested_state(X86CPU *cpu)
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
2.26.2


