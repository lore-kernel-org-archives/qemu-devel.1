Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88356C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:59:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53A12208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UzRJUaJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A12208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlEvy-0004FB-Ld
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 12:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mtosatti@redhat.com>)
 id 1jlEvG-0003Ob-72
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 12:58:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45365
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mtosatti@redhat.com>)
 id 1jlEvD-00056a-Cz
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 12:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592326729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2naFO3eclxh//d8xCYs/AzrLY0N7rdJ2y7/KIjLVWcw=;
 b=UzRJUaJPme5r91VRJgYXgYtUPsdl17b9wngTILn3mxi8mP8L6hO6zCZx/5Ukkv6tfdL2uY
 DXC92PfwSaA98O6ygwqHnIL128QR7bzTidlFspavE85DxTGPg6//scQiqAOHwy4G+YjONK
 M20z6ZZ/owO48Nbi5QWKCyV+BsFvUXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-5cKJ0fWnNB6C7W_m0zQ0sA-1; Tue, 16 Jun 2020 12:58:48 -0400
X-MC-Unique: 5cKJ0fWnNB6C7W_m0zQ0sA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C09F80F5E5;
 Tue, 16 Jun 2020 16:58:47 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-9.gru2.redhat.com [10.97.112.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF1BF19C79;
 Tue, 16 Jun 2020 16:58:46 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
 id 43FBB41887FC; Tue, 16 Jun 2020 13:58:05 -0300 (-03)
Date: Tue, 16 Jun 2020 13:58:05 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: qemu-devel <qemu-devel@nongnu.org>, kvm-devel <kvm@vger.kernel.org>
Subject: [PATCH v2] kvm: i386: allow TSC to differ by NTP correction bounds
 without TSC scaling
Message-ID: <20200616165805.GA324612@fuller.cnet>
References: <20200615120127.GB224592@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615120127.GB224592@fuller.cnet>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mtosatti@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:45:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


The Linux TSC calibration procedure is subject to small variations
(its common to see +-1 kHz difference between reboots on a given CPU, for example).

So migrating a guest between two hosts with identical processor can fail, in case 
of a small variation in calibrated TSC between them.

Allow a conservative 250ppm error between host TSC and VM TSC frequencies,
rather than requiring an exact match. NTP daemon in the guest can
correct this difference.

Also change migration to accept this bound.

KVM_SET_TSC_KHZ depends on a kernel interface change. Without this change,
the behaviour remains the same: in case of a different frequency 
between host and VM, KVM_SET_TSC_KHZ will fail and QEMU will exit.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---

v2: ensure behaviour is unchanged for older kernels and
    improve changelogs (Paolo)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 34f8387..ad825b1 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -735,26 +735,62 @@ static bool hyperv_enabled(X86CPU *cpu)
          cpu->hyperv_features || cpu->hyperv_passthrough);
 }
 
+/*
+ * Check whether target_freq is within conservative
+ * ntp correctable bounds (250ppm) of freq
+ */
+static inline bool freq_within_bounds(int freq, int target_freq)
+{
+        int max_freq = freq + (freq * 250 / 1000000);
+        int min_freq = freq - (freq * 250 / 1000000);
+
+        if (target_freq >= min_freq && target_freq <= max_freq) {
+                return true;
+        }
+
+        return false;
+}
+
 static int kvm_arch_set_tsc_khz(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
-    int r;
+    int r, cur_freq;
+    bool set_ioctl = false;
 
     if (!env->tsc_khz) {
         return 0;
     }
 
-    r = kvm_check_extension(cs->kvm_state, KVM_CAP_TSC_CONTROL) ?
+    cur_freq = kvm_check_extension(cs->kvm_state, KVM_CAP_GET_TSC_KHZ) ?
+               kvm_vcpu_ioctl(cs, KVM_GET_TSC_KHZ) : -ENOTSUP;
+
+    /*
+     * If TSC scaling is supported, attempt to set TSC frequency.
+     */
+    if (kvm_check_extension(cs->kvm_state, KVM_CAP_TSC_CONTROL)) {
+        set_ioctl = true;
+    }
+
+    /*
+     * If desired TSC frequency is within bounds of NTP correction,
+     * attempt to set TSC frequency.
+     */
+    if (cur_freq != -ENOTSUP && freq_within_bounds(cur_freq, env->tsc_khz)) {
+        set_ioctl = true;
+    }
+
+    r = set_ioctl ?
         kvm_vcpu_ioctl(cs, KVM_SET_TSC_KHZ, env->tsc_khz) :
         -ENOTSUP;
+
     if (r < 0) {
         /* When KVM_SET_TSC_KHZ fails, it's an error only if the current
          * TSC frequency doesn't match the one we want.
          */
-        int cur_freq = kvm_check_extension(cs->kvm_state, KVM_CAP_GET_TSC_KHZ) ?
-                       kvm_vcpu_ioctl(cs, KVM_GET_TSC_KHZ) :
-                       -ENOTSUP;
+        cur_freq = kvm_check_extension(cs->kvm_state, KVM_CAP_GET_TSC_KHZ) ?
+                   kvm_vcpu_ioctl(cs, KVM_GET_TSC_KHZ) :
+                   -ENOTSUP;
         if (cur_freq <= 0 || cur_freq != env->tsc_khz) {
             warn_report("TSC frequency mismatch between "
                         "VM (%" PRId64 " kHz) and host (%d kHz), "


