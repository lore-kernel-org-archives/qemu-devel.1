Received: from eggs.gnu.org ([209.51.188.92]:57720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk678-0006LJ-5a
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:45:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk677-0005gK-8n
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:45:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gk675-0005L8-Am
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:45:37 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 17 Jan 2019 15:43:47 +0400
Message-Id: <20190117114359.5164-16-marcandre.lureau@redhat.com>
In-Reply-To: <20190117114359.5164-1-marcandre.lureau@redhat.com>
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 15/27] slirp: add slirp own version of pstrcpy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, pbonzini@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>

Remove a dependency on qemu util.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/util.h  |  2 ++
 slirp/slirp.c |  4 ++--
 slirp/tftp.c  |  2 +-
 slirp/util.c  | 17 +++++++++++++++++
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/slirp/util.h b/slirp/util.h
index 782ae8ef0ee..e3332cdcd60 100644
--- a/slirp/util.h
+++ b/slirp/util.h
@@ -89,4 +89,6 @@ static inline int slirp_socket_set_fast_reuse(int fd)
 #endif
 }
=20
+void slirp_pstrcpy(char *buf, int buf_size, const char *str);
+
 #endif
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 5450b52dbf4..9e38d3f8cb3 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -320,8 +320,8 @@ Slirp *slirp_init(int restricted, bool in_enabled, st=
ruct in_addr vnetwork,
     slirp->vprefix_len =3D vprefix_len;
     slirp->vhost_addr6 =3D vhost6;
     if (vhostname) {
-        pstrcpy(slirp->client_hostname, sizeof(slirp->client_hostname),
-                vhostname);
+        slirp_pstrcpy(slirp->client_hostname, sizeof(slirp->client_hostn=
ame),
+                      vhostname);
     }
     slirp->tftp_prefix =3D g_strdup(tftp_path);
     slirp->bootp_filename =3D g_strdup(bootfile);
diff --git a/slirp/tftp.c b/slirp/tftp.c
index 6fb381ef337..f0bcc72c925 100644
--- a/slirp/tftp.c
+++ b/slirp/tftp.c
@@ -216,7 +216,7 @@ static void tftp_send_error(struct tftp_session *spt,
=20
   tp->tp_op =3D htons(TFTP_ERROR);
   tp->x.tp_error.tp_error_code =3D htons(errorcode);
-  pstrcpy((char *)tp->x.tp_error.tp_msg, sizeof(tp->x.tp_error.tp_msg), =
msg);
+  slirp_pstrcpy((char *)tp->x.tp_error.tp_msg, sizeof(tp->x.tp_error.tp_=
msg), msg);
=20
   m->m_len =3D sizeof(struct tftp_t) - (TFTP_BLOCKSIZE_MAX + 2) + 3 + st=
rlen(msg)
              - sizeof(struct udphdr);
diff --git a/slirp/util.c b/slirp/util.c
index 499c5cea46f..60f474f0aab 100644
--- a/slirp/util.c
+++ b/slirp/util.c
@@ -186,3 +186,20 @@ int slirp_closesocket(int fd)
     return ret;
 }
 #endif /* WIN32 */
+
+void slirp_pstrcpy(char *buf, int buf_size, const char *str)
+{
+    int c;
+    char *q =3D buf;
+
+    if (buf_size <=3D 0)
+        return;
+
+    for(;;) {
+        c =3D *str++;
+        if (c =3D=3D 0 || q >=3D buf + buf_size - 1)
+            break;
+        *q++ =3D c;
+    }
+    *q =3D '\0';
+}
--=20
2.20.1.98.gecbdaf0899
