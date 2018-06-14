Received: from eggs.gnu.org ([2001:4830:134:3::10]:46177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTGh8-0002mu-Ti
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTGh7-0001f1-Gk
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:04:58 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 14 Jun 2018 11:04:44 +1000
Message-Id: <20180614010446.30854-6-david@gibson.dropbear.id.au>
In-Reply-To: <20180614010446.30854-1-david@gibson.dropbear.id.au>
References: <20180614010446.30854-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCHv2 5/7] pnv: Add cpu unrealize path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org
Cc: clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Currently we don't have any unrealize path for pnv cpu cores.  We get awa=
y
with this because we don't yet support cpu hotplug for pnv.

However, we're going to want it eventually, and in the meantime, it makes
it non-obvious why there are a bunch of allocations on the realize() path
that don't have matching frees.

So, implement the missing unrealize path.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/pnv_core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index f4c41d89d6..f7cf33f547 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -186,6 +186,26 @@ err:
     error_propagate(errp, local_err);
 }
=20
+static void pnv_unrealize_vcpu(PowerPCCPU *cpu)
+{
+    qemu_unregister_reset(pnv_cpu_reset, cpu);
+    object_unparent(cpu->intc);
+    cpu_remove_sync(CPU(cpu));
+    object_unparent(OBJECT(cpu));
+}
+
+static void pnv_core_unrealize(DeviceState *dev, Error **errp)
+{
+    PnvCore *pc =3D PNV_CORE(dev);
+    CPUCore *cc =3D CPU_CORE(dev);
+    int i;
+
+    for (i =3D 0; i < cc->nr_threads; i++) {
+        pnv_unrealize_vcpu(pc->threads[i]);
+    }
+    g_free(pc->threads);
+}
+
 static Property pnv_core_properties[] =3D {
     DEFINE_PROP_UINT32("pir", PnvCore, pir, 0),
     DEFINE_PROP_END_OF_LIST(),
@@ -196,6 +216,7 @@ static void pnv_core_class_init(ObjectClass *oc, void=
 *data)
     DeviceClass *dc =3D DEVICE_CLASS(oc);
=20
     dc->realize =3D pnv_core_realize;
+    dc->unrealize =3D pnv_core_unrealize;
     dc->props =3D pnv_core_properties;
 }
=20
--=20
2.17.1
