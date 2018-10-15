Received: from eggs.gnu.org ([2001:4830:134:3::10]:39607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gC1RB-0004GP-HP
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gC1R7-00028R-9h
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gC1R6-00021Y-IX
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3005E67EC2
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 11:53:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EB6EB5D788
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 11:53:17 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 15 Oct 2018 13:53:09 +0200
Message-Id: <20181015115309.17089-36-armbru@redhat.com>
In-Reply-To: <20181015115309.17089-1-armbru@redhat.com>
References: <20181015115309.17089-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 35/35] vl: Simplify call of parse_name()
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
