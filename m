Received: from eggs.gnu.org ([2001:4830:134:3::10]:38184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cktMq-0002pV-EG
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:12:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cktMm-0002ly-R3
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:12:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cktMm-0002lM-LX
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:12:00 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DB9B3C05678C
	for <qemu-devel@nongnu.org>; Mon,  6 Mar 2017 14:12:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v26EBxla027991
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Mon, 6 Mar 2017 09:12:00 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  6 Mar 2017 15:11:41 +0100
Message-Id: <1488809515-4047-11-git-send-email-armbru@redhat.com>
In-Reply-To: <1488809515-4047-1-git-send-email-armbru@redhat.com>
References: <1488809515-4047-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 10/24] qjson: Abort earlier on
 qobject_from_jsonf() misuse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Ignoring errors first, then asserting success is suboptimal.  Pass
&error_abort instead, so we abort earlier, and hopefully get more
useful clues on what's wrong.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <1488317230-26248-11-git-send-email-armbru@redhat.com>
---
 qobject/qjson.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qobject/qjson.c b/qobject/qjson.c
index 339c9f7..c98d6a7 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -65,7 +65,7 @@ QObject *qobject_from_jsonf(const char *string, ...)
     va_list ap;
 
     va_start(ap, string);
-    obj = qobject_from_jsonv(string, &ap, NULL);
+    obj = qobject_from_jsonv(string, &ap, &error_abort);
     va_end(ap);
 
     assert(obj != NULL);
-- 
2.7.4
