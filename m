Received: from eggs.gnu.org ([2001:4830:134:3::10]:59631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dOd-00028r-8U
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dOc-0001tD-95
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:39 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d5dOc-0001ss-59
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:38 -0400
Received: by mail-qk0-x242.google.com with SMTP id o4so4543192qkb.3
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 12:23:38 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  2 May 2017 12:22:59 -0700
Message-Id: <20170502192300.2124-25-rth@twiddle.net>
In-Reply-To: <20170502192300.2124-1-rth@twiddle.net>
References: <20170502192300.2124-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v6 24/25] target/mips: optimize cross-page
 direct jumps in softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>

From: Aurelien Jarno <aurelien@aurel32.net>

Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Message-Id: <20170430145254.25616-3-aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/mips/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 3022f34..1a7ac07 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4233,7 +4233,7 @@ static inline void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
             save_cpu_state(ctx, 0);
             gen_helper_raise_exception_debug(cpu_env);
         }
-        tcg_gen_exit_tb(0);
+        tcg_gen_lookup_and_goto_ptr(cpu_PC);
     }
 }
 
-- 
2.9.3
