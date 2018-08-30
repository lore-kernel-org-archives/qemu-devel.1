Received: from eggs.gnu.org ([2001:4830:134:3::10]:59270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Gavin.Grant@mathworks.co.uk>) id 1fvPMy-0002iT-F5
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 12:00:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Gavin.Grant@mathworks.co.uk>) id 1fvPMt-0003ES-Es
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 12:00:28 -0400
Received: from mail-eopbgr680081.outbound.protection.outlook.com
	([40.107.68.81]:24336
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Gavin.Grant@mathworks.co.uk>)
	id 1fvPMt-0003CD-5a
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 12:00:23 -0400
From: Gavin Grant <gavingrant@protonmail.com>
Date: Thu, 30 Aug 2018 16:57:57 +0100
Message-ID: <20180830155757.103694-2-gavingrant@protonmail.com>
In-Reply-To: <20180830155757.103694-1-gavingrant@protonmail.com>
References: <20180830155757.103694-1-gavingrant@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] slirp: Propagate host TCP RST packet to the
 guest after socket disconnected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com, qemu-devel@nongnu.org
Cc: Gavin Grant <gavingrant@protonmail.com>

Commit 27d92ebc5ed1bb0b518d0ebc4c609182ad20a799 handled the case where the TCP
connection is abruptly closed via a RST packet, by checking for the ECONNRESET
errno. However it does not consider the case where the connection has been
half-closed by the host (FIN/ACK), then the host socket is disconnected. For
example, if the host application calls close() on the socket, then the
application exits.

In this case, the socket still exists due to the file descriptor in SLIRP, but
it is disconnected. recv() does not indicate an error since an orderly socket
close has previously occurred. The socket will then be stuck in FIN_WAIT_2,
until the peer sends FIN/ACK or a timeout occurs. Instead we can send a RST
to the peer and transition to the CLOSED state.

Signed-off-by: Gavin Grant <gavingrant@protonmail.com>
---
 slirp/socket.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/slirp/socket.c b/slirp/socket.c
index 08fe98907d..543bd5feaf 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -204,12 +204,17 @@ soread(struct socket *so)
 			return 0;
 		else {
 			int err;
+			struct sockaddr addr;
 			socklen_t slen = sizeof err;
 
 			err = errno;
 			if (nn == 0) {
-				getsockopt(so->s, SOL_SOCKET, SO_ERROR,
-					   &err, &slen);
+				if (getpeername(so->s, &addr, &slen) < 0) {
+					err = errno;
+				} else {
+					getsockopt(so->s, SOL_SOCKET, SO_ERROR,
+						&err, &slen);
+				}
 			}
 
 			DEBUG_MISC((dfd, " --- soread() disconnected, nn = %d, errno = %d-%s\n", nn, errno,strerror(errno)));
-- 
2.11.0
