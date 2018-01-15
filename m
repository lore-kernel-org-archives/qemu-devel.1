Received: from eggs.gnu.org ([2001:4830:134:3::10]:35004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb8AL-0000W7-7j
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:03:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb8AH-0006Zv-AZ
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:03:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eb8AH-0006ZO-4Y
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:03:17 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 15 Jan 2018 17:02:35 +0000
Message-Id: <20180115170243.24578-6-berrange@redhat.com>
In-Reply-To: <20180115170243.24578-1-berrange@redhat.com>
References: <20180115170243.24578-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v4 05/13] qapi: remove '-q' arg to diff when
 comparing QAPI output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

When the qapi schema tests fail they merely print that the expected
output didn't match the actual output. This is largely useless when
trying diagnose what went wrong. Removing the '-q' arg to diff
means that it is still silent on successful tests, but when it
fails we'll see details of the incorrect output.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/Makefile.include | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 39a4b5359d..d65fb4e1b3 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -908,10 +908,10 @@ $(patsubst %, check-%, $(check-qapi-schema-y)): check-%.json: $(SRC_PATH)/%.json
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
