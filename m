Received: from eggs.gnu.org ([2001:4830:134:3::10]:55999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIefA-000518-Mm
	for qemu-devel@nongnu.org; Tue, 15 May 2018 14:27:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIefA-0001di-0x
	for qemu-devel@nongnu.org; Tue, 15 May 2018 14:27:04 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41732)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fIef9-0001dS-QG
	for qemu-devel@nongnu.org; Tue, 15 May 2018 14:27:03 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 19:27:00 +0100
Message-Id: <20180515182700.31736-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] exec.c: Initialize sa_flags passed to
 sigaction()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

Coverity points out that in the user-only version of cpu_abort() we
call sigaction() with a partially initialized struct sigaction
(CID 1005351). Correct the omission.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 exec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/exec.c b/exec.c
index ffa1099547..bd8833fc9d 100644
--- a/exec.c
+++ b/exec.c
@@ -1124,6 +1124,7 @@ void cpu_abort(CPUState *cpu, const char *fmt, ...)
         struct sigaction act;
         sigfillset(&act.sa_mask);
         act.sa_handler = SIG_DFL;
+        act.sa_flags = 0;
         sigaction(SIGABRT, &act, NULL);
     }
 #endif
-- 
2.17.0
