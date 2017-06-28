Received: from eggs.gnu.org ([2001:4830:134:3::10]:52946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dQCiX-000460-LD
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dQCiW-0005dL-Gg
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:09:13 -0400
Received: from [59.151.112.132] (port=16038 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dQCiW-0005cL-3L
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:09:12 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Wed, 28 Jun 2017 21:08:47 +0800
Message-ID: <d9660b46628b52aa8c63c21fe20618b5bc33bb4c.1498654240.git.maozy.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1498654240.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1498654240.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 1/4] net/socket: Don't treat odd socket type
 as SOCK_STREAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, armbru@redhat.com, berrange@redhat.com

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
Suggested-by: Markus Armbruster <armbru@redhat.com>
Suggested-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 net/socket.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index dcae1ae..53765bd 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -449,9 +449,9 @@ static NetSocketState *net_socket_fd_init(NetClientState *peer,
     case SOCK_STREAM:
         return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
     default:
-        /* who knows ... this could be a eg. a pty, do warn and continue as stream */
-        fprintf(stderr, "qemu: warning: socket type=%d for fd=%d is not SOCK_DGRAM or SOCK_STREAM\n", so_type, fd);
-        return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
+        error_report("qemu: error: socket type=%d for fd=%d is not"
+                " SOCK_DGRAM or SOCK_STREAM", so_type, fd);
+        closesocket(fd);
     }
     return NULL;
 }
-- 
2.9.4
