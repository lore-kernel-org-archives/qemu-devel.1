Received: from eggs.gnu.org ([209.51.188.92]:54463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHN-0001Tp-TH
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:50:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHN-0000d3-2Y
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:50:57 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:37847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1DHM-0000c2-RI
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:50:57 -0500
Received: by mail-wr1-x431.google.com with SMTP id w6so10241406wrs.4
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 08:50:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id 2sm10071495wrg.89.2019.03.05.08.50.54
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Mar 2019 08:50:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Mar 2019 16:50:30 +0000
Message-Id: <20190305165051.26860-2-peter.maydell@linaro.org>
In-Reply-To: <20190305165051.26860-1-peter.maydell@linaro.org>
References: <20190305165051.26860-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/22] target/arm: Fix PC test for LDM
 (exception return)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Found by inspection: Rn is the base register against which the
load began; I is the register within the mask being processed.
The exception return should of course be processed from the loaded PC.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190301202921.21209-1-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 8f7f5b95aab..ad879e3480c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10612,7 +10612,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                             } else if (i == rn) {
                                 loaded_var = tmp;
                                 loaded_base = 1;
-                            } else if (rn == 15 && exc_return) {
+                            } else if (i == 15 && exc_return) {
                                 store_pc_exc_ret(s, tmp);
                             } else {
                                 store_reg_from_load(s, i, tmp);
-- 
2.20.1
