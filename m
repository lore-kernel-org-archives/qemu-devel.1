Received: from eggs.gnu.org ([209.51.188.92]:59275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj6r-00052Y-Ey
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:36:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj6p-0003TW-To
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:36:45 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:40246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gqj6p-0003G4-LL
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:36:43 -0500
Received: by mail-wr1-x42e.google.com with SMTP id p4so943893wrt.7
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 10:36:22 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	s132sm8836236wmf.28.2019.02.04.10.36.20 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 04 Feb 2019 10:36:21 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Feb 2019 19:35:03 +0100
Message-Id: <1549305379-51117-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
References: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/77] vhost-user-test: use g_cond_broadcast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

g_cond_signal is rarely the right thing to do, it works now because
vhost-user-test only has two threads but it is not correct in general.
Fix it before adding more calls.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1543851204-41186-7-git-send-email-pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 84e50d8..9baaff4 100644
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
1.8.3.1
