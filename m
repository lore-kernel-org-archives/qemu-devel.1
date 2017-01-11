Received: from eggs.gnu.org ([2001:4830:134:3::10]:45261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgP-00036E-6e
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgO-0003K9-6b
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:41 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cROgN-0003Jo-Vq
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:40 -0500
Received: by mail-wm0-x241.google.com with SMTP id l2so324475wml.2
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 11:35:39 -0800 (PST)
Received: from 640k.lan (94-39-158-71.adsl-ull.clienti.tiscali.it.
	[94.39.158.71]) by smtp.gmail.com with ESMTPSA id
	k11sm10463101wmb.18.2017.01.11.11.35.37 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 11 Jan 2017 11:35:38 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Jan 2017 20:35:01 +0100
Message-Id: <1484163327-111841-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
References: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 07/33] stubs: move acpi stubs to hw/acpi
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
1.8.3.1
