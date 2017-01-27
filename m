Received: from eggs.gnu.org ([2001:4830:134:3::10]:33267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6qj-0004ps-7F
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:45:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6qg-0003mV-Oq
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:45:57 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6qg-0003mE-IT
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:45:54 -0500
Received: by mail-wm0-x243.google.com with SMTP id d140so58621545wmd.2
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:45:54 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:09 +0100
Message-Id: <1485524749-118532-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 01/41] icount: update instruction counter on
 apic patching
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

kvmvapic patches the code when some instructions are executed.
E.g. mov 0xff, 0xfffe0080 is interpreted as push 0xff/call ...
This patching is also followed by some side effects (changing apic
and guest memory state). Therefore deterministic execution should take
this operation into account. This patch decreases icount when original
mov instruction is trying to execute. Therefore patching becomes
deterministic and can be replayed correctly.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Message-Id: <20170124071702.4572.17294.stgit@PASHA-ISP>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/kvmvapic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
index 2f767b6..6804661 100644
--- a/hw/i386/kvmvapic.c
+++ b/hw/i386/kvmvapic.c
@@ -413,6 +413,12 @@ static void patch_instruction(VAPICROMState *s, X86CPU *cpu, target_ulong ip)
     if (!kvm_enabled()) {
         cpu_get_tb_cpu_state(env, &current_pc, &current_cs_base,
                              &current_flags);
+        /* Account this instruction, because we will exit the tb.
+           This is the first instruction in the block. Therefore
+           there is no need in restoring CPU state. */
+        if (use_icount) {
+            --cs->icount_decr.u16.low;
+        }
     }
 
     pause_all_vcpus();
-- 
1.8.3.1
