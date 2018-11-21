Received: from eggs.gnu.org ([2001:4830:134:3::10]:50718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPafD-0004Wj-IX
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:08:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPaf9-0002AE-GF
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:08:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gPaf8-00028e-MG
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:07:59 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Nov 2018 02:06:26 +0400
Message-Id: <20181121220647.18844-10-marcandre.lureau@redhat.com>
In-Reply-To: <20181121220647.18844-1-marcandre.lureau@redhat.com>
References: <20181121220647.18844-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 for-3.2 v2 09/30] net/slirp: fix a few
 memory leaks
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

Handle chardev removal on failure to register the forward rule.

Free all the guestfwd data on cleanup.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 net/slirp.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index 9f07923925..6eeb54d7b1 100644
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
@@ -711,13 +728,6 @@ static int slirp_smb(SlirpState* s, const char *expo=
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
@@ -791,6 +801,7 @@ static int slirp_guestfwd(SlirpState *s, const char *=
config_str, Error **errp)
         qemu_chr_fe_init(&fwd->hd, chr, &err);
         if (err) {
             error_propagate(errp, err);
+            object_unparent(OBJECT(chr));
             g_free(fwd);
             return -1;
         }
@@ -799,6 +810,7 @@ static int slirp_guestfwd(SlirpState *s, const char *=
config_str, Error **errp)
                                &server, port) < 0) {
             error_setg(errp, "Conflicting/invalid host:port in guest "
                        "forwarding rule '%s'", config_str);
+            qemu_chr_fe_deinit(&fwd->hd, true);
             g_free(fwd);
             return -1;
         }
@@ -808,6 +820,7 @@ static int slirp_guestfwd(SlirpState *s, const char *=
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
2.20.0.rc1
