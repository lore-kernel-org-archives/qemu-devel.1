Received: from eggs.gnu.org ([209.51.188.92]:35803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5GH-0002Jm-Tm
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5GG-0003kg-HZ
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:15:57 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:40705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gr5GG-0003Ta-47
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:15:56 -0500
Received: by mail-wr1-x432.google.com with SMTP id p4so4706195wrt.7
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:15:30 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
	by smtp.gmail.com with ESMTPSA id p5sm8931665wmh.16.2019.02.05.10.15.28
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Feb 2019 10:15:28 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Feb 2019 19:14:12 +0100
Message-Id: <1549390526-24246-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/76] vhost-user-test: signal data_cond when
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
index 9baaff4..8eb7943 100644
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
