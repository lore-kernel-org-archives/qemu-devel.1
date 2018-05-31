Received: from eggs.gnu.org ([2001:4830:134:3::10]:58705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8h-0003ol-1J
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8g-0000M2-8Q
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59684 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOR8g-0000LR-3w
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:26 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:12:33 +0200
Message-Id: <20180531171253.21012-34-pbonzini@redhat.com>
In-Reply-To: <20180531171253.21012-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 33/53] exec.c: Initialize sa_flags passed to
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
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

Coverity points out that in the user-only version of cpu_abort() we
call sigaction() with a partially initialized struct sigaction
(CID 1005351). Correct the omission.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20180515182700.31736-1-peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
