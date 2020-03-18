Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4B3C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AF3820752
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9vj5ocN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF3820752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEa63-0004U8-9Z
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 10:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jEa3j-0000oo-NE
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:52:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jEa3h-0008RR-U8
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:52:39 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:31463)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jEa3h-0008O5-PE
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584543157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rEYKOJwzrph5RL5EzIbqa9app5q7N1QY21unZg89cSI=;
 b=Q9vj5ocNo1BEtgaqsJAMeVHNPercUfCERoHZJ2HblolHfqpihe3LVd7+HRPoha/6GesI/f
 WCBf99JvEwLexMNaohtjw2aNoDuMykg19J4t46UboQ0t3Z8a9CoiDihPcHw1U3sjJiYHiL
 Wz052uLEN085SLcgd4fP389iwwr+Wz0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-ZD6MtGpEMW6e7qGPhQY4jA-1; Wed, 18 Mar 2020 10:52:35 -0400
X-MC-Unique: ZD6MtGpEMW6e7qGPhQY4jA-1
Received: by mail-wm1-f72.google.com with SMTP id z16so1147263wmi.2
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 07:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dYyjXqlxd6o+AGz9f66cU6H8IpZBprTaTlkNnYlDx9g=;
 b=OOQCUQH9M/wVFaZqVuWUCy6hat8j5BT+619XT9zbxzRqmX+iWthePBOPXc3wCyHzhC
 Amu2KOF2//IptQQNR7KGA1bTNOZgicEFHrKS12odtVwj3pBcwtJNFYki/P+rqtz45FYx
 OD3cx7Np+OdY0nd5B5Qzvzk/oZc/xCl6KhqM6J55L698AKV9zRFrtCdAjXWUp68lOU2r
 HJFUl6LdNOQ35f6Y+ZN+2BvrYJduGOXipHBKQUCYdGe237MpGNPT/3R6sDrK9C/AYgVn
 fhgS8aHjYTL+6eO+agokRcvh4e+fRRcExtOjqXrD7JJ8ELnUI1J6R4dtdeMcEYrIKNDV
 mWkQ==
X-Gm-Message-State: ANhLgQ2LdzNz1eceD4M7A8iz8KUGR6PJjEgX1TPkrR+oL7Z1aav11wPX
 Z2UAKQ45Uvd0ciwIgPYrXH81YW/I5Q0AH3jHMaGBF9s+1/mUrhTgeRDuMWuMslStkVGX1he4sYo
 VNrHY/7zYURPwehQ=
X-Received: by 2002:adf:f9cd:: with SMTP id w13mr5939760wrr.406.1584543153462; 
 Wed, 18 Mar 2020 07:52:33 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuUmz8/57Uw4aw1IQTwRRP/6nQMhyDB2w8+SLMXrLglpYQkR22PK+qh9rzEaeI4Xku2zmTPPw==
X-Received: by 2002:adf:f9cd:: with SMTP id w13mr5939734wrr.406.1584543153168; 
 Wed, 18 Mar 2020 07:52:33 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id u144sm2582331wmu.39.2020.03.18.07.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2020 07:52:32 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 4/5] KVM: Kick resamplefd for split kernel irqchip
Date: Wed, 18 Mar 2020 10:52:03 -0400
Message-Id: <20200318145204.74483-5-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200318145204.74483-1-peterx@redhat.com>
References: <20200318145204.74483-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, peterx@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 accel/kvm/kvm-all.c    | 79 ++++++++++++++++++++++++++++++++++++++++--
 accel/kvm/trace-events |  1 +
 hw/intc/ioapic.c       | 19 ++++++++++
 include/sysemu/kvm.h   |  4 +++
 4 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d49b74512a..9a85fd1b8f 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -159,9 +159,59 @@ static const KVMCapabilityInfo kvm_required_capabilite=
s[] =3D {
 static NotifierList kvm_irqchip_change_notifiers =3D
     NOTIFIER_LIST_INITIALIZER(kvm_irqchip_change_notifiers);
=20
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
+static QLIST_HEAD(, KVMResampleFd) kvm_resample_fd_list =3D
+    QLIST_HEAD_INITIALIZER(kvm_resample_fd_list);
+
 #define kvm_slots_lock(kml)      qemu_mutex_lock(&(kml)->slots_lock)
 #define kvm_slots_unlock(kml)    qemu_mutex_unlock(&(kml)->slots_lock)
=20
+static inline void kvm_resample_fd_remove(int gsi)
+{
+    KVMResampleFd *rfd;
+
+    QLIST_FOREACH(rfd, &kvm_resample_fd_list, node) {
+        if (rfd->gsi =3D=3D gsi) {
+            QLIST_REMOVE(rfd, node);
+            g_free(rfd);
+            break;
+        }
+    }
+}
+
+static inline void kvm_resample_fd_insert(int gsi, EventNotifier *event)
+{
+    KVMResampleFd *rfd =3D g_new0(KVMResampleFd, 1);
+
+    rfd->gsi =3D gsi;
+    rfd->resample_event =3D event;
+
+    QLIST_INSERT_HEAD(&kvm_resample_fd_list, rfd, node);
+}
+
+void kvm_resample_fd_notify(int gsi)
+{
+    KVMResampleFd *rfd;
+
+    QLIST_FOREACH(rfd, &kvm_resample_fd_list, node) {
+        if (rfd->gsi =3D=3D gsi) {
+            event_notifier_set(rfd->resample_event);
+            trace_kvm_resample_fd_notify(gsi);
+            return;
+        }
+    }
+}
+
 int kvm_get_max_memslots(void)
 {
     KVMState *s =3D KVM_STATE(current_accel());
@@ -1642,8 +1692,33 @@ static int kvm_irqchip_assign_irqfd(KVMState *s, Eve=
ntNotifier *event,
     };
=20
     if (rfd !=3D -1) {
-        irqfd.flags |=3D KVM_IRQFD_FLAG_RESAMPLE;
-        irqfd.resamplefd =3D rfd;
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
+            irqfd.flags |=3D KVM_IRQFD_FLAG_RESAMPLE;
+            irqfd.resamplefd =3D rfd;
+        }
+    } else if (!assign) {
+        if (kvm_irqchip_is_split()) {
+            kvm_resample_fd_remove(virq);
+        }
     }
=20
     if (!kvm_irqfds_enabled()) {
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index 4fb6e59d19..a68eb66534 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -16,4 +16,5 @@ kvm_set_ioeventfd_mmio(int fd, uint64_t addr, uint32_t va=
l, bool assign, uint32_
 kvm_set_ioeventfd_pio(int fd, uint16_t addr, uint32_t val, bool assign, ui=
nt32_t size, bool datamatch) "fd: %d @0x%x val=3D0x%x assign: %d size: %d m=
atch: %d"
 kvm_set_user_memory(uint32_t slot, uint32_t flags, uint64_t guest_phys_add=
r, uint64_t memory_size, uint64_t userspace_addr, int ret) "Slot#%d flags=
=3D0x%x gpa=3D0x%"PRIx64 " size=3D0x%"PRIx64 " ua=3D0x%"PRIx64 " ret=3D%d"
 kvm_clear_dirty_log(uint32_t slot, uint64_t start, uint32_t size) "slot#%"=
PRId32" start 0x%"PRIx64" size 0x%"PRIx32
+kvm_resample_fd_notify(int gsi) "gsi %d"
=20
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 15747fe2c2..b9ec570c03 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -241,6 +241,25 @@ void ioapic_eoi_broadcast(int vector)
                 continue;
             }
=20
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
index 141342de98..583a976f8a 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -555,4 +555,8 @@ int kvm_set_one_reg(CPUState *cs, uint64_t id, void *so=
urce);
 int kvm_get_one_reg(CPUState *cs, uint64_t id, void *target);
 struct ppc_radix_page_info *kvm_get_radix_page_info(void);
 int kvm_get_max_memslots(void);
+
+/* Notify resamplefd for EOI of specific interrupts. */
+void kvm_resample_fd_notify(int gsi);
+
 #endif
--=20
2.24.1


