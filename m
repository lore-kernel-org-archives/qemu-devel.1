Received: from eggs.gnu.org ([209.51.188.92]:36133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gpFbM-0003RP-SY
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 11:54:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gpFbM-0004M2-5j
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 11:54:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cfergeau@redhat.com>) id 1gpFbM-0004LP-0U
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 11:54:08 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C385356F6
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 16:46:43 +0000 (UTC)
From: Christophe Fergeau <cfergeau@redhat.com>
Date: Thu, 31 Jan 2019 17:46:13 +0100
Message-Id: <20190131164614.19209-2-cfergeau@redhat.com>
In-Reply-To: <20190131164614.19209-1-cfergeau@redhat.com>
References: <20190131164614.19209-1-cfergeau@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 1/2] qemu-io: Use error_[gs]et_progname()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

qemu-io reimplements itself what
error_get_progname()/error_set_progname() already does.
This commit switches it to use this API from qemu-error.h

Signed-off-by: Christophe Fergeau <cfergeau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
No changes since v6

 qemu-io.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/qemu-io.c b/qemu-io.c
index 6df7731af4..2c52ac0ade 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -34,8 +34,6 @@
=20
 #define CMD_NOFILE_OK   0x01
=20
-static char *progname;
-
 static BlockBackend *qemuio_blk;
 static bool quit_qemu_io;
=20
@@ -312,7 +310,7 @@ static char *get_prompt(void)
     static char prompt[FILENAME_MAX + 2 /*"> "*/ + 1 /*"\0"*/ ];
=20
     if (!prompt[0]) {
-        snprintf(prompt, sizeof(prompt), "%s> ", progname);
+        snprintf(prompt, sizeof(prompt), "%s> ", error_get_progname());
     }
=20
     return prompt;
@@ -525,7 +523,7 @@ int main(int argc, char **argv)
 #endif
=20
     module_call_init(MODULE_INIT_TRACE);
-    progname =3D g_path_get_basename(argv[0]);
+    error_set_progname(argv[0]);
     qemu_init_exec_dir(argv[0]);
=20
     qcrypto_init(&error_fatal);
@@ -580,10 +578,10 @@ int main(int argc, char **argv)
             break;
         case 'V':
             printf("%s version " QEMU_FULL_VERSION "\n"
-                   QEMU_COPYRIGHT "\n", progname);
+                   QEMU_COPYRIGHT "\n", error_get_progname());
             exit(0);
         case 'h':
-            usage(progname);
+            usage(error_get_progname());
             exit(0);
         case 'U':
             force_share =3D true;
@@ -600,13 +598,13 @@ int main(int argc, char **argv)
             imageOpts =3D true;
             break;
         default:
-            usage(progname);
+            usage(error_get_progname());
             exit(1);
         }
     }
=20
     if ((argc - optind) > 1) {
-        usage(progname);
+        usage(error_get_progname());
         exit(1);
     }
=20
--=20
2.20.1
