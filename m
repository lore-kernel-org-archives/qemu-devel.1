Received: from eggs.gnu.org ([2001:4830:134:3::10]:41875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bauerman@linux.vnet.ibm.com>) id 1djssc-0003gC-I3
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 16:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bauerman@linux.vnet.ibm.com>) id 1djssa-0002ZP-0O
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 16:00:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34577
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bauerman@linux.vnet.ibm.com>)
	id 1djssZ-0002XI-Q9
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 16:00:55 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7LJx5Xb057388
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 16:00:54 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cg62r095k-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 16:00:54 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bauerman@linux.vnet.ibm.com>;
	Mon, 21 Aug 2017 16:00:53 -0400
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Date: Mon, 21 Aug 2017 17:00:36 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20170821200036.15036-1-bauerman@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] spapr: Add ibm,
 processor-storage-keys property to CPU DT node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Ram Pai <linuxram@us.ibm.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

LoPAPR says:

    =E2=80=9Cibm,processor-storage-keys=E2=80=9D

    property name indicating the number of virtual storage keys supported
    by the processor described by this node.

    prop-encoded-array: Consists of two cells encoded as with encode-int.
    The first cell represents the number of virtual storage keys supporte=
d
    for data accesses while the second cell represents the number of
    virtual storage keys supported for instruction accesses. The cell val=
ue
    of zero indicates that no storage keys are supported for the access
    type.

pHyp provides the property above but there's a bug in P8 firmware where t=
he
second cell is zero even though POWER8 supports instruction access keys.
This bug will be fixed for P9.

Tested with KVM on POWER8 Firenze machine and with TCG on x86_64 machine.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---

The sysfs files are provided by this patch for Linux:

https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-August/162005.html

I realize that this patch can't be committed before the Linux one goes in=
,
but I'd appreciate feedback so that it will be ready by the time the kern=
el
side is accepted.

 hw/ppc/spapr.c         | 76 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 include/hw/ppc/spapr.h |  6 ++++
 2 files changed, 82 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f7a19720dcdf..a665e4d830f7 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -605,6 +605,80 @@ static void spapr_populate_cpu_dt(CPUState *cs, void=
 *fdt, int offset,
                           pcc->radix_page_info->count *
                           sizeof(radix_AP_encodings[0]))));
     }
+
+    if (spapr->storage_keys) {
+        uint32_t val[2];
+
+        val[0] =3D cpu_to_be32(spapr->storage_keys);
+        val[1] =3D spapr->insn_keys ? val[0] : 0;
+
+        _FDT(fdt_setprop(fdt, offset, "ibm,processor-storage-keys",
+                         val, sizeof(val)));
+    }
+}
+
+#define SYSFS_PROT_KEYS_PATH "/sys/kernel/mm/protection_keys/"
+#define SYSFS_USABLE_STORAGE_KEYS SYSFS_PROT_KEYS_PATH "usable_keys"
+#define SYSFS_DISABLE_EXEC_KEYS SYSFS_PROT_KEYS_PATH "disable_execute_su=
pported"
+
+static void setup_storage_keys(CPUPPCState *env, sPAPRMachineState *spap=
r)
+{
+    if (!(env->mmu_model & POWERPC_MMU_AMR))
+        return;
+
+    if (kvm_enabled()) {
+        char buf[sizeof("false\n")];
+        uint32_t keys;
+        FILE *fd;
+
+        /*
+         * With KVM, we allow the guest to use the keys which the kernel=
 tells
+         * us are available.
+         */
+
+        fd =3D fopen(SYSFS_USABLE_STORAGE_KEYS, "r");
+        if (!fd) {
+            error_report("%s: open %s failed", __func__,
+                         SYSFS_USABLE_STORAGE_KEYS);
+            return;
+        }
+
+        if (fscanf(fd, "%u", &keys) !=3D 1) {
+            error_report("%s: error reading %s", __func__,
+                         SYSFS_USABLE_STORAGE_KEYS);
+            fclose(fd);
+            return;
+        }
+
+        fclose(fd);
+
+        /* Now find out whether the keys can be used for instruction acc=
ess. */
+
+        fd =3D fopen(SYSFS_DISABLE_EXEC_KEYS, "r");
+        if (!fd) {
+            error_report("%s: open %s failed", __func__,
+                         SYSFS_USABLE_STORAGE_KEYS);
+            return;
+        }
+
+        if (!fread(buf, 1, sizeof(buf), fd)) {
+            error_report("%s: error reading %s", __func__,
+                         SYSFS_DISABLE_EXEC_KEYS);
+            fclose(fd);
+            return;
+        }
+
+        fclose(fd);
+
+        spapr->storage_keys =3D keys;
+        spapr->insn_keys =3D !strncmp(buf, "true\n", sizeof(buf));
+    } else {
+        /* Without KVM, all keys provided by the architecture are availa=
ble. */
+        spapr->storage_keys =3D 32;
+
+        /* POWER7 doesn't support instruction access keys. */
+        spapr->insn_keys =3D POWERPC_MMU_VER(env->mmu_model) !=3D POWERP=
C_MMU_VER_2_06;
+    }
 }
=20
 static void spapr_populate_cpus_dt_node(void *fdt, sPAPRMachineState *sp=
apr)
@@ -619,6 +693,8 @@ static void spapr_populate_cpus_dt_node(void *fdt, sP=
APRMachineState *spapr)
     _FDT((fdt_setprop_cell(fdt, cpus_offset, "#address-cells", 0x1)));
     _FDT((fdt_setprop_cell(fdt, cpus_offset, "#size-cells", 0x0)));
=20
+    setup_storage_keys(&POWERPC_CPU(first_cpu)->env, spapr);
+
     /*
      * We walk the CPUs in reverse order to ensure that CPU DT nodes
      * created by fdt_add_subnode() end up in the right order in FDT
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 2a303a705c17..15af12010779 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -122,6 +122,12 @@ struct sPAPRMachineState {
      * occurs during the unplug process. */
     QTAILQ_HEAD(, sPAPRDIMMState) pending_dimm_unplugs;
=20
+    /* Number of processor storage keys available to the guest. */
+    uint32_t storage_keys;
+
+    /* Whether storage keys can control instruction access. */
+    bool insn_keys;
+
     /*< public >*/
     char *kvm_type;
     MemoryHotplugState hotplug_memory;
