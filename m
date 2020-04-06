Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82F5C2BA18
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 07:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83373206F8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 07:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83373206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLLt2-0006Yz-KL
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 03:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54172)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bowen.wang@intel.com>) id 1jLLsJ-00065m-Th
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 03:08:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bowen.wang@intel.com>) id 1jLLsH-0000s5-P0
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 03:08:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:30278)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bowen.wang@intel.com>)
 id 1jLLsH-0000qV-Ff
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 03:08:49 -0400
IronPort-SDR: 9qGLK1tmL0GQd7637X038lAiyeZUb+mSIdtwx3Fw3PLTaNu8HTh32Bec+aMcmSiWL7L+iRjuNX
 SmU2MLnuuYZg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2020 00:08:45 -0700
IronPort-SDR: SacmigwGlHtEX1eGO7WFX3PTQjuLyOCjjZ6whnwUiy/H+fPqAXzUSk4cBKAQQdGVbEPcRk4nuy
 /JcAtn3HA6JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,350,1580803200"; d="scan'208";a="397413436"
Received: from desktop-do5fptk.sh.intel.com (HELO localhost.localdomain)
 ([10.239.47.198])
 by orsmga004.jf.intel.com with ESMTP; 06 Apr 2020 00:08:44 -0700
From: WangBowen <bowen.wang@intel.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hax: Dynamic allocate vcpu state structure
Date: Mon,  6 Apr 2020 15:06:42 +0800
Message-Id: <20200406070642.3005-1-bowen.wang@intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.136
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
Cc: bowen.wang@intel.com, colin.xu@intel.com, wenchao.wang@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Dynamic allocating vcpu state structure according to smp value to be
more precise and safe. Previously it will alloccate array of fixed size
HAX_MAX_VCPU.

This is achieved by using g_new0 to dynamic allocate the array. The
allocated size is obtained from smp.max_cpus in MachineState. Also, the
size is compared with HAX_MAX_VCPU when creating the vm. The reason for
choosing dynamic array over linked list is because the status is visited
by index all the time.

This will lead to QEMU checking whether the smp value is larger than the
HAX_MAX_VCPU when creating vm, if larger, the process will terminate,
otherwise it will allocate array of size smp to store the status.

Signed-off-by: WangBowen <bowen.wang@intel.com>
---
 target/i386/hax-all.c  | 25 +++++++++++++++++++------
 target/i386/hax-i386.h |  5 +++--
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index a8b6e5aeb8..a22adec5da 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -232,10 +232,10 @@ int hax_init_vcpu(CPUState *cpu)
     return ret;
 }
 
-struct hax_vm *hax_vm_create(struct hax_state *hax)
+struct hax_vm *hax_vm_create(struct hax_state *hax, int max_cpus)
 {
     struct hax_vm *vm;
-    int vm_id = 0, ret;
+    int vm_id = 0, ret, i;
 
     if (hax_invalid_fd(hax->fd)) {
         return NULL;
@@ -259,6 +259,17 @@ struct hax_vm *hax_vm_create(struct hax_state *hax)
         goto error;
     }
 
+    if (max_cpus > HAX_MAX_VCPU) {
+        fprintf(stderr, "Maximum VCPU number QEMU supported is %d\n", HAX_MAX_VCPU);
+        goto error;
+    }
+
+    vm->numvcpus = max_cpus;
+    vm->vcpus = g_new0(struct hax_vcpu_state *, vm->numvcpus);
+    for (i = 0; i < vm->numvcpus; i++) {
+        vm->vcpus[i] = NULL;
+    }
+
     hax->vm = vm;
     return vm;
 
@@ -272,12 +283,14 @@ int hax_vm_destroy(struct hax_vm *vm)
 {
     int i;
 
-    for (i = 0; i < HAX_MAX_VCPU; i++)
+    for (i = 0; i < vm->numvcpus; i++)
         if (vm->vcpus[i]) {
             fprintf(stderr, "VCPU should be cleaned before vm clean\n");
             return -1;
         }
     hax_close_fd(vm->fd);
+    vm->numvcpus = 0;
+    g_free(vm->vcpus);
     g_free(vm);
     hax_global.vm = NULL;
     return 0;
@@ -292,7 +305,7 @@ static void hax_handle_interrupt(CPUState *cpu, int mask)
     }
 }
 
-static int hax_init(ram_addr_t ram_size)
+static int hax_init(ram_addr_t ram_size, int max_cpus)
 {
     struct hax_state *hax = NULL;
     struct hax_qemu_version qversion;
@@ -324,7 +337,7 @@ static int hax_init(ram_addr_t ram_size)
         goto error;
     }
 
-    hax->vm = hax_vm_create(hax);
+    hax->vm = hax_vm_create(hax, max_cpus);
     if (!hax->vm) {
         fprintf(stderr, "Failed to create HAX VM\n");
         ret = -EINVAL;
@@ -352,7 +365,7 @@ static int hax_init(ram_addr_t ram_size)
 
 static int hax_accel_init(MachineState *ms)
 {
-    int ret = hax_init(ms->ram_size);
+    int ret = hax_init(ms->ram_size, (int)ms->smp.max_cpus);
 
     if (ret && (ret != -ENOSPC)) {
         fprintf(stderr, "No accelerator found.\n");
diff --git a/target/i386/hax-i386.h b/target/i386/hax-i386.h
index 54e9d8b057..7d988f81da 100644
--- a/target/i386/hax-i386.h
+++ b/target/i386/hax-i386.h
@@ -47,7 +47,8 @@ struct hax_state {
 struct hax_vm {
     hax_fd fd;
     int id;
-    struct hax_vcpu_state *vcpus[HAX_MAX_VCPU];
+    int numvcpus;
+    struct hax_vcpu_state **vcpus;
 };
 
 #ifdef NEED_CPU_H
@@ -58,7 +59,7 @@ int valid_hax_tunnel_size(uint16_t size);
 /* Host specific functions */
 int hax_mod_version(struct hax_state *hax, struct hax_module_version *version);
 int hax_inject_interrupt(CPUArchState *env, int vector);
-struct hax_vm *hax_vm_create(struct hax_state *hax);
+struct hax_vm *hax_vm_create(struct hax_state *hax, int max_cpus);
 int hax_vcpu_run(struct hax_vcpu_state *vcpu);
 int hax_vcpu_create(int id);
 int hax_sync_vcpu_state(CPUArchState *env, struct vcpu_state_t *state,
-- 
2.24.1


