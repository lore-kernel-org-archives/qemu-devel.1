Received: from eggs.gnu.org ([2001:4830:134:3::10]:39587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gC1RB-0004GA-5l
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gC1R9-00029n-2b
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gC1R7-0001yt-6i
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:25 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EE70364100
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 11:53:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B84552B59A
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 11:53:16 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 15 Oct 2018 13:52:55 +0200
Message-Id: <20181015115309.17089-22-armbru@redhat.com>
In-Reply-To: <20181015115309.17089-1-armbru@redhat.com>
References: <20181015115309.17089-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 21/35] vl: Clean up error reporting in
 machine_set_property()
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
is suspicious.  machine_set_property() does that, and then fails without
setting an error.  Its caller main(), via qemu_opts_foreach(), is fine
with it, but clean it up anyway.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 vl.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/vl.c b/vl.c
index aa03192019..c3c17106bf 100644
--- a/vl.c
+++ b/vl.c
@@ -2676,7 +2676,7 @@ static int machine_set_property(void *opaque,
     g_free(qom_name);
=20
     if (local_err) {
-        error_report_err(local_err);
+        error_propagate(errp, local_err);
         return -1;
     }
=20
@@ -4248,11 +4248,8 @@ int main(int argc, char **argv, char **envp)
     }
=20
     machine_opts =3D qemu_get_machine_opts();
-    if (qemu_opt_foreach(machine_opts, machine_set_property, current_mac=
hine,
-                         NULL)) {
-        object_unref(OBJECT(current_machine));
-        exit(1);
-    }
+    qemu_opt_foreach(machine_opts, machine_set_property, current_machine=
,
+                     &error_fatal);
=20
     configure_accelerator(current_machine);
=20
--=20
2.17.1
