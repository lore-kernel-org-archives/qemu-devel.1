Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0993EC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C3420659
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zi/SQ+W4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C3420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1sHY-0004cR-Tj
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 08:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j1sCP-0003D3-AL
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:37:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j1sCM-0006hw-R3
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:37:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25072
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j1sCL-0006gx-Rh
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:37:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581514621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=prr+xXq0UMhDLa4d53EkNtGWAZ3Cr+6TY7QxrKm2lC8=;
 b=Zi/SQ+W45+DWHNv1k31B22QCribO/Q2jlydGjHxjf2+KmjU/DhAyFZKGsddwHigICCVUsC
 1GtWTWKsV8Gol+rmRM3yrCQO07apgFopNj9EL8zMPQratgWacAi4TBjHNF67vgpKPFLdUi
 Z46duR4WDqaG+eIrPHCLv7ZM7+pPnkI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-LIjZw0XxMIGF_grZB8SA5A-1; Wed, 12 Feb 2020 08:36:59 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF0DDDB24;
 Wed, 12 Feb 2020 13:36:58 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-92.ams2.redhat.com [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D74F519C69;
 Wed, 12 Feb 2020 13:36:54 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 16/16] kvm: Implement region_resize() for atomic memory
 section resizes
Date: Wed, 12 Feb 2020 14:36:01 +0100
Message-Id: <20200212133601.10555-17-david@redhat.com>
In-Reply-To: <20200212133601.10555-1-david@redhat.com>
References: <20200212133601.10555-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: LIjZw0XxMIGF_grZB8SA5A-1
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

virtio-mem wants to resize (esp. grow) memory regions while the guest is
already aware of them and makes use of them. Resizing a KVM slot can
only currently be done by removing it and re-adding it. While the kvm slot
is temporarily removed, VCPUs that try to read from these slots will fault.

Let's inhibit KVM_RUN while performing the resize. Keep it lightweight by
remembering using one bool per VCPU, if the VCPU is executing in the
kernel.

Note1: Instead of implementing region_resize(), we could also inhibit in
begin() and let the VCPUs continue to run in commit(). This would also
handle atomic splitting of memory regions. (I remember a BUG report but
cannot dig up the mail). However, using the region_resize() callback we
can later wire up an ioctl that can perform the resize atomically, and
make the inhibit conditional. Also, this way we inhibit KVM only when
resizing - not on any address space changes. This will not affect existing
RT workloads (resizes currently only happen during reboot or at the
start of an incoming migration).

Note2: We cannot use pause_all_vcpus()/resume_all_vcpus(), as it will
temporarily drop the BQL, which is something most caller cannot deal
with when trying to resize a memory region.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 accel/kvm/kvm-all.c   | 87 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/core/cpu.h |  3 ++
 2 files changed, 90 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index c111312dfd..e24805771c 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -148,6 +148,10 @@ bool kvm_ioeventfd_any_length_allowed;
 bool kvm_msi_use_devid;
 static bool kvm_immediate_exit;
 static hwaddr kvm_max_slot_size =3D ~0;
+static QemuMutex kvm_run_mutex;
+static QemuCond kvm_run_cond;
+static QemuCond kvm_run_inhibit_cond;
+static int kvm_run_inhibited;
=20
 static const KVMCapabilityInfo kvm_required_capabilites[] =3D {
     KVM_CAP_INFO(USER_MEMORY),
@@ -1121,6 +1125,57 @@ static void kvm_region_del(MemoryListener *listener,
     memory_region_unref(section->mr);
 }
=20
+/*
+ * Certain updates (e.g., resizing memory regions) require temporarily rem=
oving
+ * kvm memory slots. Avoid any VCPU to fault by making sure all VCPUs
+ * left KVM_RUN and won't enter it again until unblocked.
+ */
+static void kvm_run_inhibit_begin(void)
+{
+    CPUState *cpu;
+
+    atomic_inc(&kvm_run_inhibited);
+    while (true) {
+        bool any_in_kernel =3D false;
+
+        CPU_FOREACH(cpu) {
+            if (atomic_read(&cpu->in_kernel)) {
+                any_in_kernel =3D true;
+                qemu_cpu_kick(cpu);
+            }
+        }
+        if (!any_in_kernel) {
+            break;
+        }
+        qemu_mutex_lock(&kvm_run_mutex);
+        qemu_cond_wait(&kvm_run_inhibit_cond, &kvm_run_mutex);
+        qemu_mutex_unlock(&kvm_run_mutex);
+    }
+}
+
+static void kvm_run_inhibit_end(void)
+{
+    atomic_dec(&kvm_run_inhibited);
+    qemu_mutex_lock(&kvm_run_mutex);
+    qemu_cond_broadcast(&kvm_run_cond);
+    qemu_mutex_unlock(&kvm_run_mutex);
+}
+
+static void kvm_region_resize(MemoryListener *listener,
+                              MemoryRegionSection *section, Int128 new)
+{
+    KVMMemoryListener *kml =3D container_of(listener, KVMMemoryListener, l=
istener);
+    MemoryRegionSection new_section =3D *section;
+
+    new_section.size =3D new;
+
+    /* Inhibit KVM while we temporarily remove slots. */
+    kvm_run_inhibit_begin();
+    kvm_set_phys_mem(kml, section, false);
+    kvm_set_phys_mem(kml, &new_section, true);
+    kvm_run_inhibit_end();
+}
+
 static void kvm_log_sync(MemoryListener *listener,
                          MemoryRegionSection *section)
 {
@@ -1239,6 +1294,7 @@ void kvm_memory_listener_register(KVMState *s, KVMMem=
oryListener *kml,
=20
     kml->listener.region_add =3D kvm_region_add;
     kml->listener.region_del =3D kvm_region_del;
+    kml->listener.region_resize =3D kvm_region_resize;
     kml->listener.log_start =3D kvm_log_start;
     kml->listener.log_stop =3D kvm_log_stop;
     kml->listener.log_sync =3D kvm_log_sync;
@@ -1884,6 +1940,9 @@ static int kvm_init(MachineState *ms)
     assert(TARGET_PAGE_SIZE <=3D qemu_real_host_page_size);
=20
     s->sigmask_len =3D 8;
+    qemu_mutex_init(&kvm_run_mutex);
+    qemu_cond_init(&kvm_run_cond);
+    qemu_cond_init(&kvm_run_inhibit_cond);
=20
 #ifdef KVM_CAP_SET_GUEST_DEBUG
     QTAILQ_INIT(&s->kvm_sw_breakpoints);
@@ -2294,6 +2353,29 @@ static void kvm_eat_signals(CPUState *cpu)
     } while (sigismember(&chkset, SIG_IPI));
 }
=20
+static void kvm_set_cpu_in_kernel(CPUState *cpu, bool in_kernel)
+{
+    atomic_set(&cpu->in_kernel, in_kernel);
+    if (in_kernel) {
+        /* wait until KVM_RUN is no longer inhibited */
+        while (unlikely(atomic_read(&kvm_run_inhibited))) {
+            atomic_set(&cpu->in_kernel, false);
+            qemu_mutex_lock(&kvm_run_mutex);
+            qemu_cond_broadcast(&kvm_run_inhibit_cond);
+            qemu_cond_wait(&kvm_run_cond, &kvm_run_mutex);
+            qemu_mutex_unlock(&kvm_run_mutex);
+            atomic_set(&cpu->in_kernel, true);
+        }
+    } else {
+        /* wake up somebody wanting to inhibit KVM_RUN */
+        if (unlikely(atomic_read(&kvm_run_inhibited))) {
+            qemu_mutex_lock(&kvm_run_mutex);
+            qemu_cond_broadcast(&kvm_run_inhibit_cond);
+            qemu_mutex_unlock(&kvm_run_mutex);
+        }
+    }
+}
+
 int kvm_cpu_exec(CPUState *cpu)
 {
     struct kvm_run *run =3D cpu->kvm_run;
@@ -2318,6 +2400,9 @@ int kvm_cpu_exec(CPUState *cpu)
         }
=20
         kvm_arch_pre_run(cpu, run);
+
+        kvm_set_cpu_in_kernel(cpu, true);
+
         if (atomic_read(&cpu->exit_request)) {
             DPRINTF("interrupt exit requested\n");
             /*
@@ -2335,6 +2420,8 @@ int kvm_cpu_exec(CPUState *cpu)
=20
         run_ret =3D kvm_vcpu_ioctl(cpu, KVM_RUN, 0);
=20
+        kvm_set_cpu_in_kernel(cpu, false);
+
         attrs =3D kvm_arch_post_run(cpu, run);
=20
 #ifdef KVM_HAVE_MCE_INJECTION
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 73e9a869a4..83614e537b 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -431,6 +431,9 @@ struct CPUState {
     /* shared by kvm, hax and hvf */
     bool vcpu_dirty;
=20
+    /* kvm only for now: VCPU is executing in the kernel (KVM_RUN) */
+    bool in_kernel;
+
     /* Used to keep track of an outstanding cpu throttle thread for migrat=
ion
      * autoconverge
      */
--=20
2.24.1


