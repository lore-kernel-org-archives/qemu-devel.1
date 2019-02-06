Received: from eggs.gnu.org ([209.51.188.92]:45407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grKpw-0003lA-TN
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:53:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grKpv-00007A-Rw
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:53:48 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:55695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1grKpv-00006Q-JP
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:53:47 -0500
Received: by mail-wm1-x329.google.com with SMTP id y139so1940714wmc.5
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 02:53:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Feb 2019 10:53:36 +0000
Message-Id: <20190206105337.11559-3-richard.henderson@linaro.org>
In-Reply-To: <20190206105337.11559-1-richard.henderson@linaro.org>
References: <20190206105337.11559-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 2/3] target/hppa: fix setting registers via gdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Sven Schnelle <svens@stackframe.org>

From: Sven Schnelle <svens@stackframe.org>

While doing 'set $pcoqh=0xf0000000' i triggered the assertion below.
The argument order for deposit64() is wrong, and val needs to be
moved to the end.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Message-Id: <20190128165333.3814-1-svens@stackframe.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
index e2e9c4d77f..3157a690f2 100644
--- a/target/hppa/gdbstub.c
+++ b/target/hppa/gdbstub.c
@@ -266,7 +266,7 @@ int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     case 65 ... 127:
         {
             uint64_t *fr = &env->fr[(n - 64) / 2];
-            *fr = deposit64(*fr, val, (n & 1 ? 0 : 32), 32);
+            *fr = deposit64(*fr, (n & 1 ? 0 : 32), 32, val);
         }
         break;
     default:
-- 
2.17.2
