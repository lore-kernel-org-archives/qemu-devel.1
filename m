Received: from eggs.gnu.org ([209.51.188.92]:52476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCA-0001Nl-V5
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCA-0007OM-3e
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:50 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:46412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gnjC9-0007LQ-SF
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:50 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 27 Jan 2019 13:05:02 +0100
Message-Id: <20190127120526.15457-8-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
References: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/31] net/slirp: fix leaks on forwarding rule
 registration error
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
 net/slirp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/slirp.c b/net/slirp.c
index 750105a466..0b15f427f5 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -807,6 +807,7 @@ static int slirp_guestfwd(SlirpState *s, const char *=
config_str, Error **errp)
         qemu_chr_fe_init(&fwd->hd, chr, &err);
         if (err) {
             error_propagate(errp, err);
+            object_unparent(OBJECT(chr));
             g_free(fwd);
             return -1;
         }
@@ -815,6 +816,7 @@ static int slirp_guestfwd(SlirpState *s, const char *=
config_str, Error **errp)
                                &server, port) < 0) {
             error_setg(errp, "Conflicting/invalid host:port in guest "
                        "forwarding rule '%s'", config_str);
+            qemu_chr_fe_deinit(&fwd->hd, true);
             g_free(fwd);
             return -1;
         }
--=20
2.20.1
