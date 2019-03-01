Received: from eggs.gnu.org ([209.51.188.92]:53633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <llyzs.vic@gmail.com>) id 1gzaU0-00050c-PQ
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 00:13:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <llyzs.vic@gmail.com>) id 1gzaU0-0000tm-5F
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 00:13:16 -0500
Received: from mail-it1-x12c.google.com ([2607:f8b0:4864:20::12c]:36191)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <llyzs.vic@gmail.com>) id 1gzaTz-0000tO-Uq
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 00:13:16 -0500
Received: by mail-it1-x12c.google.com with SMTP id v83so19555606itf.1
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 21:13:15 -0800 (PST)
MIME-Version: 1.0
References: <CACxphuFGAODB_=X1fVFqJa=U14E_YSJMreWJcOgzdsooke1wxg@mail.gmail.com>
	<20190228205109.hmldtldbnlw3pnqq@function>
	<CACxphuHr-Eo6JoPzZWvaZ_29GjxRzP=saWUKCKQxTuBa8qC9mg@mail.gmail.com>
In-Reply-To: <CACxphuHr-Eo6JoPzZWvaZ_29GjxRzP=saWUKCKQxTuBa8qC9mg@mail.gmail.com>
From: llyzs <llyzs.vic@gmail.com>
Date: Fri, 1 Mar 2019 13:13:03 +0800
Message-ID: <CACxphuFL0hKxzf_Makk8FGh=kc5y+yrVB3v50fiWVrtiCJq=rQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [PATCHv2] slirp: check for ioctlsocket error and
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Samuel Thibault <samuel.thibault@gnu.org>

Sometimes sorecvfrom() is called from slirp.c because revents == G_IO_IN,
but there is 0 bytes available and recvfrom could be blocking indefinitely.
This is likely due to 0-length udp payload. This also adds an error
checking for ioctlsocket.

Signed-off-by: Vic Lee <llyzs.vic@gmail.com>
---
 slirp/socket.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/slirp/socket.c b/slirp/socket.c
index c01d8696af..a624d829e3 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -549,6 +549,15 @@ sorecvfrom(struct socket *so)
           int n;
 #endif

+         if (ioctlsocket(so->s, FIONREAD, &n) != 0) {
+             DEBUG_MISC((dfd," ioctlsocket errno = %d-%s\n",
+                         errno,strerror(errno)));
+             return;
+         }
+         if (n == 0) {
+             return;
+         }
+
          m = m_get(so->slirp);
          if (!m) {
              return;
@@ -572,7 +581,6 @@ sorecvfrom(struct socket *so)
           */
          len = M_FREEROOM(m);
          /* if (so->so_fport != htons(53)) { */
-         ioctlsocket(so->s, FIONREAD, &n);

          if (n > len) {
            n = (m->m_data - m->m_dat) + m->m_len + n + 1;
-- 
2.20.1
