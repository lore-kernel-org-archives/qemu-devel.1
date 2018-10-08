Received: from eggs.gnu.org ([2001:4830:134:3::10]:41276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNd-0005AN-Lt
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNZ-0005mK-Pj
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1g9ZNZ-0005j7-DE
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:37 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7AF817F419
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 17:31:32 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  8 Oct 2018 19:31:00 +0200
Message-Id: <20181008173125.19678-7-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-1-armbru@redhat.com>
References: <20181008173125.19678-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 06/31] char: Use error_printf() to print help
 and such
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Calling error_report() in a function that takes an Error ** argument
is suspicious.  Convert a few that are actually help and such to
error_printf().

Improves output of -chardev help from

    qemu-system-x86_64: -chardev help: Available chardev backend types:
    serial
    ...

to

    Available chardev backend types:
    serial
    ...

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 chardev/char-pty.c | 2 +-
 chardev/char.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index e8d9a53476..f681d637c1 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -259,7 +259,7 @@ static void char_pty_open(Chardev *chr,
     qemu_set_nonblock(master_fd);
=20
     chr->filename =3D g_strdup_printf("pty:%s", pty_name);
-    error_report("char device redirected to %s (label %s)",
+    error_printf("char device redirected to %s (label %s)\n",
                  pty_name, chr->label);
=20
     s =3D PTY_CHARDEV(chr);
diff --git a/chardev/char.c b/chardev/char.c
index e115166995..7f07a1bfbd 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -634,7 +634,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts, Error=
 **errp)
=20
         chardev_name_foreach(help_string_append, str);
=20
-        error_report("Available chardev backend types: %s", str->str);
+        error_printf("Available chardev backend types: %s\n", str->str);
         g_string_free(str, true);
         return NULL;
     }
--=20
2.17.1
