Received: from eggs.gnu.org ([2001:4830:134:3::10]:34145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1ds3cT-0001d1-Jz
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:06:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1ds3cS-0007bl-DA
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:06:05 -0400
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:36913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sergio.g.delreal@gmail.com>)
	id 1ds3cS-0007bZ-A5
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:06:04 -0400
Received: by mail-vk0-x242.google.com with SMTP id 184so3319699vkn.4
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 02:06:04 -0700 (PDT)
From: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Date: Wed, 13 Sep 2017 04:05:22 -0500
Message-Id: <20170913090522.4022-15-Sergio.G.DelReal@gmail.com>
In-Reply-To: <20170913090522.4022-1-Sergio.G.DelReal@gmail.com>
References: <20170913090522.4022-1-Sergio.G.DelReal@gmail.com>
Subject: [Qemu-devel] [PATCH v4 14/14] hvf: inject General Protection Fault
 when vmexit through vmcall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, stefanha@gmail.com, Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>

This patch injects a GP fault when the guest vmexit's by executing a
vmcall instruction.

Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
---
 target/i386/hvf-all.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/hvf-all.c b/target/i386/hvf-all.c
index 105a63ad4f..0a544470ad 100644
--- a/target/i386/hvf-all.c
+++ b/target/i386/hvf-all.c
@@ -903,7 +903,9 @@ int hvf_vcpu_exec(CPUState *cpu)
             macvm_set_rip(cpu, rip + ins_len);
             break;
         case VMX_REASON_VMCALL:
-            /* TODO: inject #GP fault */
+            env->exception_injected = EXCP0D_GPF;
+            env->has_error_code = true;
+            env->error_code = 0;
             break;
         default:
             error_report("%llx: unhandled exit %llx\n", rip, exit_reason);
-- 
2.14.1
