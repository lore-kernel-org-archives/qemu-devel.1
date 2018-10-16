Received: from eggs.gnu.org ([2001:4830:134:3::10]:56809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCTMA-00066b-Pz
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCTM8-0000Cv-O0
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:42:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gCTM8-0000AN-B6
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:42:08 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D311C012780
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 17:42:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C6AB100191D
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 17:42:07 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 16 Oct 2018 19:41:55 +0200
Message-Id: <20181016174158.15229-36-armbru@redhat.com>
In-Reply-To: <20181016174158.15229-1-armbru@redhat.com>
References: <20181016174158.15229-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 35/38] vl: Simplify call of parse_name()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

main() checks for parse_name() failure even though it can't actually
fail.  That's okay.  Simplify it to check by passing &error_fatal,
like the other users of qemu_opts_foreach().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 vl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/vl.c b/vl.c
index 89520d8007..01d71371c2 100644
--- a/vl.c
+++ b/vl.c
@@ -3973,10 +3973,8 @@ int main(int argc, char **argv, char **envp)
     }
 #endif
=20
-    if (qemu_opts_foreach(qemu_find_opts("name"),
-                          parse_name, NULL, NULL)) {
-        exit(1);
-    }
+    qemu_opts_foreach(qemu_find_opts("name"),
+                      parse_name, NULL, &error_fatal);
=20
 #ifndef _WIN32
     qemu_opts_foreach(qemu_find_opts("add-fd"),
--=20
2.17.1
