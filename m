Received: from eggs.gnu.org ([2001:4830:134:3::10]:60459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfm-0004b3-6h
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfg-0005jD-4X
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:42 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:34355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHff-0005iY-Tp
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:36 -0400
Received: by mail-wr0-x243.google.com with SMTP id k20so2150455wre.1
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:30:35 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-246-117.clienti.tiscali.it.
	[78.12.246.117]) by smtp.gmail.com with ESMTPSA id
	k18sm1292878wmd.22.2017.09.19.05.30.33 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 19 Sep 2017 05:30:33 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:29:34 +0200
Message-Id: <1505824179-21541-46-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 45/50] target/i386: fix "info mem" for LA57 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/monitor.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index fe7d57b..75e155f 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -447,7 +447,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
     start = -1;
     for (l0 = 0; l0 < 512; l0++) {
         cpu_physical_memory_read(pml5_addr + l0 * 8, &pml5e, 8);
-        pml4e = le64_to_cpu(pml5e);
+        pml5e = le64_to_cpu(pml5e);
         end = l0 << 48;
         if (!(pml5e & PG_PRESENT_MASK)) {
             prot = 0;
@@ -480,7 +480,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
                 if (pdpe & PG_PSE_MASK) {
                     prot = pdpe & (PG_USER_MASK | PG_RW_MASK |
                             PG_PRESENT_MASK);
-                    prot &= pml4e;
+                    prot &= pml5e & pml4e;
                     mem_print(mon, &start, &last_prot, end, prot);
                     continue;
                 }
@@ -499,7 +499,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
                     if (pde & PG_PSE_MASK) {
                         prot = pde & (PG_USER_MASK | PG_RW_MASK |
                                 PG_PRESENT_MASK);
-                        prot &= pml4e & pdpe;
+                        prot &= pml5e & pml4e & pdpe;
                         mem_print(mon, &start, &last_prot, end, prot);
                         continue;
                     }
@@ -513,7 +513,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
                         if (pte & PG_PRESENT_MASK) {
                             prot = pte & (PG_USER_MASK | PG_RW_MASK |
                                     PG_PRESENT_MASK);
-                            prot &= pml4e & pdpe & pde;
+                            prot &= pml5e & pml4e & pdpe & pde;
                         } else {
                             prot = 0;
                         }
-- 
1.8.3.1
