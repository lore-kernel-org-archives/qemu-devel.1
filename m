Received: from eggs.gnu.org ([2001:4830:134:3::10]:50282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi5x-00006e-DA
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:28:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi5w-0004q7-Gd
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:28:41 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 24 Jul 2017 15:27:26 -0300
Message-Id: <20170724182751.18261-11-f4bug@amsat.org>
In-Reply-To: <20170724182751.18261-1-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 10/35] net/eth: fix incorrect check of
 iov_to_buf() return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Jason Wang <jasowang@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

So we have sizeof(struct in6_address) != sizeof(uintptr_t)
and Clang > Coverity on this, see 4555ca6816c :)

net/eth.c:426:30: warning: The code calls sizeof() on a pointer type. This can produce an unexpected result
        return bytes_read == sizeof(dst_addr);
                             ^     ~~~~~~~~~~
net/eth.c:475:34: warning: The code calls sizeof() on a pointer type. This can produce an unexpected result
            return bytes_read == sizeof(src_addr);
                                 ^     ~~~~~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 net/eth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/eth.c b/net/eth.c
index 5b9ba26a56..ae5d881aae 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -423,7 +423,7 @@ _eth_get_rss_ex_dst_addr(const struct iovec *pkt, int pkt_frags,
                                 rthdr_offset + sizeof(*ext_hdr),
                                 dst_addr, sizeof(*dst_addr));
 
-        return bytes_read == sizeof(dst_addr);
+        return bytes_read == sizeof(*dst_addr);
     }
 
     return false;
@@ -472,7 +472,7 @@ _eth_get_rss_ex_src_addr(const struct iovec *pkt, int pkt_frags,
                                     opt_offset + sizeof(opthdr),
                                     src_addr, sizeof(*src_addr));
 
-            return bytes_read == sizeof(src_addr);
+            return bytes_read == sizeof(*src_addr);
         }
 
         opt_offset += optlen;
-- 
2.13.3
