Received: from eggs.gnu.org ([209.51.188.92]:35443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gwaYI-0004Zt-Qd
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 17:41:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gwaYG-0000wK-V0
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 17:41:18 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 20 Feb 2019 23:40:02 +0100
Message-Id: <20190220224003.4420-17-eric.auger@redhat.com>
In-Reply-To: <20190220224003.4420-1-eric.auger@redhat.com>
References: <20190220224003.4420-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 16/17] hw/arm/boot: Expose the pmem nodes in
 the DT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com, david@redhat.com
Cc: dgilbert@redhat.com, david@gibson.dropbear.id.au, drjones@redhat.com

In case of NV-DIMM slots, let's add /pmem DT nodes.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v6 -> v7
- does the same rework as for fdt_add_memory_node
---
 hw/arm/boot.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 255aaca0cf..66caf005e5 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -450,6 +450,32 @@ out:
     return ret;
 }
=20
+static int fdt_add_pmem_node(void *fdt, uint32_t acells, hwaddr mem_base=
,
+                             uint32_t scells, hwaddr mem_len,
+                             int numa_node_id)
+{
+    char *nodename;
+    int ret;
+
+    nodename =3D g_strdup_printf("/pmem@%" PRIx64, mem_base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "pmem-region");
+    ret =3D qemu_fdt_setprop_sized_cells(fdt, nodename, "reg", acells, m=
em_base,
+                                       scells, mem_len);
+    if (ret < 0) {
+        goto out;
+    }
+
+    /* only set the NUMA ID if it is specified */
+    if (numa_node_id >=3D 0) {
+        ret =3D qemu_fdt_setprop_cell(fdt, nodename,
+                                    "numa-node-id", numa_node_id);
+    }
+out:
+    g_free(nodename);
+    return ret;
+}
+
 static void fdt_add_psci_node(void *fdt)
 {
     uint32_t cpu_suspend_fn;
@@ -546,6 +572,20 @@ static int fdt_add_hotpluggable_memory_nodes(void *f=
dt,
             }
             break;
         }
+        case MEMORY_DEVICE_INFO_KIND_NVDIMM:
+        {
+            PCDIMMDeviceInfo *di =3D mi->u.nvdimm.data;
+
+            ret =3D fdt_add_pmem_node(fdt, acells, di->addr,
+                                    scells, di->size, di->node);
+            if (ret) {
+                fprintf(stderr,
+                        "couldn't add NVDIMM /memory@%"PRIx64" node\n",
+                        di->addr);
+                goto out;
+            }
+            break;
+        }
         default:
             fprintf(stderr, "%s memory nodes are not yet supported\n",
                     MemoryDeviceInfoKind_str(mi->type));
--=20
2.20.1
