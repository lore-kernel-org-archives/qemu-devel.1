Received: from eggs.gnu.org ([209.51.188.92]:51507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldy1-0004GJ-I4
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldxz-00041Y-PF
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:37 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:50433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gldxy-0003yP-BL
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:34 -0500
Received: by mail-wm1-x329.google.com with SMTP id n190so11755785wmd.0
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:06:33 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	133sm56197732wme.9.2019.01.21.10.06.30 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 21 Jan 2019 10:06:31 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Jan 2019 19:05:40 +0100
Message-Id: <1548093980-43088-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
References: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/49] vhost-user-test: signal data_cond when
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
index 52c4d39..409157d 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -387,6 +387,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
 
         assert(msg.payload.state.index < s->queues * 2);
         s->rings &= ~(0x1ULL << msg.payload.state.index);
+        g_cond_broadcast(&s->data_cond);
         break;
 
     case VHOST_USER_SET_MEM_TABLE:
@@ -428,6 +429,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
     case VHOST_USER_SET_VRING_BASE:
         assert(msg.payload.state.index < s->queues * 2);
         s->rings |= 0x1ULL << msg.payload.state.index;
+        g_cond_broadcast(&s->data_cond);
         break;
 
     case VHOST_USER_GET_QUEUE_NUM:
-- 
1.8.3.1
