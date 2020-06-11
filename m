Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE747C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A926C206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVh4miPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A926C206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTW4-0001gV-Qd
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8r-0007qn-Pw
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39005
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8n-00010k-BA
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sLgwJXR/oSCrwqV8wUccJw4DJzCBpLT5U3sULc5EzO4=;
 b=MVh4miPVFmDiwi6M+UR33mLotQYynie5M2ozXVEkc+IIITmfOvO6Dckl+rIBl2hPFhBASC
 Zm3BdFYzQT+sOv0yy976yuta4GbukKGGO9of/tqJ22aPJ8QJa+RJ8qj6KOLkm35WbMUyq6
 Med9au8aOpTW2QyaGS8D18LVyIPVq2k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-4uLDJUozPNi9xe57hQu9sg-1; Thu, 11 Jun 2020 15:45:30 -0400
X-MC-Unique: 4uLDJUozPNi9xe57hQu9sg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70BD619057A0;
 Thu, 11 Jun 2020 19:45:29 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1445F5C1B2;
 Thu, 11 Jun 2020 19:45:29 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 046/115] hax: Dynamic allocate vcpu state structure
Date: Thu, 11 Jun 2020 15:43:40 -0400
Message-Id: <20200611194449.31468-47-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 14:52:10
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
Cc: WangBowen <bowen.wang@intel.com>, Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: WangBowen <bowen.wang@intel.com>

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

V2: Check max_cpus before open vm. (Philippe)

Signed-off-by: WangBowen <bowen.wang@intel.com>
Signed-off-by: Colin Xu <colin.xu@intel.com>
Message-Id: <20200509035952.187615-1-colin.xu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hax-all.c  | 25 +++++++++++++++++++------
 target/i386/hax-i386.h |  5 +++--
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index f9c83fff25..c93bb23a44 100644
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
@@ -245,6 +245,11 @@ struct hax_vm *hax_vm_create(struct hax_state *hax)
         return hax->vm;
     }
 
+    if (max_cpus > HAX_MAX_VCPU) {
+        fprintf(stderr, "Maximum VCPU number QEMU supported is %d\n", HAX_MAX_VCPU);
+        return NULL;
+    }
+
     vm = g_new0(struct hax_vm, 1);
 
     ret = hax_host_create_vm(hax, &vm_id);
@@ -259,6 +264,12 @@ struct hax_vm *hax_vm_create(struct hax_state *hax)
         goto error;
     }
 
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
2.26.2



