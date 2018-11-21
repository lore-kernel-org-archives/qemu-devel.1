Received: from eggs.gnu.org ([2001:4830:134:3::10]:51044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPafw-0005Vb-BH
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:08:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPafv-0002zw-Aq
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:08:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gPafv-0002yZ-2D
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:08:47 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Nov 2018 02:06:32 +0400
Message-Id: <20181121220647.18844-16-marcandre.lureau@redhat.com>
In-Reply-To: <20181121220647.18844-1-marcandre.lureau@redhat.com>
References: <20181121220647.18844-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 for-3.2 v2 15/30] slirp: replace
 error_report() and a fprintf with g_critical()
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

Reduce dependency on QEMU. QEMU could use a custom glib log handler if
it wants to redirect/filter it.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/misc.c   | 2 +-
 slirp/socket.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/slirp/misc.c b/slirp/misc.c
index 7c2ed8c67f..6ee0ff0231 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -164,7 +164,7 @@ fork_exec(struct socket *so, const char *ex)
     g_strfreev(argv);
=20
     if (err) {
-        error_report("%s", err->message);
+        g_critical("fork_exec: %s", err->message);
         g_error_free(err);
         closesocket(sp[0]);
         closesocket(sp[1]);
diff --git a/slirp/socket.c b/slirp/socket.c
index 677fd20c9d..08a065f6a7 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -285,7 +285,7 @@ err:
=20
     sofcantrcvmore(so);
     tcp_sockclosed(sototcpcb(so));
-    fprintf(stderr, "soreadbuf buffer to small");
+    g_critical("soreadbuf buffer too small");
     return -1;
 }
=20
--=20
2.20.0.rc1
