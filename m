Received: from eggs.gnu.org ([2001:4830:134:3::10]:36813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3Mm-0007bA-53
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3Ml-0003fD-4E
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:48 -0400
Received: from mail-lf0-x231.google.com ([2a00:1450:4010:c07::231]:33188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1dG3Mk-0003f1-TS
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:47 -0400
Received: by mail-lf0-x231.google.com with SMTP id m18so8647387lfj.0
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 06:08:46 -0700 (PDT)
From: riku.voipio@linaro.org
Date: Wed, 31 May 2017 16:08:22 +0300
Message-Id: <d8b6d892c66c1b6f505cd5a2576e08deea200e6d.1496234767.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1496234766.git.riku.voipio@linaro.org>
References: <cover.1496234766.git.riku.voipio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/15] linux-user: fix mismatch of
 lock/unlock_user() invocations in rt_sigqueinfo() syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, stefanha@redhat.com, =?UTF-8?q?Milo=C5=A1=20Stojanovi=C4=87?= <Milos.Stojanovic@rt-rk.com>

From: Miloš Stojanović <Milos.Stojanovic@rt-rk.com>

Change the unlock_user() argument from arg1 to arg3 to match with
lock_user(), since arg3 contains the pointer to the siginfo_t structure.

Signed-off-by: Miloš Stojanović <Milos.Stojanovic@rt-rk.com>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 93bc6f679e..de85bce167 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8868,7 +8868,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                 goto efault;
             }
             target_to_host_siginfo(&uinfo, p);
-            unlock_user(p, arg1, 0);
+            unlock_user(p, arg3, 0);
             ret = get_errno(sys_rt_sigqueueinfo(arg1, arg2, &uinfo));
         }
         break;
-- 
2.11.0
