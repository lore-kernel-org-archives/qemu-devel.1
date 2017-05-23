Received: from eggs.gnu.org ([2001:4830:134:3::10]:38786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dD8xb-0005lm-Iz
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dD8xV-000135-TL
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:30:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dD8xV-00012F-MU
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:30:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A381EC057EC9
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 12:30:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-98.ams2.redhat.com
	[10.36.116.98])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 68C277A4CD
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 12:30:40 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 23 May 2017 14:30:31 +0200
Message-Id: <1495542638-12335-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1495542638-12335-1-git-send-email-armbru@redhat.com>
References: <1495542638-12335-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 2/9] sockets: Plug memory leak in
 socket_address_flatten()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

socket_address_flatten() leaks a SocketAddress when its argument is
null.  Happens when opening a ChardevBackend of type 'udp' that is
configured without a local address.  Screwed up in commit bd269ebc due
to last minute semantic conflict resolution.  Spotted by Coverity.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1494866344-11013-1-git-send-email-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 util/qemu-sockets.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index d8183f7..b39ae74 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -1338,12 +1338,14 @@ char *socket_address_to_string(struct SocketAddress *addr, Error **errp)
 
 SocketAddress *socket_address_flatten(SocketAddressLegacy *addr_legacy)
 {
-    SocketAddress *addr = g_new(SocketAddress, 1);
+    SocketAddress *addr;
 
     if (!addr_legacy) {
         return NULL;
     }
 
+    addr = g_new(SocketAddress, 1);
+
     switch (addr_legacy->type) {
     case SOCKET_ADDRESS_LEGACY_KIND_INET:
         addr->type = SOCKET_ADDRESS_TYPE_INET;
-- 
2.7.4
