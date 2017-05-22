Received: from eggs.gnu.org ([2001:4830:134:3::10]:53914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eyakovlev@virtuozzo.com>) id 1dCjzP-0000an-8N
	for qemu-devel@nongnu.org; Mon, 22 May 2017 05:51:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eyakovlev@virtuozzo.com>) id 1dCjzK-0003Pl-4T
	for qemu-devel@nongnu.org; Mon, 22 May 2017 05:50:59 -0400
Received: from mail-db5eur01on0092.outbound.protection.outlook.com
	([104.47.2.92]:59063
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eyakovlev@virtuozzo.com>)
	id 1dCjzJ-0003DC-Eo
	for qemu-devel@nongnu.org; Mon, 22 May 2017 05:50:53 -0400
From: Evgeny Yakovlev <eyakovlev@virtuozzo.com>
Date: Mon, 22 May 2017 12:50:30 +0300
Message-ID: <1495446630-365062-2-git-send-email-eyakovlev@virtuozzo.com>
In-Reply-To: <1495446630-365062-1-git-send-email-eyakovlev@virtuozzo.com>
References: <1495446630-365062-1-git-send-email-eyakovlev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] acpi: change CPU container node _HID to
 compatible PNP0A05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, imammedo@redhat.com, mst@redhat.com
Cc: rkagan@virtuozzo.com

When running windows 2016 server guests we have encountered a problem
with ACPI representation of CPU devices. This windows version contains a
hidinterrupt.sys driver which looks for ACPI device node with _HID set
to "ACPI0010" and "ACPI0011". ACPI0010 is also a valid id for CPU
container device which qemu uses.

hidinterrupt driver takes over (even though it fails) ACPI0010 node and
thus hides its children -- the CPUs -- from the regular ACPI
enumeration.  So there are no processors in the Windows device tree
Device Manager or "!devnode 0 1" in the debugger.

hidinterrupt.inf as shipped with Windows 2016 has both ACPI0011 and
ACPI0010; the record for the latter is preceded with a comment "This Id
is not to be used. It will be removed once everyone has stopped using
it."  So I guess the typo was not in the driver but in the ACPI tables
of some device(s) which the driver wanted to support despite the bug.

For reference this is a known issue:
https://bugzilla.redhat.com/show_bug.cgi?id=1377155#c31

This change works around this problem by setting qemu CPU container ACPI
_HID to compatible PNP0A05.

Signed-off-by: Evgeny Yakovlev <eyakovlev@virtuozzo.com>
---
 hw/acpi/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index a233fe1..b93db40 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -397,7 +397,7 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
         Aml *rm_evt = aml_name("%s.%s", cphp_res_path, CPU_REMOVE_EVENT);
         Aml *ej_evt = aml_name("%s.%s", cphp_res_path, CPU_EJECT_EVENT);
 
-        aml_append(cpus_dev, aml_name_decl("_HID", aml_string("ACPI0010")));
+        aml_append(cpus_dev, aml_name_decl("_HID", aml_string("PNP0A05")));
         aml_append(cpus_dev, aml_name_decl("_CID", aml_eisaid("PNP0A05")));
 
         method = aml_method(CPU_NOTIFY_METHOD, 2, AML_NOTSERIALIZED);
-- 
1.8.3.1
