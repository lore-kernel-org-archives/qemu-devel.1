Received: from eggs.gnu.org ([2001:4830:134:3::10]:44195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1fKjNX-0007A3-4Q
	for qemu-devel@nongnu.org; Mon, 21 May 2018 07:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1fKjNT-0005WU-AM
	for qemu-devel@nongnu.org; Mon, 21 May 2018 07:53:27 -0400
Received: from ssl.serverraum.org ([213.133.101.245]:49741)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@walle.cc>) id 1fKjNT-0005W8-4e
	for qemu-devel@nongnu.org; Mon, 21 May 2018 07:53:23 -0400
From: Michael Walle <michael@walle.cc>
Date: Mon, 21 May 2018 13:52:51 +0200
Message-Id: <20180521115252.10759-2-michael@walle.cc>
In-Reply-To: <20180521115252.10759-1-michael@walle.cc>
References: <20180521115252.10759-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] lm32: take BQL before writing IP/IM
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Michael Walle <michael@walle.cc>, qemu-stable@nongnu.org

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
