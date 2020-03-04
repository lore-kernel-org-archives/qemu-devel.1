Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413ECC3F2C6
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 02:57:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16F952073B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 02:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F952073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9KDz-0007zo-8z
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 21:57:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jianjay.zhou@huawei.com>) id 1j9KCr-0006v5-Vo
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 21:56:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jianjay.zhou@huawei.com>) id 1j9KCp-00019Z-OM
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 21:56:21 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3258 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
 id 1j9KCp-0000zp-Cs
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 21:56:19 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id B3FB6199FD87F02F1DFD;
 Wed,  4 Mar 2020 10:56:07 +0800 (CST)
Received: from localhost (10.173.228.206) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Mar 2020
 10:55:57 +0800
From: Jay Zhou <jianjay.zhou@huawei.com>
To: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>
Subject: [PATCH] kvm: support to get/set dirty log initial-all-set capability
Date: Wed, 4 Mar 2020 10:55:54 +0800
Message-ID: <20200304025554.2159-1-jianjay.zhou@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.228.206]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: liu.jinsong@huawei.com, weidong.huang@huawei.com, mst@redhat.com,
 wangxinxin.wang@huawei.com, cohuck@redhat.com, peterx@redhat.com,
 jianjay.zhou@huawei.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since the new capability KVM_DIRTY_LOG_INITIALLY_SET of
KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 has been introduced in the
kernel, tweak the userspace side to detect and enable this
capability.

Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
---
 accel/kvm/kvm-all.c       | 21 ++++++++++++++-------
 linux-headers/linux/kvm.h |  3 +++
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 439a4efe52..45ab25be63 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -100,7 +100,7 @@ struct KVMState
     bool kernel_irqchip_required;
     OnOffAuto kernel_irqchip_split;
     bool sync_mmu;
-    bool manual_dirty_log_protect;
+    uint64_t manual_dirty_log_protect;
     /* The man page (and posix) say ioctl numbers are signed int, but
      * they're not.  Linux, glibc and *BSD all treat ioctl numbers as
      * unsigned, and treating them as signed here can break things */
@@ -1882,6 +1882,7 @@ static int kvm_init(MachineState *ms)
     int ret;
     int type = 0;
     const char *kvm_type;
+    uint64_t dirty_log_manual_caps;
 
     s = KVM_STATE(ms->accelerator);
 
@@ -2007,14 +2008,20 @@ static int kvm_init(MachineState *ms)
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
 
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 265099100e..3cb71c2b19 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -1628,4 +1628,7 @@ struct kvm_hyperv_eventfd {
 #define KVM_HYPERV_CONN_ID_MASK		0x00ffffff
 #define KVM_HYPERV_EVENTFD_DEASSIGN	(1 << 0)
 
+#define KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE    (1 << 0)
+#define KVM_DIRTY_LOG_INITIALLY_SET            (1 << 1)
+
 #endif /* __LINUX_KVM_H */
-- 
2.14.1.windows.1



