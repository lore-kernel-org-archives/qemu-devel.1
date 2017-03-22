Received: from eggs.gnu.org ([2001:4830:134:3::10]:52594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqkN8-0007te-I8
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqkN6-0001Kt-KA
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:48:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cqkN6-0001K4-F2
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:48:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C00163E12
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 17:48:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 36087800D1
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 17:48:32 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 22 Mar 2017 18:48:17 +0100
Message-Id: <1490204908-26567-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1490204908-26567-1-git-send-email-armbru@redhat.com>
References: <1490204908-26567-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 for-2.9 06/17] qapi: Drop excessive Make
 dependencies on qapi2texi.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

When qapi2texi.py changes, we regenerate everything QAPI.  Screwed up
in commit 56e8bdd.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1490015515-25851-2-git-send-email-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index f4f90df..6c359b2 100644
--- a/Makefile
+++ b/Makefile
@@ -392,7 +392,6 @@ qemu-ga$(EXESUF): QEMU_CFLAGS +=3D -I qga/qapi-genera=
ted
 gen-out-type =3D $(subst .,-,$(suffix $@))
=20
 qapi-py =3D $(SRC_PATH)/scripts/qapi.py $(SRC_PATH)/scripts/ordereddict.=
py
-qapi-py +=3D $(SRC_PATH)/scripts/qapi2texi.py
=20
 qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.h =
:\
 $(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-types.py $(qap=
i-py)
@@ -701,10 +700,12 @@ qemu-monitor-info.texi: $(SRC_PATH)/hmp-commands-in=
fo.hx $(SRC_PATH)/scripts/hxt
 qemu-img-cmds.texi: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxt=
ool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","=
$@")
=20
-docs/qemu-qmp-qapi.texi: $(qapi-modules) $(qapi-py)
+docs/qemu-qmp-qapi.texi docs/qemu-ga-qapi.texi: $(SRC_PATH)/scripts/qapi=
2texi.py $(qapi-py)
+
+docs/qemu-qmp-qapi.texi: $(qapi-modules)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi2texi.py $< > $@=
,"GEN","$@")
=20
-docs/qemu-ga-qapi.texi: $(SRC_PATH)/qga/qapi-schema.json $(qapi-py)
+docs/qemu-ga-qapi.texi: $(SRC_PATH)/qga/qapi-schema.json
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi2texi.py $< > $@=
,"GEN","$@")
=20
 qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-i=
nfo.texi
--=20
2.7.4
