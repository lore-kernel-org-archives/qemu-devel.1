Received: from eggs.gnu.org ([2001:4830:134:3::10]:34807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gNIgB-0002CG-DV
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:31:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gNIg5-0003r8-GC
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:31:33 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:56144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gNIg5-0003q5-99
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:31:29 -0500
Received: by mail-wm1-x343.google.com with SMTP id y139so1666783wmc.5
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 06:31:28 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Nov 2018 15:31:15 +0100
Message-Id: <20181115143124.19234-2-pbonzini@redhat.com>
In-Reply-To: <20181115143124.19234-1-pbonzini@redhat.com>
References: <20181115143124.19234-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 01/10] vhost-user-test: use g_cond_broadcast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lvivier@redhat.com, mst@redhat.com, jasowang@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

g_cond_signal is rarely the right thing to do, it works now because
vhost-user-test only has two threads but it is not correct in general.
Fix it before adding more calls.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 45d58d8ea2..656e51938b 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -393,7 +393,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
                                             G_N_ELEMENTS(s->fds));
 
         /* signal the test that it can continue */
-        g_cond_signal(&s->data_cond);
+        g_cond_broadcast(&s->data_cond);
         break;
 
     case VHOST_USER_SET_VRING_KICK:
@@ -419,7 +419,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
         p = (uint8_t *) &msg;
         qemu_chr_fe_write_all(chr, p, VHOST_USER_HDR_SIZE);
 
-        g_cond_signal(&s->data_cond);
+        g_cond_broadcast(&s->data_cond);
         break;
 
     case VHOST_USER_SET_VRING_BASE:
-- 
2.19.1
