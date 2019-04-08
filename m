Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBF9C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 14:38:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FB8220818
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 14:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB8220818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54024 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDVPL-000851-A8
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 10:37:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDVNo-0007E0-Lz
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDVNn-0000LL-JJ
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:36:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hDVNk-0000Id-UA; Mon, 08 Apr 2019 10:36:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 242574628A;
	Mon,  8 Apr 2019 14:36:20 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-165.ams2.redhat.com
	[10.36.117.165])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B5E8E17DCE;
	Mon,  8 Apr 2019 14:36:18 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  8 Apr 2019 16:35:39 +0200
Message-Id: <20190408143543.3982-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Mon, 08 Apr 2019 14:36:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/4] file-posix: Add dynamic-auto-read-only
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408143539.gffHJfFnDGpGyaPPxm7Akt0QR48wSD0nNXDeovOp1B0@z>

This series adds optional feature lists to struct definitions in the
QAPI schema and makes use of them to advertise the new behaviour of
auto-read-only=3Don in file-posix.

Kevin Wolf (4):
  qapi: Support features for structs
  tests/qapi-schema: Test for good feature lists in structs
  tests/qapi-schema: Error case tests for features in structs
  file-posix: Add dynamic-auto-read-only QAPI feature

 qapi/block-core.json                          | 11 ++++-
 qapi/introspect.json                          |  8 ++-
 tests/qapi-schema/features-bad-type.json      |  3 ++
 tests/qapi-schema/features-missing-name.json  |  3 ++
 tests/qapi-schema/features-name-bad-type.json |  3 ++
 tests/qapi-schema/features-no-list.json       |  3 ++
 tests/qapi-schema/features-unknown-key.json   |  3 ++
 tests/qapi-schema/qapi-schema-test.json       | 27 ++++++++++
 docs/devel/qapi-code-gen.txt                  | 38 ++++++++++++++
 scripts/qapi/common.py                        | 49 +++++++++++++++----
 scripts/qapi/doc.py                           |  3 +-
 scripts/qapi/introspect.py                    |  6 ++-
 scripts/qapi/types.py                         |  3 +-
 scripts/qapi/visit.py                         |  3 +-
 tests/Makefile.include                        |  5 ++
 tests/qapi-schema/double-type.err             |  2 +-
 tests/qapi-schema/features-bad-type.err       |  1 +
 tests/qapi-schema/features-bad-type.exit      |  1 +
 tests/qapi-schema/features-bad-type.out       |  0
 tests/qapi-schema/features-missing-name.err   |  1 +
 tests/qapi-schema/features-missing-name.exit  |  1 +
 tests/qapi-schema/features-missing-name.out   |  0
 tests/qapi-schema/features-name-bad-type.err  |  1 +
 tests/qapi-schema/features-name-bad-type.exit |  1 +
 tests/qapi-schema/features-name-bad-type.out  |  0
 tests/qapi-schema/features-no-list.err        |  1 +
 tests/qapi-schema/features-no-list.exit       |  1 +
 tests/qapi-schema/features-no-list.out        |  0
 tests/qapi-schema/features-unknown-key.err    |  2 +
 tests/qapi-schema/features-unknown-key.exit   |  1 +
 tests/qapi-schema/features-unknown-key.out    |  0
 tests/qapi-schema/qapi-schema-test.out        | 26 ++++++++++
 tests/qapi-schema/test-qapi.py                |  7 ++-
 tests/qapi-schema/unknown-expr-key.err        |  2 +-
 34 files changed, 197 insertions(+), 19 deletions(-)
 create mode 100644 tests/qapi-schema/features-bad-type.json
 create mode 100644 tests/qapi-schema/features-missing-name.json
 create mode 100644 tests/qapi-schema/features-name-bad-type.json
 create mode 100644 tests/qapi-schema/features-no-list.json
 create mode 100644 tests/qapi-schema/features-unknown-key.json
 create mode 100644 tests/qapi-schema/features-bad-type.err
 create mode 100644 tests/qapi-schema/features-bad-type.exit
 create mode 100644 tests/qapi-schema/features-bad-type.out
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


