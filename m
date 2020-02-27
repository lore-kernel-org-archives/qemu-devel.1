Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE17C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:04:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 196B82469F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hy/1TWUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196B82469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Ma2-0003bs-8u
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 12:04:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j7MX9-0006zZ-Ir
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:01:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j7MX2-00083D-S0
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:01:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58958
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j7MX2-00082w-NV
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:01:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582822863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7uD1dr2E8RBvsBhL/nVR6Olg6jp2ukRHDks/zyFDcL8=;
 b=hy/1TWUzpdrS2ZR0tyDHKKCi02z7bfACWMywGW4sUBBNVAsfi6MNDJDYS5a/FxJXk17IEM
 3RWl0nn1BXp8fLnv6hUvQRRbT1osQkOkeGX5NwaviF+u+yZo6UvsnZELRYBN8P87Nb6A7i
 zEhDBVr0zbW+GWKQ+uDUnvsNrjGHS84=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-2OkbZA5RPJC4IIAL2ZivFQ-1; Thu, 27 Feb 2020 12:00:52 -0500
X-MC-Unique: 2OkbZA5RPJC4IIAL2ZivFQ-1
Received: by mail-qk1-f199.google.com with SMTP id m25so4862288qka.4
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 09:00:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BOwm2l65Skla3Nzoj/ActOtW+sphazq4agnS7MdoDXY=;
 b=If0kdEN+UA7hzrWoSn7CVkGNSCxVJ4AGYaA9ESMjaz07NsGfJpMrTIuxNUmox/gXNi
 VWA4FVhMy2LeQx9DaUMSe1TnAiGyz8BlanKuWsa2cP7KEkcXBQXpq5zXi+h2NbHkh9Nn
 enRCwtV7prHxEuMpInA6+rF3MTr+s43OwK97RD8vsD+m5ydUfjpHxG/cudutTZ4Iux+J
 ClCllfRNlZ3f8e/MJR29PF20CrxHQe8bCYTLkJlcO2HgGgsA2wgdGYN3EVlhFeiC3pTx
 XF8cZiYyv9tbUIPEtGrFDghujLvjBDa5hZGy+136yWVSKeBJNaH4fMMvOJbiNKsn8naC
 cD0g==
X-Gm-Message-State: APjAAAVFJ6dj0kNV7/4/tQuiD2095zI/ZChhwJYah57hynizTMZkIbwC
 MGvWKkS/WbNcYhVHqIt4kHfUv5kV5HuTrGd/KDDFCl5Zoz1Okkv9DOg0VKTKnwC2Hg85kP7plcw
 7Qpt+gCNfGPruw2E=
X-Received: by 2002:a37:d13:: with SMTP id 19mr109882qkn.497.1582822851408;
 Thu, 27 Feb 2020 09:00:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqxKXbwIu5ozQFTJ0Jrio+pilQMixSBxaaEdNeMwAz9ZblanD7uL/Pv+aGUqtTnCiP2vI5OX4w==
X-Received: by 2002:a37:d13:: with SMTP id 19mr109850qkn.497.1582822851062;
 Thu, 27 Feb 2020 09:00:51 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id u2sm3555690qtd.72.2020.02.27.09.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2020 09:00:50 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1.1 4/5] KVM: Kick resamplefd for split kernel irqchip
Date: Thu, 27 Feb 2020 12:00:48 -0500
Message-Id: <20200227170048.236599-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200226225510.217077-1-peterx@redhat.com>
References: 
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 Cornelia Huck <cohuck@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is majorly only for X86 because that's the only one that supports
split irqchip for now.

When the irqchip is split, we face a dilemma that KVM irqfd will be
enabled, however the slow irqchip is still running in the userspace.
It means that the resamplefd in the kernel irqfds won't take any
effect and it can miss to ack INTx interrupts on EOIs.

One example is split irqchip with VFIO INTx, which will break if we
use the VFIO INTx fast path.

This patch can potentially supports the VFIO fast path again for INTx,
that the IRQ delivery will still use the fast path, while we don't
need to trap MMIOs in QEMU for the device to emulate the EIOs (see the
callers of vfio_eoi() hook).  However the EOI of the INTx will still
need to be done from the userspace by caching all the resamplefds in
QEMU and kick properly for IOAPIC EOI broadcast.

When the userspace is responsible for the resamplefd kickup, don't
register it on the kvm_irqfd anymore, because on newer kernels (after
commit 654f1f13ea56, 5.2+) the KVM_IRQFD will fail if with both split
irqchip and resamplefd.  This will make sure that the fast path will
work for all supported kernels.

https://patchwork.kernel.org/patch/10738541/#22609933

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
v1.1 changelog:
- when resamplefd is going to be kicked from userspace, don't register
  it again in KVM_IRQFD.  Tested against upstream kernel.

 accel/kvm/kvm-all.c    | 74 ++++++++++++++++++++++++++++++++++++++++--
 accel/kvm/trace-events |  1 +
 hw/intc/ioapic.c       | 11 +++++--
 include/sysemu/kvm.h   |  4 +++
 4 files changed, 86 insertions(+), 4 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d49b74512a..b766b6e93c 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -159,9 +159,62 @@ static const KVMCapabilityInfo kvm_required_capabilite=
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
+    if (!kvm_irqchip_is_split()) {
+        return;
+    }
+
+    QLIST_FOREACH(rfd, &kvm_resample_fd_list, node) {
+        if (rfd->gsi =3D=3D gsi) {
+            event_notifier_set(rfd->resample_event);
+            trace_kvm_resample_fd_notify(gsi);
+            break;
+        }
+    }
+}
+
 int kvm_get_max_memslots(void)
 {
     KVMState *s =3D KVM_STATE(current_accel());
@@ -1642,8 +1695,25 @@ static int kvm_irqchip_assign_irqfd(KVMState *s, Eve=
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
+             * userspace, resamplefd will not work because the EOI of
+             * the interrupt will be delivered to userspace instead,
+             * the KVM resample fd kick is skipped.  The userspace
+             * needs to remember the resamplefd and kick it when we
+             * receive EOI of this IRQ.
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
index 15747fe2c2..8c75465c62 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -236,8 +236,15 @@ void ioapic_eoi_broadcast(int vector)
         for (n =3D 0; n < IOAPIC_NUM_PINS; n++) {
             entry =3D s->ioredtbl[n];
=20
-            if ((entry & IOAPIC_VECTOR_MASK) !=3D vector ||
-                ((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1) !=3D IOAPIC=
_TRIGGER_LEVEL) {
+            if ((entry & IOAPIC_VECTOR_MASK) !=3D vector) {
+                continue;
+            }
+
+            /* Kick resamplefd if KVM is bypassed */
+            kvm_resample_fd_notify(n);
+
+            if (((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1) !=3D
+                IOAPIC_TRIGGER_LEVEL) {
                 continue;
             }
=20
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 141342de98..b67552c047 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -555,4 +555,8 @@ int kvm_set_one_reg(CPUState *cs, uint64_t id, void *so=
urce);
 int kvm_get_one_reg(CPUState *cs, uint64_t id, void *target);
 struct ppc_radix_page_info *kvm_get_radix_page_info(void);
 int kvm_get_max_memslots(void);
+
+/* Notify resamplefd for EOI of specific level triggered interrupts */
+void kvm_resample_fd_notify(int gsi);
+
 #endif
--=20
2.24.1


