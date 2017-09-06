Received: from eggs.gnu.org ([2001:4830:134:3::10]:53872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpc8w-0004Ax-Sg
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:21:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpc8q-0006xr-TS
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:21:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dpc8q-0006xL-N2
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:21:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C5176883D6
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 15:21:23 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Wed,  6 Sep 2017 10:21:09 -0500
Message-Id: <20170906152111.16958-4-eblake@redhat.com>
In-Reply-To: <20170906152111.16958-1-eblake@redhat.com>
References: <20170906152111.16958-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 3/5] io: Yield rather than wait when already in
 coroutine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The new qio_channel_{read,write}{,v}_all functions are documented
as yielding until data is available.  When used on a blocking
channel, this yield is done via qio_channel_wait() which spawns
a nested event loop under the hood (so it is that secondary loop
which yields as needed); but if we are already in a coroutine (at
which point QIO_CHANNEL_ERR_BLOCK is only possible if we are a
non-blocking channel), we want to yield the current coroutine
instead of spawning a nested event loop.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170905191114.5959-2-eblake@redhat.com>
Acked-by: Daniel P. Berrange <berrange@redhat.com>
[commit message updated]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 io/channel.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/io/channel.c b/io/channel.c
index 5e8c2f0a91..9e62794cab 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -105,7 +105,11 @@ int qio_channel_readv_all(QIOChannel *ioc,
         ssize_t len;
         len = qio_channel_readv(ioc, local_iov, nlocal_iov, errp);
         if (len == QIO_CHANNEL_ERR_BLOCK) {
-            qio_channel_wait(ioc, G_IO_IN);
+            if (qemu_in_coroutine()) {
+                qio_channel_yield(ioc, G_IO_IN);
+            } else {
+                qio_channel_wait(ioc, G_IO_IN);
+            }
             continue;
         } else if (len < 0) {
             goto cleanup;
@@ -143,7 +147,11 @@ int qio_channel_writev_all(QIOChannel *ioc,
         ssize_t len;
         len = qio_channel_writev(ioc, local_iov, nlocal_iov, errp);
         if (len == QIO_CHANNEL_ERR_BLOCK) {
-            qio_channel_wait(ioc, G_IO_OUT);
+            if (qemu_in_coroutine()) {
+                qio_channel_yield(ioc, G_IO_OUT);
+            } else {
+                qio_channel_wait(ioc, G_IO_OUT);
+            }
             continue;
         }
         if (len < 0) {
-- 
2.13.5
