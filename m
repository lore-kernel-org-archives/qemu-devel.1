Received: from eggs.gnu.org ([2001:4830:134:3::10]:45935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dIgMV-0001ue-2g
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 15:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dIgMR-0004SW-Ui
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 15:11:23 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  7 Jun 2017 21:11:14 +0200
Message-Id: <1496862674-23626-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] Makefile: Do not generate files if "configure"
 has not been run yet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

When doing a "make -j10" in the vanilla QEMU source tree (without
running "configure first), the Makefile currently generates two
files already, qemu-version.h and qemu-options.def. This should not
happen, so let's make these targets depend on config-host.mak.
Also the python files can not be executed without $(PYTHON), so
these scripts should depend on config-host.mak, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c830d7a..6786dc2 100644
--- a/Makefile
+++ b/Makefile
@@ -286,7 +286,7 @@ endif
 
 all: $(DOCS) $(TOOLS) $(HELPERS-y) recurse-all modules
 
-qemu-version.h: FORCE
+qemu-version.h: config-host.mak FORCE
 	$(call quiet-command, \
 		(cd $(SRC_PATH); \
 		printf '#define QEMU_PKGVERSION '; \
@@ -312,6 +312,7 @@ qemu-version.h: FORCE
 
 config-host.h: config-host.h-timestamp
 config-host.h-timestamp: config-host.mak
+qemu-options.def: config-host.mak
 qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
 
@@ -393,6 +394,8 @@ gen-out-type = $(subst .,-,$(suffix $@))
 
 qapi-py = $(SRC_PATH)/scripts/qapi.py $(SRC_PATH)/scripts/ordereddict.py
 
+$(qapi-py): config-host.mak
+
 qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.h :\
 $(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-types.py $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-types.py \
-- 
1.8.3.1
