Received: from eggs.gnu.org ([2001:4830:134:3::10]:58812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmh00-0002P7-Q6
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmgzw-0002hC-Oa
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cmgzw-0002gz-IO
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:52 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 11 Mar 2017 17:22:48 +0400
Message-Id: <20170311132256.22951-14-marcandre.lureau@redhat.com>
In-Reply-To: <20170311132256.22951-1-marcandre.lureau@redhat.com>
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 13/21] qga: report error on keyfile dump error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anderson@redhat.com, mdroth@linux.vnet.ibm.com, armbru@redhat.com, lersek@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Cc:qemu-trivial@nongnu.org
---
 qga/main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/qga/main.c b/qga/main.c
index 92658bc0e2..beff041340 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -1082,7 +1082,12 @@ static void config_dump(GAConfig *config)
     g_free(tmp);
=20
     tmp =3D g_key_file_to_data(keyfile, NULL, &error);
-    printf("%s", tmp);
+    if (tmp) {
+        printf("%s", tmp);
+    } else if (error) {
+        g_critical("Failed to dump keyfile: %s", error->message);
+        g_clear_error(&error);
+    }
=20
     g_free(tmp);
     g_key_file_free(keyfile);
--=20
2.12.0.191.gc5d8de91d
