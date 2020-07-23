Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505AEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 16:09:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CD7F20714
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 16:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVwiVd12"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CD7F20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jydnC-00031n-EF
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 12:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jydmd-0002bN-Qj
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 12:09:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58654
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jydmb-0007jt-FX
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 12:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595520560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IzQjC5zyEdJpnpiP8ZwRR5mEDJfgupI90bAM3my6fbQ=;
 b=iVwiVd12nbC/cGZS66bGn9L2cR7m/NGaiKZtjzYrrnxSEL+THkIQ5aYRfiOhQ5PYYZaMzD
 /Id/CGD/CBoPABpozOmX8EYzSoyaqOiMA0U38sXLl0wEbJmLz6hfqdX3FOENPN3cLQNHiB
 wl8mluIuU2BvtiewZIjYQGwK3VlWid4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-L0Pg9w8FPwChpoOkEwJFPw-1; Thu, 23 Jul 2020 12:09:18 -0400
X-MC-Unique: L0Pg9w8FPwChpoOkEwJFPw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF3799127A
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 16:09:17 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-148.ams2.redhat.com
 [10.36.114.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E4BE69320;
 Thu, 23 Jul 2020 16:09:17 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	pbonzini@redhat.com
Subject: [PATCH] kvm: kvm_init_vcpu take Error pointer
Date: Thu, 23 Jul 2020 17:09:15 +0100
Message-Id: <20200723160915.129069-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Clean up the error handling in kvm_init_vcpu so we can see what went
wrong more easily.

Make it take an Error ** and fill it out with what failed, including
the cpu id, so you can tell if it only fails at a given ID.

Replace the remaining DPRINTF by a trace.

This turns a:
kvm_init_vcpu failed: Invalid argument

into:
kvm_init_vcpu: kvm_get_vcpu failed (256): Invalid argument

and with the trace you then get to see:

19049@1595520414.310107:kvm_init_vcpu index: 169 id: 212
19050@1595520414.310635:kvm_init_vcpu index: 170 id: 256
qemu-system-x86_64: kvm_init_vcpu: kvm_get_vcpu failed (256): Invalid argument

which makes stuff a lot more obvious.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 accel/kvm/kvm-all.c    | 19 ++++++++++++++-----
 accel/kvm/trace-events |  1 +
 accel/stubs/kvm-stub.c |  2 +-
 include/sysemu/kvm.h   |  2 +-
 softmmu/cpus.c         |  6 +-----
 5 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 63ef6af9a1c..0fbece977c7 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -430,17 +430,18 @@ static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id)
     return kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
 }
 
-int kvm_init_vcpu(CPUState *cpu)
+int kvm_init_vcpu(CPUState *cpu, Error **errp)
 {
     KVMState *s = kvm_state;
     long mmap_size;
     int ret;
 
-    DPRINTF("kvm_init_vcpu\n");
+    trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
 
     ret = kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
     if (ret < 0) {
-        DPRINTF("kvm_create_vcpu failed\n");
+        error_setg_errno(errp, -ret, "kvm_init_vcpu: kvm_get_vcpu failed (%lu)",
+                         kvm_arch_vcpu_id(cpu));
         goto err;
     }
 
@@ -451,7 +452,8 @@ int kvm_init_vcpu(CPUState *cpu)
     mmap_size = kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
     if (mmap_size < 0) {
         ret = mmap_size;
-        DPRINTF("KVM_GET_VCPU_MMAP_SIZE failed\n");
+        error_setg_errno(errp, -mmap_size,
+                         "kvm_init_vcpu: KVM_GET_VCPU_MMAP_SIZE failed");
         goto err;
     }
 
@@ -459,7 +461,9 @@ int kvm_init_vcpu(CPUState *cpu)
                         cpu->kvm_fd, 0);
     if (cpu->kvm_run == MAP_FAILED) {
         ret = -errno;
-        DPRINTF("mmap'ing vcpu state failed\n");
+        error_setg_errno(errp, ret,
+                         "kvm_init_vcpu: mmap'ing vcpu state failed (%lu)",
+                         kvm_arch_vcpu_id(cpu));
         goto err;
     }
 
@@ -469,6 +473,11 @@ int kvm_init_vcpu(CPUState *cpu)
     }
 
     ret = kvm_arch_init_vcpu(cpu);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret,
+                         "kvm_init_vcpu: kvm_arch_init_vcpu failed (%lu)",
+                         kvm_arch_vcpu_id(cpu));
+    }
 err:
     return ret;
 }
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index a68eb665343..e15ae8980d3 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -8,6 +8,7 @@ kvm_run_exit(int cpu_index, uint32_t reason) "cpu_index %d, reason %d"
 kvm_device_ioctl(int fd, int type, void *arg) "dev fd %d, type 0x%x, arg %p"
 kvm_failed_reg_get(uint64_t id, const char *msg) "Warning: Unable to retrieve ONEREG %" PRIu64 " from KVM: %s"
 kvm_failed_reg_set(uint64_t id, const char *msg) "Warning: Unable to set ONEREG %" PRIu64 " to KVM: %s"
+kvm_init_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
 kvm_irqchip_commit_routes(void) ""
 kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s vector %d virq %d"
 kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 82f118d2df9..cd573bfe3d9 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -37,7 +37,7 @@ int kvm_destroy_vcpu(CPUState *cpu)
     return -ENOSYS;
 }
 
-int kvm_init_vcpu(CPUState *cpu)
+int kvm_init_vcpu(CPUState *cpu, Error **errp)
 {
     return -ENOSYS;
 }
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index b4174d941c2..410848af514 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -216,7 +216,7 @@ int kvm_has_many_ioeventfds(void);
 int kvm_has_gsi_routing(void);
 int kvm_has_intx_set_mask(void);
 
-int kvm_init_vcpu(CPUState *cpu);
+int kvm_init_vcpu(CPUState *cpu, Error **errp);
 int kvm_cpu_exec(CPUState *cpu);
 int kvm_destroy_vcpu(CPUState *cpu);
 
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index a802e899abb..9725fd9951f 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -1170,11 +1170,7 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
     cpu->can_do_io = 1;
     current_cpu = cpu;
 
-    r = kvm_init_vcpu(cpu);
-    if (r < 0) {
-        error_report("kvm_init_vcpu failed: %s", strerror(-r));
-        exit(1);
-    }
+    kvm_init_vcpu(cpu, &error_fatal);
 
     kvm_init_cpu_signals(cpu);
 
-- 
2.26.2


