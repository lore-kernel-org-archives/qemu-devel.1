Received: from eggs.gnu.org ([2001:4830:134:3::10]:34868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gNIgJ-0002HT-2U
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:31:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gNIgB-0003wf-EH
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:31:39 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gNIg7-0003qZ-CH
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:31:33 -0500
Received: by mail-wr1-x443.google.com with SMTP id k15-v6so21407569wre.12
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 06:31:29 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Nov 2018 15:31:16 +0100
Message-Id: <20181115143124.19234-3-pbonzini@redhat.com>
In-Reply-To: <20181115143124.19234-1-pbonzini@redhat.com>
References: <20181115143124.19234-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 02/10] vhost-user-test: signal data_cond when
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
Cc: lvivier@redhat.com, mst@redhat.com, jasowang@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This speeds up wait_for_rings_started, which currently is just waiting for
the timeout before checking s->rings.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 656e51938b..6a805e67be 100644
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
2.19.1
