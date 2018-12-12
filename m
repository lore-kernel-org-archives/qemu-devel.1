Received: from eggs.gnu.org ([2001:4830:134:3::10]:49047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gX1Uf-0000uB-HQ
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:11:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gX1Ue-0003Ob-On
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:11:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gX1Ue-0003OD-Gk
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:11:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA6B82D7F1
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 10:11:51 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 12 Dec 2018 11:11:39 +0100
Message-Id: <20181212101145.3496-6-armbru@redhat.com>
In-Reply-To: <20181212101145.3496-1-armbru@redhat.com>
References: <20181212101145.3496-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/11] colo: check chardev can switch context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

COLO uses a worker context (iothread) to drive the chardev. All
backends are not able to switch the context, let's report an error in
this case.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20181205203737.9011-6-marcandre.lureau@redhat.com>
Reviewed-by: Li Zhijian <lizhiian@cn.fujitsu.com>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 net/colo-compare.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index a39191d522..9156ab3349 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -957,6 +957,12 @@ static int find_and_check_chardev(Chardev **chr,
         return 1;
     }
=20
+    if (!qemu_chr_has_feature(*chr, QEMU_CHAR_FEATURE_GCONTEXT)) {
+        error_setg(errp, "chardev \"%s\" cannot switch context",
+                   chr_name);
+        return 1;
+    }
+
     return 0;
 }
=20
--=20
2.17.2
