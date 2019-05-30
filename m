Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF133C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:05:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96A29257B7
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A29257B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52040 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWIrs-0002pm-P2
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 07:05:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hWIq4-0001hu-Gt
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:03:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hWIq3-0003Wk-5U
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:03:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hWIq0-0003Nc-2c; Thu, 30 May 2019 07:03:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6026930C319F;
	Thu, 30 May 2019 11:03:01 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-119.ams2.redhat.com
	[10.36.116.119])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EC5186B8E0;
	Thu, 30 May 2019 11:02:59 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 30 May 2019 13:02:49 +0200
Message-Id: <20190530110255.16225-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Thu, 30 May 2019 11:03:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 0/6] file-posix: Add dynamic-auto-read-only
 QAPI feature
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, pkrempa@redhat.com, armbru@redhat.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds optional feature lists to struct definitions in the
QAPI schema and makes use of them to advertise the new behaviour of
auto-read-only=3Don in file-posix.

v4:
- Build fix for tests/test-qmp-cmds

v3:
- Added a command using the structs types to the positive test case
- Renamed QAPIDoc.SymbolPart to QAPIDoc.DocPart
- Applied requested comment changes
- Style fixes to avoid adding pycodestyle-3 complaints
- More stylistic changes to match Markus' taste better

v2:
- Check that features have well-formed names instead of just checking
  that they are strings
- Use QAPISchemaFeature objects instead of dicts
- Catch duplicate feature names (and test that a feature name doesn't
  conflict with an object member)
- Added patch 4 and 5 to add rudimentary support for features to
  QAPIDoc so it doesn't complain about the documentation format
  suggested by Markus. Used that format in the documentation of
  dynamic-auto-read-only.


Kevin Wolf (6):
  qapi: Add feature flags to struct types
  tests/qapi-schema: Test for good feature lists in structs
  tests/qapi-schema: Error case tests for features in structs
  qapi: Disentangle QAPIDoc code
  qapi: Allow documentation for features
  file-posix: Add dynamic-auto-read-only QAPI feature

 qapi/block-core.json                          |  13 +-
 qapi/introspect.json                          |   6 +-
 tests/qapi-schema/features-bad-type.json      |   3 +
 .../qapi-schema/features-duplicate-name.json  |   3 +
 tests/qapi-schema/features-missing-name.json  |   3 +
 tests/qapi-schema/features-name-bad-type.json |   3 +
 tests/qapi-schema/features-no-list.json       |   3 +
 tests/qapi-schema/features-unknown-key.json   |   3 +
 tests/qapi-schema/qapi-schema-test.json       |  39 +++
 docs/devel/qapi-code-gen.txt                  |  38 +++
 tests/test-qmp-cmds.c                         |   8 +
 scripts/qapi/common.py                        | 228 +++++++++++++++---
 scripts/qapi/doc.py                           |  15 +-
 scripts/qapi/introspect.py                    |   6 +-
 scripts/qapi/types.py                         |   3 +-
 scripts/qapi/visit.py                         |   3 +-
 tests/Makefile.include                        |   6 +
 tests/qapi-schema/double-type.err             |   2 +-
 tests/qapi-schema/features-bad-type.err       |   1 +
 tests/qapi-schema/features-bad-type.exit      |   1 +
 tests/qapi-schema/features-bad-type.out       |   0
 tests/qapi-schema/features-duplicate-name.err |   1 +
 .../qapi-schema/features-duplicate-name.exit  |   1 +
 tests/qapi-schema/features-duplicate-name.out |   0
 tests/qapi-schema/features-missing-name.err   |   1 +
 tests/qapi-schema/features-missing-name.exit  |   1 +
 tests/qapi-schema/features-missing-name.out   |   0
 tests/qapi-schema/features-name-bad-type.err  |   1 +
 tests/qapi-schema/features-name-bad-type.exit |   1 +
 tests/qapi-schema/features-name-bad-type.out  |   0
 tests/qapi-schema/features-no-list.err        |   1 +
 tests/qapi-schema/features-no-list.exit       |   1 +
 tests/qapi-schema/features-no-list.out        |   0
 tests/qapi-schema/features-unknown-key.err    |   2 +
 tests/qapi-schema/features-unknown-key.exit   |   1 +
 tests/qapi-schema/features-unknown-key.out    |   0
 tests/qapi-schema/qapi-schema-test.out        |  43 ++++
 tests/qapi-schema/test-qapi.py                |   7 +-
 tests/qapi-schema/unknown-expr-key.err        |   2 +-
 39 files changed, 403 insertions(+), 47 deletions(-)
 create mode 100644 tests/qapi-schema/features-bad-type.json
 create mode 100644 tests/qapi-schema/features-duplicate-name.json
 create mode 100644 tests/qapi-schema/features-missing-name.json
 create mode 100644 tests/qapi-schema/features-name-bad-type.json
 create mode 100644 tests/qapi-schema/features-no-list.json
 create mode 100644 tests/qapi-schema/features-unknown-key.json
 create mode 100644 tests/qapi-schema/features-bad-type.err
 create mode 100644 tests/qapi-schema/features-bad-type.exit
 create mode 100644 tests/qapi-schema/features-bad-type.out
 create mode 100644 tests/qapi-schema/features-duplicate-name.err
 create mode 100644 tests/qapi-schema/features-duplicate-name.exit
 create mode 100644 tests/qapi-schema/features-duplicate-name.out
 create mode 100644 tests/qapi-schema/features-missing-name.err
 create mode 100644 tests/qapi-schema/features-missing-name.exit
 create mode 100644 tests/qapi-schema/features-missing-name.out
 create mode 100644 tests/qapi-schema/features-name-bad-type.err
 create mode 100644 tests/qapi-schema/features-name-bad-type.exit
 create mode 100644 tests/qapi-schema/features-name-bad-type.out
 create mode 100644 tests/qapi-schema/features-no-list.err
 create mode 100644 tests/qapi-schema/features-no-list.exit
 create mode 100644 tests/qapi-schema/features-no-list.out
 create mode 100644 tests/qapi-schema/features-unknown-key.err
 create mode 100644 tests/qapi-schema/features-unknown-key.exit
 create mode 100644 tests/qapi-schema/features-unknown-key.out

--=20
2.20.1


