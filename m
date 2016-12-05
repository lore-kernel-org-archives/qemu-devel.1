Received: from eggs.gnu.org ([2001:4830:134:3::10]:47257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cDwOG-0007V7-Be
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:45:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cDwOD-0006vz-US
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:45:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cDwOD-0006v4-Om
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:45:17 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E95C5445CF
	for <qemu-devel@nongnu.org>; Mon,  5 Dec 2016 16:45:16 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  5 Dec 2016 17:45:05 +0100
Message-Id: <1480956313-31322-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1480956313-31322-1-git-send-email-armbru@redhat.com>
References: <1480956313-31322-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 1/9] qmp-event: Avoid
 qobject_from_jsonf("%"PRId64)
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

The qobject_from_jsonf() function implements a pseudo-printf
language for creating a QObject; however, it is hard-coded to
only parse a subset of formats understood by -Wformat, and is
not a straight synonym to bare printf().  In particular, any
use of an int64_t integer works only if the system's
definition of PRId64 matches what the parser expects; which
works on glibc (%lld or %ld depending on 32- vs. 64-bit) and
mingw (%I64d), but not on Mac OS (%qd).  Rather than enhance
the parser, it is just as easy to use 'long long', which we
know always works.  There are few enough callers of
qobject_from_json[fv]() that it is easy to audit that this is
the only non-testsuite caller that was actually relying on
this particular conversion.

Reported by: G 3 <programmingkidx@gmail.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <1479922617-4400-2-git-send-email-eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Cast tv.tv_sec, tv.tv_usec to long long for type correctness]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/qmp-event.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/qapi/qmp-event.c b/qapi/qmp-event.c
index 8bba165..802ede4 100644
--- a/qapi/qmp-event.c
+++ b/qapi/qmp-event.c
@@ -35,21 +35,12 @@ static void timestamp_put(QDict *qdict)
     int err;
     QObject *obj;
     qemu_timeval tv;
-    int64_t sec, usec;
 
     err = qemu_gettimeofday(&tv);
-    if (err < 0) {
-        /* Put -1 to indicate failure of getting host time */
-        sec = -1;
-        usec = -1;
-    } else {
-        sec = tv.tv_sec;
-        usec = tv.tv_usec;
-    }
-
-    obj = qobject_from_jsonf("{ 'seconds': %" PRId64 ", "
-                             "'microseconds': %" PRId64 " }",
-                             sec, usec);
+    /* Put -1 to indicate failure of getting host time */
+    obj = qobject_from_jsonf("{ 'seconds': %lld, 'microseconds': %lld }",
+                             err < 0 ? -1LL : (long long)tv.tv_sec,
+                             err < 0 ? -1LL : (long long)tv.tv_usec);
     qdict_put_obj(qdict, "timestamp", obj);
 }
 
-- 
2.5.5
