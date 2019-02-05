Received: from eggs.gnu.org ([209.51.188.92]:33321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gr44j-0005jl-WE
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:59:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gr44g-00061s-W1
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:59:57 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:60840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gr44g-0005zM-Lv
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:59:54 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Tue,  5 Feb 2019 18:59:13 +0200
Message-Id: <20190205165927.26599-19-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190205165927.26599-1-samuel.thibault@ens-lyon.org>
References: <20190205165927.26599-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULLv2 18/32] slirp: add slirp own version of pstrcpy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Remove a dependency on qemu util.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/slirp.c |  4 ++--
 slirp/tftp.c  |  2 +-
 slirp/util.c  | 17 +++++++++++++++++
 slirp/util.h  |  2 ++
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/slirp/slirp.c b/slirp/slirp.c
index 9ec1e4c62f..b5c4788489 100644
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
index 6fb381ef33..f0bcc72c92 100644
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
index 59f6713c8b..84f5afdbc3 100644
--- a/slirp/util.c
+++ b/slirp/util.c
@@ -188,3 +188,20 @@ int slirp_closesocket(int fd)
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
diff --git a/slirp/util.h b/slirp/util.h
index 4f6e80c3ed..586517bb30 100644
--- a/slirp/util.h
+++ b/slirp/util.h
@@ -91,4 +91,6 @@ static inline int slirp_socket_set_fast_reuse(int fd)
 #endif
 }
=20
+void slirp_pstrcpy(char *buf, int buf_size, const char *str);
+
 #endif
--=20
2.20.1
