Received: from eggs.gnu.org ([2001:4830:134:3::10]:38500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1coPSv-00022Q-FS
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1coPSu-00062q-G4
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:04:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1coPSu-00062f-BF
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:04:52 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 16 Mar 2017 15:04:27 +0800
Message-Id: <20170316070427.17120-4-stefanha@redhat.com>
In-Reply-To: <20170316070427.17120-1-stefanha@redhat.com>
References: <20170316070427.17120-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 3/3] trace: ensure $(tracetool-y) is defined in
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
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

The build rules for trace files have a dependancy on $(tracetool-y).
This variable populated in the trace/Makefile.objs file and thus its
definition gets pulled into the top level makefile. This happens too
late in the process though, so by the time $(tracetool-y) is defined,
make has already evaluated $(tracetool-y) in the dependancies and
found it to be empty. The result is that when the tracetool source
is changed, the generated files are not rebuilt. The solution is to
define the variable in the top level makefile too

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>
Message-id: 20170315123421.28815-1-berrange@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Makefile            | 3 +++
 trace/Makefile.objs | 8 --------
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 6291764..108b984 100644
--- a/Makefile
+++ b/Makefile
@@ -86,6 +86,9 @@ GENERATED_FILES += $(BUILD_DIR)/trace-events-all
 
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
