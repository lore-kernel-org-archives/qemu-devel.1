Received: from eggs.gnu.org ([2001:4830:134:3::10]:50219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgf4H-0006rO-GO
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 17:07:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgf4G-0002bh-BG
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 17:07:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cgf4G-0002bT-5u
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 17:07:24 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6AC1D3D95F
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 22:07:24 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 22 Feb 2017 19:07:08 -0300
Message-Id: <20170222220709.3707-3-ehabkost@redhat.com>
In-Reply-To: <20170222220709.3707-1-ehabkost@redhat.com>
References: <20170222220709.3707-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/3] i386/kvm: Blacklist TSX on known broken
 hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com

Some Intel CPUs are known to have a broken TSX implementation. A
microcode update from Intel disabled TSX on those CPUs, but
GET_SUPPORTED_CPUID might be reporting it as supported if the
hosts were not updated yet.

Manually fixup the GET_SUPPORTED_CPUID data to ensure we will
never enable TSX when running on those hosts.

Reference:
* glibc commit 2702856bf45c82cf8e69f2064f5aa15c0ceb6359:
  https://sourceware.org/git/?p=glibc.git;a=commit;h=2702856bf45c82cf8e69f2064f5aa15c0ceb6359

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/kvm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 27fd0505df..2694f35e74 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -273,6 +273,19 @@ static int get_para_features(KVMState *s)
     return features;
 }
 
+static bool host_tsx_blacklisted(void)
+{
+    int family, model, stepping;\
+    char vendor[CPUID_VENDOR_SZ + 1];
+
+    host_vendor_fms(vendor, &family, &model, &stepping);
+
+    /* Check if we are running on a Haswell host known to have broken TSX */
+    return !strcmp(vendor, CPUID_VENDOR_INTEL) &&
+           (family == 6) &&
+           ((model == 63 && stepping < 4) ||
+            model == 60 || model == 69 || model == 70);
+}
 
 /* Returns the value for a specific register on the cpuid entry
  */
@@ -356,6 +369,10 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
         }
     } else if (function == 6 && reg == R_EAX) {
         ret |= CPUID_6_EAX_ARAT; /* safe to allow because of emulated APIC */
+    } else if (function == 7 && index == 0 && reg == R_EBX) {
+        if (host_tsx_blacklisted()) {
+            ret &= ~(CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_HLE);
+        }
     } else if (function == 0x80000001 && reg == R_EDX) {
         /* On Intel, kvm returns cpuid according to the Intel spec,
          * so add missing bits according to the AMD spec:
-- 
2.11.0.259.g40922b1
