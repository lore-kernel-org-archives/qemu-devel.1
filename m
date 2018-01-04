Received: from eggs.gnu.org ([2001:4830:134:3::10]:47754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gson@gson.org>) id 1eX9lQ-0004kr-C7
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:57:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gson@gson.org>) id 1eX9lM-00065d-Av
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:57:12 -0500
Received: from gw03.mail.saunalahti.fi ([195.197.172.111]:55812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gson@gson.org>) id 1eX9lM-00063i-1r
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:57:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <23118.27370.136663.284087@guava.gson.org>
Date: Thu, 4 Jan 2018 19:56:58 +0200
From: Andreas Gustafsson <gson@gson.org>
Subject: [Qemu-devel] [PATCH] slirp: disable Nagle in outgoing connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, Kamil Rytarowski <kamil@NetBSD.org>

slirp: disable Nagle in outgoing connections

When setting up an outgoing user mode networking TCP connection,
disable the Nagle algorithm in the host-side connection.  Either the
guest is already doing Nagle, in which case there is no point in doing
it twice, or it has chosen to disable it, in which case we should
respect that choice.

This change speeds up GDB remote debugging over TCP over user mode
networking (with GDB runing on the guest) by multiple orders of
magnitude, and has been part of the local patches applied by pkgsrc
since 2012 with no reported ill effects.

Signed-off-by: Andreas Gustafsson <gson@gson.org>
---
 slirp/tcp_subr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index da0d53743f..8d0f94b75f 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -416,6 +416,8 @@ int tcp_fconnect(struct socket *so, unsigned short af)
     socket_set_fast_reuse(s);
     opt = 1;
     qemu_setsockopt(s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(opt));
+    opt = 1;
+    qemu_setsockopt(s, IPPROTO_TCP, TCP_NODELAY, &opt, sizeof(opt));
 
     addr = so->fhost.ss;
     DEBUG_CALL(" connect()ing")
-- 
2.15.1
