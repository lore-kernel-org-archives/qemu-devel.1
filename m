Received: from eggs.gnu.org ([2001:4830:134:3::10]:55190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBioc-0003ao-Tb
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBioY-0007XK-UQ
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:28:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37690 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fBioY-0007XC-OI
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:28:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5E373A201D
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 15:28:06 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 26 Apr 2018 17:28:05 +0200
Message-Id: <20180426152805.8469-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH] qobject: Use qobject_to() instead of type cast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com

The proper way to convert from (abstract) QObject to a (concrete)
subtype is qobject_to().  Look for offenders that type cast instead:

    $ git-grep '(Q[A-Z][a-z]* \*)'
    hmp.c:    qmp_device_add((QDict *)qdict, NULL, &err);
    include/qapi/qmp/qobject.h:        return (QObject *)obj;
    qobject/qobject.c:static void (*qdestroy[QTYPE__MAX])(QObject *) = {
    tests/check-qdict.c:    dst = (QDict *)qdict_crumple(src, &error_abort);

The first two cast away const, the third isn't a type cast.  Fix the
fourth.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/check-qdict.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/check-qdict.c b/tests/check-qdict.c
index a0e0454684..eba5d3528e 100644
--- a/tests/check-qdict.c
+++ b/tests/check-qdict.c
@@ -657,7 +657,7 @@ static void qdict_crumple_test_empty(void)
 
     src = qdict_new();
 
-    dst = (QDict *)qdict_crumple(src, &error_abort);
+    dst = qobject_to(QDict, qdict_crumple(src, &error_abort));
 
     g_assert_cmpint(qdict_size(dst), ==, 0);
 
-- 
2.13.6
