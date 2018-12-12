Received: from eggs.gnu.org ([2001:4830:134:3::10]:52782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6N9-0001NO-NN
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6N5-0000ga-VV
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:27 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:39692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6N5-0000YH-MC
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:23 -0500
Received: by mail-wr1-x436.google.com with SMTP id t27so18088871wra.6
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:24:10 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	u10sm15878859wrr.33.2018.12.12.07.24.07 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 12 Dec 2018 07:24:07 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:23:08 +0100
Message-Id: <1544628195-37728-48-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 47/54] vhost-user-test: signal data_cond when
 s->rings changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This speeds up wait_for_rings_started, which currently is just waiting for
the timeout before checking s->rings.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1543851204-41186-8-git-send-email-pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 656e519..6a805e6 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -384,6 +384,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
 
         assert(msg.payload.state.index < s->queues * 2);
         s->rings &= ~(0x1ULL << msg.payload.state.index);
+        g_cond_broadcast(&s->data_cond);
         break;
 
     case VHOST_USER_SET_MEM_TABLE:
@@ -425,6 +426,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
     case VHOST_USER_SET_VRING_BASE:
         assert(msg.payload.state.index < s->queues * 2);
         s->rings |= 0x1ULL << msg.payload.state.index;
+        g_cond_broadcast(&s->data_cond);
         break;
 
     case VHOST_USER_GET_QUEUE_NUM:
-- 
1.8.3.1
