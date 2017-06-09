Received: from eggs.gnu.org ([2001:4830:134:3::10]:40842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dJGlS-0007Kb-Hx
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dJGlP-0002WP-D5
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:03:34 -0400
Received: from [59.151.112.132] (port=57873 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dJGlP-0002K7-22
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:03:31 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Fri, 9 Jun 2017 18:01:45 +0800
Message-ID: <92b1a896753cc1b2a1200f5a525bad314152cdd9.1496924675.git.maozy.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1496924675.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1496924675.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 1/4] net/socket: Drop the odd 'default' case
 and comment
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

In the net_socket_fd_init(), the 'default' case and comment is odd.
If @fd really was a pty, getsockopt() would fail with ENOTSOCK. If
@fd was a socket, but neither SOCK_DGRAM nor SOCK_STREAM. It should
not be treated as if it was SOCK_STREAM.

If there is a genuine reason to support something like SOCK_RAW, it
should be explicitly handled.

So, drop the 'default' case since it is broken already.

Cc: jasowang@redhat.com
Cc: armbru@redhat.com
Cc: berrange@redhat.com
Cc: armbru@redhat.com
Suggested-by: Markus Armbruster <armbru@redhat.com>
Suggested-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
 net/socket.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index dcae1ae..a503cfe 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -449,9 +449,9 @@ static NetSocketState *net_socket_fd_init(NetClientState *peer,
     case SOCK_STREAM:
         return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
     default:
-        /* who knows ... this could be a eg. a pty, do warn and continue as stream */
-        fprintf(stderr, "qemu: warning: socket type=%d for fd=%d is not SOCK_DGRAM or SOCK_STREAM\n", so_type, fd);
-        return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
+        fprintf(stderr, "qemu: error: socket type=%d for fd=%d is not"
+                " SOCK_DGRAM or SOCK_STREAM\n", so_type, fd);
+        closesocket(fd);
     }
     return NULL;
 }
-- 
2.9.3
