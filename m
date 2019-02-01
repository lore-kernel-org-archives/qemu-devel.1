Received: from eggs.gnu.org ([209.51.188.92]:59102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMF-0008Id-MC
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:08:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMB-0003kq-K2
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:59 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:55109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpbMB-0003fn-8b
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:55 -0500
Received: by mail-wm1-x334.google.com with SMTP id a62so6651364wmh.4
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:07:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id n6sm2847250wmk.9.2019.02.01.08.07.50
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 01 Feb 2019 08:07:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 16:06:50 +0000
Message-Id: <20190201160653.13829-45-peter.maydell@linaro.org>
In-Reply-To: <20190201160653.13829-1-peter.maydell@linaro.org>
References: <20190201160653.13829-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 44/47] target/arm: fix decoding of B{, L}RA{A, B}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Remi Denis-Courmont <remi.denis.courmont@huawei.com>

A flawed test lead to the instructions always being treated as
unallocated encodings.

Fixes: https://bugs.launchpad.net/bugs/1813460
Signed-off-by: Remi Denis-Courmont <remi.denis.courmont@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index b864ac7a69f..a1997e3ae28 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -2036,7 +2036,7 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
         if (!dc_isar_feature(aa64_pauth, s)) {
             goto do_unallocated;
         }
-        if (op3 != 2 || op3 != 3) {
+        if ((op3 & ~1) != 2) {
             goto do_unallocated;
         }
         if (s->pauth_active) {
-- 
2.20.1
