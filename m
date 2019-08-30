Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A49FC3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 10:14:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9148921721
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 10:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9148921721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3dvM-0000WG-Ju
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 06:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1i3drB-0006fS-Qc
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 06:10:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1i3drA-0005ea-D7
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 06:10:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44872)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1i3drA-0005bM-32; Fri, 30 Aug 2019 06:10:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 46D6F308FBB4;
 Fri, 30 Aug 2019 10:10:11 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-243.ams2.redhat.com [10.36.117.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 13901600F8;
 Fri, 30 Aug 2019 10:10:07 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 30 Aug 2019 12:09:58 +0200
Message-Id: <20190830100959.26615-2-david@redhat.com>
In-Reply-To: <20190830100959.26615-1-david@redhat.com>
References: <20190830100959.26615-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 30 Aug 2019 10:10:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 1/2] tcg: Make probe_write() return a
 pointer to the host page
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

... similar to tlb_vaddr_to_host(); however, allow access to the host
page except when TLB_NOTDIRTY or TLB_MMIO is set.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 accel/tcg/cputlb.c      | 21 ++++++++++++++++-----
 accel/tcg/user-exec.c   |  6 ++++--
 include/exec/exec-all.h |  4 ++--
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 707adf7631..cb969d8372 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1078,11 +1078,11 @@ tb_page_addr_t get_page_addr_code(CPUArchState *e=
nv, target_ulong addr)
 /* Probe for whether the specified guest write access is permitted.
  * If it is not permitted then an exception will be taken in the same
  * way as if this were a real write access (and we will not return).
- * Otherwise the function will return, and there will be a valid
- * entry in the TLB for this access.
+ * If the size is 0 or the page requires I/O access, returns NULL; other=
wise,
+ * returns the address of the host page similar to tlb_vaddr_to_host().
  */
-void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu=
_idx,
-                 uintptr_t retaddr)
+void *probe_write(CPUArchState *env, target_ulong addr, int size, int mm=
u_idx,
+                  uintptr_t retaddr)
 {
     uintptr_t index =3D tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *entry =3D tlb_entry(env, mmu_idx, addr);
@@ -1101,12 +1101,23 @@ void probe_write(CPUArchState *env, target_ulong =
addr, int size, int mmu_idx,
         tlb_addr =3D tlb_addr_write(entry);
     }
=20
+    if (!size) {
+        return NULL;
+    }
+
     /* Handle watchpoints.  */
-    if ((tlb_addr & TLB_WATCHPOINT) && size > 0) {
+    if (tlb_addr & TLB_WATCHPOINT) {
         cpu_check_watchpoint(env_cpu(env), addr, size,
                              env_tlb(env)->d[mmu_idx].iotlb[index].attrs=
,
                              BP_MEM_WRITE, retaddr);
     }
+
+    if (tlb_addr & (TLB_NOTDIRTY | TLB_MMIO)) {
+        /* I/O access */
+        return NULL;
+    }
+
+    return (void *)((uintptr_t)addr + entry->addend);
 }
=20
 void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 625c33f893..5720bf8056 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -188,8 +188,8 @@ static inline int handle_cpu_signal(uintptr_t pc, sig=
info_t *info,
     g_assert_not_reached();
 }
=20
-void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu=
_idx,
-                 uintptr_t retaddr)
+void *probe_write(CPUArchState *env, target_ulong addr, int size, int mm=
u_idx,
+                  uintptr_t retaddr)
 {
     g_assert(-(addr | TARGET_PAGE_MASK) >=3D size);
=20
@@ -202,6 +202,8 @@ void probe_write(CPUArchState *env, target_ulong addr=
, int size, int mmu_idx,
                      retaddr);
         g_assert_not_reached();
     }
+
+    return size ? g2h(addr) : NULL;
 }
=20
 #if defined(__i386__)
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index cbcc85add3..a7893ed16b 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -310,8 +310,8 @@ static inline void tlb_flush_by_mmuidx_all_cpus_synce=
d(CPUState *cpu,
 {
 }
 #endif
-void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu=
_idx,
-                 uintptr_t retaddr);
+void *probe_write(CPUArchState *env, target_ulong addr, int size, int mm=
u_idx,
+                  uintptr_t retaddr);
=20
 #define CODE_GEN_ALIGN           16 /* must be >=3D of the size of a ica=
che line */
=20
--=20
2.21.0


