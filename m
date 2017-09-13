Received: from eggs.gnu.org ([2001:4830:134:3::10]:43198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1ds8po-0003AT-J5
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:40:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1ds8pj-0001Mq-2S
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:40:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:35552 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1ds8pi-0001Lf-S7
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:40:07 -0400
From: Alexander Graf <agraf@suse.de>
Date: Wed, 13 Sep 2017 16:39:58 +0200
Message-Id: <20170913143958.86385-1-agraf@suse.de>
Subject: [Qemu-devel] [PATCH] target-i386: enable kvm_pv_unhalt by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Andrew Jones <drjones@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>

Commit f010bc643a (target-i386: add feature kvm_pv_unhalt) introduced the
kvm_pv_unhalt feature but didn't enable it by default.

Without kvm_pv_unhalt we see a measurable degradation in scheduling
performance, so enabling it by default does make sense IMHO. This patch
just flips it to default to on by default.

  [With kvm_pv_unhalt disabled]
  $ perf bench sched messaging -l 10000
    Total time: 8.573 [sec]

  [With kvm_pv_unhalt enabled]
  $ perf bench sched messaging -l 10000
    Total time: 4.416 [sec]

Signed-off-by: Alexander Graf <agraf@suse.de>

---

Let's ask everyone who was involved back then whether this is a feature
that is good to enable by default. My measurements imply so, but who knows...

Also, I'd kindly like to ask for guidance on how to make this reasonably
well backwards compatible. I assume we only want to flip the default in newer
machine models? If so, how?
---
 target/i386/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 69676e13e1..c58f4ab24f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1581,6 +1581,7 @@ static PropValue kvm_default_props[] = {
     { "kvm-asyncpf", "on" },
     { "kvm-steal-time", "on" },
     { "kvm-pv-eoi", "on" },
+    { "kvm-pv-unhalt", "on" },
     { "kvmclock-stable-bit", "on" },
     { "x2apic", "on" },
     { "acpi", "off" },
-- 
2.12.3
