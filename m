Received: from eggs.gnu.org ([2001:4830:134:3::10]:47362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUC6-0000r4-Tq
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUC2-00054q-Rn
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33186
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUC2-00054O-ML
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:46 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0EAuo017896
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:15:46 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cmub2wv9w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:15:46 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 20:15:45 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:13:49 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-15-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 14/79] coccinelle: Add script to remove useless
 QObject casts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

From: Eric Blake <eblake@redhat.com>

We have macros in place to make it less verbose to add a subtype
of QObject to both QDict and QList. While we have made cleanups
like this in the past (see commit fcfcd8ffc, for example), having
it be automated by Coccinelle makes it easier to maintain.

The script is separate from the cleanups, for ease of review and
backporting.  A later patch will then add further possible cleanups.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20170427215821.19397-4-eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
(cherry picked from commit a2f3453ebc64b1ebe094aeaf83f9e67896f90ac3)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 MAINTAINERS                      |  1 +
 scripts/coccinelle/qobject.cocci | 13 +++++++++++++
 2 files changed, 14 insertions(+)
 create mode 100644 scripts/coccinelle/qobject.cocci

diff --git a/MAINTAINERS b/MAINTAINERS
index c60235e..430efb0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1395,6 +1395,7 @@ S: Supported
 F: qobject/
 F: include/qapi/qmp/
 X: include/qapi/qmp/dispatch.h
+F: scripts/coccinelle/qobject.cocci
 F: tests/check-qdict.c
 F: tests/check-qfloat.c
 F: tests/check-qint.c
diff --git a/scripts/coccinelle/qobject.cocci b/scripts/coccinelle/qobject.cocci
new file mode 100644
index 0000000..aa899e2
--- /dev/null
+++ b/scripts/coccinelle/qobject.cocci
@@ -0,0 +1,13 @@
+// Use QDict macros where they make sense
+@@
+expression Obj, Key, E;
+@@
+- qdict_put_obj(Obj, Key, QOBJECT(E));
++ qdict_put(Obj, Key, E);
+
+// Use QList macros where they make sense
+@@
+expression Obj, E;
+@@
+- qlist_append_obj(Obj, QOBJECT(E));
++ qlist_append(Obj, E);
-- 
2.7.4
