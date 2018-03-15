Received: from eggs.gnu.org ([2001:4830:134:3::10]:33741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ewSM9-0003BD-Cp
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 08:51:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ewSM5-00032L-HT
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 08:51:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55352 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ewSM5-00031a-CH
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 08:51:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 831AE7CBBA
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 12:51:25 +0000 (UTC)
Received: from red.redhat.com (ovpn-121-135.rdu2.redhat.com [10.10.121.135])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4D4491208F79
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 12:51:21 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu, 15 Mar 2018 07:51:16 -0500
Message-Id: <20180315125116.804342-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 for-2.12] qapi: Pass '-u' when doing
 non-silent diff
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Ed-script diffs are awful compared to context diffs.  Fix another
'diff -q' while in the area (if the files are different, being
noisy makes it easier to diagnose why).

While at it, diff .err before .out, because if a test fails, .err
is more likely to contain the most important information for
fixing the failure.

Fixes: 46ec4fce
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

---
v2: diff .err first [Markus], R-b added (since swapping lines is trivial)

Extracted from a larger '0/3 QAPI file renames' series; this patch
is reasonable for inclusion during softfreeze, so I'll queue it through
my QAPI tree.
---
 tests/Makefile.include | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index ef9b88c3694..5d8c730bf46 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -926,14 +926,14 @@ $(patsubst %, check-%, $(check-qapi-schema-y)): che=
ck-%.json: $(SRC_PATH)/%.json
 		$^ >$*.test.out 2>$*.test.err; \
 		echo $$? >$*.test.exit, \
 		"TEST","$*.out")
-	@diff $(SRC_PATH)/$*.out $*.test.out
 	@# Sanitize error messages (make them independent of build directory)
-	@perl -p -e 's|\Q$(SRC_PATH)\E/||g' $*.test.err | diff $(SRC_PATH)/$*.e=
rr -
-	@diff $(SRC_PATH)/$*.exit $*.test.exit
+	@perl -p -e 's|\Q$(SRC_PATH)\E/||g' $*.test.err | diff -u $(SRC_PATH)/$=
*.err -
+	@diff -u $(SRC_PATH)/$*.out $*.test.out
+	@diff -u $(SRC_PATH)/$*.exit $*.test.exit

 .PHONY: check-tests/qapi-schema/doc-good.texi
 check-tests/qapi-schema/doc-good.texi: tests/qapi-schema/doc-good.test.t=
exi
-	@diff -q $(SRC_PATH)/tests/qapi-schema/doc-good.texi $<
+	@diff -u $(SRC_PATH)/tests/qapi-schema/doc-good.texi $<

 .PHONY: check-decodetree
 check-decodetree:
--=20
2.14.3
