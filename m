Received: from eggs.gnu.org ([2001:4830:134:3::10]:58970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgbp2-0007qN-02
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:39:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgbp1-000752-0c
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:39:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cgbp0-00074w-Qh
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:39:26 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EAB5A61D02
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 18:39:26 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 22 Feb 2017 15:39:18 -0300
Message-Id: <20170222183919.11928-3-ehabkost@redhat.com>
In-Reply-To: <20170222183919.11928-1-ehabkost@redhat.com>
References: <20170222183919.11928-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/3] i386: Make "max" model not use any host
 CPUID info on TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Instead of reporting host CPUID data on "max", use the qemu64 CPU
model as reference to initialize CPUID
vendor/family/model/stepping/model-id.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f7bd59617e..5164cd9ed5 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1594,6 +1594,15 @@ static void max_x86_cpu_initfn(Object *obj)
         if (lmce_supported()) {
             object_property_set_bool(OBJECT(cpu), true, "lmce", &error_abort);
         }
+    } else {
+        object_property_set_str(OBJECT(cpu), CPUID_VENDOR_AMD,
+                                "vendor", &error_abort);
+        object_property_set_int(OBJECT(cpu), 6, "family", &error_abort);
+        object_property_set_int(OBJECT(cpu), 6, "model", &error_abort);
+        object_property_set_int(OBJECT(cpu), 3, "stepping", &error_abort);
+        object_property_set_str(OBJECT(cpu),
+                                "QEMU TCG CPU version " QEMU_HW_VERSION,
+                                "model-id", &error_abort);
     }
 
     object_property_set_bool(OBJECT(cpu), true, "pmu", &error_abort);
-- 
2.11.0.259.g40922b1
