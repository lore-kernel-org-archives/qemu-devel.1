Received: from eggs.gnu.org ([2001:4830:134:3::10]:60848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dq8gM-0003Iy-Ck
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:06:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dq8gH-0002HI-NY
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:06:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dq8gH-0002Ga-Gy
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:06:05 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Fri,  8 Sep 2017 10:05:14 +0800
Message-Id: <1504836324-4871-9-git-send-email-jasowang@redhat.com>
In-Reply-To: <1504836324-4871-1-git-send-email-jasowang@redhat.com>
References: <1504836324-4871-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 08/18] net/socket: Don't treat odd socket type
 as SOCK_STREAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, jasowang@redhat.com, armbru@redhat.com, berrange@redhat.com, eblake@redhat.com

From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>

In net_socket_fd_init(), the 'default' case is odd: it warns,
then continues as if the socket type was SOCK_STREAM. The
comment explains "this could be a eg. a pty", but that makes
no sense. If @fd really was a pty, getsockopt() would fail
with ENOTSOCK. If @fd was a socket, but neither SOCK_DGRAM nor
SOCK_STREAM. It should not be treated as if it was SOCK_STREAM.

Turn this case into an Error. If there is a genuine reason to
support something like SOCK_RAW, it should be explicitly
handled.

Cc: jasowang@redhat.com
Cc: armbru@redhat.com
Cc: berrange@redhat.com
Cc: armbru@redhat.com
Cc: eblake@redhat.com
Suggested-by: Markus Armbruster <armbru@redhat.com>
Suggested-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/socket.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 18af2ab..b4c5a04 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -448,9 +448,9 @@ static NetSocketState *net_socket_fd_init(NetClientState *peer,
     case SOCK_STREAM:
         return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
     default:
-        /* who knows ... this could be a eg. a pty, do warn and continue as stream */
-        fprintf(stderr, "qemu: warning: socket type=%d for fd=%d is not SOCK_DGRAM or SOCK_STREAM\n", so_type, fd);
-        return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
+        error_report("socket type=%d for fd=%d must be either"
+                     " SOCK_DGRAM or SOCK_STREAM", so_type, fd);
+        closesocket(fd);
     }
     return NULL;
 }
-- 
2.7.4
