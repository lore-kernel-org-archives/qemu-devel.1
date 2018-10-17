Received: from eggs.gnu.org ([2001:4830:134:3::10]:51314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gChAx-00006H-DW
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gChAr-0001eP-R9
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54393)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gChAh-00017B-L8
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9D7F846202
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 08:27:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 17 Oct 2018 10:26:31 +0200
Message-Id: <20181017082702.5581-8-armbru@redhat.com>
In-Reply-To: <20181017082702.5581-1-armbru@redhat.com>
References: <20181017082702.5581-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 07/38] char: Use error_printf() to print
 help and such
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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
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
