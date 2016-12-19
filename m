Received: from eggs.gnu.org ([2001:4830:134:3::10]:34145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cIxsO-00076e-RY
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 08:21:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cIxsN-0007aS-Us
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 08:21:12 -0500
Received: from mail.ispras.ru ([83.149.199.45]:46250)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cIxsN-0007aD-Ng
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 08:21:11 -0500
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Mon, 19 Dec 2016 16:21:11 +0300
Message-ID: <20161219132111.3016.50241.stgit@PASHA-ISP>
In-Reply-To: <20161219132102.3016.46687.stgit@PASHA-ISP>
References: <20161219132102.3016.46687.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v6 1/9] icount: update instruction counter on
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, pbonzini@redhat.com

kvmvapic patches the code when some instructions are executed.
E.g. mov 0xff, 0xfffe0080 is interpreted as push 0xff/call ...
This patching is also followed by some side effects (changing apic
and guest memory state). Therefore deterministic execution should take
this operation into account. This patch decreases icount when original
mov instruction is trying to execute. Therefore patching becomes
deterministic and can be replayed correctly.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 hw/i386/kvmvapic.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
index b30d1b9..146d47c 100644
--- a/hw/i386/kvmvapic.c
+++ b/hw/i386/kvmvapic.c
@@ -412,6 +412,12 @@ static void patch_instruction(VAPICROMState *s, X86CPU *cpu, target_ulong ip)
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
