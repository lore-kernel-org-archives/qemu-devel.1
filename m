Received: from eggs.gnu.org ([2001:4830:134:3::10]:45375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1S8-0006nL-Ot
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:43:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1S8-0006Yj-2O
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:43:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dO1S7-0006Wr-ST
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:43:15 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Jun 2017 14:41:45 +0200
Message-Id: <20170622124204.19407-13-marcandre.lureau@redhat.com>
In-Reply-To: <20170622124204.19407-1-marcandre.lureau@redhat.com>
References: <20170622124204.19407-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 12/31] slirp: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/ip6.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/slirp/ip6.h b/slirp/ip6.h
index 0908855f0f..b1bea43b3c 100644
--- a/slirp/ip6.h
+++ b/slirp/ip6.h
@@ -57,9 +57,9 @@ static inline bool in6_equal_mach(const struct in6_addr=
 *a,
                                   const struct in6_addr *b,
                                   int prefix_len)
 {
-    if (memcmp(&(a->s6_addr[(prefix_len + 7) / 8]),
-               &(b->s6_addr[(prefix_len + 7) / 8]),
-               16 - (prefix_len + 7) / 8) !=3D 0) {
+    if (memcmp(&(a->s6_addr[DIV_ROUND_UP(prefix_len, 8)]),
+               &(b->s6_addr[DIV_ROUND_UP(prefix_len, 8)]),
+               16 - DIV_ROUND_UP(prefix_len, 8)) !=3D 0) {
         return 0;
     }
=20
--=20
2.13.1.395.gf7b71de06
