Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA46C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:22:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1039620772
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SljljaII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1039620772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtISu-0003w0-Az
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jtHzc-0004Xu-BF
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:52:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22728
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jtHza-0005Hf-1W
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594245157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lvsml5SkldcIC+94tbIyaovLnNYw/WpFjcjBx3vvPBk=;
 b=SljljaIIKk0NyrsPoBOv3omPwbgk2i9YVI/FXcwJTiwiwmchszk303r6KmMHvSJTJelT/5
 3uSAyd/xHV7wJjMANu8o77hp6IYxA24VIa4Wu4KzlB2ML2KIIh+byMDeIqHlTWhu3Qa/hD
 5fA1+wnL3b5RtoppZofy7gZ5egUh4+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-6k6sN3VPPhKaCTv42SwX9A-1; Wed, 08 Jul 2020 14:52:15 -0400
X-MC-Unique: 6k6sN3VPPhKaCTv42SwX9A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 270D1801E6A;
 Wed,  8 Jul 2020 18:52:14 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-117.ams2.redhat.com [10.36.113.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0ACA87554B;
 Wed,  8 Jul 2020 18:51:52 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 2/5] s390x: implement diag260
Date: Wed,  8 Jul 2020 20:51:32 +0200
Message-Id: <20200708185135.46694-3-david@redhat.com>
In-Reply-To: <20200708185135.46694-1-david@redhat.com>
References: <20200708185135.46694-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's implement the "storage configuration" part of diag260. This diag
is found under z/VM, to indicate usable chunks of memory tot he guest OS.
As I don't have access to documentation, I have no clue what the actual
error cases are, and which other stuff we could eventually query using this
interface. Somebody with access to documentation should fix this. This
implementation seems to work with Linux guests just fine.

The Linux kernel supports diag260 to query the available memory since
v4.20. Older kernels / kvm-unit-tests will later fail to run in such a VM
(with maxmem being defined and bigger than the memory size, e.g., "-m
 2G,maxmem=4G"), just as if support for SCLP storage information is not
implemented. They will fail to detect the actual initial memory size.

This interface allows us to expose the maximum ramsize via sclp
and the initial ramsize via diag260 - without having to mess with the
memory increment size and having to align the initial memory size to it.

This is a preparation for memory device support. We'll unlock the
implementation with a new QEMU machine that supports memory devices.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/diag.c        | 57 ++++++++++++++++++++++++++++++++++++++
 target/s390x/internal.h    |  2 ++
 target/s390x/kvm.c         | 11 ++++++++
 target/s390x/misc_helper.c |  6 ++++
 target/s390x/translate.c   |  4 +++
 5 files changed, 80 insertions(+)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 1a48429564..c3b1e24b2c 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -23,6 +23,63 @@
 #include "hw/s390x/pv.h"
 #include "kvm_s390x.h"
 
+void handle_diag_260(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    const ram_addr_t initial_ram_size = ms->ram_size;
+    const uint64_t subcode = env->regs[r3];
+    S390CPU *cpu = env_archcpu(env);
+    ram_addr_t addr, length;
+    uint64_t tmp;
+
+    /* TODO: Unlock with new QEMU machine. */
+    if (false) {
+        s390_program_interrupt(env, PGM_OPERATION, ra);
+        return;
+    }
+
+    /*
+     * There also seems to be subcode "0xc", which stores the size of the
+     * first chunk and the total size to r1/r2. It's only used by very old
+     * Linux, so don't implement it.
+     */
+    if ((r1 & 1) || subcode != 0x10) {
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        return;
+    }
+    addr = env->regs[r1];
+    length = env->regs[r1 + 1];
+
+    /* FIXME: Somebody with documentation should fix this. */
+    if (!QEMU_IS_ALIGNED(addr, 16) || !QEMU_IS_ALIGNED(length, 16)) {
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        return;
+    }
+
+    /* FIXME: Somebody with documentation should fix this. */
+    if (!length) {
+        setcc(cpu, 3);
+        return;
+    }
+
+    /* FIXME: Somebody with documentation should fix this. */
+    if (!address_space_access_valid(&address_space_memory, addr, length, true,
+                                    MEMTXATTRS_UNSPECIFIED)) {
+        s390_program_interrupt(env, PGM_ADDRESSING, ra);
+        return;
+    }
+
+    /* Indicate our initial memory ([0 .. ram_size - 1]) */
+    tmp = cpu_to_be64(0);
+    cpu_physical_memory_write(addr, &tmp, sizeof(tmp));
+    tmp = cpu_to_be64(initial_ram_size - 1);
+    cpu_physical_memory_write(addr + sizeof(tmp), &tmp, sizeof(tmp));
+
+    /* Exactly one entry was stored. */
+    env->regs[r3] = 1;
+    setcc(cpu, 0);
+}
+
 int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
 {
     uint64_t func = env->regs[r1];
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index b1e0ebf67f..a7a3df9a3b 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -372,6 +372,8 @@ int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
 
 
 /* misc_helper.c */
+void handle_diag_260(CPUS390XState *env, uint64_t r1, uint64_t r3,
+                     uintptr_t ra);
 int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3);
 void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3,
                      uintptr_t ra);
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index f2f75d2a57..d6de3ad86c 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1565,6 +1565,14 @@ static int handle_hypercall(S390CPU *cpu, struct kvm_run *run)
     return ret;
 }
 
+static void kvm_handle_diag_260(S390CPU *cpu, struct kvm_run *run)
+{
+    const uint64_t r1 = (run->s390_sieic.ipa & 0x00f0) >> 4;
+    const uint64_t r3 = run->s390_sieic.ipa & 0x000f;
+
+    handle_diag_260(&cpu->env, r1, r3, 0);
+}
+
 static void kvm_handle_diag_288(S390CPU *cpu, struct kvm_run *run)
 {
     uint64_t r1, r3;
@@ -1614,6 +1622,9 @@ static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
      */
     func_code = decode_basedisp_rs(&cpu->env, ipb, NULL) & DIAG_KVM_CODE_MASK;
     switch (func_code) {
+    case 0x260:
+        kvm_handle_diag_260(cpu, run);
+        break;
     case DIAG_TIMEREVENT:
         kvm_handle_diag_288(cpu, run);
         break;
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 58dbc023eb..d7274eb320 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -116,6 +116,12 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
     uint64_t r;
 
     switch (num) {
+    case 0x260:
+        qemu_mutex_lock_iothread();
+        handle_diag_260(env, r1, r3, GETPC());
+        qemu_mutex_unlock_iothread();
+        r = 0;
+        break;
     case 0x500:
         /* KVM hypercall */
         qemu_mutex_lock_iothread();
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 4f6f1e31cd..6bb8b6e513 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2398,6 +2398,10 @@ static DisasJumpType op_diag(DisasContext *s, DisasOps *o)
     TCGv_i32 func_code = tcg_const_i32(get_field(s, i2));
 
     gen_helper_diag(cpu_env, r1, r3, func_code);
+    /* Only some diags modify the CC. */
+    if (get_field(s, i2) == 0x260) {
+        set_cc_static(s);
+    }
 
     tcg_temp_free_i32(func_code);
     tcg_temp_free_i32(r3);
-- 
2.26.2


