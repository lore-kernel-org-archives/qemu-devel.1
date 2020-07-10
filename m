Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41639C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:17:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AD8A20725
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CseWvVfy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD8A20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtumI-0000B4-Av
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 11:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jtui5-0003fB-7a
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:13:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47563
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jtuhz-0003Nx-GA
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594393982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BjhX2dEfgjwFUWCJn0R79aU8kWqVhy9JiKwWzlHqt0Y=;
 b=CseWvVfyjpM77MdRGOuGACDEqV6pGDWSVMxEE7Me4MU5pNqCaEWYAt1KRtLQA5oXvxNQpk
 pKSXTtSR+Cub7D5TKOH+l9a1odHHQH0e4x3SMgcI7yoShJClcxchU9+HCbcanwRQKne975
 W84km2iIBhiw9atGgdnNN52O1Bxcvik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-jkt7YjdaOFSH7Fo2z-Pz4g-1; Fri, 10 Jul 2020 11:12:58 -0400
X-MC-Unique: jkt7YjdaOFSH7Fo2z-Pz4g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D4E9100CD01;
 Fri, 10 Jul 2020 15:12:57 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-41.ams2.redhat.com [10.36.114.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D0DF1A913;
 Fri, 10 Jul 2020 15:12:53 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFCv2 3/6] s390x/diag: implement diag260
Date: Fri, 10 Jul 2020 17:12:36 +0200
Message-Id: <20200710151239.39370-4-david@redhat.com>
In-Reply-To: <20200710151239.39370-1-david@redhat.com>
References: <20200710151239.39370-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=david@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 04:36:30
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
 "Michael S . Tsirkin" <mst@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's implement diag260 - "Access Certain Virtual Machine Information",
used under z/VM to expose the storage configuration (especially, layout of
storage extends and thereby holes). For now, the returned information is
completely redundant to the information exposed via SCLP.

We want to reuse diag260 in QEMU to implement memory devices - to have a
mechanism to indicate to the guest OS that the initial ram size and the
maximum possible physical address differ.

The Linux kernel supports diag260 (0x10) to query the available memory
since v4.20. Ancient Linux versions used diag 260 (0xc), but stopped doing
so a while ago.

Let's unconditionally implement the new diag, without any migration
checks (e.g., compatibility machine, CPU model). Although a guest OS
could observe this when migrating between QEMU evrsions, it's somewhat
unlikely to ever trigger due to the way diag260 is used within a guest
OS - called only once or twice during boot.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/diag.c        | 51 ++++++++++++++++++++++++++++++++++++++
 target/s390x/internal.h    |  2 ++
 target/s390x/kvm.c         | 11 ++++++++
 target/s390x/misc_helper.c |  6 +++++
 target/s390x/translate.c   |  7 ++++++
 5 files changed, 77 insertions(+)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index be70aecd72..5378fcf582 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -23,6 +23,57 @@
 #include "hw/s390x/pv.h"
 #include "kvm_s390x.h"
 
+void handle_diag_260(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    const ram_addr_t initial_ram_size = ms->ram_size;
+    const uint64_t subcode = env->regs[r3];
+
+    switch (subcode) {
+    case 0xc:
+        /* The first storage extent maps to our initial ram. */
+        env->regs[r1] = initial_ram_size - 1;
+        /* The highest addressable byte maps to the initial ram size for now. */
+        env->regs[r3] = initial_ram_size - 1;
+        break;
+    case 0x10: {
+        ram_addr_t addr, length;
+        uint64_t tmp;
+
+        if (r1 & 1) {
+            s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+            return;
+        }
+
+        addr = env->regs[r1];
+        length = env->regs[r1 + 1];
+        if (!QEMU_IS_ALIGNED(addr, 16) || !QEMU_IS_ALIGNED(length, 16) ||
+            !length) {
+            s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+            return;
+        }
+        if (!address_space_access_valid(&address_space_memory, addr, length,
+                                        true, MEMTXATTRS_UNSPECIFIED)) {
+            s390_program_interrupt(env, PGM_ADDRESSING, ra);
+            return;
+        }
+
+        /* Indicate our initial memory ([0 .. ram_size - 1]) */
+        tmp = cpu_to_be64(0);
+        cpu_physical_memory_write(addr, &tmp, sizeof(tmp));
+        tmp = cpu_to_be64(initial_ram_size - 1);
+        cpu_physical_memory_write(addr + sizeof(tmp), &tmp, sizeof(tmp));
+
+        /* Exactly one entry was stored, it always fits into the area. */
+        env->regs[r3] = 1;
+        setcc(env_archcpu(env), 0);
+        break;
+    }
+    default:
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
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
index 4f6f1e31cd..e3358395f0 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2397,6 +2397,13 @@ static DisasJumpType op_diag(DisasContext *s, DisasOps *o)
     TCGv_i32 r3 = tcg_const_i32(get_field(s, r3));
     TCGv_i32 func_code = tcg_const_i32(get_field(s, i2));
 
+    /*
+     * Diag 0x260 updates the CC - only for some subcodes. Calculate the
+     * current cc, such that the helper can simply overwrite it conditionally.
+     */
+    if (get_field(s, i2) == 0x260) {
+        gen_op_calc_cc(s);
+    }
     gen_helper_diag(cpu_env, r1, r3, func_code);
 
     tcg_temp_free_i32(func_code);
-- 
2.26.2


