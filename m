Received: from eggs.gnu.org ([2001:4830:134:3::10]:60612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1dmyLt-0002g9-NG
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:27:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1dmyLp-0000S0-OP
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:27:57 -0400
Received: from mail-ua0-x241.google.com ([2607:f8b0:400c:c08::241]:34721)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sergio.g.delreal@gmail.com>)
	id 1dmyLp-0000Rs-KV
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:27:53 -0400
Received: by mail-ua0-x241.google.com with SMTP id 105so2346980uad.1
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 01:27:53 -0700 (PDT)
From: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Date: Wed, 30 Aug 2017 03:27:02 -0500
Message-Id: <20170830082702.3011-14-Sergio.G.DelReal@gmail.com>
In-Reply-To: <20170830082702.3011-1-Sergio.G.DelReal@gmail.com>
References: <20170830082702.3011-1-Sergio.G.DelReal@gmail.com>
Subject: [Qemu-devel] [PATCH v2 13/13] hvf: inject General Protection Fault
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
Cc: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>

This commit injects a GP fault when the guest vmexit's by executing a
vmcall instruction.

Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
---
 target/i386/hvf-all.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/hvf-all.c b/target/i386/hvf-all.c
index 430affd9ce..ccd19bd629 100644
--- a/target/i386/hvf-all.c
+++ b/target/i386/hvf-all.c
@@ -1076,7 +1076,9 @@ int hvf_vcpu_exec(CPUState *cpu)
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
