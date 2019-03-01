Received: from eggs.gnu.org ([209.51.188.92]:39600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <llyzs.vic@gmail.com>) id 1gzbyj-0005Sa-A7
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 01:49:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <llyzs.vic@gmail.com>) id 1gzbyi-0000hV-J8
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 01:49:05 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <llyzs.vic@gmail.com>) id 1gzbyi-0000gz-Ba
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 01:49:04 -0500
Received: by mail-pl1-x642.google.com with SMTP id bj4so11005199plb.7
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 22:49:04 -0800 (PST)
From: Vic Lee <llyzs.vic@gmail.com>
Date: Fri,  1 Mar 2019 14:48:09 +0800
Message-Id: <20190301064809.3074-1-llyzs.vic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] slirp: check for ioctlsocket error and
 0-length udp payload.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@gnu.org>, Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Vic Lee <llyzs.vic@gmail.com>

Sometimes sorecvfrom() is called from slirp.c because revents == G_IO_IN,
but there is 0 bytes available and recvfrom could be blocking indefinitely.
This is likely due to 0-length udp payload. This also adds an error
checking for ioctlsocket.

Signed-off-by: Vic Lee <llyzs.vic@gmail.com>
---
 slirp/socket.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/slirp/socket.c b/slirp/socket.c
index 4876ea3f31..03266128b1 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -529,6 +529,15 @@ sorecvfrom(struct socket *so)
           int n;
 #endif
 
+	  if (ioctlsocket(so->s, FIONREAD, &n) != 0) {
+	      DEBUG_MISC((dfd," ioctlsocket errno = %d-%s\n",
+			  errno,strerror(errno)));
+	      return;
+	  }
+	  if (n == 0) {
+	      return;
+	  }
+
 	  m = m_get(so->slirp);
 	  if (!m) {
 	      return;
@@ -552,7 +561,6 @@ sorecvfrom(struct socket *so)
 	   */
 	  len = M_FREEROOM(m);
 	  /* if (so->so_fport != htons(53)) { */
-	  ioctlsocket(so->s, FIONREAD, &n);
 
 	  if (n > len) {
 	    n = (m->m_data - m->m_dat) + m->m_len + n + 1;
-- 
2.20.1
