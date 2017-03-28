Received: from eggs.gnu.org ([2001:4830:134:3::10]:56225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tejaswinipoluri3@gmail.com>) id 1cslQ5-0007LV-5X
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 03:19:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tejaswinipoluri3@gmail.com>) id 1cslQ0-00032m-8A
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 03:19:57 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:35972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tejaswinipoluri3@gmail.com>)
	id 1cslQ0-00032Z-25
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 03:19:52 -0400
Received: by mail-pg0-x242.google.com with SMTP id 81so19139703pgh.3
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 00:19:52 -0700 (PDT)
From: Tejaswini <tejaswinipoluri3@gmail.com>
Date: Tue, 28 Mar 2017 12:49:43 +0530
Message-Id: <1490685583-16987-1-git-send-email-tejaswinipoluri3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] target-i386: fix "info lapic" segfault on isapc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, Tejaswini Poluri <tejaswinipoluri3@gmail.com>

From: Tejaswini Poluri <tejaswinipoluri3@gmail.com>

Start QEMU with
"qemu-system-x86_64 -nographic -M isapc -serial none-monitor stdio"
and enter "info lapic" at the monitor prompt ⇒
Segmentation fault

Signed-off-by: Tejaswini Poluri <tejaswinipoluri3@gmail.com>
---
 target/i386/helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index e2af340..f11cac6 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -326,6 +326,10 @@ void x86_cpu_dump_local_apic_state(CPUState *cs, FILE *f,
 {
     X86CPU *cpu = X86_CPU(cs);
     APICCommonState *s = APIC_COMMON(cpu->apic_state);
+    if (!s) {
+        cpu_fprintf(f, "local apic state not available\n");
+        return;
+    }
     uint32_t *lvt = s->lvt;
 
     cpu_fprintf(f, "dumping local APIC state for CPU %-2u\n\n",
-- 
2.7.4
