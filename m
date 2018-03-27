Received: from eggs.gnu.org ([2001:4830:134:3::10]:45014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1f0wBl-0002MR-B9
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 17:31:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1f0wBi-0003up-5G
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 17:31:29 -0400
Received: from mail-bn3nam01on0079.outbound.protection.outlook.com
	([104.47.33.79]:25485
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1f0wBh-0003ss-Sq
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 17:31:25 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Tue, 27 Mar 2018 17:31:06 -0400
Message-Id: <1522186271-27743-5-git-send-email-babu.moger@amd.com>
In-Reply-To: <1522186271-27743-1-git-send-email-babu.moger@amd.com>
References: <1522186271-27743-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 4/9] i386: Add new property to control cache
 info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, kash@tripleback.net, babu.moger@amd.com

This will be used to control the cache information.
By default new information will be displayed. If user
passes "-cpu legacy-cache" then older information will
be displayed even if the hardware supports new information.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 include/hw/i386/pc.h | 6 +++++-
 target/i386/cpu.c    | 1 +
 target/i386/cpu.h    | 5 +++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ffee841..9cda1ab 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -327,7 +327,11 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .driver   = "q35-pcihost",\
         .property = "x-pci-hole64-fix",\
         .value    = "off",\
-    },
+    },{\
+        .driver   = TYPE_X86_CPU,\
+        .property = "legacy-cache",\
+        .value    = "off",\
+    },\
 
 #define PC_COMPAT_2_9 \
     HW_COMPAT_2_9 \
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 67faa53..f4fbe3a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5132,6 +5132,7 @@ static Property x86_cpu_properties[] = {
                      false),
     DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
     DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
+    DEFINE_PROP_BOOL("legacy-cache", X86CPU, legacy_cache, false),
 
     /*
      * From "Requirements for Implementing the Microsoft
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 806c34b..bbe13f2 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1394,6 +1394,11 @@ struct X86CPU {
      */
     bool enable_l3_cache;
 
+    /* Compatibility bits for old machine types.
+     * If true present the old cache topology information
+     */
+    bool legacy_cache;
+
     /* Compatibility bits for old machine types: */
     bool enable_cpuid_0xb;
 
-- 
1.8.3.1
