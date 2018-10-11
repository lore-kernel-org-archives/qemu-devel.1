Received: from eggs.gnu.org ([2001:4830:134:3::10]:52695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gAZ5D-000636-CX
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:24:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gAZ5A-0007h7-7u
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:24:47 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55170 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gAZ59-0007gn-RN
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:24:44 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 11 Oct 2018 13:22:15 +0200
Message-Id: <1539256947-22807-11-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539256947-22807-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539256947-22807-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v4 10/22] target/mips: Add CPO MemoryMapID
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, laurent@vivier.eu, riku.voipio@iki.fi

From: Yongbok Kim <yongbok.kim@mips.com>

Add CPO MemoryMapID register. It is used by Global TLB Invalidate
instruction (GINVT).

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h      | 1 +
 target/mips/internal.h | 1 +
 target/mips/machine.c  | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 10c3813..77c6355 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -252,6 +252,7 @@ struct CPUMIPSState {
 #define CP0GN_VPId 0
     target_ulong CP0_Context;
     target_ulong CP0_KScratch[MIPS_KSCRATCH_NUM];
+    int32_t CP0_MemoryMapID;
     int32_t CP0_PageMask;
     int32_t CP0_PageGrain_rw_bitmask;
     int32_t CP0_PageGrain;
diff --git a/target/mips/internal.h b/target/mips/internal.h
index 2898bfc..6888a06 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -91,6 +91,7 @@ struct r4k_tlb_t {
     target_ulong VPN;
     uint32_t PageMask;
     uint16_t ASID;
+    uint32_t MMID;
     unsigned int G:1;
     unsigned int C0:3;
     unsigned int C1:3;
diff --git a/target/mips/machine.c b/target/mips/machine.c
index 0ef9b71..8e34b8c 100644
--- a/target/mips/machine.c
+++ b/target/mips/machine.c
@@ -136,6 +136,7 @@ static int get_tlb(QEMUFile *f, void *pv, size_t size, VMStateField *field)
     qemu_get_betls(f, &v->VPN);
     qemu_get_be32s(f, &v->PageMask);
     qemu_get_be16s(f, &v->ASID);
+    qemu_get_be32s(f, &v->MMID);
     qemu_get_be16s(f, &flags);
     v->G = (flags >> 10) & 1;
     v->C0 = (flags >> 7) & 3;
@@ -161,6 +162,7 @@ static int put_tlb(QEMUFile *f, void *pv, size_t size, VMStateField *field,
     r4k_tlb_t *v = pv;
 
     uint16_t asid = v->ASID;
+    uint32_t mmid = v->MMID;
     uint16_t flags = ((v->EHINV << 15) |
                       (v->RI1 << 14) |
                       (v->RI0 << 13) |
@@ -177,6 +179,7 @@ static int put_tlb(QEMUFile *f, void *pv, size_t size, VMStateField *field,
     qemu_put_betls(f, &v->VPN);
     qemu_put_be32s(f, &v->PageMask);
     qemu_put_be16s(f, &asid);
+    qemu_put_be32s(f, &mmid);
     qemu_put_be16s(f, &flags);
     qemu_put_be64s(f, &v->PFN[0]);
     qemu_put_be64s(f, &v->PFN[1]);
@@ -251,6 +254,7 @@ const VMStateDescription vmstate_mips_cpu = {
         VMSTATE_UINT64(env.CP0_EntryLo0, MIPSCPU),
         VMSTATE_UINT64(env.CP0_EntryLo1, MIPSCPU),
         VMSTATE_UINTTL(env.CP0_Context, MIPSCPU),
+        VMSTATE_INT32(env.CP0_MemoryMapID, MIPSCPU),
         VMSTATE_INT32(env.CP0_PageMask, MIPSCPU),
         VMSTATE_INT32(env.CP0_PageGrain, MIPSCPU),
         VMSTATE_UINTTL(env.CP0_SegCtl0, MIPSCPU),
-- 
2.7.4
