Received: from eggs.gnu.org ([2001:4830:134:3::10]:53963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1co88N-00058y-Qh
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1co88J-0007Ri-Qs
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:34:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1co88J-0007RQ-Ln
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:34:27 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 728487E9C4
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 12:34:27 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 15 Mar 2017 12:34:21 +0000
Message-Id: <20170315123421.28815-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2] trace: ensure $(tracetool-y) is defined in
 top level makefile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The build rules for trace files have a dependancy on $(tracetool-y).
This variable populated in the trace/Makefile.objs file and thus its
definition gets pulled into the top level makefile. This happens too
late in the process though, so by the time $(tracetool-y) is defined,
make has already evaluated $(tracetool-y) in the dependancies and
found it to be empty. The result is that when the tracetool source
is changed, the generated files are not rebuilt. The solution is to
define the variable in the top level makefile too

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile            | 3 +++
 trace/Makefile.objs | 8 --------
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 1c4c04f..dffc74b 100644
--- a/Makefile
+++ b/Makefile
@@ -85,6 +85,9 @@ GENERATED_SOURCES += $(TRACE_SOURCES)
 
 trace-group-name = $(shell dirname $1 | sed -e 's/[^a-zA-Z0-9]/_/g')
 
+tracetool-y = $(SRC_PATH)/scripts/tracetool.py
+tracetool-y += $(shell find $(SRC_PATH)/scripts/tracetool -name "*.py")
+
 %/trace.h: %/trace.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
 %/trace.h-timestamp: $(SRC_PATH)/%/trace-events $(tracetool-y)
diff --git a/trace/Makefile.objs b/trace/Makefile.objs
index 7de840a..1b8eb4a 100644
--- a/trace/Makefile.objs
+++ b/trace/Makefile.objs
@@ -1,13 +1,5 @@
 # -*- mode: makefile -*-
 
-######################################################################
-# tracetool source files
-# Every rule that invokes tracetool must depend on this so code is regenerated
-# if tracetool itself changes.
-
-tracetool-y = $(SRC_PATH)/scripts/tracetool.py
-tracetool-y += $(shell find $(SRC_PATH)/scripts/tracetool -name "*.py")
-
 $(BUILD_DIR)/trace-events-all: $(trace-events-files)
 	$(call quiet-command,cat $^ > $@)
 
-- 
2.9.3
