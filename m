Received: from eggs.gnu.org ([2001:4830:134:3::10]:44045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1Th-0006xN-HW
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1Te-0003ax-Qf
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz1Te-0003ai-Kv
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C47CA4ACB4
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 14:13:45 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 16:13:32 +0200
Message-Id: <20171002141341.24616-3-armbru@redhat.com>
In-Reply-To: <20171002141341.24616-1-armbru@redhat.com>
References: <20171002141341.24616-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 02/11] qapi: Stop rejecting #optional
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
List-ID: <qemu-devel.nongnu.org>

Commit 1d8bda1 got rid of #optional tags, and added a check to keep
them from getting added back, to make sure patches then in flight
don't add them back.  It's been six months, time to drop that check.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 62dc52ed6e..dc92bca620 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -234,10 +234,6 @@ class QAPIDoc(object):
             raise QAPIParseError(self.parser,
                                  "'%s' not allowed in free-form documentation"
                                  % match.group(1))
-        # TODO Drop this once the dust has settled
-        if (isinstance(self.section, QAPIDoc.ArgSection)
-                and '#optional' in line):
-            raise QAPISemError(self.info, "Please drop the #optional tag")
         self.section.append(line)
 
     def connect_member(self, member):
-- 
2.13.6
