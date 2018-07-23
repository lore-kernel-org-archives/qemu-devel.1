Received: from eggs.gnu.org ([2001:4830:134:3::10]:40731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhIK-0001V8-V1
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhIJ-0002Xf-Ba
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:00 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:16:26 -0500
Message-Id: <20180723201748.25573-18-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 17/99] lm32: take BQL before writing IP/IM
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Walle <michael@walle.cc>

From: Michael Walle <michael@walle.cc>

Writing to these registers may raise an interrupt request. Actually,
this prevents the milkymist board from starting.

Cc: qemu-stable@nongnu.org
Signed-off-by: Michael Walle <michael@walle.cc>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
(cherry picked from commit 81e9cbd0ca1131012b058df6804b1f626a6b730c)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/lm32/op_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/lm32/op_helper.c b/target/lm32/op_helper.c
index 577f8306e3..234d55e056 100644
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
2.17.1
