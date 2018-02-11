Received: from eggs.gnu.org ([2001:4830:134:3::10]:43211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ekfgz-0002v3-5W
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 19:40:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ekfgv-0006qJ-VD
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 19:40:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58405 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ekfgv-0006nq-M5
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 19:40:25 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4DC8B407519B
	for <qemu-devel@nongnu.org>; Sun, 11 Feb 2018 00:40:20 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Sat, 10 Feb 2018 18:40:11 -0600
Message-Id: <20180211004013.10784-2-eblake@redhat.com>
In-Reply-To: <20180211004013.10784-1-eblake@redhat.com>
References: <20180211004013.10784-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] qapi: Pass '-u' when doing non-silent diff
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

Ed-script diffs are awful compared to context diffs.  Fix another
'diff -q' while in the area (if the files are different, being
noisy makes it easier to diagnose why).

Fixes: 46ec4fce
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/Makefile.include | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index f41da235aef..375f31b5bc0 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -919,14 +919,14 @@ $(patsubst %, check-%, $(check-qapi-schema-y)): check-%.json: $(SRC_PATH)/%.json
 		$^ >$*.test.out 2>$*.test.err; \
 		echo $$? >$*.test.exit, \
 		"TEST","$*.out")
-	@diff $(SRC_PATH)/$*.out $*.test.out
+	@diff -u $(SRC_PATH)/$*.out $*.test.out
 	@# Sanitize error messages (make them independent of build directory)
-	@perl -p -e 's|\Q$(SRC_PATH)\E/||g' $*.test.err | diff $(SRC_PATH)/$*.err -
-	@diff $(SRC_PATH)/$*.exit $*.test.exit
+	@perl -p -e 's|\Q$(SRC_PATH)\E/||g' $*.test.err | diff -u $(SRC_PATH)/$*.err -
+	@diff -u $(SRC_PATH)/$*.exit $*.test.exit

 .PHONY: check-tests/qapi-schema/doc-good.texi
 check-tests/qapi-schema/doc-good.texi: tests/qapi-schema/doc-good.test.texi
-	@diff -q $(SRC_PATH)/tests/qapi-schema/doc-good.texi $<
+	@diff -u $(SRC_PATH)/tests/qapi-schema/doc-good.texi $<

 # Consolidated targets

-- 
2.14.3
