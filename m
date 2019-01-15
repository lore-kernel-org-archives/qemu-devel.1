Received: from eggs.gnu.org ([209.51.188.92]:35497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyn-00081M-Sj
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyV-0003Xp-U9
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57857)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUyT-0003TY-Jy
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:13 -0500
Date: Tue, 15 Jan 2019 15:06:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-44-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 43/49] hw: acpi: Fix memory hotplug AML
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Yang Zhong <yang.zhong@intel.com>, Igor Mammedov <imammedo@redhat.com>

From: Yang Zhong <yang.zhong@intel.com>

When using the generated memory hotplug AML, the iasl
compiler would give the following error:

dsdt.dsl 266: Return (MOST (_UID, Arg0, Arg1, Arg2))
Error 6080 - Called method returns no value ^

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/memory_hotplug.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 8c7c1013f3..921cad2c5e 100644
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
MST
