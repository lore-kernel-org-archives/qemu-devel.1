Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A68EC8300B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:51:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AAA62082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OA/vFlIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AAA62082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU5r4-0001MO-Te
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 05:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5lA-0006Ow-GJ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5l7-000419-28
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45622
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jU5l6-0003xN-Fa
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588239931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MMtvEfv/VUNukcBqRRVBLf0Lsy4fzGg4LYyCZY1jfkU=;
 b=OA/vFlIaEdkkq+YgYBJDBS7Jfxh8ayVsnFubS4okskkSdh5mGQMTCjEhX4boar1jpwfGbq
 GvFBxUv6xiENc71EjE5TJhV3NQqi94D9YhFLKQuofXGF9HQzMeSZfQNwipVz/EKuHxwcLs
 quPciZNr2XBEmk1HuvRekrozRf/Gryo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-G_BeuEz7NOyU0GZ8Dl18zg-1; Thu, 30 Apr 2020 05:45:27 -0400
X-MC-Unique: G_BeuEz7NOyU0GZ8Dl18zg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD705107ACCD;
 Thu, 30 Apr 2020 09:45:25 +0000 (UTC)
Received: from localhost (ovpn-112-226.ams2.redhat.com [10.36.112.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 77A805117E;
 Thu, 30 Apr 2020 09:45:25 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 08/20] s390x: Add SIDA memory ops
Date: Thu, 30 Apr 2020 11:44:33 +0200
Message-Id: <20200430094445.25943-9-cohuck@redhat.com>
In-Reply-To: <20200430094445.25943-1-cohuck@redhat.com>
References: <20200430094445.25943-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:31:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Janosch Frank <frankja@linux.ibm.com>

Protected guests save the instruction control blocks in the SIDA
instead of QEMU/KVM directly accessing the guest's memory.

Let's introduce new functions to access the SIDA.

The memops for doing so are available with KVM_CAP_S390_PROTECTED, so
let's check for that.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200319131921.2367-8-frankja@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.h        |  7 ++++++-
 target/s390x/kvm.c        | 26 ++++++++++++++++++++++++++
 target/s390x/kvm_s390x.h  |  2 ++
 target/s390x/mmu_helper.c | 14 ++++++++++++++
 4 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 1d17709d6e10..035427521cec 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -823,7 +823,12 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, ui=
nt8_t ar, void *hostbuf,
 #define s390_cpu_virt_mem_check_write(cpu, laddr, ar, len)   \
         s390_cpu_virt_mem_rw(cpu, laddr, ar, NULL, len, true)
 void s390_cpu_virt_mem_handle_exc(S390CPU *cpu, uintptr_t ra);
-
+int s390_cpu_pv_mem_rw(S390CPU *cpu, unsigned int offset, void *hostbuf,
+                       int len, bool is_write);
+#define s390_cpu_pv_mem_read(cpu, offset, dest, len)    \
+        s390_cpu_pv_mem_rw(cpu, offset, dest, len, false)
+#define s390_cpu_pv_mem_write(cpu, offset, dest, len)       \
+        s390_cpu_pv_mem_rw(cpu, offset, dest, len, true)
=20
 /* sigp.c */
 int s390_cpu_restart(S390CPU *cpu);
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 1988809ec2e7..0e93778ed15d 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -154,6 +154,7 @@ static int cap_ri;
 static int cap_gs;
 static int cap_hpage_1m;
 static int cap_vcpu_resets;
+static int cap_protected;
=20
 static int active_cmma;
=20
@@ -351,6 +352,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_mem_op =3D kvm_check_extension(s, KVM_CAP_S390_MEM_OP);
     cap_s390_irq =3D kvm_check_extension(s, KVM_CAP_S390_INJECT_IRQ);
     cap_vcpu_resets =3D kvm_check_extension(s, KVM_CAP_S390_VCPU_RESETS);
+    cap_protected =3D kvm_check_extension(s, KVM_CAP_S390_PROTECTED);
=20
     if (!kvm_check_extension(s, KVM_CAP_S390_GMAP)
         || !kvm_check_extension(s, KVM_CAP_S390_COW)) {
@@ -851,6 +853,30 @@ int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t =
ar, void *hostbuf,
     return ret;
 }
=20
+int kvm_s390_mem_op_pv(S390CPU *cpu, uint64_t offset, void *hostbuf,
+                       int len, bool is_write)
+{
+    struct kvm_s390_mem_op mem_op =3D {
+        .sida_offset =3D offset,
+        .size =3D len,
+        .op =3D is_write ? KVM_S390_MEMOP_SIDA_WRITE
+                       : KVM_S390_MEMOP_SIDA_READ,
+        .buf =3D (uint64_t)hostbuf,
+    };
+    int ret;
+
+    if (!cap_mem_op || !cap_protected) {
+        return -ENOSYS;
+    }
+
+    ret =3D kvm_vcpu_ioctl(CPU(cpu), KVM_S390_MEM_OP, &mem_op);
+    if (ret < 0) {
+        error_report("KVM_S390_MEM_OP failed: %s", strerror(-ret));
+        abort();
+    }
+    return ret;
+}
+
 /*
  * Legacy layout for s390:
  * Older S390 KVM requires the topmost vma of the RAM to be
diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
index dea813f45015..6ab17c81b73a 100644
--- a/target/s390x/kvm_s390x.h
+++ b/target/s390x/kvm_s390x.h
@@ -19,6 +19,8 @@ void kvm_s390_vcpu_interrupt(S390CPU *cpu, struct kvm_s39=
0_irq *irq);
 void kvm_s390_access_exception(S390CPU *cpu, uint16_t code, uint64_t te_co=
de);
 int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar, void *hostbuf,
                     int len, bool is_write);
+int kvm_s390_mem_op_pv(S390CPU *cpu, vaddr addr, void *hostbuf, int len,
+                       bool is_write);
 void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t code);
 int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state);
 void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu);
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 0be2f300bbe4..7d9f3059cd50 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -474,6 +474,20 @@ static int translate_pages(S390CPU *cpu, vaddr addr, i=
nt nr_pages,
     return 0;
 }
=20
+int s390_cpu_pv_mem_rw(S390CPU *cpu, unsigned int offset, void *hostbuf,
+                       int len, bool is_write)
+{
+    int ret;
+
+    if (kvm_enabled()) {
+        ret =3D kvm_s390_mem_op_pv(cpu, offset, hostbuf, len, is_write);
+    } else {
+        /* Protected Virtualization is a KVM/Hardware only feature */
+        g_assert_not_reached();
+    }
+    return ret;
+}
+
 /**
  * s390_cpu_virt_mem_rw:
  * @laddr:     the logical start address
--=20
2.21.1


