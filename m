Received: from eggs.gnu.org ([2001:4830:134:3::10]:58979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dGPNc-0002Oa-4o
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:39:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dGPNX-0004ss-9X
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:39:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dGPNX-0004sb-4P
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:39:03 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  1 Jun 2017 16:38:47 +0400
Message-Id: <20170601123847.8922-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] qga: report error on keyfile dump error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Cc:qemu-trivial@nongnu.org
---
 qga/main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/qga/main.c b/qga/main.c
index cc58d2b53d..dc42b306b5 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -1075,7 +1075,12 @@ static void config_dump(GAConfig *config)
     g_free(tmp);
=20
     tmp =3D g_key_file_to_data(keyfile, NULL, &error);
-    printf("%s", tmp);
+    if (error) {
+        g_critical("Failed to dump keyfile: %s", error->message);
+        g_clear_error(&error);
+    } else {
+        printf("%s", tmp);
+    }
=20
     g_free(tmp);
     g_key_file_free(keyfile);
--=20
2.13.0.91.g00982b8dd
