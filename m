Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A22C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 10:11:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F6D921726
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 10:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F6D921726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i16XU-0002XV-EU
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 06:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1i16UD-0006QR-IJ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 06:08:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1i16UC-00083W-Ay
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 06:08:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45542)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1i16UC-00082j-2b; Fri, 23 Aug 2019 06:08:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5D7EF3064FCF;
 Fri, 23 Aug 2019 10:07:59 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-2.ams2.redhat.com [10.36.117.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E77485D6B2;
 Fri, 23 Aug 2019 10:07:54 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 23 Aug 2019 12:07:35 +0200
Message-Id: <20190823100741.9621-4-david@redhat.com>
In-Reply-To: <20190823100741.9621-1-david@redhat.com>
References: <20190823100741.9621-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 23 Aug 2019 10:07:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 3/9] tcg: Factor out CONFIG_USER_ONLY
 probe_write() from s390x code
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
Cc: Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Cornelia Huck <cohuck@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Factor it out, we'll do some further changes/extensions to both
probe_write() implementations soon. Make sure to allow "size =3D 0".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 accel/tcg/user-exec.c     | 16 ++++++++++++++++
 include/exec/exec-all.h   |  4 ++--
 target/s390x/mem_helper.c |  7 -------
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 897d1571c4..322d49c9b8 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -188,6 +188,22 @@ static inline int handle_cpu_signal(uintptr_t pc, si=
ginfo_t *info,
     g_assert_not_reached();
 }
=20
+void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu=
_idx,
+                 uintptr_t retaddr)
+{
+    CPUState *cpu =3D env_cpu(env);
+    CPUClass *cc;
+
+    if (!guest_addr_valid(addr) ||
+        (size > 0 && !guest_addr_valid(addr + size - 1)) ||
+        page_check_range(addr, size, PAGE_WRITE) < 0) {
+        cc =3D CPU_GET_CLASS(cpu);
+        cc->tlb_fill(cpu, addr, size, MMU_DATA_STORE, MMU_USER_IDX, fals=
e,
+                     retaddr);
+        g_assert_not_reached();
+    }
+}
+
 #if defined(__i386__)
=20
 #if defined(__NetBSD__)
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 135aeaab0d..cbcc85add3 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -260,8 +260,6 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ul=
ong vaddr,
 void tlb_set_page(CPUState *cpu, target_ulong vaddr,
                   hwaddr paddr, int prot,
                   int mmu_idx, target_ulong size);
-void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu=
_idx,
-                 uintptr_t retaddr);
 #else
 static inline void tlb_init(CPUState *cpu)
 {
@@ -312,6 +310,8 @@ static inline void tlb_flush_by_mmuidx_all_cpus_synce=
d(CPUState *cpu,
 {
 }
 #endif
+void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu=
_idx,
+                 uintptr_t retaddr);
=20
 #define CODE_GEN_ALIGN           16 /* must be >=3D of the size of a ica=
che line */
=20
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 4b43440e89..fdff60ce5d 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -2615,12 +2615,6 @@ uint32_t HELPER(cu42)(CPUS390XState *env, uint32_t=
 r1, uint32_t r2, uint32_t m3)
 void probe_write_access(CPUS390XState *env, uint64_t addr, uint64_t len,
                         uintptr_t ra)
 {
-#ifdef CONFIG_USER_ONLY
-    if (!guest_addr_valid(addr) || !guest_addr_valid(addr + len - 1) ||
-        page_check_range(addr, len, PAGE_WRITE) < 0) {
-        s390_program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO, ra);
-    }
-#else
     /* test the actual access, not just any access to the page due to LA=
P */
     while (len) {
         const uint64_t pagelen =3D -(addr | TARGET_PAGE_MASK);
@@ -2630,7 +2624,6 @@ void probe_write_access(CPUS390XState *env, uint64_=
t addr, uint64_t len,
         addr =3D wrap_address(env, addr + curlen);
         len -=3D curlen;
     }
-#endif
 }
=20
 void HELPER(probe_write_access)(CPUS390XState *env, uint64_t addr, uint6=
4_t len)
--=20
2.21.0


