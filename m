Received: from eggs.gnu.org ([2001:4830:134:3::10]:53105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc7ur-0007q8-2d
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc7uo-0001zW-Dt
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:27:13 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 31 Jul 2017 13:21:31 +0300
Message-Id: <b2caa3b82edca29ccb5e7d6311ffcf841b9b7786.1501496349.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/25] net/eth: fix incorrect check of
 iov_to_buf() return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

So we have sizeof(struct in6_address) !=3D sizeof(uintptr_t)
and Clang > Coverity on this, see 4555ca6816c :)

net/eth.c:426:30: warning: The code calls sizeof() on a pointer type. Thi=
s can produce an unexpected result
        return bytes_read =3D=3D sizeof(dst_addr);
                             ^     ~~~~~~~~~~
net/eth.c:475:34: warning: The code calls sizeof() on a pointer type. Thi=
s can produce an unexpected result
            return bytes_read =3D=3D sizeof(src_addr);
                                 ^     ~~~~~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Dmitry Fleytman <dmitry@daynix.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 net/eth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/eth.c b/net/eth.c
index 5b9ba26a56..ae5d881aae 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -423,7 +423,7 @@ _eth_get_rss_ex_dst_addr(const struct iovec *pkt, int=
 pkt_frags,
                                 rthdr_offset + sizeof(*ext_hdr),
                                 dst_addr, sizeof(*dst_addr));
=20
-        return bytes_read =3D=3D sizeof(dst_addr);
+        return bytes_read =3D=3D sizeof(*dst_addr);
     }
=20
     return false;
@@ -472,7 +472,7 @@ _eth_get_rss_ex_src_addr(const struct iovec *pkt, int=
 pkt_frags,
                                     opt_offset + sizeof(opthdr),
                                     src_addr, sizeof(*src_addr));
=20
-            return bytes_read =3D=3D sizeof(src_addr);
+            return bytes_read =3D=3D sizeof(*src_addr);
         }
=20
         opt_offset +=3D optlen;
--=20
2.11.0
