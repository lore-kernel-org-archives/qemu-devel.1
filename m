Received: from eggs.gnu.org ([2001:4830:134:3::10]:54376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cQJKz-0005QU-OW
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 14:41:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cQJKy-0008QO-Jq
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 14:41:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cQJKy-0008QC-Da
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 14:41:04 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8CFDB83F47
	for <qemu-devel@nongnu.org>; Sun,  8 Jan 2017 19:41:04 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Sun,  8 Jan 2017 17:40:41 -0200
Message-Id: <20170108194041.10908-6-ehabkost@redhat.com>
In-Reply-To: <20170108194041.10908-1-ehabkost@redhat.com>
References: <20170108194041.10908-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] i386: Change stepping of Haswell to
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
 include/hw/i386/pc.h | 6 +++++-
 target/i386/cpu.c    | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 230e9e70c5..fcd9b4f541 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -376,7 +376,11 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
 #define PC_COMPAT_2_8 \
     HW_COMPAT_2_8 \
-
+    {\
+        .driver   = "Haswell-" TYPE_X86_CPU,\
+        .property = "stepping",\
+        .value    = "1",\
+    },
 
 #define PC_COMPAT_2_7 \
     HW_COMPAT_2_7 \
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9dbb2d98da..003de7e74f 100644
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
