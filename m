Received: from eggs.gnu.org ([2001:4830:134:3::10]:49278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cpx6R-0003dA-Qn
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:12:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cpx6P-0002bZ-Ck
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:12:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cpx6P-0002bE-7D
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:12:01 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 20 Mar 2017 14:11:50 +0100
Message-Id: <1490015515-25851-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1490015515-25851-1-git-send-email-armbru@redhat.com>
References: <1490015515-25851-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 1/6] qapi: Drop excessive Make
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
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

When qapi2texi.py changes, we regenerate everything QAPI.  Screwed up
in commit 56e8bdd.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 73e0c12..14d3e55 100644
--- a/Makefile
+++ b/Makefile
@@ -391,7 +391,6 @@ qemu-ga$(EXESUF): QEMU_CFLAGS += -I qga/qapi-generated
 gen-out-type = $(subst .,-,$(suffix $@))
 
 qapi-py = $(SRC_PATH)/scripts/qapi.py $(SRC_PATH)/scripts/ordereddict.py
-qapi-py += $(SRC_PATH)/scripts/qapi2texi.py
 
 qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.h :\
 $(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-types.py $(qapi-py)
@@ -700,10 +699,12 @@ qemu-monitor-info.texi: $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/scripts/hxt
 qemu-img-cmds.texi: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
 
-docs/qemu-qmp-qapi.texi: $(qapi-modules) $(qapi-py)
+docs/qemu-qmp-qapi.texi docs/qemu-ga-qapi.texi: $(SRC_PATH)/scripts/qapi2texi.py $(qapi-py)
+
+docs/qemu-qmp-qapi.texi: $(qapi-modules)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi2texi.py $< > $@,"GEN","$@")
 
-docs/qemu-ga-qapi.texi: $(SRC_PATH)/qga/qapi-schema.json $(qapi-py)
+docs/qemu-ga-qapi.texi: $(SRC_PATH)/qga/qapi-schema.json
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi2texi.py $< > $@,"GEN","$@")
 
 qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-info.texi
-- 
2.7.4
