Received: from eggs.gnu.org ([2001:4830:134:3::10]:47627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRijA-0004RE-C9
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRij4-0002XF-VN
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eRij4-0002Vv-Lu
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:18 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 19:03:48 +0100
Message-Id: <20171220180358.29316-10-pbonzini@redhat.com>
In-Reply-To: <20171220180358.29316-1-pbonzini@redhat.com>
References: <20171220180358.29316-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 09/19] i386: hvf: inject General Protection
 Fault when vmexit through vmcall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>, Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>

From: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>

This patch injects a GP fault when the guest vmexit's by executing a
vmcall instruction.

Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
Message-Id: <20170913090522.4022-15-Sergio.G.DelReal@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf-all.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/hvf-all.c b/target/i386/hvf-all.c
index 8a5b165e62..5cf1ad0d35 100644
--- a/target/i386/hvf-all.c
+++ b/target/i386/hvf-all.c
@@ -898,7 +898,9 @@ int hvf_vcpu_exec(CPUState *cpu)
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
2.14.3
