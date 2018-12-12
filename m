Received: from eggs.gnu.org ([2001:4830:134:3::10]:52735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6N8-0001NH-9R
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6N5-0000fZ-9w
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:26 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:46536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6N3-0000XV-Dq
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:23 -0500
Received: by mail-wr1-x434.google.com with SMTP id l9so18049536wrt.13
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:24:08 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	u10sm15878859wrr.33.2018.12.12.07.24.06 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 12 Dec 2018 07:24:07 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:23:07 +0100
Message-Id: <1544628195-37728-47-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 46/54] vhost-user-test: use g_cond_broadcast
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
index 45d58d8..656e519 100644
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
