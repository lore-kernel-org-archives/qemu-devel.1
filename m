Received: from eggs.gnu.org ([209.51.188.92]:57092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk66F-0005R3-2z
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:44:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk66D-0004SQ-Bb
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:44:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gk66D-0004Fl-50
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:44:41 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 17 Jan 2019 15:43:36 +0400
Message-Id: <20190117114359.5164-5-marcandre.lureau@redhat.com>
In-Reply-To: <20190117114359.5164-1-marcandre.lureau@redhat.com>
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 04/27] net/slirp: fix leaks on forwaring rule
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
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, pbonzini@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 net/slirp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/slirp.c b/net/slirp.c
index 750105a466e..0b15f427f5c 100644
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
2.20.1.98.gecbdaf0899
