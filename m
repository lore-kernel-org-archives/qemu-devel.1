Received: from eggs.gnu.org ([2001:4830:134:3::10]:34998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cUJtM-0004n4-0B
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:05:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cUJtI-0001PO-Q5
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:05:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cUJtI-0001OY-K3
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:05:04 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BF631624D4
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 21:05:04 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 19 Jan 2017 19:04:48 -0200
Message-Id: <20170119210449.11991-6-ehabkost@redhat.com>
In-Reply-To: <20170119210449.11991-1-ehabkost@redhat.com>
References: <20170119210449.11991-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 5/6] i386: Make "max" model not use any host
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
index 6f3a62840f..ea4e1ae519 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1592,6 +1592,15 @@ static void max_x86_cpu_initfn(Object *obj)
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
