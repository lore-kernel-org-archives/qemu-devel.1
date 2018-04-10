Received: from eggs.gnu.org ([2001:4830:134:3::10]:33731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1f62V1-0003Bx-Hq
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 19:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1f62V0-0005gb-5J
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 19:16:27 -0400
Received: from mail-bn3nam01on0065.outbound.protection.outlook.com
	([104.47.33.65]:17470
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1f62Uz-0005gT-Ur
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 19:16:26 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Tue, 10 Apr 2018 19:16:04 -0400
Message-Id: <1523402169-113351-5-git-send-email-babu.moger@amd.com>
In-Reply-To: <1523402169-113351-1-git-send-email-babu.moger@amd.com>
References: <1523402169-113351-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 4/9] i386: Add new property to control cache
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
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, kash@tripleback.net, geoff@hostfission.com, babu.moger@amd.com

This will be used to control the cache information.
By default new information will be displayed. If user
passes "-cpu legacy-cache" then older information will
be displayed even if the hardware supports new information.
It will be "on" for machine type "pc-q35-2.10" for compatibility.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Tested-by: Geoffrey McRae <geoff@hostfission.com>
---
 include/hw/i386/pc.h | 4 ++++
 target/i386/cpu.c    | 1 +
 target/i386/cpu.h    | 5 +++++
 3 files changed, 10 insertions(+)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ffee841..d904a3c 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -327,6 +327,10 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .driver   = "q35-pcihost",\
         .property = "x-pci-hole64-fix",\
         .value    = "off",\
+    },{\
+        .driver   = TYPE_X86_CPU,\
+        .property = "legacy-cache",\
+        .value    = "on",\
     },
 
 #define PC_COMPAT_2_9 \
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3b2a19a..1659320 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5129,6 +5129,7 @@ static Property x86_cpu_properties[] = {
                      false),
     DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
     DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
+    DEFINE_PROP_BOOL("legacy-cache", X86CPU, legacy_cache, false),
 
     /*
      * From "Requirements for Implementing the Microsoft
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index aff8396..fe8edf6 100644
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
