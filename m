Received: from eggs.gnu.org ([2001:4830:134:3::10]:34904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fv2WS-0004Q6-Aq
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fv2WR-0001xf-FG
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:36:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43954 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fv2WQ-0001xI-7r
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:36:42 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 29 Aug 2018 17:36:07 +0200
Message-Id: <20180829153624.12299-4-david@redhat.com>
In-Reply-To: <20180829153624.12299-1-david@redhat.com>
References: <20180829153624.12299-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 03/20] memory-device: introduce separate
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
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, David Hildenbrand <david@redhat.com>

Some architectures might support memory devices, while they don't
support DIMM/NVDIMM. So let's
- Rename CONFIG_MEM_HOTPLUG to CONFIG_MEM_DEVICE
- Introduce CONFIG_DIMM and use it similarly to CONFIG NVDIMM

CONFIG_DIMM and CONFIG_NVDIMM require CONFIG_MEM_DEVICE.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
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
index d450cfef21..7c36de0464 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -2061,7 +2061,7 @@
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
