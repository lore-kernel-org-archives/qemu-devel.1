Received: from eggs.gnu.org ([209.51.188.92]:35159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gjB7F-0004l9-Uj
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:53:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gjB7E-0001eY-7n
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:53:57 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:40536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gjB7D-0001UB-HP
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:53:56 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Mon, 14 Jan 2019 23:52:35 +0100
Message-Id: <20190114225306.21569-35-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190114225306.21569-1-samuel.thibault@ens-lyon.org>
References: <20190114225306.21569-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 34/65] slirp: replace error_report() with
 g_critical()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reduce dependency on QEMU. QEMU could use a custom log handler if it
wants to redirect/filter it.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/ip6_icmp.c | 2 +-
 slirp/misc.c     | 2 +-
 slirp/slirp.c    | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
index cd1e0b9fe1..3c424df591 100644
--- a/slirp/ip6_icmp.c
+++ b/slirp/ip6_icmp.c
@@ -417,7 +417,7 @@ void icmp6_input(struct mbuf *m)
             icmp6_send_echoreply(m, slirp, ip, icmp);
         } else {
             /* TODO */
-            error_report("external icmpv6 not supported yet");
+            g_critical("external icmpv6 not supported yet");
         }
         break;
=20
diff --git a/slirp/misc.c b/slirp/misc.c
index 7362e14339..ee3492a2ae 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -119,7 +119,7 @@ slirp_socketpair_with_oob(int sv[2])
     return 0;
=20
 err:
-    error_report("Error: slirp_socketpair(): %s", strerror(errno));
+    g_critical("slirp_socketpair(): %s", strerror(errno));
     if (s >=3D 0) {
         closesocket(s);
     }
diff --git a/slirp/slirp.c b/slirp/slirp.c
index f11f9e9e51..8391d18faf 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -1214,8 +1214,8 @@ static int sbuf_tmp_post_load(void *opaque, int ver=
sion)
     }
     if (tmp->woff >=3D requested_len ||
         tmp->roff >=3D requested_len) {
-        error_report("invalid sbuf offsets r/w=3D%u/%u len=3D%u",
-                     tmp->roff, tmp->woff, requested_len);
+        g_critical("invalid sbuf offsets r/w=3D%u/%u len=3D%u",
+                   tmp->roff, tmp->woff, requested_len);
         return -EINVAL;
     }
=20
@@ -1323,7 +1323,7 @@ static int ss_family_post_load(void *opaque, int ve=
rsion_id)
         tss->parent->ss.ss_family =3D AF_INET6;
         break;
     default:
-        error_report("invalid ss_family type %x", tss->portable_family);
+        g_critical("invalid ss_family type %x", tss->portable_family);
         return -EINVAL;
     }
=20
--=20
2.20.1
