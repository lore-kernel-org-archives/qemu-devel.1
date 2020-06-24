Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E74C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19CCD2084D
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+T+hXjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19CCD2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo321-00050v-Bn
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 06:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo2za-0000j6-4K
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:50:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60976
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo2zY-000192-9T
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592995855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J0abId/W90zeO0fS4yKO+eD2M9J2AtJsNlz22d9npeE=;
 b=N+T+hXjN8F9zpnRGkfI6UVx02jUiASiWD2AefHJn4fK93I0R+rB/zRH9pabW6gKXX/joXL
 Ju3ap+LQxYnARu8Dkc6WeUA2/PCcYQaHVLu/1hM06tEr1zklz8SS72YB8e+1ccSJYaykI7
 yR+UwZvyB3SQFUMPYXg6kRUYCDnwMRU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-Fq64_ABMO0ainnVBV5Rh4w-1; Wed, 24 Jun 2020 06:50:53 -0400
X-MC-Unique: Fq64_ABMO0ainnVBV5Rh4w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6807E18A8229;
 Wed, 24 Jun 2020 10:50:52 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com
 (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 419CC1DC;
 Wed, 24 Jun 2020 10:50:49 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/31] kvm: support to get/set dirty log initial-all-set
 capability
Date: Wed, 24 Jun 2020 06:50:18 -0400
Message-Id: <20200624105048.375353-1-pbonzini@redhat.com>
In-Reply-To: <20200624104917.375143-1-pbonzini@redhat.com>
References: <20200624104917.375143-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Xu <peterx@redhat.com>, Jay Zhou <jianjay.zhou@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jay Zhou <jianjay.zhou@huawei.com>

Since the new capability KVM_DIRTY_LOG_INITIALLY_SET of
KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 has been introduced in the
kernel, tweak the userspace side to detect and enable this
capability.

Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20200304025554.2159-1-jianjay.zhou@huawei.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f24d7da783..d54a8701d8 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -101,7 +101,7 @@ struct KVMState
     bool kernel_irqchip_required;
     OnOffAuto kernel_irqchip_split;
     bool sync_mmu;
-    bool manual_dirty_log_protect;
+    uint64_t manual_dirty_log_protect;
     /* The man page (and posix) say ioctl numbers are signed int, but
      * they're not.  Linux, glibc and *BSD all treat ioctl numbers as
      * unsigned, and treating them as signed here can break things */
@@ -1995,6 +1995,7 @@ static int kvm_init(MachineState *ms)
     int ret;
     int type = 0;
     const char *kvm_type;
+    uint64_t dirty_log_manual_caps;
 
     s = KVM_STATE(ms->accelerator);
 
@@ -2120,14 +2121,20 @@ static int kvm_init(MachineState *ms)
     s->coalesced_pio = s->coalesced_mmio &&
                        kvm_check_extension(s, KVM_CAP_COALESCED_PIO);
 
-    s->manual_dirty_log_protect =
+    dirty_log_manual_caps =
         kvm_check_extension(s, KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2);
-    if (s->manual_dirty_log_protect) {
-        ret = kvm_vm_enable_cap(s, KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2, 0, 1);
+    dirty_log_manual_caps &= (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE |
+                              KVM_DIRTY_LOG_INITIALLY_SET);
+    s->manual_dirty_log_protect = dirty_log_manual_caps;
+    if (dirty_log_manual_caps) {
+        ret = kvm_vm_enable_cap(s, KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2, 0,
+                                   dirty_log_manual_caps);
         if (ret) {
-            warn_report("Trying to enable KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 "
-                        "but failed.  Falling back to the legacy mode. ");
-            s->manual_dirty_log_protect = false;
+            warn_report("Trying to enable capability %"PRIu64" of "
+                        "KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 but failed. "
+                        "Falling back to the legacy mode. ",
+                        dirty_log_manual_caps);
+            s->manual_dirty_log_protect = 0;
         }
     }
 
-- 
2.26.2



