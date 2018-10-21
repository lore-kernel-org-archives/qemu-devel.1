Received: from eggs.gnu.org ([2001:4830:134:3::10]:60417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gEJQn-0001iC-4b
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 15:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gEJQl-0003iW-AY
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 15:30:32 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 21 Oct 2018 21:30:13 +0200
Message-Id: <20181021193014.22512-2-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181021193014.22512-1-samuel.thibault@ens-lyon.org>
References: <20181021193014.22512-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] slirp: Add sanity check for str option
 length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Fam Zheng <famz@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, qemu-stable@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Fam Zheng <famz@redhat.com>

When user provides a long domainname or hostname that doesn't fit in the
DHCP packet, we mustn't overflow the response packet buffer. Instead,
report errors, following the g_warning() in the slirp->vdnssearch
branch.

Also check the strlen against 256 when initializing slirp, which limit
is also from the protocol where one byte represents the string length.
This gives an early error before the warning which is harder to notice
or diagnose.

Reported-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Fam Zheng <famz@redhat.com>
Tested-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 net/slirp.c   |  9 +++++++++
 slirp/bootp.c | 32 ++++++++++++++++++++++----------
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index 99884de204..da6c0a1a5c 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -350,6 +350,15 @@ static int net_slirp_init(NetClientState *peer, cons=
t char *model,
         return -1;
     }
=20
+    if (vdomainname && strlen(vdomainname) > 255) {
+        error_setg(errp, "'domainname' parameter cannot exceed 255 bytes=
");
+        return -1;
+    }
+
+    if (vhostname && strlen(vhostname) > 255) {
+        error_setg(errp, "'vhostname' parameter cannot exceed 255 bytes"=
);
+        return -1;
+    }
=20
     nc =3D qemu_new_net_client(&net_slirp_info, peer, model, name);
=20
diff --git a/slirp/bootp.c b/slirp/bootp.c
index 9e7b53ba94..1e8185f0ec 100644
--- a/slirp/bootp.c
+++ b/slirp/bootp.c
@@ -159,6 +159,7 @@ static void bootp_reply(Slirp *slirp, const struct bo=
otp_t *bp)
     struct in_addr preq_addr;
     int dhcp_msg_type, val;
     uint8_t *q;
+    uint8_t *end;
     uint8_t client_ethaddr[ETH_ALEN];
=20
     /* extract exact DHCP msg type */
@@ -240,6 +241,7 @@ static void bootp_reply(Slirp *slirp, const struct bo=
otp_t *bp)
     rbp->bp_siaddr =3D saddr.sin_addr; /* Server IP address */
=20
     q =3D rbp->bp_vend;
+    end =3D (uint8_t *)&rbp[1];
     memcpy(q, rfc1533_cookie, 4);
     q +=3D 4;
=20
@@ -292,24 +294,33 @@ static void bootp_reply(Slirp *slirp, const struct =
bootp_t *bp)
=20
         if (*slirp->client_hostname) {
             val =3D strlen(slirp->client_hostname);
-            *q++ =3D RFC1533_HOSTNAME;
-            *q++ =3D val;
-            memcpy(q, slirp->client_hostname, val);
-            q +=3D val;
+            if (q + val + 2 >=3D end) {
+                g_warning("DHCP packet size exceeded, "
+                    "omitting host name option.");
+            } else {
+                *q++ =3D RFC1533_HOSTNAME;
+                *q++ =3D val;
+                memcpy(q, slirp->client_hostname, val);
+                q +=3D val;
+            }
         }
=20
         if (slirp->vdomainname) {
             val =3D strlen(slirp->vdomainname);
-            *q++ =3D RFC1533_DOMAINNAME;
-            *q++ =3D val;
-            memcpy(q, slirp->vdomainname, val);
-            q +=3D val;
+            if (q + val + 2 >=3D end) {
+                g_warning("DHCP packet size exceeded, "
+                    "omitting domain name option.");
+            } else {
+                *q++ =3D RFC1533_DOMAINNAME;
+                *q++ =3D val;
+                memcpy(q, slirp->vdomainname, val);
+                q +=3D val;
+            }
         }
=20
         if (slirp->vdnssearch) {
-            size_t spaceleft =3D sizeof(rbp->bp_vend) - (q - rbp->bp_ven=
d);
             val =3D slirp->vdnssearch_len;
-            if (val + 1 > spaceleft) {
+            if (q + val >=3D end) {
                 g_warning("DHCP packet size exceeded, "
                     "omitting domain-search option.");
             } else {
@@ -331,6 +342,7 @@ static void bootp_reply(Slirp *slirp, const struct bo=
otp_t *bp)
         memcpy(q, nak_msg, sizeof(nak_msg) - 1);
         q +=3D sizeof(nak_msg) - 1;
     }
+    assert(q < end);
     *q =3D RFC1533_END;
=20
     daddr.sin_addr.s_addr =3D 0xffffffffu;
--=20
2.19.1
