Received: from eggs.gnu.org ([209.51.188.92]:33072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gr44d-0005ei-4U
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:59:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gr44b-0005uH-J4
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:59:50 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:40380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gr44b-0005ls-Ag
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:59:49 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Tue,  5 Feb 2019 18:59:02 +0200
Message-Id: <20190205165927.26599-8-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190205165927.26599-1-samuel.thibault@ens-lyon.org>
References: <20190205165927.26599-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULLv2 07/32] net/slirp: fix leaks on forwarding rule
 registration error
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
