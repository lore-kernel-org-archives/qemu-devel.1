Received: from eggs.gnu.org ([2001:4830:134:3::10]:43760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ciO6z-00080q-1m
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:25:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ciO6y-0005Ed-4f
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:25:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ciO6x-0005EL-V8
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:25:20 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 27 Feb 2017 13:24:57 -0300
Message-Id: <20170227162501.29280-8-ehabkost@redhat.com>
In-Reply-To: <20170227162501.29280-1-ehabkost@redhat.com>
References: <20170227162501.29280-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 07/11] i386: Make "max" model not use any host
 CPUID info on TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

Instead of reporting host CPUID data on "max", use the qemu64 CPU
model as reference to initialize CPUID
vendor/family/model/stepping/model-id.

Message-Id: <20170222183919.11928-3-ehabkost@redhat.com>
Tested-by: Richard W.M. Jones <rjones@redhat.com>
Tested-by: Jiri Denemark <jdenemar@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a53fafa205..ec22ed41b2 100644
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
