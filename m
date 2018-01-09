Received: from eggs.gnu.org ([2001:4830:134:3::10]:49377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1eYxJE-0007bc-1Q
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:03:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1eYxJA-0007Hr-Sx
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:03:32 -0500
From: Michael Walle <michael@walle.cc>
Date: Tue,  9 Jan 2018 18:01:13 +0100
Message-Id: <20180109170113.20768-1-michael@walle.cc>
In-Reply-To: <CAFEAcA-pjg34=bPe7EiYN6oYC_3xuMCyiucPwZrka2Fxxrk3DQ@mail.gmail.com>
References: <CAFEAcA-pjg34=bPe7EiYN6oYC_3xuMCyiucPwZrka2Fxxrk3DQ@mail.gmail.com>
Subject: [Qemu-devel] [PATCH] lm32: take BQL before writing IP/IM register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Programmingkid <programmingkidx@gmail.com>, Michael Walle <michael@walle.cc>, qemu-stable@nongnu.org

Writing to these registers may raise an interrupt request. Actually,
this prevents the milkymist board from starting.

Cc: qemu-stable@nongnu.org
Signed-off-by: Michael Walle <michael@walle.cc>
---
 target/lm32/op_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/lm32/op_helper.c b/target/lm32/op_helper.c
index 30f670eee8..a766a1ece4 100644
--- a/target/lm32/op_helper.c
+++ b/target/lm32/op_helper.c
@@ -102,12 +102,16 @@ void HELPER(wcsr_dc)(CPULM32State *env, uint32_t dc)
 
 void HELPER(wcsr_im)(CPULM32State *env, uint32_t im)
 {
+    qemu_mutex_lock_iothread();
     lm32_pic_set_im(env->pic_state, im);
+    qemu_mutex_unlock_iothread();
 }
 
 void HELPER(wcsr_ip)(CPULM32State *env, uint32_t im)
 {
+    qemu_mutex_lock_iothread();
     lm32_pic_set_ip(env->pic_state, im);
+    qemu_mutex_unlock_iothread();
 }
 
 void HELPER(wcsr_jtx)(CPULM32State *env, uint32_t jtx)
-- 
2.11.0
