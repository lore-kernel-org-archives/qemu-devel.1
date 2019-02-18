Received: from eggs.gnu.org ([209.51.188.92]:60022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvjYu-0001yF-Sm
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:06:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvjYm-0005Sf-TM
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:06:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gvjYm-0005Ox-E8
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:06:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 32BF488E58
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 14:06:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-92.ams2.redhat.com
	[10.36.116.92])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 009B91024948
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 14:06:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 18 Feb 2019 15:05:57 +0100
Message-Id: <20190218140607.31998-9-armbru@redhat.com>
In-Reply-To: <20190218140607.31998-1-armbru@redhat.com>
References: <20190218140607.31998-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/18] qapi: New module target.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We can't add appropriate target-specific conditionals to misc.json,
because that would make all of misc.json unusable in
target-independent code.  To keep misc.json target-independent, we
need to split off target-dependent target.json.

This commit doesn't actually split off anything, it merely creates the
empty module.  The next few patches will move stuff from misc.json
there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190214152251.2073-9-armbru@redhat.com>
---
 qapi/Makefile.objs    | 28 +++++++++++++++++-----------
 qapi/qapi-schema.json |  1 +
 qapi/target.json      | 13 +++++++++++++
 3 files changed, 31 insertions(+), 11 deletions(-)
 create mode 100644 qapi/target.json

diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index 05bb0564f2..87e4df1660 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -5,21 +5,27 @@ util-obj-y +=3D opts-visitor.o qapi-clone-visitor.o
 util-obj-y +=3D qmp-event.o
 util-obj-y +=3D qapi-util.o
=20
-QAPI_MODULES =3D block-core block char common crypto introspect job migr=
ation
-QAPI_MODULES +=3D misc net rdma rocker run-state sockets tpm trace trans=
action
-QAPI_MODULES +=3D ui
+QAPI_COMMON_MODULES =3D block-core block char common crypto introspect
+QAPI_COMMON_MODULES +=3D job migration misc net rdma rocker run-state
+QAPI_COMMON_MODULES +=3D sockets tpm trace transaction ui
+QAPI_TARGET_MODULES =3D target
+QAPI_MODULES =3D $(QAPI_COMMON_MODULES) $(QAPI_TARGET_MODULES)
=20
 util-obj-y +=3D qapi-builtin-types.o
-util-obj-y +=3D qapi-types.o
-util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi-types-%.o)
+util-obj-y +=3D $(QAPI_COMMON_MODULES:%=3Dqapi-types-%.o)
 util-obj-y +=3D qapi-builtin-visit.o
-util-obj-y +=3D qapi-visit.o
-util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi-visit-%.o)
+util-obj-y +=3D $(QAPI_COMMON_MODULES:%=3Dqapi-visit-%.o)
 util-obj-y +=3D qapi-emit-events.o
-util-obj-y +=3D qapi-events.o
-util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi-events-%.o)
+util-obj-y +=3D $(QAPI_COMMON_MODULES:%=3Dqapi-events-%.o)
=20
-common-obj-y =3D qapi-commands.o
-common-obj-y +=3D $(QAPI_MODULES:%=3Dqapi-commands-%.o)
+common-obj-y =3D $(QAPI_COMMON_MODULES:%=3Dqapi-commands-%.o)
=20
 obj-y =3D qapi-introspect.o
+obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-types-%.o)
+obj-y +=3D qapi-types.o
+obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-visit-%.o)
+obj-y +=3D qapi-visit.o
+obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-events-%.o)
+obj-y +=3D qapi-events.o
+obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-commands-%.o)
+obj-y +=3D qapi-commands.o
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 1845aa78ff..db61bfd688 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -97,3 +97,4 @@
 { 'include': 'trace.json' }
 { 'include': 'introspect.json' }
 { 'include': 'misc.json' }
+{ 'include': 'target.json' }
diff --git a/qapi/target.json b/qapi/target.json
new file mode 100644
index 0000000000..8054926293
--- /dev/null
+++ b/qapi/target.json
@@ -0,0 +1,13 @@
+# -*- Mode: Python -*-
+#
+
+##
+# =3D Target-specific commands & events
+##
+
+##
+# @TARGET-TEMPORARY-DUMMY:
+# Will go away in the next commit.  Needed in this one because empty
+# modules don't generate anything, defeating this commit's purpose.
+##
+{ 'event': 'TARGET-TEMPORARY-DUMMY' }
--=20
2.17.2
