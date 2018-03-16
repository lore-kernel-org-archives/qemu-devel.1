Received: from eggs.gnu.org ([2001:4830:134:3::10]:57131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ewpzz-0001Ul-77
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:06:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ewpzt-0005k5-95
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:06:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38292 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ewpzt-0005jo-5L
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:06:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C424B4023156
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 14:06:16 +0000 (UTC)
Received: from red.redhat.com (ovpn-121-135.rdu2.redhat.com [10.10.121.135])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8BF2110B009C
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 14:06:16 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri, 16 Mar 2018 09:05:08 -0500
Message-Id: <20180316140508.863778-39-eblake@redhat.com>
In-Reply-To: <20180316140508.863778-1-eblake@redhat.com>
References: <20180316140508.863778-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 38/38] qapi: Pass '-u' when doing non-silent diff
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
Message-Id: <20180315125116.804342-1-eblake@redhat.com>
---
 tests/Makefile.include | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 42fd426cd00..412aed1737f 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -929,14 +929,14 @@ $(patsubst %, check-%, $(check-qapi-schema-y)): che=
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
