Received: from eggs.gnu.org ([2001:4830:134:3::10]:56664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCTM8-00063f-98
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:42:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCTM5-000071-To
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:42:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gCTM5-00005l-Kj
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:42:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DCD9285A07
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 17:42:04 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 16 Oct 2018 19:41:34 +0200
Message-Id: <20181016174158.15229-15-armbru@redhat.com>
In-Reply-To: <20181016174158.15229-1-armbru@redhat.com>
References: <20181016174158.15229-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 14/38] net/socket: Fix invalid socket type
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
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 net/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 6917fbcbf5..90ef3517be 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -453,8 +453,8 @@ static NetSocketState *net_socket_fd_init(NetClientSt=
ate *peer,
     case SOCK_STREAM:
         return net_socket_fd_init_stream(peer, model, name, fd, is_conne=
cted);
     default:
-        error_report("socket type=3D%d for fd=3D%d must be either"
-                     " SOCK_DGRAM or SOCK_STREAM", so_type, fd);
+        error_setg(errp, "socket type=3D%d for fd=3D%d must be either"
+                   " SOCK_DGRAM or SOCK_STREAM", so_type, fd);
         closesocket(fd);
     }
     return NULL;
--=20
2.17.1
