Received: from eggs.gnu.org ([2001:4830:134:3::10]:38003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1fKn5s-00049S-Gs
	for qemu-devel@nongnu.org; Mon, 21 May 2018 11:51:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1fKn5o-00047K-LX
	for qemu-devel@nongnu.org; Mon, 21 May 2018 11:51:28 -0400
From: Michael Walle <michael@walle.cc>
Date: Mon, 21 May 2018 17:49:52 +0200
Message-Id: <20180521154952.15421-2-michael@walle.cc>
In-Reply-To: <20180521154952.15421-1-michael@walle.cc>
References: <20180521154952.15421-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/1] lm32: take BQL before writing IP/IM register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, qemu-stable@nongnu.org

Writing to these registers may raise an interrupt request. Actually,
this prevents the milkymist board from starting.

Cc: qemu-stable@nongnu.org
Signed-off-by: Michael Walle <michael@walle.cc>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 target/lm32/op_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/lm32/op_helper.c b/target/lm32/op_helper.c
index 577f8306e3..234d55e056 100644
--- a/target/lm32/op_helper.c
+++ b/target/lm32/op_helper.c
@@ -102,12 +102,16 @@ void HELPER(wcsr_dc)(CPULM32State *env, uint32_t dc=
)
=20
 void HELPER(wcsr_im)(CPULM32State *env, uint32_t im)
 {
+    qemu_mutex_lock_iothread();
     lm32_pic_set_im(env->pic_state, im);
+    qemu_mutex_unlock_iothread();
 }
=20
 void HELPER(wcsr_ip)(CPULM32State *env, uint32_t im)
 {
+    qemu_mutex_lock_iothread();
     lm32_pic_set_ip(env->pic_state, im);
+    qemu_mutex_unlock_iothread();
 }
=20
 void HELPER(wcsr_jtx)(CPULM32State *env, uint32_t jtx)
--=20
2.11.0
