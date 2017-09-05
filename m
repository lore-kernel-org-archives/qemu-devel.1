Received: from eggs.gnu.org ([2001:4830:134:3::10]:41734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1dp4y1-0001y8-Va
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:56:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1dp4xw-0008E9-PS
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:56:02 -0400
Received: from mail-vk0-x243.google.com ([2607:f8b0:400c:c05::243]:37787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sergio.g.delreal@gmail.com>)
	id 1dp4xw-0008DY-Jw
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:55:56 -0400
Received: by mail-vk0-x243.google.com with SMTP id 184so713224vkn.4
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 20:55:56 -0700 (PDT)
From: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Date: Mon,  4 Sep 2017 22:54:57 -0500
Message-Id: <20170905035457.3753-15-Sergio.G.DelReal@gmail.com>
In-Reply-To: <20170905035457.3753-1-Sergio.G.DelReal@gmail.com>
References: <20170905035457.3753-1-Sergio.G.DelReal@gmail.com>
Subject: [Qemu-devel] [PATCH v3 14/14] hvf: inject General Protection Fault
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

This commit injects a GP fault when the guest vmexit's by executing a
vmcall instruction.

Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
---
 target/i386/hvf-all.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/hvf-all.c b/target/i386/hvf-all.c
index 8fc6a0b5d1..cdf4d6f8e7 100644
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
