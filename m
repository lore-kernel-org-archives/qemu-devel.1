Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE11C3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 10:12:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01CB7206BB
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 10:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01CB7206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3dto-0007wW-46
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 06:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1i3drG-0006h9-Mj
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 06:10:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1i3drC-0005o9-SQ
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 06:10:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39960)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1i3drC-0005k7-Ga; Fri, 30 Aug 2019 06:10:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6D276693E7;
 Fri, 30 Aug 2019 10:10:13 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-243.ams2.redhat.com [10.36.117.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A2DF4600F8;
 Fri, 30 Aug 2019 10:10:11 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 30 Aug 2019 12:09:59 +0200
Message-Id: <20190830100959.26615-3-david@redhat.com>
In-Reply-To: <20190830100959.26615-1-david@redhat.com>
References: <20190830100959.26615-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 30 Aug 2019 10:10:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 2/2] tcg: Factor out probe_write() logic
 into probe_access()
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
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's also allow to probe other access types.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 accel/tcg/cputlb.c      | 43 ++++++++++++++++++++++++++++++-----------
 accel/tcg/user-exec.c   | 26 +++++++++++++++++++------
 include/exec/exec-all.h |  9 +++++++--
 3 files changed, 59 insertions(+), 19 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index cb969d8372..abae79650c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1075,30 +1075,51 @@ tb_page_addr_t get_page_addr_code(CPUArchState *e=
nv, target_ulong addr)
     return qemu_ram_addr_from_host_nofail(p);
 }
=20
-/* Probe for whether the specified guest write access is permitted.
- * If it is not permitted then an exception will be taken in the same
- * way as if this were a real write access (and we will not return).
+/*
+ * Probe for whether the specified guest access is permitted. If it is n=
ot
+ * permitted then an exception will be taken in the same way as if this
+ * were a real access (and we will not return).
  * If the size is 0 or the page requires I/O access, returns NULL; other=
wise,
  * returns the address of the host page similar to tlb_vaddr_to_host().
  */
-void *probe_write(CPUArchState *env, target_ulong addr, int size, int mm=
u_idx,
-                  uintptr_t retaddr)
+void *probe_access(CPUArchState *env, target_ulong addr, int size,
+                   MMUAccessType access_type, int mmu_idx, uintptr_t ret=
addr)
 {
     uintptr_t index =3D tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *entry =3D tlb_entry(env, mmu_idx, addr);
-    target_ulong tlb_addr =3D tlb_addr_write(entry);
+    target_ulong tlb_addr;
+    size_t elt_ofs;
+    int wp_access;
=20
     g_assert(-(addr | TARGET_PAGE_MASK) >=3D size);
=20
+    switch (access_type) {
+    case MMU_DATA_LOAD:
+        elt_ofs =3D offsetof(CPUTLBEntry, addr_read);
+        wp_access =3D BP_MEM_READ;
+        break;
+    case MMU_DATA_STORE:
+        elt_ofs =3D offsetof(CPUTLBEntry, addr_write);
+        wp_access =3D BP_MEM_WRITE;
+        break;
+    case MMU_INST_FETCH:
+        elt_ofs =3D offsetof(CPUTLBEntry, addr_code);
+        wp_access =3D BP_MEM_READ;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    tlb_addr =3D tlb_read_ofs(entry, elt_ofs);
+
     if (unlikely(!tlb_hit(tlb_addr, addr))) {
-        if (!VICTIM_TLB_HIT(addr_write, addr)) {
-            tlb_fill(env_cpu(env), addr, size, MMU_DATA_STORE,
-                     mmu_idx, retaddr);
+        if (!victim_tlb_hit(env, mmu_idx, index, elt_ofs,
+                            addr & TARGET_PAGE_MASK)) {
+            tlb_fill(env_cpu(env), addr, size, access_type, mmu_idx, ret=
addr);
             /* TLB resize via tlb_fill may have moved the entry. */
             index =3D tlb_index(env, mmu_idx, addr);
             entry =3D tlb_entry(env, mmu_idx, addr);
         }
-        tlb_addr =3D tlb_addr_write(entry);
+        tlb_addr =3D tlb_read_ofs(entry, elt_ofs);
     }
=20
     if (!size) {
@@ -1109,7 +1130,7 @@ void *probe_write(CPUArchState *env, target_ulong a=
ddr, int size, int mmu_idx,
     if (tlb_addr & TLB_WATCHPOINT) {
         cpu_check_watchpoint(env_cpu(env), addr, size,
                              env_tlb(env)->d[mmu_idx].iotlb[index].attrs=
,
-                             BP_MEM_WRITE, retaddr);
+                             wp_access, retaddr);
     }
=20
     if (tlb_addr & (TLB_NOTDIRTY | TLB_MMIO)) {
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 5720bf8056..71c4bf6477 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -188,17 +188,31 @@ static inline int handle_cpu_signal(uintptr_t pc, s=
iginfo_t *info,
     g_assert_not_reached();
 }
=20
-void *probe_write(CPUArchState *env, target_ulong addr, int size, int mm=
u_idx,
-                  uintptr_t retaddr)
+void *probe_access(CPUArchState *env, target_ulong addr, int size,
+                   MMUAccessType access_type, int mmu_idx, uintptr_t ret=
addr)
 {
+    int flags;
+
     g_assert(-(addr | TARGET_PAGE_MASK) >=3D size);
=20
-    if (!guest_addr_valid(addr) ||
-        page_check_range(addr, size, PAGE_WRITE) < 0) {
+    switch (access_type) {
+    case MMU_DATA_STORE:
+        flags =3D PAGE_WRITE;
+        break;
+    case MMU_DATA_LOAD:
+        flags =3D PAGE_READ;
+        break;
+    case MMU_INST_FETCH:
+        flags =3D PAGE_EXEC;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (!guest_addr_valid(addr) || page_check_range(addr, size, flags) <=
 0) {
         CPUState *cpu =3D env_cpu(env);
         CPUClass *cc =3D CPU_GET_CLASS(cpu);
-
-        cc->tlb_fill(cpu, addr, size, MMU_DATA_STORE, MMU_USER_IDX, fals=
e,
+        cc->tlb_fill(cpu, addr, size, access_type, MMU_USER_IDX, false,
                      retaddr);
         g_assert_not_reached();
     }
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index a7893ed16b..3eaf39cd0d 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -310,8 +310,13 @@ static inline void tlb_flush_by_mmuidx_all_cpus_sync=
ed(CPUState *cpu,
 {
 }
 #endif
-void *probe_write(CPUArchState *env, target_ulong addr, int size, int mm=
u_idx,
-                  uintptr_t retaddr);
+void *probe_access(CPUArchState *env, target_ulong addr, int size,
+                   MMUAccessType access_type, int mmu_idx, uintptr_t ret=
addr);
+static inline void *probe_write(CPUArchState *env, target_ulong addr, in=
t size,
+                                int mmu_idx, uintptr_t retaddr)
+{
+    return probe_access(env, addr, size, MMU_DATA_STORE, mmu_idx, retadd=
r);
+}
=20
 #define CODE_GEN_ALIGN           16 /* must be >=3D of the size of a ica=
che line */
=20
--=20
2.21.0


