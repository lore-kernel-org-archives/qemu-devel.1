Received: from eggs.gnu.org ([2001:4830:134:3::10]:46280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eK8wv-00069D-BL
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 15:27:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eK8ws-0007sB-RZ
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 15:27:17 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 29 Nov 2017 21:26:48 +0100
Message-Id: <20171129202701.16117-4-david@redhat.com>
In-Reply-To: <20171129202701.16117-1-david@redhat.com>
References: <20171129202701.16117-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.12 03/16] s390x/tcg: rip out dead tpi
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

It is broken and not even wired up. We'll add a new handler soon, but
that will live somewhere else.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/css.c          |  6 ------
 include/hw/s390x/css.h  |  1 -
 target/s390x/internal.h |  1 -
 target/s390x/ioinst.c   | 26 --------------------------
 4 files changed, 34 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index f6b5c807cd..6bd0fedc78 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1723,12 +1723,6 @@ void css_undo_stcrw(CRW *crw)
     QTAILQ_INSERT_HEAD(&channel_subsys.pending_crws, crw_cont, sibling);
 }
 
-int css_do_tpi(IOIntCode *int_code, int lowcore)
-{
-    /* No pending interrupts for !KVM. */
-    return 0;
- }
-
 int css_collect_chp_desc(int m, uint8_t cssid, uint8_t f_chpid, uint8_t l_chpid,
                          int rfmt, void *buf)
 {
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index ab6ebe66b5..0a14f76fea 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -248,7 +248,6 @@ int css_do_tsch_get_irb(SubchDev *sch, IRB *irb, int *irb_len);
 void css_do_tsch_update_subch(SubchDev *sch);
 int css_do_stcrw(CRW *crw);
 void css_undo_stcrw(CRW *crw);
-int css_do_tpi(IOIntCode *int_code, int lowcore);
 int css_collect_chp_desc(int m, uint8_t cssid, uint8_t f_chpid, uint8_t l_chpid,
                          int rfmt, void *buf);
 void css_do_schm(uint8_t mbk, int update, int dct, uint64_t mbo);
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index db39d5bfac..603b0d7a7c 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -388,7 +388,6 @@ void ioinst_handle_stcrw(S390CPU *cpu, uint32_t ipb);
 void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb);
 int ioinst_handle_tsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb);
 void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb);
-int ioinst_handle_tpi(S390CPU *cpu, uint32_t ipb);
 void ioinst_handle_schm(S390CPU *cpu, uint64_t reg1, uint64_t reg2,
                         uint32_t ipb);
 void ioinst_handle_rsch(S390CPU *cpu, uint64_t reg1);
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index 23962fbebc..1d6857c14d 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -647,32 +647,6 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb)
     }
 }
 
-int ioinst_handle_tpi(S390CPU *cpu, uint32_t ipb)
-{
-    CPUS390XState *env = &cpu->env;
-    uint64_t addr;
-    int lowcore;
-    IOIntCode int_code;
-    hwaddr len;
-    int ret;
-    uint8_t ar;
-
-    trace_ioinst("tpi");
-    addr = decode_basedisp_s(env, ipb, &ar);
-    if (addr & 3) {
-        program_interrupt(env, PGM_SPECIFICATION, 4);
-        return -EIO;
-    }
-
-    lowcore = addr ? 0 : 1;
-    len = lowcore ? 8 /* two words */ : 12 /* three words */;
-    ret = css_do_tpi(&int_code, lowcore);
-    if (ret == 1) {
-        s390_cpu_virt_mem_write(cpu, lowcore ? 184 : addr, ar, &int_code, len);
-    }
-    return ret;
-}
-
 #define SCHM_REG1_RES(_reg) (_reg & 0x000000000ffffffc)
 #define SCHM_REG1_MBK(_reg) ((_reg & 0x00000000f0000000) >> 28)
 #define SCHM_REG1_UPD(_reg) ((_reg & 0x0000000000000002) >> 1)
-- 
2.14.3
