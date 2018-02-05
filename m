Received: from eggs.gnu.org ([2001:4830:134:3::10]:59272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eipsx-0001bC-K3
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eipsw-0006ug-IE
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eipsw-0006t7-Ba
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:14 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  5 Feb 2018 21:08:45 -0200
Message-Id: <20180205230900.11344-7-ehabkost@redhat.com>
In-Reply-To: <20180205230900.11344-1-ehabkost@redhat.com>
References: <20180205230900.11344-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 06/21] qapi: remove '-q' arg to diff when
 comparing QAPI output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

When the qapi schema tests fail they merely print that the expected
output didn't match the actual output. This is largely useless when
trying diagnose what went wrong. Removing the '-q' arg to diff
means that it is still silent on successful tests, but when it
fails we'll see details of the incorrect output.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-Id: <20180116134217.8725-7-berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/Makefile.include | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index ca82e0c0cc..3258b9c22a 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -917,10 +917,10 @@ $(patsubst %, check-%, $(check-qapi-schema-y)): check-%.json: $(SRC_PATH)/%.json
 		$^ >$*.test.out 2>$*.test.err; \
 		echo $$? >$*.test.exit, \
 		"TEST","$*.out")
-	@diff -q $(SRC_PATH)/$*.out $*.test.out
+	@diff $(SRC_PATH)/$*.out $*.test.out
 	@# Sanitize error messages (make them independent of build directory)
-	@perl -p -e 's|\Q$(SRC_PATH)\E/||g' $*.test.err | diff -q $(SRC_PATH)/$*.err -
-	@diff -q $(SRC_PATH)/$*.exit $*.test.exit
+	@perl -p -e 's|\Q$(SRC_PATH)\E/||g' $*.test.err | diff $(SRC_PATH)/$*.err -
+	@diff $(SRC_PATH)/$*.exit $*.test.exit
 
 .PHONY: check-tests/qapi-schema/doc-good.texi
 check-tests/qapi-schema/doc-good.texi: tests/qapi-schema/doc-good.test.texi
-- 
2.14.3
