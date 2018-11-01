Received: from eggs.gnu.org ([2001:4830:134:3::10]:59584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gIA9q-000526-4N
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gIA9l-0003Gr-6f
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:24:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:61544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gIA9k-0003Em-6v
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:24:53 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Thu,  1 Nov 2018 11:22:55 +0100
Message-Id: <20181101102303.16439-16-sameo@linux.intel.com>
In-Reply-To: <20181101102303.16439-1-sameo@linux.intel.com>
References: <20181101102303.16439-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 15/23] hw: acpi: Fix memory hotplug AML
 generation error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yang Zhong <yang.zhong@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: Yang Zhong <yang.zhong@intel.com>

When using the generated memory hotplug AML, the iasl
compiler would give the following error:

dsdt.dsl 266: Return (MOST (_UID, Arg0, Arg1, Arg2))
Error 6080 - Called method returns no value ^

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 hw/acpi/memory_hotplug.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index db2c4df961..893fc2bd27 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -686,15 +686,15 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
 
             method = aml_method("_OST", 3, AML_NOTSERIALIZED);
             s = MEMORY_SLOT_OST_METHOD;
-            aml_append(method, aml_return(aml_call4(
-                s, aml_name("_UID"), aml_arg(0), aml_arg(1), aml_arg(2)
-            )));
+            aml_append(method,
+                       aml_call4(s, aml_name("_UID"), aml_arg(0),
+                                 aml_arg(1), aml_arg(2)));
             aml_append(dev, method);
 
             method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
             s = MEMORY_SLOT_EJECT_METHOD;
-            aml_append(method, aml_return(aml_call2(
-                       s, aml_name("_UID"), aml_arg(0))));
+            aml_append(method,
+                       aml_call2(s, aml_name("_UID"), aml_arg(0)));
             aml_append(dev, method);
 
             aml_append(dev_container, dev);
-- 
2.19.1
