Received: from eggs.gnu.org ([2001:4830:134:3::10]:48664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fTGuW-0001I1-0Q
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:18:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fTGuR-0007hQ-Ar
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:18:47 -0400
Received: from mail-eopbgr700076.outbound.protection.outlook.com
	([40.107.70.76]:10976
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fTGuR-0007gd-5m
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:18:43 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Wed, 13 Jun 2018 21:18:22 -0400
Message-Id: <1528939107-17193-2-git-send-email-babu.moger@amd.com>
In-Reply-To: <1528939107-17193-1-git-send-email-babu.moger@amd.com>
References: <1528939107-17193-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v14 1/6] i386: Set TOPOEXT unconditionally for
 comapatibility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, babu.moger@amd.com, kash@tripleback.net, geoff@hostfission.com

Enabling TOPOEXT feature might cause compatibility issues if
older kernels does not set this feature. Lets set this feature
unconditionally.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/kvm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 445e0e0..6f2cca7 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -372,6 +372,12 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
         if (host_tsx_blacklisted()) {
             ret &= ~(CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_HLE);
         }
+    } else if (function == 0x80000001 && reg == R_ECX) {
+        /* Enabling topoext feature might cause compatibility issues if
+         * older kernel does not set this feature. Lets set this feature
+         * unconditionally.
+         */
+        ret |= CPUID_EXT3_TOPOEXT;
     } else if (function == 0x80000001 && reg == R_EDX) {
         /* On Intel, kvm returns cpuid according to the Intel spec,
          * so add missing bits according to the AMD spec:
-- 
1.8.3.1
