Received: from eggs.gnu.org ([2001:4830:134:3::10]:39717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWDcz-0007iu-SK
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWDcx-0003Zt-Ol
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:24:53 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 22 Jun 2018 14:24:23 +1000
Message-Id: <20180622042437.14259-9-david@gibson.dropbear.id.au>
In-Reply-To: <20180622042437.14259-1-david@gibson.dropbear.id.au>
References: <20180622042437.14259-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 09/23] spapr: Add cpu_apply hook to capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

spapr capabilities have an apply hook to actually activate (or deactivate=
)
the feature in the system at reset time.  However, a number of capabiliti=
es
affect the setup of cpus, and need to be applied to each of them -
including hotplugged cpus for extra complication.  To make this simpler,
add an optional cpu_apply hook that is called from spapr_cpu_reset().

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr_caps.c     | 19 +++++++++++++++++++
 hw/ppc/spapr_cpu_core.c |  2 ++
 include/hw/ppc/spapr.h  |  1 +
 3 files changed, 22 insertions(+)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index dabed817d1..68a4243efc 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -59,6 +59,8 @@ typedef struct sPAPRCapabilityInfo {
     sPAPRCapPossible *possible;
     /* Make sure the virtual hardware can support this capability */
     void (*apply)(sPAPRMachineState *spapr, uint8_t val, Error **errp);
+    void (*cpu_apply)(sPAPRMachineState *spapr, PowerPCCPU *cpu,
+                      uint8_t val, Error **errp);
 } sPAPRCapabilityInfo;
=20
 static void spapr_cap_get_bool(Object *obj, Visitor *v, const char *name=
,
@@ -472,6 +474,23 @@ void spapr_caps_apply(sPAPRMachineState *spapr)
     }
 }
=20
+void spapr_caps_cpu_apply(sPAPRMachineState *spapr, PowerPCCPU *cpu)
+{
+    int i;
+
+    for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
+        sPAPRCapabilityInfo *info =3D &capability_table[i];
+
+        /*
+         * If the apply function can't set the desired level and thinks =
it's
+         * fatal, it should cause that.
+         */
+        if (info->cpu_apply) {
+            info->cpu_apply(spapr, cpu, spapr->eff.caps[i], &error_fatal=
);
+        }
+    }
+}
+
 void spapr_caps_add_properties(sPAPRMachineClass *smc, Error **errp)
 {
     Error *local_err =3D NULL;
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 67f1596c57..bfb94f650c 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -76,6 +76,8 @@ static void spapr_cpu_reset(void *opaque)
     spapr_cpu->slb_shadow_size =3D 0;
     spapr_cpu->dtl_addr =3D 0;
     spapr_cpu->dtl_size =3D 0;
+
+    spapr_caps_cpu_apply(SPAPR_MACHINE(qdev_get_machine()), cpu);
 }
=20
 void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target=
_ulong r3)
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 9dbd6010f5..9dd46a72f6 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -800,6 +800,7 @@ static inline uint8_t spapr_get_cap(sPAPRMachineState=
 *spapr, int cap)
=20
 void spapr_caps_init(sPAPRMachineState *spapr);
 void spapr_caps_apply(sPAPRMachineState *spapr);
+void spapr_caps_cpu_apply(sPAPRMachineState *spapr, PowerPCCPU *cpu);
 void spapr_caps_add_properties(sPAPRMachineClass *smc, Error **errp);
 int spapr_caps_post_migration(sPAPRMachineState *spapr);
=20
--=20
2.17.1
