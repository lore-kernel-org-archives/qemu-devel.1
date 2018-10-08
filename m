Received: from eggs.gnu.org ([2001:4830:134:3::10]:41371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNf-0005Ad-O6
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNb-0005nr-1v
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1g9ZNa-0005iI-HO
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51FC530D2C3B
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 17:31:30 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  8 Oct 2018 19:31:07 +0200
Message-Id: <20181008173125.19678-14-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-1-armbru@redhat.com>
References: <20181008173125.19678-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 13/31] net/socket: Fix invalid socket type
 error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

Calling error_report() in a function that takes an Error ** argument
is suspicious.  net_socket_fd_init() does that, and then fails without
setting an error.  Wrong.  I didn't analyze how exactly this can
break.  A caller that reports the error on failure would crash.

Broken when commit c37f0bb1d0d (v2.11.0) converted the function to
Error.  Fix by calling error_setg() instead of error_report().

Fixes: c37f0bb1d0d24e3a6b5f4659bb305913dcb798a6
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 net/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 6917fbcbf5..90ef3517be 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -453,8 +453,8 @@ static NetSocketState *net_socket_fd_init(NetClientState *peer,
     case SOCK_STREAM:
         return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
     default:
-        error_report("socket type=%d for fd=%d must be either"
-                     " SOCK_DGRAM or SOCK_STREAM", so_type, fd);
+        error_setg(errp, "socket type=%d for fd=%d must be either"
+                   " SOCK_DGRAM or SOCK_STREAM", so_type, fd);
         closesocket(fd);
     }
     return NULL;
-- 
2.17.1
