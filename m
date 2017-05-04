Received: from eggs.gnu.org ([2001:4830:134:3::10]:56296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6Ic0-00022I-Gc
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6Iby-0008Gz-Ip
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d6Iby-0008Fl-Cb
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6133963E25
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 15:24:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  4 May 2017 17:23:42 +0200
Message-Id: <1493911445-19568-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1493911445-19568-1-git-send-email-armbru@redhat.com>
References: <1493911445-19568-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 05/28] coccinelle: Add script to remove useless
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
---
 MAINTAINERS                      |  1 +
 scripts/coccinelle/qobject.cocci | 13 +++++++++++++
 2 files changed, 14 insertions(+)
 create mode 100644 scripts/coccinelle/qobject.cocci

diff --git a/MAINTAINERS b/MAINTAINERS
index a1d2b3a..d852efc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1393,6 +1393,7 @@ S: Supported
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
