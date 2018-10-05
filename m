Received: from eggs.gnu.org ([2001:4830:134:3::10]:47738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g8MRi-00021C-0V
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g8MIk-0006LA-LE
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:21:39 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri,  5 Oct 2018 11:20:14 +0200
Message-Id: <20181005092024.14344-7-david@redhat.com>
In-Reply-To: <20181005092024.14344-1-david@redhat.com>
References: <20181005092024.14344-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v5 06/16] memory-device: introduce separate
 config option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Auger Eric <eric.auger@redhat.com>, David Hildenbrand <david@redhat.com>

Some architectures might support memory devices, while they don't
support DIMM/NVDIMM. So let's
- Rename CONFIG_MEM_HOTPLUG to CONFIG_MEM_DEVICE
- Introduce CONFIG_DIMM and use it similarly to CONFIG NVDIMM

CONFIG_DIMM and CONFIG_NVDIMM require CONFIG_MEM_DEVICE.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 default-configs/i386-softmmu.mak  | 3 ++-
 default-configs/ppc64-softmmu.mak | 3 ++-
 hw/Makefile.objs                  | 2 +-
 hw/mem/Makefile.objs              | 4 ++--
 qapi/misc.json                    | 2 +-
 5 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 8c7d4a0fa0..4c1637338b 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -50,7 +50,8 @@ CONFIG_PCI_Q35=y
 CONFIG_APIC=y
 CONFIG_IOAPIC=y
 CONFIG_PVPANIC=y
-CONFIG_MEM_HOTPLUG=y
+CONFIG_MEM_DEVICE=y
+CONFIG_DIMM=y
 CONFIG_NVDIMM=y
 CONFIG_ACPI_NVDIMM=y
 CONFIG_PCIE_PORT=y
diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-softmmu.mak
index b94af6c7c6..f550573782 100644
--- a/default-configs/ppc64-softmmu.mak
+++ b/default-configs/ppc64-softmmu.mak
@@ -16,4 +16,5 @@ CONFIG_VIRTIO_VGA=y
 CONFIG_XICS=$(CONFIG_PSERIES)
 CONFIG_XICS_SPAPR=$(CONFIG_PSERIES)
 CONFIG_XICS_KVM=$(call land,$(CONFIG_PSERIES),$(CONFIG_KVM))
-CONFIG_MEM_HOTPLUG=y
+CONFIG_MEM_DEVICE=y
+CONFIG_DIMM=y
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index a19c1417ed..58872e27e0 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -33,7 +33,7 @@ devices-dirs-$(CONFIG_SOFTMMU) += vfio/
 devices-dirs-$(CONFIG_SOFTMMU) += virtio/
 devices-dirs-$(CONFIG_SOFTMMU) += watchdog/
 devices-dirs-$(CONFIG_SOFTMMU) += xen/
-devices-dirs-$(CONFIG_MEM_HOTPLUG) += mem/
+devices-dirs-$(CONFIG_MEM_DEVICE) += mem/
 devices-dirs-$(CONFIG_SOFTMMU) += smbios/
 devices-dirs-y += core/
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/mem/Makefile.objs b/hw/mem/Makefile.objs
index 10be4df2a2..3e2f7c5ca2 100644
--- a/hw/mem/Makefile.objs
+++ b/hw/mem/Makefile.objs
@@ -1,3 +1,3 @@
-common-obj-$(CONFIG_MEM_HOTPLUG) += pc-dimm.o
-common-obj-$(CONFIG_MEM_HOTPLUG) += memory-device.o
+common-obj-$(CONFIG_DIMM) += pc-dimm.o
+common-obj-$(CONFIG_MEM_DEVICE) += memory-device.o
 common-obj-$(CONFIG_NVDIMM) += nvdimm.o
diff --git a/qapi/misc.json b/qapi/misc.json
index ada9af5add..e14efd70b0 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -2066,7 +2066,7 @@
 #
 # @plugged-memory: size of memory that can be hot-unplugged. This field
 #                  is omitted if target doesn't support memory hotplug
-#                  (i.e. CONFIG_MEM_HOTPLUG not defined on build time).
+#                  (i.e. CONFIG_MEM_DEVICE not defined at build time).
 #
 # Since: 2.11.0
 ##
-- 
2.17.1
