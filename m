Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CD1C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 13:57:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F6202071E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 13:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8n25+HL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6202071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNcbh-0007Du-OM
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 09:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kNcMp-0006Nt-Pd
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 09:42:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52893)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kNcMb-0005eJ-6D
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 09:41:59 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601473301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cb7AYxa52bczCra2WNWtZH3Ub0GdlJaxkEkTO/fkjMo=;
 b=M8n25+HL6+NzZjWA/3OV8PrRQdrAIp93ttFbFCdjop9MrCFr+u6SJcJzMKt+c2u6lfBaKf
 m49oVEyBQ8VZb2jmfRCzpCAMDRQ9EH/Y1cDIjolKwyq4J2MoQUrr2cHNcxjTF3zbr4UO5w
 CViDTlmRD96gvaTmDQqFn4JFg6kzaiw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-XvAb72UqMo-Q3DvCWxIXYA-1; Wed, 30 Sep 2020 09:41:39 -0400
X-MC-Unique: XvAb72UqMo-Q3DvCWxIXYA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9542F1868416
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 13:41:38 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.194.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6458460C05;
 Wed, 30 Sep 2020 13:41:37 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v2 17/19] i386: prefer system KVM_GET_SUPPORTED_HV_CPUID
 ioctl over vCPU's one
Date: Wed, 30 Sep 2020 15:40:25 +0200
Message-Id: <20200930134027.1348021-18-vkuznets@redhat.com>
In-Reply-To: <20200930134027.1348021-1-vkuznets@redhat.com>
References: <20200930134027.1348021-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
index 39a6e89dbb60..af59b5f1a935 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -942,7 +942,8 @@ static struct {
     },
 };
 
-static struct kvm_cpuid2 *try_get_hv_cpuid(CPUState *cs, int max)
+static struct kvm_cpuid2 *try_get_hv_cpuid(CPUState *cs, int max,
+                                           bool do_sys_ioctl)
 {
     struct kvm_cpuid2 *cpuid;
     int r, size;
@@ -951,7 +952,11 @@ static struct kvm_cpuid2 *try_get_hv_cpuid(CPUState *cs, int max)
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
@@ -978,13 +983,17 @@ static struct kvm_cpuid2 *get_supported_hv_cpuid(CPUState *cs)
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
 
@@ -994,7 +1003,7 @@ static struct kvm_cpuid2 *get_supported_hv_cpuid(CPUState *cs)
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


