Received: from eggs.gnu.org ([2001:4830:134:3::10]:51908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cavz6-0005PG-Ne
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:58:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cavz4-0002za-T0
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:58:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1cavz4-0002ys-JX
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:58:22 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v172rwYF111301
	for <qemu-devel@nongnu.org>; Mon, 6 Feb 2017 21:58:21 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28eups6s10-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 21:58:21 -0500
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Tue, 7 Feb 2017 12:58:18 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Tue,  7 Feb 2017 13:56:51 +1100
In-Reply-To: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
References: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
References: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
Message-Id: <0d06b1c772cf35947e9f095202ab4ca2a50aaf76.1486436186.git.sam.bobroff@au1.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 8/9] spapr: Advertise ISA 3.0 MMU features
 in pa_features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Set the default ibm,pa_features bits for ISA 3.0.

Providing the radix MMU support bit in ibm,pa-features will cause some
recent (e.g. 4.9) kernels to attempt to initialize the MMU as if they
were a radix host, which will cause them to crash. So, if a guest
performs a client architecture support call without indicating ISA
3.00 support (specifically, if they do not indicate that they support
either new radix or new hash mode) then the radix bit is removed from
ibm,pa-features to avoid triggering the bug.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 hw/ppc/spapr.c         | 125 +++++++++++++++++++++++++++++++------------------
 hw/ppc/spapr_hcall.c   |   4 +-
 include/hw/ppc/spapr.h |   1 +
 3 files changed, 83 insertions(+), 47 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c6a3a638cd..325a9c587b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -194,6 +194,76 @@ static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, CPUState *cs)
     return ret;
 }
 
+/* Populate the "ibm,pa-features" property */
+static int spapr_populate_pa_features(CPUPPCState *env, void *fdt, int offset,
+                                      bool legacy_guest)
+{
+    uint8_t pa_features_206[] = { 6, 0,
+        0xf6, 0x1f, 0xc7, 0x00, 0x80, 0xc0 };
+    uint8_t pa_features_207[] = { 24, 0,
+        0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0,
+        0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
+        0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
+        0x80, 0x00, 0x80, 0x00, 0x00, 0x00 };
+    uint8_t pa_features_300[70 + 2] = { 70, 0,
+        0xf6, 0x3f, 0xc7, 0xc0, 0x80, 0xf0, /* 0 - 5 */
+        0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
+        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 18 - 23 */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
+        0x80, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 36 - 41 */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
+        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 64 */
+        0x00, 0x00, 0x00, 0x00,             /* 66 - 69 */
+        };
+    uint8_t *pa_features;
+    size_t pa_size;
+
+    switch (env->mmu_model) {
+    case POWERPC_MMU_2_06:
+    case POWERPC_MMU_2_06a:
+        pa_features = pa_features_206;
+        pa_size = sizeof(pa_features_206);
+        break;
+    case POWERPC_MMU_2_07:
+    case POWERPC_MMU_2_07a:
+        pa_features = pa_features_207;
+        pa_size = sizeof(pa_features_207);
+        break;
+    case POWERPC_MMU_3_00:
+        pa_features = pa_features_300;
+        pa_size = sizeof(pa_features_300);
+        break;
+    default:
+        return 0; /* TODO, this is actually an error! */
+    }
+
+    if (env->ci_large_pages) {
+        /*
+         * Note: we keep CI large pages off by default because a 64K capable
+         * guest provisioned with large pages might otherwise try to map a qemu
+         * framebuffer (or other kind of memory mapped PCI BAR) using 64K pages
+         * even if that qemu runs on a 4k host.
+         * We dd this bit back here if we are confident this is not an issue
+         */
+        pa_features[3] |= 0x20;
+    }
+    if (kvmppc_has_cap_htm() && pa_size > 24) {
+        pa_features[24] |= 0x80;    /* Transactional memory support */
+    }
+    if (legacy_guest && pa_size > 40) {
+        /* Workaround for broken kernels that attempt (guest) radix
+         * mode when they can't handle it, if they see the radix bit set
+         * in pa-features. So hide it from them. */
+        pa_features[40 + 2] &= ~0x80; /* Radix MMU */
+    }
+
+    return fdt_setprop(fdt, offset, "ibm,pa-features", pa_features, pa_size);
+}
+
 static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
 {
     int ret = 0, offset, cpus_offset;
@@ -204,6 +274,7 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
 
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
+        CPUPPCState *env = &cpu->env;
         DeviceClass *dc = DEVICE_GET_CLASS(cs);
         int index = ppc_get_vcpu_dt_id(cpu);
 
@@ -245,6 +316,12 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
         if (ret < 0) {
             return ret;
         }
+
+        ret = spapr_populate_pa_features(env, fdt, offset,
+                                         spapr->cas_legacy_guest_workaround);
+        if (ret < 0) {
+            return ret;
+        }
     }
     return ret;
 }
@@ -346,51 +423,6 @@ static int spapr_populate_memory(sPAPRMachineState *spapr, void *fdt)
     return 0;
 }
 
-/* Populate the "ibm,pa-features" property */
-static void spapr_populate_pa_features(CPUPPCState *env, void *fdt, int offset)
-{
-    uint8_t pa_features_206[] = { 6, 0,
-        0xf6, 0x1f, 0xc7, 0x00, 0x80, 0xc0 };
-    uint8_t pa_features_207[] = { 24, 0,
-        0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0,
-        0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
-        0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
-        0x80, 0x00, 0x80, 0x00, 0x00, 0x00 };
-    uint8_t *pa_features;
-    size_t pa_size;
-
-    switch (env->mmu_model) {
-    case POWERPC_MMU_2_06:
-    case POWERPC_MMU_2_06a:
-        pa_features = pa_features_206;
-        pa_size = sizeof(pa_features_206);
-        break;
-    case POWERPC_MMU_2_07:
-    case POWERPC_MMU_2_07a:
-        pa_features = pa_features_207;
-        pa_size = sizeof(pa_features_207);
-        break;
-    default:
-        return;
-    }
-
-    if (env->ci_large_pages) {
-        /*
-         * Note: we keep CI large pages off by default because a 64K capable
-         * guest provisioned with large pages might otherwise try to map a qemu
-         * framebuffer (or other kind of memory mapped PCI BAR) using 64K pages
-         * even if that qemu runs on a 4k host.
-         * We dd this bit back here if we are confident this is not an issue
-         */
-        pa_features[3] |= 0x20;
-    }
-    if (kvmppc_has_cap_htm() && pa_size > 24) {
-        pa_features[24] |= 0x80;    /* Transactional memory support */
-    }
-
-    _FDT((fdt_setprop(fdt, offset, "ibm,pa-features", pa_features, pa_size)));
-}
-
 static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
                                   sPAPRMachineState *spapr)
 {
@@ -484,7 +516,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
                           page_sizes_prop, page_sizes_prop_size)));
     }
 
-    spapr_populate_pa_features(env, fdt, offset);
+    _FDT(spapr_populate_pa_features(env, fdt, offset, false));
 
     _FDT((fdt_setprop_cell(fdt, offset, "ibm,chip-id",
                            cs->cpu_index / vcpus_per_socket)));
@@ -1870,6 +1902,7 @@ static void ppc_spapr_init(MachineState *machine)
     }
     spapr_ovec_set(spapr->ov5, OV5_SEG_HCALL);
     spapr_ovec_set(spapr->ov5, OV5_SHOOTDOWN);
+    spapr_ovec_set(spapr->ov5, OV5_SEG_HCALL);
 
     /* advertise support for dedicated HP event source to guests */
     if (spapr->use_hotplug_event_source) {
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 4de511c386..d04f696e65 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -999,7 +999,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu_,
         }
     }
 
-    if (!cpu_version) {
+    if (!cpu_version  && !spapr->cas_legacy_guest_workaround) {
         cpu_update = false;
     }
 
@@ -1033,6 +1033,8 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu_,
                                         ov5_cas_old, spapr->ov5_cas);
     spapr_ovec_stderr("update", 16, ov5_updates);
     fprintf(stderr, "Old CAS reboot flag: %d\n", spapr->cas_reboot);
+    spapr->cas_legacy_guest_workaround = !spapr_ovec_test(ov5_updates, OV5_MMU_RADIX) &&
+                                         !spapr_ovec_test(ov5_updates, OV5_MMU_HASH);
 
     if (!spapr->cas_reboot) {
         spapr->cas_reboot =
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 92bda0f36d..974338d1df 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -77,6 +77,7 @@ struct sPAPRMachineState {
     sPAPROptionVector *ov5;         /* QEMU-supported option vectors */
     sPAPROptionVector *ov5_cas;     /* negotiated (via CAS) option vectors */
     bool cas_reboot;
+    bool cas_legacy_guest_workaround;
 
     Notifier epow_notifier;
     QTAILQ_HEAD(, sPAPREventLogEntry) pending_events;
-- 
2.11.0
