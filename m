Received: from eggs.gnu.org ([2001:4830:134:3::10]:48390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cy0sR-0002jQ-1l
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 14:50:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cy0sN-0004Qy-6T
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 14:50:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cy0sN-0004Qo-0Z
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 14:50:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EE963804F0
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 18:50:49 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Tue, 11 Apr 2017 13:50:25 -0500
Message-Id: <20170411185034.13460-5-eblake@redhat.com>
In-Reply-To: <20170411185034.13460-1-eblake@redhat.com>
References: <20170411185034.13460-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 04/13] coccinelle: Add script to remove
 useless QObject casts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

We have macros in place to make it less verbose to add a subtype
of QObject to both QDict and QList. While we have made cleanups
like this in the past (see commit fcfcd8ffc, for example), having
it be automated by Coccinelle makes it easier to maintain.

The script is separate from the cleanups, for ease of review and
backporting.  A later patch will then add further possible cleanups.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v4: no change
v3: new patch
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
2.9.3
