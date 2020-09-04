Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5493C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9528120722
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3TmVG1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9528120722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kED9P-00038n-OY
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 10:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kED8U-0001PP-Qb
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:56:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50874
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kED8T-0007Fd-6U
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599231376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/z9vb+EyV5Sv3SSatE4EZlOo7VZJ2a2YjWLkr5W6TfE=;
 b=a3TmVG1ZWJ827wwF+w/vlSpzfhPIBtRT9YWQCcA54XdI5WKvjEXOi2OAqDdtgef+SOY1ho
 6p3Khfg+OvE49Yb7IzpRVUc8RuOO/ApL7QdDOiFW/47JJI+nwQTy3bWRhArPfzHBwLvy9a
 F19ahrqlttmR/CcWW8E0H/IZDaqVz/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-ss_cc6wsOECNYzUG3MVDOg-1; Fri, 04 Sep 2020 10:55:09 -0400
X-MC-Unique: ss_cc6wsOECNYzUG3MVDOg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B34301084D62
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2020 14:55:08 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.194.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 167627E416;
 Fri,  4 Sep 2020 14:55:06 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 18/22] i386: prefer system KVM_GET_SUPPORTED_HV_CPUID
 ioctl over vCPU's one
Date: Fri,  4 Sep 2020 16:54:27 +0200
Message-Id: <20200904145431.196885-19-vkuznets@redhat.com>
In-Reply-To: <20200904145431.196885-1-vkuznets@redhat.com>
References: <20200904145431.196885-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:57:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

KVM_GET_SUPPORTED_HV_CPUID was made a system wide ioctl which can be called
prior to creating vCPUs and we are going to use that to expand Hyper-V cpu
features early. Use it when it is supported by KVM.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/kvm.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 70db2ca26313..b76d4a5a147b 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -940,7 +940,8 @@ static struct {
     },
 };
 
-static struct kvm_cpuid2 *try_get_hv_cpuid(CPUState *cs, int max)
+static struct kvm_cpuid2 *try_get_hv_cpuid(CPUState *cs, int max,
+                                           bool do_sys_ioctl)
 {
     struct kvm_cpuid2 *cpuid;
     int r, size;
@@ -949,7 +950,11 @@ static struct kvm_cpuid2 *try_get_hv_cpuid(CPUState *cs, int max)
     cpuid = g_malloc0(size);
     cpuid->nent = max;
 
-    r = kvm_vcpu_ioctl(cs, KVM_GET_SUPPORTED_HV_CPUID, cpuid);
+    if (do_sys_ioctl) {
+        r = kvm_ioctl(kvm_state, KVM_GET_SUPPORTED_HV_CPUID, cpuid);
+    } else {
+        r = kvm_vcpu_ioctl(cs, KVM_GET_SUPPORTED_HV_CPUID, cpuid);
+    }
     if (r == 0 && cpuid->nent >= max) {
         r = -E2BIG;
     }
@@ -976,13 +981,17 @@ static struct kvm_cpuid2 *get_supported_hv_cpuid(CPUState *cs)
     /* 0x40000000..0x40000005, 0x4000000A, 0x40000080..0x40000080 leaves */
     int max = 10;
     int i;
+    bool do_sys_ioctl;
+
+    do_sys_ioctl =
+        kvm_check_extension(kvm_state, KVM_CAP_SYS_HYPERV_CPUID) > 0;
 
     /*
      * When the buffer is too small, KVM_GET_SUPPORTED_HV_CPUID fails with
      * -E2BIG, however, it doesn't report back the right size. Keep increasing
      * it and re-trying until we succeed.
      */
-    while ((cpuid = try_get_hv_cpuid(cs, max)) == NULL) {
+    while ((cpuid = try_get_hv_cpuid(cs, max, do_sys_ioctl)) == NULL) {
         max++;
     }
 
@@ -992,7 +1001,7 @@ static struct kvm_cpuid2 *get_supported_hv_cpuid(CPUState *cs)
      * information early, just check for the capability and set the bit
      * manually.
      */
-    if (kvm_check_extension(cs->kvm_state,
+    if (!do_sys_ioctl && kvm_check_extension(cs->kvm_state,
                             KVM_CAP_HYPERV_ENLIGHTENED_VMCS) > 0) {
         for (i = 0; i < cpuid->nent; i++) {
             if (cpuid->entries[i].function == HV_CPUID_ENLIGHTMENT_INFO) {
-- 
2.25.4


