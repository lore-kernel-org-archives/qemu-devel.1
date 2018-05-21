Received: from eggs.gnu.org ([2001:4830:134:3::10]:44183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1fKjNV-00079w-VU
	for qemu-devel@nongnu.org; Mon, 21 May 2018 07:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1fKjNV-0005XJ-9s
	for qemu-devel@nongnu.org; Mon, 21 May 2018 07:53:26 -0400
Received: from ssl.serverraum.org ([2a01:4f8:222:d45::1:2]:37391)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@walle.cc>) id 1fKjNV-0005Wu-41
	for qemu-devel@nongnu.org; Mon, 21 May 2018 07:53:25 -0400
From: Michael Walle <michael@walle.cc>
Date: Mon, 21 May 2018 13:52:52 +0200
Message-Id: <20180521115252.10759-3-michael@walle.cc>
In-Reply-To: <20180521115252.10759-1-michael@walle.cc>
References: <20180521115252.10759-1-michael@walle.cc>
Subject: [Qemu-devel] [PATCH 2/2] target/lm32: hold BQL in gdbstub
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

Changing the IP/IM registers may cause interrupts, so hold the BQL.

Cc: qemu-stable@nongnu.org
Signed-off-by: Michael Walle <michael@walle.cc>
---
 target/lm32/gdbstub.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/lm32/gdbstub.c b/target/lm32/gdbstub.c
index cf929dd392..2cdeef8f5e 100644
--- a/target/lm32/gdbstub.c
+++ b/target/lm32/gdbstub.c
@@ -82,10 +82,14 @@ int lm32_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
             env->ie = tmp;
             break;
         case 37:
+            qemu_mutex_lock_iothread();
             lm32_pic_set_im(env->pic_state, tmp);
+            qemu_mutex_unlock_iothread();
             break;
         case 38:
+            qemu_mutex_lock_iothread();
             lm32_pic_set_ip(env->pic_state, tmp);
+            qemu_mutex_unlock_iothread();
             break;
         }
     }
-- 
2.11.0
