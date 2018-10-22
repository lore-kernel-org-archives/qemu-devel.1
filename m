Received: from eggs.gnu.org ([2001:4830:134:3::10]:38095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gEZPn-0002Nj-7p
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gEZPl-0003AK-Hx
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:34:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gEZPl-0002w8-7r
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:34:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A2ED0300239F
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 12:34:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-34.ams2.redhat.com
	[10.36.117.34])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B57F6092D
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 12:34:20 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 22 Oct 2018 14:33:55 +0200
Message-Id: <20181022123413.28044-23-armbru@redhat.com>
In-Reply-To: <20181022123413.28044-1-armbru@redhat.com>
References: <20181022123413.28044-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 22/40] vl: Clean up error reporting in
 chardev_init_func()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Calling error_report() in a function that takes an Error ** argument
is suspicious.  chardev_init_func() does that, and then fails without
setting an error.  Its caller main(), via qemu_opts_foreach(), is fine
with it, but clean it up anyway.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20181017082702.5581-21-armbru@redhat.com>
---
 vl.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/vl.c b/vl.c
index f8a13d7070..d84857c064 100644
--- a/vl.c
+++ b/vl.c
@@ -2239,7 +2239,7 @@ static int chardev_init_func(void *opaque, QemuOpts=
 *opts, Error **errp)
=20
     if (!qemu_chr_new_from_opts(opts, &local_err)) {
         if (local_err) {
-            error_report_err(local_err);
+            error_propagate(errp, local_err);
             return -1;
         }
         exit(0);
@@ -4233,10 +4233,8 @@ int main(int argc, char **argv, char **envp)
                       user_creatable_add_opts_foreach,
                       object_create_initial, &error_fatal);
=20
-    if (qemu_opts_foreach(qemu_find_opts("chardev"),
-                          chardev_init_func, NULL, NULL)) {
-        exit(1);
-    }
+    qemu_opts_foreach(qemu_find_opts("chardev"),
+                      chardev_init_func, NULL, &error_fatal);
=20
 #ifdef CONFIG_VIRTFS
     if (qemu_opts_foreach(qemu_find_opts("fsdev"),
--=20
2.17.2
