Received: from eggs.gnu.org ([2001:4830:134:3::10]:56182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fROTk-0004ES-T2
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 16:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fROTh-0002jG-1E
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 16:59:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49402 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fROTg-0002iu-SA
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 16:59:20 -0400
Date: Fri, 8 Jun 2018 23:59:19 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180608205830.308627-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [RFC untested PATCH] i386/cpu: make -cpu host support
 monitor/mwait
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

When guest CPU PM is enabled, and with -cpu host, expose the host CPU
MWAIT leaf to guest so guest can make good PM decisions.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

This builds but is untested. Is this a reasonable way to go about it?

 target/i386/cpu.h |  9 +++++++++
 target/i386/cpu.c | 18 +++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 664504610e..309f804573 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1378,6 +1378,15 @@ struct X86CPU {
     /* if true the CPUID code directly forward host cache leaves to the guest */
     bool cache_info_passthrough;
 
+    /* if true the CPUID code directly forwards
+     * host monitor/mwait leaves to the guest */
+    struct {
+        uint32_t eax;
+        uint32_t ebx;
+        uint32_t ecx;
+        uint32_t edx;
+    } mwait;
+
     /* Features that were filtered out because of missing host capabilities */
     uint32_t filtered_features[FEATURE_WORDS];
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 94260412e2..a49443de56 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3760,11 +3760,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         break;
     case 5:
-        /* mwait info: needed for Core compatibility */
-        *eax = 0; /* Smallest monitor-line size in bytes */
-        *ebx = 0; /* Largest monitor-line size in bytes */
-        *ecx = CPUID_MWAIT_EMX | CPUID_MWAIT_IBE;
-        *edx = 0;
+        /* MONITOR/MWAIT Leaf */
+        *eax = cpu->mwait.eax; /* Smallest monitor-line size in bytes */
+        *ebx = cpu->mwait.ebx; /* Largest monitor-line size in bytes */
+        *ecx = cpu->mwait.ecx; /* flags */
+        *edx = cpu->mwait.edx; /* mwait substates */
         break;
     case 6:
         /* Thermal and Power Leaf */
@@ -4595,6 +4595,14 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         goto out;
     }
 
+    if (xcc->host_cpuid_required && enable_cpu_pm) {
+        host_cpuid(5, 0, &cpu->mwait.eax, &cpu->mwait.ebx,
+                   &cpu->mwait.ecx, &cpu->mwait.edx);
+    }
+    /* We always wake on interrupt even if host does not have the capability */
+    /* mwait extended info: needed for Core compatibility */
+    cpu->mwait.ecx |= CPUID_MWAIT_EMX | CPUID_MWAIT_IBE;
+
     if (cpu->apic_id == UNASSIGNED_APIC_ID) {
         error_setg(errp, "apic-id property was not initialized properly");
         return;
-- 
MST
