Received: from eggs.gnu.org ([2001:4830:134:3::10]:50239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgf4J-0006sr-AI
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 17:07:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgf4I-0002cC-9j
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 17:07:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cgf4I-0002bw-46
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 17:07:26 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5A282C04B93A
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 22:07:26 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 22 Feb 2017 19:07:09 -0300
Message-Id: <20170222220709.3707-4-ehabkost@redhat.com>
In-Reply-To: <20170222220709.3707-1-ehabkost@redhat.com>
References: <20170222220709.3707-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/3] i386: Change stepping of Haswell to
 non-blacklisted value
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

glibc blacklists TSX on Haswell CPUs with model==60 and
stepping < 4. To make the Haswell CPU model more useful, make
those guests actually use TSX by changing CPU stepping to 4.

References:
* glibc commit 2702856bf45c82cf8e69f2064f5aa15c0ceb6359
  https://sourceware.org/git/?p=glibc.git;a=commit;h=2702856bf45c82cf8e69f2064f5aa15c0ceb6359

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/i386/pc.h | 5 +++++
 target/i386/cpu.c    | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 079e8d9393..2ada479138 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -390,6 +390,11 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .driver   = TYPE_X86_CPU,\
         .property = "vmware-cpuid-freq",\
         .value    = "off",\
+    },\
+    {\
+        .driver   = "Haswell-" TYPE_X86_CPU,\
+        .property = "stepping",\
+        .value    = "1",\
     },
 
 #define PC_COMPAT_2_7 \
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a8e4f37e27..eab1ad7935 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1190,7 +1190,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .vendor = CPUID_VENDOR_INTEL,
         .family = 6,
         .model = 60,
-        .stepping = 1,
+        .stepping = 4,
         .features[FEAT_1_EDX] =
             CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
             CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
-- 
2.11.0.259.g40922b1
