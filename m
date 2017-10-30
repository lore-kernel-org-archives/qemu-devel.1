Received: from eggs.gnu.org ([2001:4830:134:3::10]:52832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e988A-0005Pc-Ti
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 07:21:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e9888-0007jR-9U
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 07:21:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e9888-0007j2-30
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 07:21:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E5522D6A27
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 11:21:19 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 30 Oct 2017 12:21:07 +0100
Message-Id: <20171030112112.6952-2-quintela@redhat.com>
In-Reply-To: <20171030112112.6952-1-quintela@redhat.com>
References: <20171030112112.6952-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 1/6] qio: Make port 0 work for qio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, "Daniel P . Berrange" <berrange@redhat.com>

For tcp sockets we read back what is the socket/address.  So we know
what is the port that we are listening into.

Looked all callers of the function, and they just create the addr, use
it, and drop it, so no problem that we always update the port in the
address.

Signed-off-by: Juan Quintela <quintela@redhat.com>
CC: Daniel P. Berrange <berrange@redhat.com>
---
 util/qemu-sockets.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index b47fb45885..b099c88dd1 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -322,13 +322,16 @@ listen_failed:
 
 listen_ok:
     if (update_addr) {
+        SocketAddress *addr;
+
+        addr = socket_local_address(slisten, errp);
         g_free(saddr->host);
-        saddr->host = g_strdup(uaddr);
+        saddr->host = g_strdup(addr->u.inet.host);
         g_free(saddr->port);
-        saddr->port = g_strdup_printf("%d",
-                                      inet_getport(e) - port_offset);
+        saddr->port = g_strdup(addr->u.inet.port);
         saddr->has_ipv6 = saddr->ipv6 = e->ai_family == PF_INET6;
         saddr->has_ipv4 = saddr->ipv4 = e->ai_family != PF_INET6;
+        qapi_free_SocketAddress(addr);
     }
     freeaddrinfo(res);
     return slisten;
@@ -1047,7 +1050,7 @@ int socket_listen(SocketAddress *addr, Error **errp)
 
     switch (addr->type) {
     case SOCKET_ADDRESS_TYPE_INET:
-        fd = inet_listen_saddr(&addr->u.inet, 0, false, errp);
+        fd = inet_listen_saddr(&addr->u.inet, 0, true, errp);
         break;
 
     case SOCKET_ADDRESS_TYPE_UNIX:
-- 
2.13.6
