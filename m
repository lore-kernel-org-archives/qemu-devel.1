Received: from eggs.gnu.org ([2001:4830:134:3::10]:41349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNf-0005Aa-5d
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNa-0005nN-J5
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1g9ZNa-0005iy-6U
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 66DFC30B844E
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 17:31:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3389717A67
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 17:31:32 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  8 Oct 2018 19:31:25 +0200
Message-Id: <20181008173125.19678-32-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-1-armbru@redhat.com>
References: <20181008173125.19678-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 31/31] vl: Simplify call of parse_name()
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
---
 vl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/vl.c b/vl.c
index 101e0123d9..0a76c58943 100644
--- a/vl.c
+++ b/vl.c
@@ -3926,10 +3926,8 @@ int main(int argc, char **argv, char **envp)
     }
 #endif
 
-    if (qemu_opts_foreach(qemu_find_opts("name"),
-                          parse_name, NULL, NULL)) {
-        exit(1);
-    }
+    qemu_opts_foreach(qemu_find_opts("name"),
+                      parse_name, NULL, &error_fatal);
 
 #ifndef _WIN32
     qemu_opts_foreach(qemu_find_opts("add-fd"),
-- 
2.17.1
