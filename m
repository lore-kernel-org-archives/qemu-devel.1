Received: from eggs.gnu.org ([2001:4830:134:3::10]:45347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f20Be-000791-3Z
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 15:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f20Bd-0001o8-9u
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 15:59:46 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:42123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1f20Bd-0001nO-1W
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 15:59:45 -0400
Received: by mail-lf0-x241.google.com with SMTP id a22-v6so13727149lfg.9
	for <qemu-devel@nongnu.org>; Fri, 30 Mar 2018 12:59:44 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 30 Mar 2018 12:59:28 -0700
Message-Id: <20180330195928.15607-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] target/xtensa: linux-user: rewind pc for
 restarted syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

In case of syscall restart request set pc back to the syscall
instruction.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 linux-user/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/main.c b/linux-user/main.c
index ba09b7d0c873..8907a8411411 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4006,6 +4006,9 @@ void cpu_loop(CPUXtensaState *env)
                     break;
 
                 case -TARGET_ERESTARTSYS:
+                    env->pc -= 3;
+                    break;
+
                 case -TARGET_QEMU_ESIGRETURN:
                     break;
                 }
-- 
2.11.0
