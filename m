Received: from eggs.gnu.org ([209.51.188.92]:52485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCB-0001Nm-6i
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCA-0007Oo-8K
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:51 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:43210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gnjCA-00070F-0w
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:50 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 27 Jan 2019 13:05:01 +0100
Message-Id: <20190127120526.15457-7-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
References: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/31] net/slirp: free forwarding rules on
 cleanup
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 net/slirp.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index b91741b8fc..750105a466 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -75,6 +75,13 @@ struct slirp_config_str {
     char str[1024];
 };
=20
+struct GuestFwd {
+    CharBackend hd;
+    struct in_addr server;
+    int port;
+    Slirp *slirp;
+};
+
 typedef struct SlirpState {
     NetClientState nc;
     QTAILQ_ENTRY(SlirpState) entry;
@@ -83,6 +90,7 @@ typedef struct SlirpState {
 #ifndef _WIN32
     gchar *smb_dir;
 #endif
+    GSList *fwd;
 } SlirpState;
=20
 static struct slirp_config_str *slirp_configs;
@@ -122,10 +130,19 @@ static void slirp_smb_exit(Notifier *n, void *data)
     slirp_smb_cleanup(s);
 }
=20
+static void slirp_free_fwd(gpointer data)
+{
+    struct GuestFwd *fwd =3D data;
+
+    qemu_chr_fe_deinit(&fwd->hd, true);
+    g_free(data);
+}
+
 static void net_slirp_cleanup(NetClientState *nc)
 {
     SlirpState *s =3D DO_UPCAST(SlirpState, nc, nc);
=20
+    g_slist_free_full(s->fwd, slirp_free_fwd);
     slirp_cleanup(s->slirp);
     if (s->exit_notifier.notify) {
         qemu_remove_exit_notifier(&s->exit_notifier);
@@ -717,13 +734,6 @@ static int slirp_smb(SlirpState* s, const char *expo=
rted_dir,
=20
 #endif /* !defined(_WIN32) */
=20
-struct GuestFwd {
-    CharBackend hd;
-    struct in_addr server;
-    int port;
-    Slirp *slirp;
-};
-
 static int guestfwd_can_read(void *opaque)
 {
     struct GuestFwd *fwd =3D opaque;
@@ -814,6 +824,7 @@ static int slirp_guestfwd(SlirpState *s, const char *=
config_str, Error **errp)
=20
         qemu_chr_fe_set_handlers(&fwd->hd, guestfwd_can_read, guestfwd_r=
ead,
                                  NULL, NULL, fwd, NULL, true);
+        s->fwd =3D g_slist_append(s->fwd, fwd);
     }
     return 0;
=20
--=20
2.20.1
