Received: from eggs.gnu.org ([2001:4830:134:3::10]:58983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cepIU-0002Yd-Qh
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cepIT-0004Pz-Kj
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cepIT-0004PG-FK
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:29 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9661F4DD4C
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 20:38:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1HKcSY6018328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 15:38:29 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Feb 2017 21:38:16 +0100
Message-Id: <1487363905-9480-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1487363905-9480-1-git-send-email-armbru@redhat.com>
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 05/14] libqtest: Clean up qmp_response() a bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Use qobject_to_qdict() instead of a type cast.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/libqtest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index d8fba66..e54354d 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -379,9 +379,9 @@ static void qmp_response(JSONMessageParser *parser, GQueue *tokens)
         exit(1);
     }
 
-    g_assert(qobject_type(obj) == QTYPE_QDICT);
     g_assert(!qmp->response);
-    qmp->response = (QDict *)obj;
+    qmp->response = qobject_to_qdict(obj);
+    g_assert(qmp->response);
 }
 
 QDict *qmp_fd_receive(int fd)
-- 
2.7.4
