Received: from eggs.gnu.org ([2001:4830:134:3::10]:39228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cv7tl-0005JF-QK
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:44:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cv7tj-0003Bd-9M
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:44:21 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cv7tj-0003B4-2A
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:44:19 -0400
Received: by mail-wr0-x22c.google.com with SMTP id k6so179297808wre.2
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 12:44:18 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Apr 2017 21:44:07 +0200
Message-Id: <20170403194409.21276-5-pbonzini@redhat.com>
In-Reply-To: <20170403194409.21276-1-pbonzini@redhat.com>
References: <20170403194409.21276-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 4/6] nbd: fix memory leak on socket_connect
 failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yaolujing <yaolujing@huawei.com>

From: yaolujing <yaolujing@huawei.com>

When TCP connection fails between nbd server and client,
the local var, sioc, memory leak.

This patch fixes the memory leak.

Signed-off-by: yaolujing <yaolujing@huawei.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1491005709-29989-1-git-send-email-yaolujing@huawei.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/nbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/nbd.c b/block/nbd.c
index 1b832c2..3150712 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -311,6 +311,7 @@ static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
                                     saddr,
                                     &local_err);
     if (local_err) {
+        object_unref(OBJECT(sioc));
         error_propagate(errp, local_err);
         return NULL;
     }
-- 
1.8.3.1
