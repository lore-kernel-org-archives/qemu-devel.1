Received: from eggs.gnu.org ([2001:4830:134:3::10]:49359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1co6by-0001xU-To
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 06:56:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1co6bt-0004qV-4m
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 06:56:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1co6bt-0004q7-03
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 06:56:53 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D153FC05AA5B
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 10:56:52 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 15 Mar 2017 10:56:46 +0000
Message-Id: <20170315105646.32355-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] trace: ensure $(tracetool-y) is defined in top
 level makefile
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
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

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
-- 
2.9.3
