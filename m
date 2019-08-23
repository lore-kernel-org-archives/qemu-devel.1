Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EAAC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 10:18:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4951021726
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 10:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4951021726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i16eb-0002zD-9X
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 06:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1i16UV-0006oO-41
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 06:08:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1i16UT-0008Ht-Q1
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 06:08:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37010)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1i16UT-0008HN-IM; Fri, 23 Aug 2019 06:08:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C78F285536;
 Fri, 23 Aug 2019 10:08:16 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-2.ams2.redhat.com [10.36.117.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 53B685D6B2;
 Fri, 23 Aug 2019 10:08:14 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 23 Aug 2019 12:07:40 +0200
Message-Id: <20190823100741.9621-9-david@redhat.com>
In-Reply-To: <20190823100741.9621-1-david@redhat.com>
References: <20190823100741.9621-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 23 Aug 2019 10:08:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 8/9] exec.c: Factor out core logic of
 check_watchpoint()
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

We want to perform the same checks in probe_write() to trigger a cpu
exit before doing any modifications. We'll have to pass a PC.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 exec.c                | 23 +++++++++++++++++------
 include/hw/core/cpu.h |  2 ++
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/exec.c b/exec.c
index 1df966d17a..d233a4250b 100644
--- a/exec.c
+++ b/exec.c
@@ -2810,12 +2810,10 @@ static const MemoryRegionOps notdirty_mem_ops =3D=
 {
     },
 };
=20
-/* Generate a debug exception if a watchpoint has been hit.  */
-static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int =
flags)
+void cpu_check_watchpoint(CPUState *cpu, vaddr vaddr, int len,
+                          MemTxAttrs attrs, int flags, uintptr_t ra)
 {
-    CPUState *cpu =3D current_cpu;
     CPUClass *cc =3D CPU_GET_CLASS(cpu);
-    target_ulong vaddr;
     CPUWatchpoint *wp;
=20
     assert(tcg_enabled());
@@ -2826,7 +2824,7 @@ static void check_watchpoint(int offset, int len, M=
emTxAttrs attrs, int flags)
         cpu_interrupt(cpu, CPU_INTERRUPT_DEBUG);
         return;
     }
-    vaddr =3D (cpu->mem_io_vaddr & TARGET_PAGE_MASK) + offset;
+
     vaddr =3D cc->adjust_watchpoint_address(cpu, vaddr, len);
     QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
         if (cpu_watchpoint_address_matches(wp, vaddr, len)
@@ -2851,11 +2849,14 @@ static void check_watchpoint(int offset, int len,=
 MemTxAttrs attrs, int flags)
                 if (wp->flags & BP_STOP_BEFORE_ACCESS) {
                     cpu->exception_index =3D EXCP_DEBUG;
                     mmap_unlock();
-                    cpu_loop_exit(cpu);
+                    cpu_loop_exit_restore(cpu, ra);
                 } else {
                     /* Force execution of one insn next time.  */
                     cpu->cflags_next_tb =3D 1 | curr_cflags();
                     mmap_unlock();
+                    if (ra) {
+                        cpu_restore_state(cpu, ra, true);
+                    }
                     cpu_loop_exit_noexc(cpu);
                 }
             }
@@ -2865,6 +2866,16 @@ static void check_watchpoint(int offset, int len, =
MemTxAttrs attrs, int flags)
     }
 }
=20
+/* Generate a debug exception if a watchpoint has been hit.  */
+static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int =
flags)
+{
+    CPUState *cpu =3D current_cpu;
+    vaddr vaddr;
+
+    vaddr =3D (cpu->mem_io_vaddr & TARGET_PAGE_MASK) + offset;
+    cpu_check_watchpoint(cpu, vaddr, len, attrs, flags, 0);
+}
+
 /* Watchpoint access routines.  Watchpoints are inserted using TLB trick=
s,
    so these check for a hit then pass through to the normal out-of-line
    phys routines.  */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 77fca95a40..3a2d76b32c 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1070,6 +1070,8 @@ static inline bool cpu_breakpoint_test(CPUState *cp=
u, vaddr pc, int mask)
     return false;
 }
=20
+void cpu_check_watchpoint(CPUState *cpu, vaddr vaddr, int len,
+                          MemTxAttrs attrs, int flags, uintptr_t ra);
 int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
                           int flags, CPUWatchpoint **watchpoint);
 int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
--=20
2.21.0


