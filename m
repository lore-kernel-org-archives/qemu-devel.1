Received: from eggs.gnu.org ([2001:4830:134:3::10]:51398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPagu-0006Jk-7l
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:09:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPagn-0004nJ-Lb
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:09:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gPagl-0004jT-NK
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:09:40 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Nov 2018 02:06:39 +0400
Message-Id: <20181121220647.18844-23-marcandre.lureau@redhat.com>
In-Reply-To: <20181121220647.18844-1-marcandre.lureau@redhat.com>
References: <20181121220647.18844-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 for-3.2 v2 22/30] slirp: remove remaining
 DEBUG blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Instead, rely on slirp_debug flags, or compile unconditionally (the
substraction in cksum is unlikely to affect any benchmark result).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/cksum.c   | 4 ----
 slirp/ip_icmp.c | 5 ++---
 slirp/slirp.c   | 5 +----
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/slirp/cksum.c b/slirp/cksum.c
index b9466485b5..0a988b845d 100644
--- a/slirp/cksum.c
+++ b/slirp/cksum.c
@@ -70,9 +70,7 @@ int cksum(struct mbuf *m, int len)
=20
 	if (len < mlen)
 	   mlen =3D len;
-#ifdef DEBUG
 	len -=3D mlen;
-#endif
 	/*
 	 * Force to even boundary.
 	 */
@@ -122,12 +120,10 @@ int cksum(struct mbuf *m, int len)
 	   s_util.c[0] =3D *(uint8_t *)w;
=20
 cont:
-#ifdef DEBUG
 	if (len) {
 		DEBUG_ERROR("cksum: out of data\n");
 		DEBUG_ERROR(" len =3D %d\n", len);
 	}
-#endif
 	if (mlen =3D=3D -1) {
 		/* The last mbuf has odd # of bytes. Follow the
 		 standard (the odd byte may be shifted left by 8 bits
diff --git a/slirp/ip_icmp.c b/slirp/ip_icmp.c
index 6c7e375ff8..cd2faeacb6 100644
--- a/slirp/ip_icmp.c
+++ b/slirp/ip_icmp.c
@@ -257,13 +257,12 @@ icmp_send_error(struct mbuf *msrc, u_char type, u_c=
har code, int minsize,
   /* check msrc */
   if(!msrc) goto end_error;
   ip =3D mtod(msrc, struct ip *);
-#ifdef DEBUG
-  { char bufa[20], bufb[20];
+  if (slirp_debug & DBG_MISC) {
+    char bufa[20], bufb[20];
     strcpy(bufa, inet_ntoa(ip->ip_src));
     strcpy(bufb, inet_ntoa(ip->ip_dst));
     DEBUG_MISC(" %.16s to %.16s\n", bufa, bufb);
   }
-#endif
   if(ip->ip_off & IP_OFFMASK) goto end_error;    /* Only reply to fragme=
nt 0 */
=20
   /* Do not reply to source-only IPs */
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 51c5813c7c..5954a99d3c 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -194,9 +194,7 @@ static int get_dns_addr_resolv_conf(int af, void *pdn=
s_addr, void *cached_addr,
             if (++found > 3) {
                 DEBUG_MISC("(more)");
                 break;
-            }
-#ifdef DEBUG
-            else {
+            } else if (slirp_debug & DBG_MISC) {
                 char s[INET6_ADDRSTRLEN];
                 const char *res =3D inet_ntop(af, tmp_addr, s, sizeof(s)=
);
                 if (!res) {
@@ -204,7 +202,6 @@ static int get_dns_addr_resolv_conf(int af, void *pdn=
s_addr, void *cached_addr,
                 }
                 DEBUG_MISC("%s", res);
             }
-#endif
         }
     }
     fclose(f);
--=20
2.20.0.rc1
