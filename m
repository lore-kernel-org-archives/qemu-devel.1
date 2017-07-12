Received: from eggs.gnu.org ([2001:4830:134:3::10]:36536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVKCq-0001Qz-OF
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVKCp-0003BX-SW
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:09:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dVKCp-0003AV-M8
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:09:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C1F480B22
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 16:09:38 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 12 Jul 2017 18:09:34 +0200
Message-Id: <1499875776-12688-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1499875776-12688-1-git-send-email-armbru@redhat.com>
References: <1499875776-12688-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] qobject: Catch another straggler for use of
 qdict_put_str()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

Dan's addition of key-secret improvements in commit 29cf9336 was
developed prior to the addition of QDict scalar insertion macros,
but merged after the general cleanup in commit 46f5ac20.
Patch created mechanically by rerunning:
  spatch --sp-file scripts/coccinelle/qobject.cocci \
         --macro-file scripts/cocci-macro-file.h --dir . --in-place

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-Id: <20170624181008.25497-2-eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qemu-img.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index f7ffb79..02900ce 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -355,7 +355,7 @@ static int img_add_key_secrets(void *opaque,
     QDict *options = opaque;
 
     if (g_str_has_suffix(name, "key-secret")) {
-        qdict_put(options, name, qstring_from_str(value));
+        qdict_put_str(options, name, value);
     }
 
     return 0;
-- 
2.7.5
