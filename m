Received: from eggs.gnu.org ([2001:4830:134:3::10]:41192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSPP-0000D8-Mw
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSPL-0007hH-Lx
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:51 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:34308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSPL-0007ge-FL
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:47 -0400
Received: by mail-wr0-x231.google.com with SMTP id 77so16401108wrb.1
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:47 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:52 +0200
Message-Id: <1497523981-38449-33-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 32/41] nbd/server: nbd_negotiate: fix error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Current code will return 0 on this nbd_write fail, as rc is 0
after successful nbd_negotiate_options. Fix this.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170602150150.258222-10-vsementsov@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 nbd/server.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/nbd/server.c b/nbd/server.c
index d526827..c9ca847 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -607,7 +607,8 @@ static coroutine_fn int nbd_negotiate(NBDClient *client)
         stq_be_p(buf + 18, client->exp->size);
         stw_be_p(buf + 26, client->exp->nbdflags | myflags);
         len = client->no_zeroes ? 10 : sizeof(buf) - 18;
-        if (nbd_write(client->ioc, buf + 18, len, NULL) < 0) {
+        rc = nbd_write(client->ioc, buf + 18, len, NULL);
+        if (rc < 0) {
             LOG("write failed");
             goto fail;
         }
-- 
1.8.3.1
