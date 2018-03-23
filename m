Received: from eggs.gnu.org ([2001:4830:134:3::10]:33676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezQdX-0005ZC-Kv
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 13:37:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezQdW-0002Jd-6i
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 13:37:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46872 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ezQdW-0002J9-2Y
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 13:37:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AF120406E8A4
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 17:37:53 +0000 (UTC)
Received: from red.redhat.com (ovpn-121-135.rdu2.redhat.com [10.10.121.135])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 77AA58443F
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 17:37:53 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri, 23 Mar 2018 12:37:41 -0500
Message-Id: <20180323173741.1445744-5-eblake@redhat.com>
In-Reply-To: <20180323173741.1445744-1-eblake@redhat.com>
References: <20180323173741.1445744-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/4] qapi: Force UTF8 encoding when parsing qapi
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Commit d4e5ec877 already fixed things to work around Python 3's
lame bug of having LC_ALL=3DC not be 8-bit clean, when parsing the
main QMP qapi files; but failed to do likewise in the tests
directory.  As a result, running 'LC_ALL=3DC make check' fails on
escape-too-big and unicode-str when using python 3 with a nasty
stack trace instead of the intended graceful error message that
QAPI doesn't yet support 8-bit data (the two tests contain
Unicode =C3=A9, when parsed in UTF-8; they represent something
different when parsed in a proper single-byte C locale, but that
doesn't matter to the error message printed out, provided that
brain-dead Python hasn't first choked on the input instead of
being 8-bit clean).

Ideally, we'd teach the qapi generator scripts to automatically
slurp things in using UTF-8 regardless of locale, and to honor
content that is not limited to 7 bit data rather than gracefully
erroring out; but until then, since our graceful error depends
on python parsing 8-bit data (even if nothing we generate uses
8-bit data), our quick fix is to use the right locale when
running these tests.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180319205040.1113423-1-eblake@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/Makefile.include | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 0b277036df1..eb218a9539d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -669,13 +669,13 @@ tests/test-qapi-events.c tests/test-qapi-events.h \
 tests/test-qapi-introspect.c tests/test-qapi-introspect.h: \
 tests/test-qapi-gen-timestamp ;
 tests/test-qapi-gen-timestamp: $(SRC_PATH)/tests/qapi-schema/qapi-schema=
-test.json $(qapi-py)
-	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
+	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-gen.py \
 		-o tests -p "test-" $<, \
 		"GEN","$(@:%-timestamp=3D%)")
 	@>$@

 tests/qapi-schema/doc-good.test.texi: $(SRC_PATH)/tests/qapi-schema/doc-=
good.json $(qapi-py)
-	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
+	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-gen.py \
 		-o tests/qapi-schema -p "doc-good-" $<, \
 		"GEN","$@")
 	@mv tests/qapi-schema/doc-good-qapi-doc.texi $@
@@ -927,7 +927,7 @@ check-tests/qemu-iotests-quick.sh: tests/qemu-iotests=
-quick.sh qemu-img$(EXESUF)
 .PHONY: $(patsubst %, check-%, $(check-qapi-schema-y))
 $(patsubst %, check-%, $(check-qapi-schema-y)): check-%.json: $(SRC_PATH=
)/%.json
 	$(call quiet-command, PYTHONPATH=3D$(SRC_PATH)/scripts \
-		$(PYTHON) $(SRC_PATH)/tests/qapi-schema/test-qapi.py \
+		$(PYTHON_UTF8) $(SRC_PATH)/tests/qapi-schema/test-qapi.py \
 		$^ >$*.test.out 2>$*.test.err; \
 		echo $$? >$*.test.exit, \
 		"TEST","$*.out")
--=20
2.14.3
