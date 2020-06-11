Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BE4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EE3D2073E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+SJHO2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE3D2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjUFl-00009M-JZ
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAG-0001bt-RL
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55700
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAE-0001OA-5l
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VOlDszRVFFz87rfQJWUx9nl1C9JGDSXdw5TCSqdQv1E=;
 b=c+SJHO2FR9Sbh5pwQQDbofBXhBKWVKXHdUzKD3StfMBQhXX8p8aRaldighQ6HsZbnx+nrQ
 XRsj++3VaGMg7oRNeZN2UUY9XmE9DeRY58hAZAqqKNL1ECDJ2Fxx1G09Ju+fEQIMJR78uT
 fCL4dPhY8N7FnLM2nDOx5DE8z3MZzsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-nUN0LumTMj6ZOw1sSstVag-1; Thu, 11 Jun 2020 15:46:52 -0400
X-MC-Unique: nUN0LumTMj6ZOw1sSstVag-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4219107ACCA
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 19:46:43 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86F236840E;
 Thu, 11 Jun 2020 19:46:38 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 069/115] KVM: Kick resamplefd for split kernel irqchip
Date: Thu, 11 Jun 2020 15:44:03 -0400
Message-Id: <20200611194449.31468-70-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:37:10
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
Cc: Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Xu <peterx@redhat.com>

This is majorly only for X86 because that's the only one that supports
split irqchip for now.

When the irqchip is split, we face a dilemma that KVM irqfd will be
enabled, however the slow irqchip is still running in the userspace.
It means that the resamplefd in the kernel irqfds won't take any
effect and it will miss to ack INTx interrupts on EOIs.

One example is split irqchip with VFIO INTx, which will break if we
use the VFIO INTx fast path.

This patch can potentially supports the VFIO fast path again for INTx,
that the IRQ delivery will still use the fast path, while we don't
need to trap MMIOs in QEMU for the device to emulate the EIOs (see the
callers of vfio_eoi() hook).  However the EOI of the INTx will still
need to be done from the userspace by caching all the resamplefds in
QEMU and kick properly for IOAPIC EOI broadcast.

This is tricky because in this case the userspace ioapic irr &
remote-irr will be bypassed.  However such a change will greatly boost
performance for assigned devices using INTx irqs (TCP_RR boosts 46%
after this patch applied).

When the userspace is responsible for the resamplefd kickup, don't
register it on the kvm_irqfd anymore, because on newer kernels (after
commit 654f1f13ea56, 5.2+) the KVM_IRQFD will fail if with both split
irqchip and resamplefd.  This will make sure that the fast path will
work for all supported kernels.

https://patchwork.kernel.org/patch/10738541/#22609933

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20200318145204.74483-5-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c    | 79 ++++++++++++++++++++++++++++++++++++++++--
 accel/kvm/trace-events |  1 +
 hw/intc/ioapic.c       | 19 ++++++++++
 include/sysemu/kvm.h   |  4 +++
 4 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b048c10af9..f24d7da783 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -160,9 +160,59 @@ static const KVMCapabilityInfo kvm_required_capabilites[] = {
 static NotifierList kvm_irqchip_change_notifiers =
     NOTIFIER_LIST_INITIALIZER(kvm_irqchip_change_notifiers);
 
+struct KVMResampleFd {
+    int gsi;
+    EventNotifier *resample_event;
+    QLIST_ENTRY(KVMResampleFd) node;
+};
+typedef struct KVMResampleFd KVMResampleFd;
+
+/*
+ * Only used with split irqchip where we need to do the resample fd
+ * kick for the kernel from userspace.
+ */
+static QLIST_HEAD(, KVMResampleFd) kvm_resample_fd_list =
+    QLIST_HEAD_INITIALIZER(kvm_resample_fd_list);
+
 #define kvm_slots_lock(kml)      qemu_mutex_lock(&(kml)->slots_lock)
 #define kvm_slots_unlock(kml)    qemu_mutex_unlock(&(kml)->slots_lock)
 
+static inline void kvm_resample_fd_remove(int gsi)
+{
+    KVMResampleFd *rfd;
+
+    QLIST_FOREACH(rfd, &kvm_resample_fd_list, node) {
+        if (rfd->gsi == gsi) {
+            QLIST_REMOVE(rfd, node);
+            g_free(rfd);
+            break;
+        }
+    }
+}
+
+static inline void kvm_resample_fd_insert(int gsi, EventNotifier *event)
+{
+    KVMResampleFd *rfd = g_new0(KVMResampleFd, 1);
+
+    rfd->gsi = gsi;
+    rfd->resample_event = event;
+
+    QLIST_INSERT_HEAD(&kvm_resample_fd_list, rfd, node);
+}
+
+void kvm_resample_fd_notify(int gsi)
+{
+    KVMResampleFd *rfd;
+
+    QLIST_FOREACH(rfd, &kvm_resample_fd_list, node) {
+        if (rfd->gsi == gsi) {
+            event_notifier_set(rfd->resample_event);
+            trace_kvm_resample_fd_notify(gsi);
+            return;
+        }
+    }
+}
+
 int kvm_get_max_memslots(void)
 {
     KVMState *s = KVM_STATE(current_accel());
@@ -1676,8 +1726,33 @@ static int kvm_irqchip_assign_irqfd(KVMState *s, EventNotifier *event,
     };
 
     if (rfd != -1) {
-        irqfd.flags |= KVM_IRQFD_FLAG_RESAMPLE;
-        irqfd.resamplefd = rfd;
+        assert(assign);
+        if (kvm_irqchip_is_split()) {
+            /*
+             * When the slow irqchip (e.g. IOAPIC) is in the
+             * userspace, KVM kernel resamplefd will not work because
+             * the EOI of the interrupt will be delivered to userspace
+             * instead, so the KVM kernel resamplefd kick will be
+             * skipped.  The userspace here mimics what the kernel
+             * provides with resamplefd, remember the resamplefd and
+             * kick it when we receive EOI of this IRQ.
+             *
+             * This is hackery because IOAPIC is mostly bypassed
+             * (except EOI broadcasts) when irqfd is used.  However
+             * this can bring much performance back for split irqchip
+             * with INTx IRQs (for VFIO, this gives 93% perf of the
+             * full fast path, which is 46% perf boost comparing to
+             * the INTx slow path).
+             */
+            kvm_resample_fd_insert(virq, resample);
+        } else {
+            irqfd.flags |= KVM_IRQFD_FLAG_RESAMPLE;
+            irqfd.resamplefd = rfd;
+        }
+    } else if (!assign) {
+        if (kvm_irqchip_is_split()) {
+            kvm_resample_fd_remove(virq);
+        }
     }
 
     if (!kvm_irqfds_enabled()) {
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index 4fb6e59d19..a68eb66534 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -16,4 +16,5 @@ kvm_set_ioeventfd_mmio(int fd, uint64_t addr, uint32_t val, bool assign, uint32_
 kvm_set_ioeventfd_pio(int fd, uint16_t addr, uint32_t val, bool assign, uint32_t size, bool datamatch) "fd: %d @0x%x val=0x%x assign: %d size: %d match: %d"
 kvm_set_user_memory(uint32_t slot, uint32_t flags, uint64_t guest_phys_addr, uint64_t memory_size, uint64_t userspace_addr, int ret) "Slot#%d flags=0x%x gpa=0x%"PRIx64 " size=0x%"PRIx64 " ua=0x%"PRIx64 " ret=%d"
 kvm_clear_dirty_log(uint32_t slot, uint64_t start, uint32_t size) "slot#%"PRId32" start 0x%"PRIx64" size 0x%"PRIx32
+kvm_resample_fd_notify(int gsi) "gsi %d"
 
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index ffe30dc457..bca71b5934 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -241,6 +241,25 @@ void ioapic_eoi_broadcast(int vector)
                 continue;
             }
 
+#ifdef CONFIG_KVM
+            /*
+             * When IOAPIC is in the userspace while APIC is still in
+             * the kernel (i.e., split irqchip), we have a trick to
+             * kick the resamplefd logic for registered irqfds from
+             * userspace to deactivate the IRQ.  When that happens, it
+             * means the irq bypassed userspace IOAPIC (so the irr and
+             * remote-irr of the table entry should be bypassed too
+             * even if interrupt come).  Still kick the resamplefds if
+             * they're bound to the IRQ, to make sure to EOI the
+             * interrupt for the hardware correctly.
+             *
+             * Note: We still need to go through the irr & remote-irr
+             * operations below because we don't know whether there're
+             * emulated devices that are using/sharing the same IRQ.
+             */
+            kvm_resample_fd_notify(n);
+#endif
+
             if (!(entry & IOAPIC_LVT_REMOTE_IRR)) {
                 continue;
             }
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 3b2250471c..b4174d941c 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -554,4 +554,8 @@ int kvm_set_one_reg(CPUState *cs, uint64_t id, void *source);
 int kvm_get_one_reg(CPUState *cs, uint64_t id, void *target);
 struct ppc_radix_page_info *kvm_get_radix_page_info(void);
 int kvm_get_max_memslots(void);
+
+/* Notify resamplefd for EOI of specific interrupts. */
+void kvm_resample_fd_notify(int gsi);
+
 #endif
-- 
2.26.2



