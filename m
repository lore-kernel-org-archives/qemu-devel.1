Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61696C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 15:39:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28B7C206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 15:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZgM+XIt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B7C206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTonb-0005tS-7E
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 11:38:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jTolk-0002dZ-PW
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:37:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jTolJ-0005yK-DT
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:37:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27835
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jTolI-0005y2-Uo
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588174596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tnUJG1X0ayXfwR1nvayzRVxX8tprQnFECdsWg5e0f4Q=;
 b=ZgM+XIt3usb+PaRg1F3hWqj74y0stayHH5Gj8VrRDHG2i+Lze7qWrjEdzfzaw/+YjwawBO
 Wmb1gLiqAigaoWQ9USC417mnVT24Nh+dLW7XiXM2VT3Tm7CLNaeXBjSqR/hh5/POvHpc9W
 Uq+YFMUhHCnTUq+oCguCWMNeVyJw4Zc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-CrPub6U4P6KmKMBopEn_pg-1; Wed, 29 Apr 2020 11:36:31 -0400
X-MC-Unique: CrPub6U4P6KmKMBopEn_pg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55ABABFC2;
 Wed, 29 Apr 2020 15:36:30 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ADE626A942;
 Wed, 29 Apr 2020 15:36:28 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests: add a "check-flake8" test for validating python code
 style
Date: Wed, 29 Apr 2020 16:36:21 +0100
Message-Id: <20200429153621.1694266-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The flake8 program is a standard tool used by Python projects for
validating many commonly recommended style rules. It would be desirable
for QEMU to come into alignment with normal Python coding style best
practices.

QEMU currently violates a huge number of the style rules, so we can't
blindly turn it on. Instead this patch introduces use of flake8 with
a huge ignore list to turn off everything that is currently violated.

The following descriptions are mostly taken from:

  https://www.flake8rules.com/

Indentation:

 E111 =09Indentation is not a multiple of four
 E114 =09Indentation is not a multiple of four (comment)
 E115   Expected an indented block (comment)
 E116 =09Unexpected indentation (comment)
 E117   Over-indented
 E121   Continuation line under-indented for hanging indent
 E122 =09Continuation line missing indentation or outdented
 E123 =09Closing bracket does not match indentation of opening bracket's li=
ne
 E124 =09Closing bracket does not match visual indentation
 E125 =09Continuation line with same indent as next logical line
 E126 =09Continuation line over-indented for hanging indent
 E127 =09Continuation line over-indented for visual indent
 E128 =09Continuation line under-indented for visual indent
 E129 =09Visually indented line with same indent as next logical line
 E131 =09Continuation line unaligned for hanging indent

Whitespace:

 E201 =09Whitespace after '('
 E202 =09Whitespace before ')'
 E203 =09Whitespace before ':'
 E211 =09Whitespace before '('
 E221 =09Multiple spaces before operator
 E222 =09Multiple spaces after operator
 E225 =09Missing whitespace around operator
 E226 =09Missing whitespace around arithmetic operator
 E228 =09Missing whitespace around modulo operator
 E231 =09Missing whitespace after ',', ';', or ':'
 E241 =09Multiple spaces after ','
 E251 =09Unexpected spaces around keyword / parameter equals
 E261 =09At least two spaces before inline comment
 E265 =09Block comment should start with '# '
 E266 =09Too many leading '#' for block comment

Blank lines:

 E301 =09Expected 1 blank line, found 0
 E302 =09Expected 2 blank lines, found 0
 E303 =09Too many blank lines (3)
 E305 =09Expected 2 blank lines after end of function or class
 E306 =09Expected 1 blank line before a nested definition

Imports:

 E401 =09Multiple imports on one line
 E402 =09Module level import not at top of file

Line length:

 E501 =09Line too long (82 > 79 characters)
 E502 =09The backslash is redundant between brackets

Statements:

 E701 =09Multiple statements on one line (colon)
 E702 =09Multiple statements on one line (semicolon)
 E703 =09Statement ends with a semicolon
 E711 =09Comparison to none should be 'if cond is none:'
 E712 =09Comparison to true should be 'if cond is true:' or 'if cond:'
 E713 =09Test for membership should be 'not in'
 E714 =09Test for object identity should be 'is not'
 E722   Do not use bare 'except'
 E731 =09Do not assign a lambda expression, use a def
 E741 =09Do not use variables named 'I', 'O', or 'l'

Errors:

 F401 =09Module imported but unused
 F403 =09'from module import *' used; unable to detect undefined names
 F405 =09Name may be undefined, or defined from star imports: module
 F811 =09Redefinition of unused name from line n
 F821 =09Undefined name name
 F841 =09Local variable name is assigned to but never used

Warnings:

 W391 =09Blank line at end of file
 W503 =09Line break occurred before a binary operator
 W504 =09Line break occurred after a binary operator
 W605 =09Invalid escape sequence 'x'

Over time code should be fixed and rules removed from the ignore list.
A handful of style rules may not warrant fixing as the cure is arguably
worse and very subjective. e.g.

 E501: Force breaking lines at < 80 characters results in
       some really unnatural code formatting which harms
       readability.

 W504: Knuth code style requires the operators "or" and "and" etc
       to be at the start of line in a multi-line conditional.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---

On its own this patch doesn't really do much of use except try to stop the
situation getting worse. To be valuable some motivated contributor(s)
would need to go through fixing the code, and re-enabling each excluded
warning category one at a time.

I'm mostly proposing this patch as a starting point for discussion, to
see if anyone is indeed motivated to take on the code cleanup challenge,
and feed the fixes in through the various maintainers trees.

 tests/Makefile.include | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 51de676298..f08e99b09c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -4,7 +4,7 @@
 check-help:
 =09@echo "Regression testing targets:"
 =09@echo
-=09@echo " $(MAKE) check                Run unit, qapi-schema, qtest and d=
ecodetree"
+=09@echo " $(MAKE) check                Run unit, qapi-schema, qtest and d=
ecodetree flake8"
 =09@echo
 =09@echo " $(MAKE) check-qtest-TARGET   Run qtest tests for given target"
 =09@echo " $(MAKE) check-qtest          Run qtest tests"
@@ -19,6 +19,7 @@ check-help:
 =09@echo " $(MAKE) check-report.tap     Generates an aggregated TAP test r=
eport"
 =09@echo " $(MAKE) check-venv           Creates a Python venv for tests"
 =09@echo " $(MAKE) check-clean          Clean the tests and related data"
+=09@echo " $(MAKE) check-flake8         Clean the tests and related data"
 =09@echo
 =09@echo " $(MAKE) get-vm-images        Downloads all images used by accep=
tance tests, according to configured targets (~350 MB each, 1.5 GB max)"
 =09@echo
@@ -923,7 +924,40 @@ check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGE=
TS))
 ifeq ($(CONFIG_TOOLS),y)
 check-block: $(patsubst %,check-%, $(check-block-y))
 endif
-check: check-block check-qapi-schema check-unit check-softfloat check-qtes=
t check-decodetree
+
+is_git :=3D $(shell test -d $(SRC_PATH)/.git && echo 1 || echo 0)
+
+ifeq (1, $(is_git))
+PYTHON_FILES =3D $(shell git ls-tree -r HEAD: --name-only | grep '.py$$')
+PYTHON_FILES +=3D $(shell git ls-tree -r HEAD: --name-only tests/qemu-iote=
sts/??? | xargs grep -l '/usr/bin/env python')
+
+# Validate many python style rules
+FLAKE8_INDENTATION =3D E111,E114,E115,E116,E117,E121,E122,E123,E124,E125,E=
126,E127,E128,E129,E131
+FLAKE8_WHITESPACE =3D E201,E202,E203,E211,E221,E222,E225,E226,E228,E231,E2=
41,E251,E261,E265,E266
+FLAKE8_BLANK_LINES =3D E301,E302,E303,E305,E306
+FLAKE8_IMPORTS =3D E401,E402
+FLAKE8_LINE_LENGTH =3D E501,E502
+FLAKE8_STATEMENTS =3D E701,E702,E703,E711,E712,E713,E714,E722,E731,E741
+FLAKE8_ERRORS =3D F401,F403,F405,F811,F821,F841
+FLAKE8_WARNINGS =3D W391,W503,W504,W605
+
+FLAKE8_IGNORE =3D $(FLAKE8_INDENTATION),$\
+               $(FLAKE8_WHITESPACE),$\
+               $(FLAKE8_BLANK_LINES),$\
+               $(FLAKE8_IMPORTS),$\
+               $(FLAKE8_LINE_LENGTH),$\
+               $(FLAKE8_STATEMENTS),$\
+               $(FLAKE8_ERRORS),$\
+               $(FLAKE8_WARNINGS) \
+               $(NULL)
+
+check-flake8:
+=09$(call quiet-command,flake8 --ignore=3D$(FLAKE8_IGNORE) $(PYTHON_FILES)=
)
+else
+check-flake8:
+endif
+
+check: check-block check-qapi-schema check-unit check-softfloat check-qtes=
t check-decodetree check-flake8
 check-clean:
 =09rm -rf $(check-unit-y) tests/*.o tests/*/*.o $(QEMU_IOTESTS_HELPERS-y)
 =09rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(t=
arget)-y:%=3Dtests/qtest/%$(EXESUF))) $(check-qtest-generic-y:%=3Dtests/qte=
st/%$(EXESUF)))
--=20
2.25.4


