Received: from eggs.gnu.org ([209.51.188.92]:46574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <llyzs.vic@gmail.com>) id 1gzKLe-0003mK-Og
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:59:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <llyzs.vic@gmail.com>) id 1gzKLa-0001yA-I7
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:59:32 -0500
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:35754)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <llyzs.vic@gmail.com>) id 1gzKLW-0001xn-Ps
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:59:28 -0500
Received: by mail-io1-xd44.google.com with SMTP id x4so16387713ion.2
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 03:59:24 -0800 (PST)
MIME-Version: 1.0
From: llyzs <llyzs.vic@gmail.com>
Date: Thu, 28 Feb 2019 19:59:12 +0800
Message-ID: <CACxphuFGAODB_=X1fVFqJa=U14E_YSJMreWJcOgzdsooke1wxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [PATCH] socket: fix blocking udp recvfrom.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>

Sometimes sorecvfrom() is called from slirp.c because revents == G_IO_IN,
however inside sorecvfrom() function, ioctlsocket() returns 0 bytes available
and recvfrom could be blocking indefinitely. This adds a non-blocking flag to
recvfrom and checks data availability.
---
 slirp/socket.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/slirp/socket.c b/slirp/socket.c
index c01d8696af..ea30478ce6 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -581,7 +581,7 @@ sorecvfrom(struct socket *so)
          }
          /* } */

-         m->m_len = recvfrom(so->s, m->m_data, len, 0,
+         m->m_len = recvfrom(so->s, m->m_data, len, MSG_DONTWAIT,
                              (struct sockaddr *)&addr, &addrlen);
          DEBUG_MISC((dfd, " did recvfrom %d, errno = %d-%s\n",
                      m->m_len, errno,strerror(errno)));
@@ -618,6 +618,8 @@ sorecvfrom(struct socket *so)
              break;
            }
            m_free(m);
+         } else if (m->m_len==0) {
+           m_free(m);
          } else {
          /*
           * Hack: domain name lookup will be used the most for UDP,
-- 
2.20.1
