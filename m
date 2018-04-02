Received: from eggs.gnu.org ([2001:4830:134:3::10]:36365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f332F-0004GC-G8
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 13:14:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f332E-0004ao-Op
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 13:14:23 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:37379)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1f332E-0004aZ-I4
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 13:14:22 -0400
Received: by mail-wr0-x244.google.com with SMTP id l49so14752227wrl.4
	for <qemu-devel@nongnu.org>; Mon, 02 Apr 2018 10:14:22 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon,  2 Apr 2018 10:13:48 -0700
Message-Id: <20180402171354.27706-3-jcmvbkbc@gmail.com>
In-Reply-To: <20180402171354.27706-1-jcmvbkbc@gmail.com>
References: <20180402171354.27706-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PULL 2/8] target/xtensa: linux-user: rewind pc for
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

In case of syscall restart request set pc back to the syscall
instruction.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
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
