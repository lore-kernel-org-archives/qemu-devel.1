Received: from eggs.gnu.org ([2001:4830:134:3::10]:39179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cv7ti-0005Gr-W0
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cv7th-0003AY-Gq
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:44:19 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:34000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cv7th-00039t-9F
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:44:17 -0400
Received: by mail-wr0-x244.google.com with SMTP id w43so36363138wrb.1
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 12:44:17 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Apr 2017 21:44:05 +0200
Message-Id: <20170403194409.21276-3-pbonzini@redhat.com>
In-Reply-To: <20170403194409.21276-1-pbonzini@redhat.com>
References: <20170403194409.21276-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/6] target-i386: fix "info lapic" segfault on
 isapc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Tejaswini Poluri <tejaswinipoluri3@gmail.com>

From: Tejaswini Poluri <tejaswinipoluri3@gmail.com>

Start QEMU with
"qemu-system-x86_64 -nographic -M isapc -serial none-monitor stdio"
and enter "info lapic" at the monitor prompt â‡’
Segmentation fault

Signed-off-by: Tejaswini Poluri <tejaswinipoluri3@gmail.com>
Message-Id: <1490685583-16987-1-git-send-email-tejaswinipoluri3@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
1.8.3.1
