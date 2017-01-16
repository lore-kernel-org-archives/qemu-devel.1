Received: from eggs.gnu.org ([2001:4830:134:3::10]:57944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTAcx-0000j0-KV
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTAcw-0008Vn-QE
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cTAcw-0008VX-Jt
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:26 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A493D85376
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 16:59:26 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-100.ams2.redhat.com
	[10.36.116.100])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v0GGxGUs001760
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 11:59:26 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 16 Jan 2017 17:58:51 +0100
Message-Id: <20170116165916.8575-8-pbonzini@redhat.com>
In-Reply-To: <20170116165916.8575-1-pbonzini@redhat.com>
References: <20170116165916.8575-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 07/32] stubs: move acpi stubs to hw/acpi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

No need to include them in libqemustub.a, since only system emulators
need them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/acpi/Makefile.objs               | 12 ++++++++----
 stubs/ipmi.c => hw/acpi/ipmi-stub.c |  0
 stubs/Makefile.objs                 |  1 -
 3 files changed, 8 insertions(+), 5 deletions(-)
 rename stubs/ipmi.c => hw/acpi/ipmi-stub.c (100%)

diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
index 834c63b..dfc8229 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -4,7 +4,11 @@ common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu_hotplug.o
 common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) += memory_hotplug.o
 common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu.o
 common-obj-$(CONFIG_ACPI_NVDIMM) += nvdimm.o
-common-obj-$(CONFIG_ACPI) += acpi_interface.o
-common-obj-$(CONFIG_ACPI) += bios-linker-loader.o
-common-obj-$(CONFIG_ACPI) += aml-build.o
-common-obj-$(call land,$(CONFIG_ACPI),$(CONFIG_IPMI)) += ipmi.o
+
+common-obj-y += acpi_interface.o
+common-obj-y += bios-linker-loader.o
+common-obj-y += aml-build.o
+
+common-obj-$(CONFIG_IPMI) += ipmi.o
+common-obj-$(call lnot,$(CONFIG_IPMI)) += ipmi-stub.o
+common-obj-$(CONFIG_ALL) += ipmi-stub.o
diff --git a/stubs/ipmi.c b/hw/acpi/ipmi-stub.c
similarity index 100%
rename from stubs/ipmi.c
rename to hw/acpi/ipmi-stub.c
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 13c5d45..c4df915 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -44,6 +44,5 @@ stub-obj-y += target-monitor-defs.o
 stub-obj-y += target-get-monitor-def.o
 stub-obj-y += vhost.o
 stub-obj-y += iohandler.o
-stub-obj-y += ipmi.o
 stub-obj-y += pc_madt_cpu_entry.o
 stub-obj-y += migration-colo.o
-- 
2.9.3
