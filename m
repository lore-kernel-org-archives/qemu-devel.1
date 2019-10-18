Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37467CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 08:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAD7A222C3
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 08:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD7A222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLNDu-0004C3-Gx
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 04:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iLMvb-0000jO-Bz
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:44:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iLMvQ-0007gc-6Y
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:44:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36752)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iLMvP-0007fb-I9
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:43:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BA41C76521;
 Fri, 18 Oct 2019 07:43:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 184A160925;
 Fri, 18 Oct 2019 07:43:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8F93F1132A05; Fri, 18 Oct 2019 09:43:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/7] qapi: Speed up frontend tests
Date: Fri, 18 Oct 2019 09:43:42 +0200
Message-Id: <20191018074345.24034-5-armbru@redhat.com>
In-Reply-To: <20191018074345.24034-1-armbru@redhat.com>
References: <20191018074345.24034-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 18 Oct 2019 07:43:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"make check-qapi-schema" takes around 10s user + system time for me.
With -j, it takes a bit over 3s real time.  We have worse tests.  It's
still annoying when you work on the QAPI generator.

Some 1.4s user + system time is consumed by make figuring out what to
do, measured by making a target that does nothing.  There's nothing I
can do about that right now.  But let's see what we can do about the
other 8s.

Almost 7s are spent running test-qapi.py for every test case, the rest
normalizing and diffing test-qapi.py output.  We have 190 test cases.

If I downgrade to python2, it's 4.5s, but python2 is a goner.

Hacking up test-qapi.py to exit(0) without doing anything makes it
only marginally faster.  The problem is Python startup overhead.

Our configure puts -B into $(PYTHON).  Running without -B is faster:
4.4s.

We could improve the Makefile to run test cases only when the test
case or the generator changed.  But I'm after improvement in the case
where the generator changed.

test-qapi.py is designed to be the simplest possible building block
for a shell script to do the complete job (it's actually a Makefile,
not a shell script; no real difference).  Python is just not meant for
that.  It's for bigger blocks.

Move the post-processing and diffing into test-qapi.py, and make it
capable of testing multiple schema files.  Set executable bits while
there.

Running it once per test case now takes slightly longer than 8s.  But
running it once for all of them takes under 0.2s.

Messing with the Makefile to run it only on the tests that need
retesting is clearly not worth the bother.

Expected error output changes because the new normalization strips off
$(SRCDIR)/tests/qapi-schema/ instead of just $(SRCDIR)/.

The .exit files go away, because there is no exit status to test
anymore.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/Makefile.include                        |  16 +--
 tests/qapi-schema/allow-preconfig-test.err    |   4 +-
 tests/qapi-schema/allow-preconfig-test.exit   |   1 -
 tests/qapi-schema/alternate-any.err           |   4 +-
 tests/qapi-schema/alternate-any.exit          |   1 -
 tests/qapi-schema/alternate-array.err         |   4 +-
 tests/qapi-schema/alternate-array.exit        |   1 -
 tests/qapi-schema/alternate-base.err          |   4 +-
 tests/qapi-schema/alternate-base.exit         |   1 -
 .../alternate-branch-if-invalid.err           |   4 +-
 .../alternate-branch-if-invalid.exit          |   1 -
 tests/qapi-schema/alternate-clash.err         |   4 +-
 tests/qapi-schema/alternate-clash.exit        |   1 -
 .../alternate-conflict-bool-string.err        |   4 +-
 .../alternate-conflict-bool-string.exit       |   1 -
 tests/qapi-schema/alternate-conflict-dict.err |   4 +-
 .../qapi-schema/alternate-conflict-dict.exit  |   1 -
 .../alternate-conflict-enum-bool.err          |   4 +-
 .../alternate-conflict-enum-bool.exit         |   1 -
 .../alternate-conflict-enum-int.err           |   4 +-
 .../alternate-conflict-enum-int.exit          |   1 -
 .../alternate-conflict-num-string.err         |   4 +-
 .../alternate-conflict-num-string.exit        |   1 -
 .../qapi-schema/alternate-conflict-string.err |   4 +-
 .../alternate-conflict-string.exit            |   1 -
 tests/qapi-schema/alternate-empty.err         |   4 +-
 tests/qapi-schema/alternate-empty.exit        |   1 -
 tests/qapi-schema/alternate-invalid-dict.err  |   4 +-
 tests/qapi-schema/alternate-invalid-dict.exit |   1 -
 tests/qapi-schema/alternate-nested.err        |   4 +-
 tests/qapi-schema/alternate-nested.exit       |   1 -
 tests/qapi-schema/alternate-unknown.err       |   4 +-
 tests/qapi-schema/alternate-unknown.exit      |   1 -
 tests/qapi-schema/args-alternate.err          |   4 +-
 tests/qapi-schema/args-alternate.exit         |   1 -
 tests/qapi-schema/args-any.err                |   4 +-
 tests/qapi-schema/args-any.exit               |   1 -
 tests/qapi-schema/args-array-empty.err        |   4 +-
 tests/qapi-schema/args-array-empty.exit       |   1 -
 tests/qapi-schema/args-array-unknown.err      |   4 +-
 tests/qapi-schema/args-array-unknown.exit     |   1 -
 tests/qapi-schema/args-bad-boxed.err          |   4 +-
 tests/qapi-schema/args-bad-boxed.exit         |   1 -
 tests/qapi-schema/args-boxed-anon.err         |   4 +-
 tests/qapi-schema/args-boxed-anon.exit        |   1 -
 tests/qapi-schema/args-boxed-string.err       |   4 +-
 tests/qapi-schema/args-boxed-string.exit      |   1 -
 tests/qapi-schema/args-int.err                |   4 +-
 tests/qapi-schema/args-int.exit               |   1 -
 tests/qapi-schema/args-invalid.err            |   4 +-
 tests/qapi-schema/args-invalid.exit           |   1 -
 tests/qapi-schema/args-member-array-bad.err   |   4 +-
 tests/qapi-schema/args-member-array-bad.exit  |   1 -
 tests/qapi-schema/args-member-case.err        |   4 +-
 tests/qapi-schema/args-member-case.exit       |   1 -
 tests/qapi-schema/args-member-unknown.err     |   4 +-
 tests/qapi-schema/args-member-unknown.exit    |   1 -
 tests/qapi-schema/args-name-clash.err         |   4 +-
 tests/qapi-schema/args-name-clash.exit        |   1 -
 tests/qapi-schema/args-union.err              |   4 +-
 tests/qapi-schema/args-union.exit             |   1 -
 tests/qapi-schema/args-unknown.err            |   4 +-
 tests/qapi-schema/args-unknown.exit           |   1 -
 tests/qapi-schema/bad-base.err                |   4 +-
 tests/qapi-schema/bad-base.exit               |   1 -
 tests/qapi-schema/bad-data.err                |   4 +-
 tests/qapi-schema/bad-data.exit               |   1 -
 tests/qapi-schema/bad-ident.err               |   4 +-
 tests/qapi-schema/bad-ident.exit              |   1 -
 tests/qapi-schema/bad-if-empty-list.err       |   4 +-
 tests/qapi-schema/bad-if-empty-list.exit      |   1 -
 tests/qapi-schema/bad-if-empty.err            |   4 +-
 tests/qapi-schema/bad-if-empty.exit           |   1 -
 tests/qapi-schema/bad-if-list.err             |   4 +-
 tests/qapi-schema/bad-if-list.exit            |   1 -
 tests/qapi-schema/bad-if.err                  |   4 +-
 tests/qapi-schema/bad-if.exit                 |   1 -
 tests/qapi-schema/bad-type-bool.err           |   2 +-
 tests/qapi-schema/bad-type-bool.exit          |   1 -
 tests/qapi-schema/bad-type-dict.err           |   2 +-
 tests/qapi-schema/bad-type-dict.exit          |   1 -
 tests/qapi-schema/bad-type-int.err            |   2 +-
 tests/qapi-schema/bad-type-int.exit           |   1 -
 tests/qapi-schema/base-cycle-direct.err       |   4 +-
 tests/qapi-schema/base-cycle-direct.exit      |   1 -
 tests/qapi-schema/base-cycle-indirect.err     |   4 +-
 tests/qapi-schema/base-cycle-indirect.exit    |   1 -
 tests/qapi-schema/command-int.err             |   4 +-
 tests/qapi-schema/command-int.exit            |   1 -
 tests/qapi-schema/comments.exit               |   1 -
 .../qapi-schema/doc-bad-alternate-member.err  |   2 +-
 .../qapi-schema/doc-bad-alternate-member.exit |   1 -
 tests/qapi-schema/doc-bad-command-arg.err     |   2 +-
 tests/qapi-schema/doc-bad-command-arg.exit    |   1 -
 tests/qapi-schema/doc-bad-section.exit        |   1 -
 tests/qapi-schema/doc-bad-symbol.err          |   4 +-
 tests/qapi-schema/doc-bad-symbol.exit         |   1 -
 tests/qapi-schema/doc-bad-union-member.err    |   2 +-
 tests/qapi-schema/doc-bad-union-member.exit   |   1 -
 tests/qapi-schema/doc-before-include.err      |   2 +-
 tests/qapi-schema/doc-before-include.exit     |   1 -
 tests/qapi-schema/doc-before-pragma.err       |   2 +-
 tests/qapi-schema/doc-before-pragma.exit      |   1 -
 tests/qapi-schema/doc-duplicated-arg.err      |   2 +-
 tests/qapi-schema/doc-duplicated-arg.exit     |   1 -
 tests/qapi-schema/doc-duplicated-return.err   |   2 +-
 tests/qapi-schema/doc-duplicated-return.exit  |   1 -
 tests/qapi-schema/doc-duplicated-since.err    |   2 +-
 tests/qapi-schema/doc-duplicated-since.exit   |   1 -
 tests/qapi-schema/doc-empty-arg.err           |   2 +-
 tests/qapi-schema/doc-empty-arg.exit          |   1 -
 tests/qapi-schema/doc-empty-section.err       |   2 +-
 tests/qapi-schema/doc-empty-section.exit      |   1 -
 tests/qapi-schema/doc-empty-symbol.err        |   2 +-
 tests/qapi-schema/doc-empty-symbol.exit       |   1 -
 tests/qapi-schema/doc-good.exit               |   1 -
 tests/qapi-schema/doc-interleaved-section.err |   2 +-
 .../qapi-schema/doc-interleaved-section.exit  |   1 -
 tests/qapi-schema/doc-invalid-end.err         |   2 +-
 tests/qapi-schema/doc-invalid-end.exit        |   1 -
 tests/qapi-schema/doc-invalid-end2.err        |   2 +-
 tests/qapi-schema/doc-invalid-end2.exit       |   1 -
 tests/qapi-schema/doc-invalid-return.err      |   2 +-
 tests/qapi-schema/doc-invalid-return.exit     |   1 -
 tests/qapi-schema/doc-invalid-section.err     |   2 +-
 tests/qapi-schema/doc-invalid-section.exit    |   1 -
 tests/qapi-schema/doc-invalid-start.err       |   2 +-
 tests/qapi-schema/doc-invalid-start.exit      |   1 -
 tests/qapi-schema/doc-missing-colon.err       |   2 +-
 tests/qapi-schema/doc-missing-colon.exit      |   1 -
 tests/qapi-schema/doc-missing-expr.err        |   2 +-
 tests/qapi-schema/doc-missing-expr.exit       |   1 -
 tests/qapi-schema/doc-missing-space.err       |   2 +-
 tests/qapi-schema/doc-missing-space.exit      |   1 -
 tests/qapi-schema/doc-missing.err             |   4 +-
 tests/qapi-schema/doc-missing.exit            |   1 -
 tests/qapi-schema/doc-no-symbol.err           |   2 +-
 tests/qapi-schema/doc-no-symbol.exit          |   1 -
 tests/qapi-schema/double-type.err             |   4 +-
 tests/qapi-schema/double-type.exit            |   1 -
 tests/qapi-schema/duplicate-key.err           |   2 +-
 tests/qapi-schema/duplicate-key.exit          |   1 -
 tests/qapi-schema/empty.exit                  |   1 -
 tests/qapi-schema/enum-bad-member.err         |   4 +-
 tests/qapi-schema/enum-bad-member.exit        |   1 -
 tests/qapi-schema/enum-bad-name.err           |   4 +-
 tests/qapi-schema/enum-bad-name.exit          |   1 -
 tests/qapi-schema/enum-bad-prefix.err         |   4 +-
 tests/qapi-schema/enum-bad-prefix.exit        |   1 -
 tests/qapi-schema/enum-clash-member.err       |   4 +-
 tests/qapi-schema/enum-clash-member.exit      |   1 -
 .../qapi-schema/enum-dict-member-unknown.err  |   4 +-
 .../qapi-schema/enum-dict-member-unknown.exit |   1 -
 tests/qapi-schema/enum-if-invalid.err         |   4 +-
 tests/qapi-schema/enum-if-invalid.exit        |   1 -
 tests/qapi-schema/enum-int-member.err         |   2 +-
 tests/qapi-schema/enum-int-member.exit        |   1 -
 tests/qapi-schema/enum-member-case.err        |   4 +-
 tests/qapi-schema/enum-member-case.exit       |   1 -
 tests/qapi-schema/enum-missing-data.err       |   4 +-
 tests/qapi-schema/enum-missing-data.exit      |   1 -
 tests/qapi-schema/enum-wrong-data.err         |   4 +-
 tests/qapi-schema/enum-wrong-data.exit        |   1 -
 tests/qapi-schema/escape-outside-string.err   |   2 +-
 tests/qapi-schema/event-boxed-empty.err       |   4 +-
 tests/qapi-schema/event-boxed-empty.exit      |   1 -
 tests/qapi-schema/event-case.exit             |   1 -
 .../qapi-schema/event-member-invalid-dict.err |   4 +-
 .../event-member-invalid-dict.exit            |   1 -
 tests/qapi-schema/event-nest-struct.err       |   4 +-
 tests/qapi-schema/event-nest-struct.exit      |   1 -
 tests/qapi-schema/features-bad-type.err       |   4 +-
 tests/qapi-schema/features-bad-type.exit      |   1 -
 tests/qapi-schema/features-duplicate-name.err |   4 +-
 .../qapi-schema/features-duplicate-name.exit  |   1 -
 tests/qapi-schema/features-if-invalid.err     |   4 +-
 tests/qapi-schema/features-if-invalid.exit    |   1 -
 tests/qapi-schema/features-missing-name.err   |   4 +-
 tests/qapi-schema/features-missing-name.exit  |   1 -
 tests/qapi-schema/features-name-bad-type.err  |   4 +-
 tests/qapi-schema/features-name-bad-type.exit |   1 -
 tests/qapi-schema/features-no-list.err        |   4 +-
 tests/qapi-schema/features-no-list.exit       |   1 -
 tests/qapi-schema/features-unknown-key.err    |   4 +-
 tests/qapi-schema/features-unknown-key.exit   |   1 -
 tests/qapi-schema/flat-union-array-branch.err |   4 +-
 .../qapi-schema/flat-union-array-branch.exit  |   1 -
 tests/qapi-schema/flat-union-bad-base.err     |   4 +-
 tests/qapi-schema/flat-union-bad-base.exit    |   1 -
 .../flat-union-bad-discriminator.err          |   4 +-
 .../flat-union-bad-discriminator.exit         |   1 -
 tests/qapi-schema/flat-union-base-any.err     |   4 +-
 tests/qapi-schema/flat-union-base-any.exit    |   1 -
 tests/qapi-schema/flat-union-base-union.err   |   4 +-
 tests/qapi-schema/flat-union-base-union.exit  |   1 -
 tests/qapi-schema/flat-union-clash-member.err |   4 +-
 .../qapi-schema/flat-union-clash-member.exit  |   1 -
 .../flat-union-discriminator-bad-name.err     |   4 +-
 .../flat-union-discriminator-bad-name.exit    |   1 -
 tests/qapi-schema/flat-union-empty.err        |   4 +-
 tests/qapi-schema/flat-union-empty.exit       |   1 -
 .../flat-union-inline-invalid-dict.err        |   4 +-
 .../flat-union-inline-invalid-dict.exit       |   1 -
 tests/qapi-schema/flat-union-inline.err       |   4 +-
 tests/qapi-schema/flat-union-inline.exit      |   1 -
 tests/qapi-schema/flat-union-int-branch.err   |   4 +-
 tests/qapi-schema/flat-union-int-branch.exit  |   1 -
 .../flat-union-invalid-branch-key.err         |   4 +-
 .../flat-union-invalid-branch-key.exit        |   1 -
 .../flat-union-invalid-discriminator.err      |   4 +-
 .../flat-union-invalid-discriminator.exit     |   1 -
 .../flat-union-invalid-if-discriminator.err   |   4 +-
 .../flat-union-invalid-if-discriminator.exit  |   1 -
 tests/qapi-schema/flat-union-no-base.err      |   4 +-
 tests/qapi-schema/flat-union-no-base.exit     |   1 -
 .../flat-union-optional-discriminator.err     |   4 +-
 .../flat-union-optional-discriminator.exit    |   1 -
 .../flat-union-string-discriminator.err       |   4 +-
 .../flat-union-string-discriminator.exit      |   1 -
 tests/qapi-schema/funny-char.err              |   2 +-
 tests/qapi-schema/funny-char.exit             |   1 -
 tests/qapi-schema/funny-word.err              |   2 +-
 tests/qapi-schema/funny-word.exit             |   1 -
 tests/qapi-schema/ident-with-escape.err       |   2 +-
 tests/qapi-schema/ident-with-escape.exit      |   1 -
 tests/qapi-schema/include-before-err.err      |   2 +-
 tests/qapi-schema/include-before-err.exit     |   1 -
 tests/qapi-schema/include-cycle.err           |   6 +-
 tests/qapi-schema/include-cycle.exit          |   1 -
 tests/qapi-schema/include-extra-junk.err      |   2 +-
 tests/qapi-schema/include-extra-junk.exit     |   1 -
 tests/qapi-schema/include-nested-err.err      |   4 +-
 tests/qapi-schema/include-nested-err.exit     |   1 -
 tests/qapi-schema/include-no-file.err         |   2 +-
 tests/qapi-schema/include-no-file.exit        |   1 -
 tests/qapi-schema/include-non-file.err        |   2 +-
 tests/qapi-schema/include-non-file.exit       |   1 -
 tests/qapi-schema/include-repetition.exit     |   1 -
 tests/qapi-schema/include-self-cycle.err      |   2 +-
 tests/qapi-schema/include-self-cycle.exit     |   1 -
 tests/qapi-schema/include-simple.exit         |   1 -
 tests/qapi-schema/indented-expr.exit          |   1 -
 tests/qapi-schema/leading-comma-list.err      |   2 +-
 tests/qapi-schema/leading-comma-list.exit     |   1 -
 tests/qapi-schema/leading-comma-object.err    |   2 +-
 tests/qapi-schema/leading-comma-object.exit   |   1 -
 tests/qapi-schema/missing-colon.err           |   2 +-
 tests/qapi-schema/missing-colon.exit          |   1 -
 tests/qapi-schema/missing-comma-list.err      |   2 +-
 tests/qapi-schema/missing-comma-list.exit     |   1 -
 tests/qapi-schema/missing-comma-object.err    |   2 +-
 tests/qapi-schema/missing-comma-object.exit   |   1 -
 tests/qapi-schema/missing-type.err            |   2 +-
 tests/qapi-schema/missing-type.exit           |   1 -
 .../nested-struct-data-invalid-dict.err       |   4 +-
 .../nested-struct-data-invalid-dict.exit      |   1 -
 tests/qapi-schema/nested-struct-data.err      |   4 +-
 tests/qapi-schema/nested-struct-data.exit     |   1 -
 tests/qapi-schema/non-objects.err             |   2 +-
 tests/qapi-schema/non-objects.exit            |   1 -
 tests/qapi-schema/oob-test.err                |   4 +-
 tests/qapi-schema/oob-test.exit               |   1 -
 .../qapi-schema/pragma-doc-required-crap.err  |   2 +-
 .../qapi-schema/pragma-doc-required-crap.exit |   1 -
 tests/qapi-schema/pragma-extra-junk.err       |   2 +-
 tests/qapi-schema/pragma-extra-junk.exit      |   1 -
 .../pragma-name-case-whitelist-crap.err       |   2 +-
 .../pragma-name-case-whitelist-crap.exit      |   1 -
 tests/qapi-schema/pragma-non-dict.err         |   2 +-
 tests/qapi-schema/pragma-non-dict.exit        |   1 -
 .../pragma-returns-whitelist-crap.err         |   2 +-
 .../pragma-returns-whitelist-crap.exit        |   1 -
 tests/qapi-schema/pragma-unknown.err          |   2 +-
 tests/qapi-schema/pragma-unknown.exit         |   1 -
 tests/qapi-schema/qapi-schema-test.exit       |   1 -
 tests/qapi-schema/quoted-structural-chars.err |   2 +-
 .../qapi-schema/quoted-structural-chars.exit  |   1 -
 tests/qapi-schema/redefined-builtin.err       |   4 +-
 tests/qapi-schema/redefined-builtin.exit      |   1 -
 tests/qapi-schema/redefined-command.err       |   8 +-
 tests/qapi-schema/redefined-command.exit      |   1 -
 tests/qapi-schema/redefined-event.err         |   8 +-
 tests/qapi-schema/redefined-event.exit        |   1 -
 tests/qapi-schema/redefined-type.err          |   8 +-
 tests/qapi-schema/redefined-type.exit         |   1 -
 tests/qapi-schema/reserved-command-q.err      |   4 +-
 tests/qapi-schema/reserved-command-q.exit     |   1 -
 tests/qapi-schema/reserved-enum-q.err         |   4 +-
 tests/qapi-schema/reserved-enum-q.exit        |   1 -
 tests/qapi-schema/reserved-member-has.err     |   4 +-
 tests/qapi-schema/reserved-member-has.exit    |   1 -
 tests/qapi-schema/reserved-member-q.err       |   4 +-
 tests/qapi-schema/reserved-member-q.exit      |   1 -
 tests/qapi-schema/reserved-member-u.err       |   4 +-
 tests/qapi-schema/reserved-member-u.exit      |   1 -
 .../reserved-member-underscore.err            |   4 +-
 .../reserved-member-underscore.exit           |   1 -
 tests/qapi-schema/reserved-type-kind.err      |   4 +-
 tests/qapi-schema/reserved-type-kind.exit     |   1 -
 tests/qapi-schema/reserved-type-list.err      |   4 +-
 tests/qapi-schema/reserved-type-list.exit     |   1 -
 tests/qapi-schema/returns-alternate.err       |   4 +-
 tests/qapi-schema/returns-alternate.exit      |   1 -
 tests/qapi-schema/returns-array-bad.err       |   4 +-
 tests/qapi-schema/returns-array-bad.exit      |   1 -
 tests/qapi-schema/returns-dict.err            |   4 +-
 tests/qapi-schema/returns-dict.exit           |   1 -
 tests/qapi-schema/returns-unknown.err         |   4 +-
 tests/qapi-schema/returns-unknown.exit        |   1 -
 tests/qapi-schema/returns-whitelist.err       |   4 +-
 tests/qapi-schema/returns-whitelist.exit      |   1 -
 tests/qapi-schema/string-code-point-127.err   |   2 +-
 tests/qapi-schema/string-code-point-127.exit  |   1 -
 tests/qapi-schema/string-code-point-31.err    |   2 +-
 tests/qapi-schema/string-code-point-31.exit   |   1 -
 tests/qapi-schema/struct-base-clash-deep.err  |   4 +-
 tests/qapi-schema/struct-base-clash-deep.exit |   1 -
 tests/qapi-schema/struct-base-clash.err       |   4 +-
 tests/qapi-schema/struct-base-clash.exit      |   1 -
 tests/qapi-schema/struct-data-invalid.err     |   4 +-
 tests/qapi-schema/struct-data-invalid.exit    |   1 -
 .../qapi-schema/struct-member-if-invalid.err  |   4 +-
 .../qapi-schema/struct-member-if-invalid.exit |   1 -
 .../struct-member-invalid-dict.err            |   4 +-
 .../struct-member-invalid-dict.exit           |   1 -
 tests/qapi-schema/struct-member-invalid.err   |   4 +-
 tests/qapi-schema/struct-member-invalid.exit  |   1 -
 tests/qapi-schema/test-qapi.py                | 119 +++++++++++++++---
 tests/qapi-schema/trailing-comma-list.err     |   2 +-
 tests/qapi-schema/trailing-comma-list.exit    |   1 -
 tests/qapi-schema/trailing-comma-object.err   |   2 +-
 tests/qapi-schema/trailing-comma-object.exit  |   1 -
 tests/qapi-schema/type-bypass-bad-gen.err     |   4 +-
 tests/qapi-schema/type-bypass-bad-gen.exit    |   1 -
 tests/qapi-schema/unclosed-list.err           |   2 +-
 tests/qapi-schema/unclosed-list.exit          |   1 -
 tests/qapi-schema/unclosed-object.err         |   2 +-
 tests/qapi-schema/unclosed-object.exit        |   1 -
 tests/qapi-schema/unclosed-string.err         |   2 +-
 tests/qapi-schema/unclosed-string.exit        |   1 -
 tests/qapi-schema/union-base-empty.err        |   4 +-
 tests/qapi-schema/union-base-empty.exit       |   1 -
 .../union-base-no-discriminator.err           |   4 +-
 .../union-base-no-discriminator.exit          |   1 -
 tests/qapi-schema/union-branch-case.err       |   4 +-
 tests/qapi-schema/union-branch-case.exit      |   1 -
 tests/qapi-schema/union-branch-if-invalid.err |   4 +-
 .../qapi-schema/union-branch-if-invalid.exit  |   1 -
 .../qapi-schema/union-branch-invalid-dict.err |   4 +-
 .../union-branch-invalid-dict.exit            |   1 -
 tests/qapi-schema/union-clash-branches.err    |   4 +-
 tests/qapi-schema/union-clash-branches.exit   |   1 -
 tests/qapi-schema/union-empty.err             |   4 +-
 tests/qapi-schema/union-empty.exit            |   1 -
 tests/qapi-schema/union-invalid-base.err      |   4 +-
 tests/qapi-schema/union-invalid-base.exit     |   1 -
 tests/qapi-schema/union-optional-branch.err   |   4 +-
 tests/qapi-schema/union-optional-branch.exit  |   1 -
 tests/qapi-schema/union-unknown.err           |   4 +-
 tests/qapi-schema/union-unknown.exit          |   1 -
 tests/qapi-schema/unknown-escape.err          |   2 +-
 tests/qapi-schema/unknown-escape.exit         |   1 -
 tests/qapi-schema/unknown-expr-key.err        |   4 +-
 tests/qapi-schema/unknown-expr-key.exit       |   1 -
 364 files changed, 413 insertions(+), 515 deletions(-)
 delete mode 100644 tests/qapi-schema/allow-preconfig-test.exit
 delete mode 100644 tests/qapi-schema/alternate-any.exit
 delete mode 100644 tests/qapi-schema/alternate-array.exit
 delete mode 100644 tests/qapi-schema/alternate-base.exit
 delete mode 100644 tests/qapi-schema/alternate-branch-if-invalid.exit
 delete mode 100644 tests/qapi-schema/alternate-clash.exit
 delete mode 100644 tests/qapi-schema/alternate-conflict-bool-string.exit
 delete mode 100644 tests/qapi-schema/alternate-conflict-dict.exit
 delete mode 100644 tests/qapi-schema/alternate-conflict-enum-bool.exit
 delete mode 100644 tests/qapi-schema/alternate-conflict-enum-int.exit
 delete mode 100644 tests/qapi-schema/alternate-conflict-num-string.exit
 delete mode 100644 tests/qapi-schema/alternate-conflict-string.exit
 delete mode 100644 tests/qapi-schema/alternate-empty.exit
 delete mode 100644 tests/qapi-schema/alternate-invalid-dict.exit
 delete mode 100644 tests/qapi-schema/alternate-nested.exit
 delete mode 100644 tests/qapi-schema/alternate-unknown.exit
 delete mode 100644 tests/qapi-schema/args-alternate.exit
 delete mode 100644 tests/qapi-schema/args-any.exit
 delete mode 100644 tests/qapi-schema/args-array-empty.exit
 delete mode 100644 tests/qapi-schema/args-array-unknown.exit
 delete mode 100644 tests/qapi-schema/args-bad-boxed.exit
 delete mode 100644 tests/qapi-schema/args-boxed-anon.exit
 delete mode 100644 tests/qapi-schema/args-boxed-string.exit
 delete mode 100644 tests/qapi-schema/args-int.exit
 delete mode 100644 tests/qapi-schema/args-invalid.exit
 delete mode 100644 tests/qapi-schema/args-member-array-bad.exit
 delete mode 100644 tests/qapi-schema/args-member-case.exit
 delete mode 100644 tests/qapi-schema/args-member-unknown.exit
 delete mode 100644 tests/qapi-schema/args-name-clash.exit
 delete mode 100644 tests/qapi-schema/args-union.exit
 delete mode 100644 tests/qapi-schema/args-unknown.exit
 delete mode 100644 tests/qapi-schema/bad-base.exit
 delete mode 100644 tests/qapi-schema/bad-data.exit
 delete mode 100644 tests/qapi-schema/bad-ident.exit
 delete mode 100644 tests/qapi-schema/bad-if-empty-list.exit
 delete mode 100644 tests/qapi-schema/bad-if-empty.exit
 delete mode 100644 tests/qapi-schema/bad-if-list.exit
 delete mode 100644 tests/qapi-schema/bad-if.exit
 delete mode 100644 tests/qapi-schema/bad-type-bool.exit
 delete mode 100644 tests/qapi-schema/bad-type-dict.exit
 delete mode 100644 tests/qapi-schema/bad-type-int.exit
 delete mode 100644 tests/qapi-schema/base-cycle-direct.exit
 delete mode 100644 tests/qapi-schema/base-cycle-indirect.exit
 delete mode 100644 tests/qapi-schema/command-int.exit
 delete mode 100644 tests/qapi-schema/comments.exit
 delete mode 100644 tests/qapi-schema/doc-bad-alternate-member.exit
 delete mode 100644 tests/qapi-schema/doc-bad-command-arg.exit
 delete mode 100644 tests/qapi-schema/doc-bad-section.exit
 delete mode 100644 tests/qapi-schema/doc-bad-symbol.exit
 delete mode 100644 tests/qapi-schema/doc-bad-union-member.exit
 delete mode 100644 tests/qapi-schema/doc-before-include.exit
 delete mode 100644 tests/qapi-schema/doc-before-pragma.exit
 delete mode 100644 tests/qapi-schema/doc-duplicated-arg.exit
 delete mode 100644 tests/qapi-schema/doc-duplicated-return.exit
 delete mode 100644 tests/qapi-schema/doc-duplicated-since.exit
 delete mode 100644 tests/qapi-schema/doc-empty-arg.exit
 delete mode 100644 tests/qapi-schema/doc-empty-section.exit
 delete mode 100644 tests/qapi-schema/doc-empty-symbol.exit
 delete mode 100644 tests/qapi-schema/doc-good.exit
 delete mode 100644 tests/qapi-schema/doc-interleaved-section.exit
 delete mode 100644 tests/qapi-schema/doc-invalid-end.exit
 delete mode 100644 tests/qapi-schema/doc-invalid-end2.exit
 delete mode 100644 tests/qapi-schema/doc-invalid-return.exit
 delete mode 100644 tests/qapi-schema/doc-invalid-section.exit
 delete mode 100644 tests/qapi-schema/doc-invalid-start.exit
 delete mode 100644 tests/qapi-schema/doc-missing-colon.exit
 delete mode 100644 tests/qapi-schema/doc-missing-expr.exit
 delete mode 100644 tests/qapi-schema/doc-missing-space.exit
 delete mode 100644 tests/qapi-schema/doc-missing.exit
 delete mode 100644 tests/qapi-schema/doc-no-symbol.exit
 delete mode 100644 tests/qapi-schema/double-type.exit
 delete mode 100644 tests/qapi-schema/duplicate-key.exit
 delete mode 100644 tests/qapi-schema/empty.exit
 delete mode 100644 tests/qapi-schema/enum-bad-member.exit
 delete mode 100644 tests/qapi-schema/enum-bad-name.exit
 delete mode 100644 tests/qapi-schema/enum-bad-prefix.exit
 delete mode 100644 tests/qapi-schema/enum-clash-member.exit
 delete mode 100644 tests/qapi-schema/enum-dict-member-unknown.exit
 delete mode 100644 tests/qapi-schema/enum-if-invalid.exit
 delete mode 100644 tests/qapi-schema/enum-int-member.exit
 delete mode 100644 tests/qapi-schema/enum-member-case.exit
 delete mode 100644 tests/qapi-schema/enum-missing-data.exit
 delete mode 100644 tests/qapi-schema/enum-wrong-data.exit
 delete mode 100644 tests/qapi-schema/event-boxed-empty.exit
 delete mode 100644 tests/qapi-schema/event-case.exit
 delete mode 100644 tests/qapi-schema/event-member-invalid-dict.exit
 delete mode 100644 tests/qapi-schema/event-nest-struct.exit
 delete mode 100644 tests/qapi-schema/features-bad-type.exit
 delete mode 100644 tests/qapi-schema/features-duplicate-name.exit
 delete mode 100644 tests/qapi-schema/features-if-invalid.exit
 delete mode 100644 tests/qapi-schema/features-missing-name.exit
 delete mode 100644 tests/qapi-schema/features-name-bad-type.exit
 delete mode 100644 tests/qapi-schema/features-no-list.exit
 delete mode 100644 tests/qapi-schema/features-unknown-key.exit
 delete mode 100644 tests/qapi-schema/flat-union-array-branch.exit
 delete mode 100644 tests/qapi-schema/flat-union-bad-base.exit
 delete mode 100644 tests/qapi-schema/flat-union-bad-discriminator.exit
 delete mode 100644 tests/qapi-schema/flat-union-base-any.exit
 delete mode 100644 tests/qapi-schema/flat-union-base-union.exit
 delete mode 100644 tests/qapi-schema/flat-union-clash-member.exit
 delete mode 100644 tests/qapi-schema/flat-union-discriminator-bad-name.e=
xit
 delete mode 100644 tests/qapi-schema/flat-union-empty.exit
 delete mode 100644 tests/qapi-schema/flat-union-inline-invalid-dict.exit
 delete mode 100644 tests/qapi-schema/flat-union-inline.exit
 delete mode 100644 tests/qapi-schema/flat-union-int-branch.exit
 delete mode 100644 tests/qapi-schema/flat-union-invalid-branch-key.exit
 delete mode 100644 tests/qapi-schema/flat-union-invalid-discriminator.ex=
it
 delete mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.exit
 delete mode 100644 tests/qapi-schema/flat-union-no-base.exit
 delete mode 100644 tests/qapi-schema/flat-union-optional-discriminator.e=
xit
 delete mode 100644 tests/qapi-schema/flat-union-string-discriminator.exi=
t
 delete mode 100644 tests/qapi-schema/funny-char.exit
 delete mode 100644 tests/qapi-schema/funny-word.exit
 delete mode 100644 tests/qapi-schema/ident-with-escape.exit
 delete mode 100644 tests/qapi-schema/include-before-err.exit
 delete mode 100644 tests/qapi-schema/include-cycle.exit
 delete mode 100644 tests/qapi-schema/include-extra-junk.exit
 delete mode 100644 tests/qapi-schema/include-nested-err.exit
 delete mode 100644 tests/qapi-schema/include-no-file.exit
 delete mode 100644 tests/qapi-schema/include-non-file.exit
 delete mode 100644 tests/qapi-schema/include-repetition.exit
 delete mode 100644 tests/qapi-schema/include-self-cycle.exit
 delete mode 100644 tests/qapi-schema/include-simple.exit
 delete mode 100644 tests/qapi-schema/indented-expr.exit
 delete mode 100644 tests/qapi-schema/leading-comma-list.exit
 delete mode 100644 tests/qapi-schema/leading-comma-object.exit
 delete mode 100644 tests/qapi-schema/missing-colon.exit
 delete mode 100644 tests/qapi-schema/missing-comma-list.exit
 delete mode 100644 tests/qapi-schema/missing-comma-object.exit
 delete mode 100644 tests/qapi-schema/missing-type.exit
 delete mode 100644 tests/qapi-schema/nested-struct-data-invalid-dict.exi=
t
 delete mode 100644 tests/qapi-schema/nested-struct-data.exit
 delete mode 100644 tests/qapi-schema/non-objects.exit
 delete mode 100644 tests/qapi-schema/oob-test.exit
 delete mode 100644 tests/qapi-schema/pragma-doc-required-crap.exit
 delete mode 100644 tests/qapi-schema/pragma-extra-junk.exit
 delete mode 100644 tests/qapi-schema/pragma-name-case-whitelist-crap.exi=
t
 delete mode 100644 tests/qapi-schema/pragma-non-dict.exit
 delete mode 100644 tests/qapi-schema/pragma-returns-whitelist-crap.exit
 delete mode 100644 tests/qapi-schema/pragma-unknown.exit
 delete mode 100644 tests/qapi-schema/qapi-schema-test.exit
 delete mode 100644 tests/qapi-schema/quoted-structural-chars.exit
 delete mode 100644 tests/qapi-schema/redefined-builtin.exit
 delete mode 100644 tests/qapi-schema/redefined-command.exit
 delete mode 100644 tests/qapi-schema/redefined-event.exit
 delete mode 100644 tests/qapi-schema/redefined-type.exit
 delete mode 100644 tests/qapi-schema/reserved-command-q.exit
 delete mode 100644 tests/qapi-schema/reserved-enum-q.exit
 delete mode 100644 tests/qapi-schema/reserved-member-has.exit
 delete mode 100644 tests/qapi-schema/reserved-member-q.exit
 delete mode 100644 tests/qapi-schema/reserved-member-u.exit
 delete mode 100644 tests/qapi-schema/reserved-member-underscore.exit
 delete mode 100644 tests/qapi-schema/reserved-type-kind.exit
 delete mode 100644 tests/qapi-schema/reserved-type-list.exit
 delete mode 100644 tests/qapi-schema/returns-alternate.exit
 delete mode 100644 tests/qapi-schema/returns-array-bad.exit
 delete mode 100644 tests/qapi-schema/returns-dict.exit
 delete mode 100644 tests/qapi-schema/returns-unknown.exit
 delete mode 100644 tests/qapi-schema/returns-whitelist.exit
 delete mode 100644 tests/qapi-schema/string-code-point-127.exit
 delete mode 100644 tests/qapi-schema/string-code-point-31.exit
 delete mode 100644 tests/qapi-schema/struct-base-clash-deep.exit
 delete mode 100644 tests/qapi-schema/struct-base-clash.exit
 delete mode 100644 tests/qapi-schema/struct-data-invalid.exit
 delete mode 100644 tests/qapi-schema/struct-member-if-invalid.exit
 delete mode 100644 tests/qapi-schema/struct-member-invalid-dict.exit
 delete mode 100644 tests/qapi-schema/struct-member-invalid.exit
 mode change 100644 =3D> 100755 tests/qapi-schema/test-qapi.py
 delete mode 100644 tests/qapi-schema/trailing-comma-list.exit
 delete mode 100644 tests/qapi-schema/trailing-comma-object.exit
 delete mode 100644 tests/qapi-schema/type-bypass-bad-gen.exit
 delete mode 100644 tests/qapi-schema/unclosed-list.exit
 delete mode 100644 tests/qapi-schema/unclosed-object.exit
 delete mode 100644 tests/qapi-schema/unclosed-string.exit
 delete mode 100644 tests/qapi-schema/union-base-empty.exit
 delete mode 100644 tests/qapi-schema/union-base-no-discriminator.exit
 delete mode 100644 tests/qapi-schema/union-branch-case.exit
 delete mode 100644 tests/qapi-schema/union-branch-if-invalid.exit
 delete mode 100644 tests/qapi-schema/union-branch-invalid-dict.exit
 delete mode 100644 tests/qapi-schema/union-clash-branches.exit
 delete mode 100644 tests/qapi-schema/union-empty.exit
 delete mode 100644 tests/qapi-schema/union-invalid-base.exit
 delete mode 100644 tests/qapi-schema/union-optional-branch.exit
 delete mode 100644 tests/qapi-schema/union-unknown.exit
 delete mode 100644 tests/qapi-schema/unknown-escape.exit
 delete mode 100644 tests/qapi-schema/unknown-expr-key.exit

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 214fbd941c..1b24b8ba10 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1102,17 +1102,11 @@ check-tests/check-block.sh: tests/check-block.sh =
qemu-img$(EXESUF) \
 		$(patsubst %,%/all,$(filter %-softmmu,$(TARGET_DIRS)))
 	@$<
=20
-.PHONY: $(patsubst %, check-%, $(check-qapi-schema-y))
-$(patsubst %, check-%, $(check-qapi-schema-y)): check-%.json: $(SRC_PATH=
)/%.json
+.PHONY: check-tests/qapi-schema/frontend
+check-tests/qapi-schema/frontend: $(addprefix $(SRC_PATH)/, $(check-qapi=
-schema-y))
 	$(call quiet-command, PYTHONPATH=3D$(SRC_PATH)/scripts \
-		PYTHONIOENCODING=3Dutf-8 $(PYTHON) $(SRC_PATH)/tests/qapi-schema/test-=
qapi.py \
-		$^ >$*.test.out 2>$*.test.err; \
-		echo $$? >$*.test.exit, \
-		"TEST","$*.out")
-	@# Sanitize error messages (make them independent of build directory)
-	@perl -p -e 's|\Q$(SRC_PATH)\E/||g' $*.test.err | diff -u $(SRC_PATH)/$=
*.err -
-	@diff -u $(SRC_PATH)/$*.out $*.test.out
-	@diff -u $(SRC_PATH)/$*.exit $*.test.exit
+	  PYTHONIOENCODING=3Dutf-8 $(PYTHON) $(SRC_PATH)/tests/qapi-schema/test=
-qapi.py $^, \
+	  TEST, check-qapi-schema)
=20
 .PHONY: check-tests/qapi-schema/doc-good.texi
 check-tests/qapi-schema/doc-good.texi: tests/qapi-schema/doc-good.test.t=
exi
@@ -1170,7 +1164,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
 # Consolidated targets
=20
 .PHONY: check-block check-qapi-schema check-qtest check-unit check check=
-clean
-check-qapi-schema: $(patsubst %,check-%, $(check-qapi-schema-y)) check-t=
ests/qapi-schema/doc-good.texi
+check-qapi-schema: check-tests/qapi-schema/frontend check-tests/qapi-sch=
ema/doc-good.texi
 check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
 check-block: $(patsubst %,check-%, $(check-block-y))
 check: check-block check-qapi-schema check-unit check-softfloat check-qt=
est check-decodetree
diff --git a/tests/qapi-schema/allow-preconfig-test.err b/tests/qapi-sche=
ma/allow-preconfig-test.err
index 2a4e6ce663..3cd672bc61 100644
--- a/tests/qapi-schema/allow-preconfig-test.err
+++ b/tests/qapi-schema/allow-preconfig-test.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/allow-preconfig-test.json: In command 'allow-preconfig=
-test':
-tests/qapi-schema/allow-preconfig-test.json:2: flag 'allow-preconfig' ma=
y only use true value
+allow-preconfig-test.json: In command 'allow-preconfig-test':
+allow-preconfig-test.json:2: flag 'allow-preconfig' may only use true va=
lue
diff --git a/tests/qapi-schema/allow-preconfig-test.exit b/tests/qapi-sch=
ema/allow-preconfig-test.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/allow-preconfig-test.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/alternate-any.err b/tests/qapi-schema/alte=
rnate-any.err
index 03aaf29506..baeb3f66d1 100644
--- a/tests/qapi-schema/alternate-any.err
+++ b/tests/qapi-schema/alternate-any.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/alternate-any.json: In alternate 'Alt':
-tests/qapi-schema/alternate-any.json:2: branch 'one' cannot use built-in=
 type 'any'
+alternate-any.json: In alternate 'Alt':
+alternate-any.json:2: branch 'one' cannot use built-in type 'any'
diff --git a/tests/qapi-schema/alternate-any.exit b/tests/qapi-schema/alt=
ernate-any.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/alternate-any.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/alternate-array.err b/tests/qapi-schema/al=
ternate-array.err
index dfbe3ee998..b1aa1f4e8d 100644
--- a/tests/qapi-schema/alternate-array.err
+++ b/tests/qapi-schema/alternate-array.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/alternate-array.json: In alternate 'Alt':
-tests/qapi-schema/alternate-array.json:5: 'data' member 'two' cannot be =
an array
+alternate-array.json: In alternate 'Alt':
+alternate-array.json:5: 'data' member 'two' cannot be an array
diff --git a/tests/qapi-schema/alternate-array.exit b/tests/qapi-schema/a=
lternate-array.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/alternate-array.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/alternate-base.err b/tests/qapi-schema/alt=
ernate-base.err
index 04cea97e5c..31ebe56bbf 100644
--- a/tests/qapi-schema/alternate-base.err
+++ b/tests/qapi-schema/alternate-base.err
@@ -1,3 +1,3 @@
-tests/qapi-schema/alternate-base.json: In alternate 'Alt':
-tests/qapi-schema/alternate-base.json:4: alternate has unknown key 'base=
'
+alternate-base.json: In alternate 'Alt':
+alternate-base.json:4: alternate has unknown key 'base'
 Valid keys are 'alternate', 'data', 'if'.
diff --git a/tests/qapi-schema/alternate-base.exit b/tests/qapi-schema/al=
ternate-base.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/alternate-base.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/alternate-branch-if-invalid.err b/tests/qa=
pi-schema/alternate-branch-if-invalid.err
index 6c68e5a922..d384929c51 100644
--- a/tests/qapi-schema/alternate-branch-if-invalid.err
+++ b/tests/qapi-schema/alternate-branch-if-invalid.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/alternate-branch-if-invalid.json: In alternate 'Alt':
-tests/qapi-schema/alternate-branch-if-invalid.json:2: 'if' condition ' '=
 of 'data' member 'branch' makes no sense
+alternate-branch-if-invalid.json: In alternate 'Alt':
+alternate-branch-if-invalid.json:2: 'if' condition ' ' of 'data' member =
'branch' makes no sense
diff --git a/tests/qapi-schema/alternate-branch-if-invalid.exit b/tests/q=
api-schema/alternate-branch-if-invalid.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/alternate-branch-if-invalid.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/alternate-clash.err b/tests/qapi-schema/al=
ternate-clash.err
index 73a52d69d1..f58b977f7b 100644
--- a/tests/qapi-schema/alternate-clash.err
+++ b/tests/qapi-schema/alternate-clash.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/alternate-clash.json: In alternate 'Alt1':
-tests/qapi-schema/alternate-clash.json:7: branch 'a_b' collides with bra=
nch 'a-b'
+alternate-clash.json: In alternate 'Alt1':
+alternate-clash.json:7: branch 'a_b' collides with branch 'a-b'
diff --git a/tests/qapi-schema/alternate-clash.exit b/tests/qapi-schema/a=
lternate-clash.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/alternate-clash.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/alternate-conflict-bool-string.err b/tests=
/qapi-schema/alternate-conflict-bool-string.err
index f7513b9cbe..59ff5efa87 100644
--- a/tests/qapi-schema/alternate-conflict-bool-string.err
+++ b/tests/qapi-schema/alternate-conflict-bool-string.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/alternate-conflict-bool-string.json: In alternate 'Alt=
':
-tests/qapi-schema/alternate-conflict-bool-string.json:2: branch 'two' ca=
n't be distinguished from 'one'
+alternate-conflict-bool-string.json: In alternate 'Alt':
+alternate-conflict-bool-string.json:2: branch 'two' can't be distinguish=
ed from 'one'
diff --git a/tests/qapi-schema/alternate-conflict-bool-string.exit b/test=
s/qapi-schema/alternate-conflict-bool-string.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/alternate-conflict-bool-string.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/alternate-conflict-dict.err b/tests/qapi-s=
chema/alternate-conflict-dict.err
index e5b42d04c9..d4970284ba 100644
--- a/tests/qapi-schema/alternate-conflict-dict.err
+++ b/tests/qapi-schema/alternate-conflict-dict.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/alternate-conflict-dict.json: In alternate 'Alt':
-tests/qapi-schema/alternate-conflict-dict.json:6: branch 'two' can't be =
distinguished from 'one'
+alternate-conflict-dict.json: In alternate 'Alt':
+alternate-conflict-dict.json:6: branch 'two' can't be distinguished from=
 'one'
diff --git a/tests/qapi-schema/alternate-conflict-dict.exit b/tests/qapi-=
schema/alternate-conflict-dict.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/alternate-conflict-dict.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/alternate-conflict-enum-bool.err b/tests/q=
api-schema/alternate-conflict-enum-bool.err
index 3d23aeba51..5f35855274 100644
--- a/tests/qapi-schema/alternate-conflict-enum-bool.err
+++ b/tests/qapi-schema/alternate-conflict-enum-bool.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/alternate-conflict-enum-bool.json: In alternate 'Alt':
-tests/qapi-schema/alternate-conflict-enum-bool.json:4: branch 'two' can'=
t be distinguished from 'one'
+alternate-conflict-enum-bool.json: In alternate 'Alt':
+alternate-conflict-enum-bool.json:4: branch 'two' can't be distinguished=
 from 'one'
diff --git a/tests/qapi-schema/alternate-conflict-enum-bool.exit b/tests/=
qapi-schema/alternate-conflict-enum-bool.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/alternate-conflict-enum-bool.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/alternate-conflict-enum-int.err b/tests/qa=
pi-schema/alternate-conflict-enum-int.err
index b72768caa4..6a6d156664 100644
--- a/tests/qapi-schema/alternate-conflict-enum-int.err
+++ b/tests/qapi-schema/alternate-conflict-enum-int.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/alternate-conflict-enum-int.json: In alternate 'Alt':
-tests/qapi-schema/alternate-conflict-enum-int.json:4: branch 'two' can't=
 be distinguished from 'one'
+alternate-conflict-enum-int.json: In alternate 'Alt':
+alternate-conflict-enum-int.json:4: branch 'two' can't be distinguished =
from 'one'
diff --git a/tests/qapi-schema/alternate-conflict-enum-int.exit b/tests/q=
api-schema/alternate-conflict-enum-int.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/alternate-conflict-enum-int.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/alternate-conflict-num-string.err b/tests/=
qapi-schema/alternate-conflict-num-string.err
index b8a2bb1829..38c805ea1f 100644
--- a/tests/qapi-schema/alternate-conflict-num-string.err
+++ b/tests/qapi-schema/alternate-conflict-num-string.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/alternate-conflict-num-string.json: In alternate 'Alt'=
:
-tests/qapi-schema/alternate-conflict-num-string.json:2: branch 'two' can=
't be distinguished from 'one'
+alternate-conflict-num-string.json: In alternate 'Alt':
+alternate-conflict-num-string.json:2: branch 'two' can't be distinguishe=
d from 'one'
diff --git a/tests/qapi-schema/alternate-conflict-num-string.exit b/tests=
/qapi-schema/alternate-conflict-num-string.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/alternate-conflict-num-string.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/alternate-conflict-string.err b/tests/qapi=
-schema/alternate-conflict-string.err
index 3edec51911..2fa08193db 100644
--- a/tests/qapi-schema/alternate-conflict-string.err
+++ b/tests/qapi-schema/alternate-conflict-string.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/alternate-conflict-string.json: In alternate 'Alt':
-tests/qapi-schema/alternate-conflict-string.json:2: branch 'two' can't b=
e distinguished from 'one'
+alternate-conflict-string.json: In alternate 'Alt':
+alternate-conflict-string.json:2: branch 'two' can't be distinguished fr=
om 'one'
diff --git a/tests/qapi-schema/alternate-conflict-string.exit b/tests/qap=
i-schema/alternate-conflict-string.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/alternate-conflict-string.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/alternate-empty.err b/tests/qapi-schema/al=
ternate-empty.err
index 908c309518..c6f6401d18 100644
--- a/tests/qapi-schema/alternate-empty.err
+++ b/tests/qapi-schema/alternate-empty.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/alternate-empty.json: In alternate 'Alt':
-tests/qapi-schema/alternate-empty.json:2: 'data' must not be empty
+alternate-empty.json: In alternate 'Alt':
+alternate-empty.json:2: 'data' must not be empty
diff --git a/tests/qapi-schema/alternate-empty.exit b/tests/qapi-schema/a=
lternate-empty.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/alternate-empty.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/alternate-invalid-dict.err b/tests/qapi-sc=
hema/alternate-invalid-dict.err
index d6a18a294b..e9e5025226 100644
--- a/tests/qapi-schema/alternate-invalid-dict.err
+++ b/tests/qapi-schema/alternate-invalid-dict.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/alternate-invalid-dict.json: In alternate 'Alt':
-tests/qapi-schema/alternate-invalid-dict.json:2: 'data' member 'two' mis=
ses key 'type'
+alternate-invalid-dict.json: In alternate 'Alt':
+alternate-invalid-dict.json:2: 'data' member 'two' misses key 'type'
diff --git a/tests/qapi-schema/alternate-invalid-dict.exit b/tests/qapi-s=
chema/alternate-invalid-dict.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/alternate-invalid-dict.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/alternate-nested.err b/tests/qapi-schema/a=
lternate-nested.err
index cd7a076ce5..3ae9cd2f11 100644
--- a/tests/qapi-schema/alternate-nested.err
+++ b/tests/qapi-schema/alternate-nested.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/alternate-nested.json: In alternate 'Alt2':
-tests/qapi-schema/alternate-nested.json:4: branch 'nested' cannot use al=
ternate type 'Alt1'
+alternate-nested.json: In alternate 'Alt2':
+alternate-nested.json:4: branch 'nested' cannot use alternate type 'Alt1=
'
diff --git a/tests/qapi-schema/alternate-nested.exit b/tests/qapi-schema/=
alternate-nested.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/alternate-nested.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/alternate-unknown.err b/tests/qapi-schema/=
alternate-unknown.err
index df05860bba..17fec1cd17 100644
--- a/tests/qapi-schema/alternate-unknown.err
+++ b/tests/qapi-schema/alternate-unknown.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/alternate-unknown.json: In alternate 'Alt':
-tests/qapi-schema/alternate-unknown.json:2: branch 'unknown' uses unknow=
n type 'MissingType'
+alternate-unknown.json: In alternate 'Alt':
+alternate-unknown.json:2: branch 'unknown' uses unknown type 'MissingTyp=
e'
diff --git a/tests/qapi-schema/alternate-unknown.exit b/tests/qapi-schema=
/alternate-unknown.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/alternate-unknown.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/args-alternate.err b/tests/qapi-schema/arg=
s-alternate.err
index 852b81b89c..b1530aa610 100644
--- a/tests/qapi-schema/args-alternate.err
+++ b/tests/qapi-schema/args-alternate.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/args-alternate.json: In command 'oops':
-tests/qapi-schema/args-alternate.json:3: command's 'data' cannot take al=
ternate type 'Alt'
+args-alternate.json: In command 'oops':
+args-alternate.json:3: command's 'data' cannot take alternate type 'Alt'
diff --git a/tests/qapi-schema/args-alternate.exit b/tests/qapi-schema/ar=
gs-alternate.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/args-alternate.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/args-any.err b/tests/qapi-schema/args-any.=
err
index 04e11df29f..4b60560247 100644
--- a/tests/qapi-schema/args-any.err
+++ b/tests/qapi-schema/args-any.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/args-any.json: In command 'oops':
-tests/qapi-schema/args-any.json:2: command's 'data' cannot take built-in=
 type 'any'
+args-any.json: In command 'oops':
+args-any.json:2: command's 'data' cannot take built-in type 'any'
diff --git a/tests/qapi-schema/args-any.exit b/tests/qapi-schema/args-any=
.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/args-any.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/args-array-empty.err b/tests/qapi-schema/a=
rgs-array-empty.err
index c7d367730e..181222296e 100644
--- a/tests/qapi-schema/args-array-empty.err
+++ b/tests/qapi-schema/args-array-empty.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/args-array-empty.json: In command 'oops':
-tests/qapi-schema/args-array-empty.json:2: 'data' member 'empty': array =
type must contain single type name
+args-array-empty.json: In command 'oops':
+args-array-empty.json:2: 'data' member 'empty': array type must contain =
single type name
diff --git a/tests/qapi-schema/args-array-empty.exit b/tests/qapi-schema/=
args-array-empty.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/args-array-empty.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/args-array-unknown.err b/tests/qapi-schema=
/args-array-unknown.err
index 218fc4bf9a..cbc598e4ff 100644
--- a/tests/qapi-schema/args-array-unknown.err
+++ b/tests/qapi-schema/args-array-unknown.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/args-array-unknown.json: In command 'oops':
-tests/qapi-schema/args-array-unknown.json:2: command uses unknown type '=
NoSuchType'
+args-array-unknown.json: In command 'oops':
+args-array-unknown.json:2: command uses unknown type 'NoSuchType'
diff --git a/tests/qapi-schema/args-array-unknown.exit b/tests/qapi-schem=
a/args-array-unknown.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/args-array-unknown.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/args-bad-boxed.err b/tests/qapi-schema/arg=
s-bad-boxed.err
index 31d39038fc..361276eb29 100644
--- a/tests/qapi-schema/args-bad-boxed.err
+++ b/tests/qapi-schema/args-bad-boxed.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/args-bad-boxed.json: In command 'foo':
-tests/qapi-schema/args-bad-boxed.json:2: flag 'boxed' may only use true =
value
+args-bad-boxed.json: In command 'foo':
+args-bad-boxed.json:2: flag 'boxed' may only use true value
diff --git a/tests/qapi-schema/args-bad-boxed.exit b/tests/qapi-schema/ar=
gs-bad-boxed.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/args-bad-boxed.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/args-boxed-anon.err b/tests/qapi-schema/ar=
gs-boxed-anon.err
index 5e0c2979b7..a89af75bef 100644
--- a/tests/qapi-schema/args-boxed-anon.err
+++ b/tests/qapi-schema/args-boxed-anon.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/args-boxed-anon.json: In command 'foo':
-tests/qapi-schema/args-boxed-anon.json:2: 'data' should be a type name
+args-boxed-anon.json: In command 'foo':
+args-boxed-anon.json:2: 'data' should be a type name
diff --git a/tests/qapi-schema/args-boxed-anon.exit b/tests/qapi-schema/a=
rgs-boxed-anon.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/args-boxed-anon.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/args-boxed-string.err b/tests/qapi-schema/=
args-boxed-string.err
index dc2b00f217..415c1148a9 100644
--- a/tests/qapi-schema/args-boxed-string.err
+++ b/tests/qapi-schema/args-boxed-string.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/args-boxed-string.json: In command 'foo':
-tests/qapi-schema/args-boxed-string.json:2: command's 'data' cannot take=
 built-in type 'str'
+args-boxed-string.json: In command 'foo':
+args-boxed-string.json:2: command's 'data' cannot take built-in type 'st=
r'
diff --git a/tests/qapi-schema/args-boxed-string.exit b/tests/qapi-schema=
/args-boxed-string.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/args-boxed-string.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/args-int.err b/tests/qapi-schema/args-int.=
err
index 81b6f86b66..a2331c5543 100644
--- a/tests/qapi-schema/args-int.err
+++ b/tests/qapi-schema/args-int.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/args-int.json: In command 'oops':
-tests/qapi-schema/args-int.json:2: command's 'data' cannot take built-in=
 type 'int'
+args-int.json: In command 'oops':
+args-int.json:2: command's 'data' cannot take built-in type 'int'
diff --git a/tests/qapi-schema/args-int.exit b/tests/qapi-schema/args-int=
.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/args-int.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/args-invalid.err b/tests/qapi-schema/args-=
invalid.err
index c4971e1399..1527c4a48d 100644
--- a/tests/qapi-schema/args-invalid.err
+++ b/tests/qapi-schema/args-invalid.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/args-invalid.json: In command 'foo':
-tests/qapi-schema/args-invalid.json:1: 'data' should be an object or typ=
e name
+args-invalid.json: In command 'foo':
+args-invalid.json:1: 'data' should be an object or type name
diff --git a/tests/qapi-schema/args-invalid.exit b/tests/qapi-schema/args=
-invalid.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/args-invalid.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/args-member-array-bad.err b/tests/qapi-sch=
ema/args-member-array-bad.err
index f95ac01372..194a3052d2 100644
--- a/tests/qapi-schema/args-member-array-bad.err
+++ b/tests/qapi-schema/args-member-array-bad.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/args-member-array-bad.json: In command 'oops':
-tests/qapi-schema/args-member-array-bad.json:2: 'data' member 'member': =
array type must contain single type name
+args-member-array-bad.json: In command 'oops':
+args-member-array-bad.json:2: 'data' member 'member': array type must co=
ntain single type name
diff --git a/tests/qapi-schema/args-member-array-bad.exit b/tests/qapi-sc=
hema/args-member-array-bad.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/args-member-array-bad.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/args-member-case.err b/tests/qapi-schema/a=
rgs-member-case.err
index 3ecd276040..4f33dbbc38 100644
--- a/tests/qapi-schema/args-member-case.err
+++ b/tests/qapi-schema/args-member-case.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/args-member-case.json: In command 'no-way-this-will-ge=
t-whitelisted':
-tests/qapi-schema/args-member-case.json:2: 'data' member 'Arg' uses uppe=
rcase in name
+args-member-case.json: In command 'no-way-this-will-get-whitelisted':
+args-member-case.json:2: 'data' member 'Arg' uses uppercase in name
diff --git a/tests/qapi-schema/args-member-case.exit b/tests/qapi-schema/=
args-member-case.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/args-member-case.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/args-member-unknown.err b/tests/qapi-schem=
a/args-member-unknown.err
index 0626e1209d..96b6e5d289 100644
--- a/tests/qapi-schema/args-member-unknown.err
+++ b/tests/qapi-schema/args-member-unknown.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/args-member-unknown.json: In command 'oops':
-tests/qapi-schema/args-member-unknown.json:2: parameter 'member' uses un=
known type 'NoSuchType'
+args-member-unknown.json: In command 'oops':
+args-member-unknown.json:2: parameter 'member' uses unknown type 'NoSuch=
Type'
diff --git a/tests/qapi-schema/args-member-unknown.exit b/tests/qapi-sche=
ma/args-member-unknown.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/args-member-unknown.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/args-name-clash.err b/tests/qapi-schema/ar=
gs-name-clash.err
index c5916a80fb..3e04817bc0 100644
--- a/tests/qapi-schema/args-name-clash.err
+++ b/tests/qapi-schema/args-name-clash.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/args-name-clash.json: In command 'oops':
-tests/qapi-schema/args-name-clash.json:4: parameter 'a_b' collides with =
parameter 'a-b'
+args-name-clash.json: In command 'oops':
+args-name-clash.json:4: parameter 'a_b' collides with parameter 'a-b'
diff --git a/tests/qapi-schema/args-name-clash.exit b/tests/qapi-schema/a=
rgs-name-clash.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/args-name-clash.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/args-union.err b/tests/qapi-schema/args-un=
ion.err
index 3a77b2863f..4bf4955027 100644
--- a/tests/qapi-schema/args-union.err
+++ b/tests/qapi-schema/args-union.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/args-union.json: In command 'oops':
-tests/qapi-schema/args-union.json:3: command's 'data' can take union typ=
e 'Uni' only with 'boxed': true
+args-union.json: In command 'oops':
+args-union.json:3: command's 'data' can take union type 'Uni' only with =
'boxed': true
diff --git a/tests/qapi-schema/args-union.exit b/tests/qapi-schema/args-u=
nion.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/args-union.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/args-unknown.err b/tests/qapi-schema/args-=
unknown.err
index 6857d6bf48..44bf8706ae 100644
--- a/tests/qapi-schema/args-unknown.err
+++ b/tests/qapi-schema/args-unknown.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/args-unknown.json: In command 'oops':
-tests/qapi-schema/args-unknown.json:2: command's 'data' uses unknown typ=
e 'NoSuchType'
+args-unknown.json: In command 'oops':
+args-unknown.json:2: command's 'data' uses unknown type 'NoSuchType'
diff --git a/tests/qapi-schema/args-unknown.exit b/tests/qapi-schema/args=
-unknown.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/args-unknown.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/bad-base.err b/tests/qapi-schema/bad-base.=
err
index 039678a364..61a1efc2c0 100644
--- a/tests/qapi-schema/bad-base.err
+++ b/tests/qapi-schema/bad-base.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/bad-base.json: In struct 'MyType':
-tests/qapi-schema/bad-base.json:3: 'base' requires a struct type, union =
type 'Union' isn't
+bad-base.json: In struct 'MyType':
+bad-base.json:3: 'base' requires a struct type, union type 'Union' isn't
diff --git a/tests/qapi-schema/bad-base.exit b/tests/qapi-schema/bad-base=
.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/bad-base.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/bad-data.err b/tests/qapi-schema/bad-data.=
err
index 5227bdce7e..7991c8898d 100644
--- a/tests/qapi-schema/bad-data.err
+++ b/tests/qapi-schema/bad-data.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/bad-data.json: In command 'oops':
-tests/qapi-schema/bad-data.json:2: 'data' cannot be an array
+bad-data.json: In command 'oops':
+bad-data.json:2: 'data' cannot be an array
diff --git a/tests/qapi-schema/bad-data.exit b/tests/qapi-schema/bad-data=
.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/bad-data.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/bad-ident.err b/tests/qapi-schema/bad-iden=
t.err
index ad38a679c7..263fcd3ecd 100644
--- a/tests/qapi-schema/bad-ident.err
+++ b/tests/qapi-schema/bad-ident.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/bad-ident.json: In struct '*oops':
-tests/qapi-schema/bad-ident.json:2: struct has an invalid name
+bad-ident.json: In struct '*oops':
+bad-ident.json:2: struct has an invalid name
diff --git a/tests/qapi-schema/bad-ident.exit b/tests/qapi-schema/bad-ide=
nt.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/bad-ident.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/bad-if-empty-list.err b/tests/qapi-schema/=
bad-if-empty-list.err
index 517519f500..a946376d06 100644
--- a/tests/qapi-schema/bad-if-empty-list.err
+++ b/tests/qapi-schema/bad-if-empty-list.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/bad-if-empty-list.json: In struct 'TestIfStruct':
-tests/qapi-schema/bad-if-empty-list.json:2: 'if' condition [] of struct =
is useless
+bad-if-empty-list.json: In struct 'TestIfStruct':
+bad-if-empty-list.json:2: 'if' condition [] of struct is useless
diff --git a/tests/qapi-schema/bad-if-empty-list.exit b/tests/qapi-schema=
/bad-if-empty-list.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/bad-if-empty-list.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/bad-if-empty.err b/tests/qapi-schema/bad-i=
f-empty.err
index 5f1767388e..a0f3effefb 100644
--- a/tests/qapi-schema/bad-if-empty.err
+++ b/tests/qapi-schema/bad-if-empty.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/bad-if-empty.json: In struct 'TestIfStruct':
-tests/qapi-schema/bad-if-empty.json:2: 'if' condition '' of struct makes=
 no sense
+bad-if-empty.json: In struct 'TestIfStruct':
+bad-if-empty.json:2: 'if' condition '' of struct makes no sense
diff --git a/tests/qapi-schema/bad-if-empty.exit b/tests/qapi-schema/bad-=
if-empty.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/bad-if-empty.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/bad-if-list.err b/tests/qapi-schema/bad-if=
-list.err
index e5d72b2f39..c462f11b90 100644
--- a/tests/qapi-schema/bad-if-list.err
+++ b/tests/qapi-schema/bad-if-list.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/bad-if-list.json: In struct 'TestIfStruct':
-tests/qapi-schema/bad-if-list.json:2: 'if' condition ' ' of struct makes=
 no sense
+bad-if-list.json: In struct 'TestIfStruct':
+bad-if-list.json:2: 'if' condition ' ' of struct makes no sense
diff --git a/tests/qapi-schema/bad-if-list.exit b/tests/qapi-schema/bad-i=
f-list.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/bad-if-list.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/bad-if.err b/tests/qapi-schema/bad-if.err
index 65d8efd7e4..f83dee65da 100644
--- a/tests/qapi-schema/bad-if.err
+++ b/tests/qapi-schema/bad-if.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/bad-if.json: In struct 'TestIfStruct':
-tests/qapi-schema/bad-if.json:2: 'if' condition of struct must be a stri=
ng or a list of strings
+bad-if.json: In struct 'TestIfStruct':
+bad-if.json:2: 'if' condition of struct must be a string or a list of st=
rings
diff --git a/tests/qapi-schema/bad-if.exit b/tests/qapi-schema/bad-if.exi=
t
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/bad-if.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/bad-type-bool.err b/tests/qapi-schema/bad-=
type-bool.err
index 984a77c4e3..42ccc18988 100644
--- a/tests/qapi-schema/bad-type-bool.err
+++ b/tests/qapi-schema/bad-type-bool.err
@@ -1 +1 @@
-tests/qapi-schema/bad-type-bool.json:2: 'struct' requires a string name
+bad-type-bool.json:2: 'struct' requires a string name
diff --git a/tests/qapi-schema/bad-type-bool.exit b/tests/qapi-schema/bad=
-type-bool.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/bad-type-bool.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/bad-type-dict.err b/tests/qapi-schema/bad-=
type-dict.err
index e83b8cfb41..3d97cd3f0a 100644
--- a/tests/qapi-schema/bad-type-dict.err
+++ b/tests/qapi-schema/bad-type-dict.err
@@ -1 +1 @@
-tests/qapi-schema/bad-type-dict.json:2: 'command' requires a string name
+bad-type-dict.json:2: 'command' requires a string name
diff --git a/tests/qapi-schema/bad-type-dict.exit b/tests/qapi-schema/bad=
-type-dict.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/bad-type-dict.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/bad-type-int.err b/tests/qapi-schema/bad-t=
ype-int.err
index 7f5916ea29..90d06bd94d 100644
--- a/tests/qapi-schema/bad-type-int.err
+++ b/tests/qapi-schema/bad-type-int.err
@@ -1 +1 @@
-tests/qapi-schema/bad-type-int.json:3:13: stray '123'
+bad-type-int.json:3:13: stray '123'
diff --git a/tests/qapi-schema/bad-type-int.exit b/tests/qapi-schema/bad-=
type-int.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/bad-type-int.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/base-cycle-direct.err b/tests/qapi-schema/=
base-cycle-direct.err
index 233e4b8952..4ea6c5064e 100644
--- a/tests/qapi-schema/base-cycle-direct.err
+++ b/tests/qapi-schema/base-cycle-direct.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/base-cycle-direct.json: In struct 'Loopy':
-tests/qapi-schema/base-cycle-direct.json:2: object Loopy contains itself
+base-cycle-direct.json: In struct 'Loopy':
+base-cycle-direct.json:2: object Loopy contains itself
diff --git a/tests/qapi-schema/base-cycle-direct.exit b/tests/qapi-schema=
/base-cycle-direct.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/base-cycle-direct.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/base-cycle-indirect.err b/tests/qapi-schem=
a/base-cycle-indirect.err
index 4472f30ba1..9b5e7ec174 100644
--- a/tests/qapi-schema/base-cycle-indirect.err
+++ b/tests/qapi-schema/base-cycle-indirect.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/base-cycle-indirect.json: In struct 'Base1':
-tests/qapi-schema/base-cycle-indirect.json:2: object Base1 contains itse=
lf
+base-cycle-indirect.json: In struct 'Base1':
+base-cycle-indirect.json:2: object Base1 contains itself
diff --git a/tests/qapi-schema/base-cycle-indirect.exit b/tests/qapi-sche=
ma/base-cycle-indirect.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/base-cycle-indirect.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/command-int.err b/tests/qapi-schema/comman=
d-int.err
index 3523d50a79..df0e5f5a57 100644
--- a/tests/qapi-schema/command-int.err
+++ b/tests/qapi-schema/command-int.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/command-int.json: In command 'int':
-tests/qapi-schema/command-int.json:2: built-in type 'int' is already def=
ined
+command-int.json: In command 'int':
+command-int.json:2: built-in type 'int' is already defined
diff --git a/tests/qapi-schema/command-int.exit b/tests/qapi-schema/comma=
nd-int.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/command-int.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/comments.exit b/tests/qapi-schema/comments=
.exit
deleted file mode 100644
index 573541ac97..0000000000
--- a/tests/qapi-schema/comments.exit
+++ /dev/null
@@ -1 +0,0 @@
-0
diff --git a/tests/qapi-schema/doc-bad-alternate-member.err b/tests/qapi-=
schema/doc-bad-alternate-member.err
index 19a1ffd76e..a1c282f935 100644
--- a/tests/qapi-schema/doc-bad-alternate-member.err
+++ b/tests/qapi-schema/doc-bad-alternate-member.err
@@ -1 +1 @@
-tests/qapi-schema/doc-bad-alternate-member.json:3: the following documen=
ted members are not in the declaration: aa, bb
+doc-bad-alternate-member.json:3: the following documented members are no=
t in the declaration: aa, bb
diff --git a/tests/qapi-schema/doc-bad-alternate-member.exit b/tests/qapi=
-schema/doc-bad-alternate-member.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/doc-bad-alternate-member.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/doc-bad-command-arg.err b/tests/qapi-schem=
a/doc-bad-command-arg.err
index 6962ebed69..153ea0330a 100644
--- a/tests/qapi-schema/doc-bad-command-arg.err
+++ b/tests/qapi-schema/doc-bad-command-arg.err
@@ -1 +1 @@
-tests/qapi-schema/doc-bad-command-arg.json:3: the following documented m=
embers are not in the declaration: b
+doc-bad-command-arg.json:3: the following documented members are not in =
the declaration: b
diff --git a/tests/qapi-schema/doc-bad-command-arg.exit b/tests/qapi-sche=
ma/doc-bad-command-arg.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/doc-bad-command-arg.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/doc-bad-section.exit b/tests/qapi-schema/d=
oc-bad-section.exit
deleted file mode 100644
index 573541ac97..0000000000
--- a/tests/qapi-schema/doc-bad-section.exit
+++ /dev/null
@@ -1 +0,0 @@
-0
diff --git a/tests/qapi-schema/doc-bad-symbol.err b/tests/qapi-schema/doc=
-bad-symbol.err
index b23e99d160..166c8dcc18 100644
--- a/tests/qapi-schema/doc-bad-symbol.err
+++ b/tests/qapi-schema/doc-bad-symbol.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/doc-bad-symbol.json: In command 'foo':
-tests/qapi-schema/doc-bad-symbol.json:6: documentation comment is for 'f=
ood'
+doc-bad-symbol.json: In command 'foo':
+doc-bad-symbol.json:6: documentation comment is for 'food'
diff --git a/tests/qapi-schema/doc-bad-symbol.exit b/tests/qapi-schema/do=
c-bad-symbol.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/doc-bad-symbol.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/doc-bad-union-member.err b/tests/qapi-sche=
ma/doc-bad-union-member.err
index da3cd806e3..8b9d36eab1 100644
--- a/tests/qapi-schema/doc-bad-union-member.err
+++ b/tests/qapi-schema/doc-bad-union-member.err
@@ -1 +1 @@
-tests/qapi-schema/doc-bad-union-member.json:3: the following documented =
members are not in the declaration: a, b
+doc-bad-union-member.json:3: the following documented members are not in=
 the declaration: a, b
diff --git a/tests/qapi-schema/doc-bad-union-member.exit b/tests/qapi-sch=
ema/doc-bad-union-member.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/doc-bad-union-member.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/doc-before-include.err b/tests/qapi-schema=
/doc-before-include.err
index e5566f11e9..ae23ea2f57 100644
--- a/tests/qapi-schema/doc-before-include.err
+++ b/tests/qapi-schema/doc-before-include.err
@@ -1 +1 @@
-tests/qapi-schema/doc-before-include.json:3: documentation for 'foo' is =
not followed by the definition
+doc-before-include.json:3: documentation for 'foo' is not followed by th=
e definition
diff --git a/tests/qapi-schema/doc-before-include.exit b/tests/qapi-schem=
a/doc-before-include.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/doc-before-include.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/doc-before-pragma.err b/tests/qapi-schema/=
doc-before-pragma.err
index 8a97ebb578..c776252e07 100644
--- a/tests/qapi-schema/doc-before-pragma.err
+++ b/tests/qapi-schema/doc-before-pragma.err
@@ -1 +1 @@
-tests/qapi-schema/doc-before-pragma.json:3: documentation for 'foo' is n=
ot followed by the definition
+doc-before-pragma.json:3: documentation for 'foo' is not followed by the=
 definition
diff --git a/tests/qapi-schema/doc-before-pragma.exit b/tests/qapi-schema=
/doc-before-pragma.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/doc-before-pragma.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/doc-duplicated-arg.err b/tests/qapi-schema=
/doc-duplicated-arg.err
index 1c3f8e0a54..0d0d777a1f 100644
--- a/tests/qapi-schema/doc-duplicated-arg.err
+++ b/tests/qapi-schema/doc-duplicated-arg.err
@@ -1 +1 @@
-tests/qapi-schema/doc-duplicated-arg.json:6:1: 'a' parameter name duplic=
ated
+doc-duplicated-arg.json:6:1: 'a' parameter name duplicated
diff --git a/tests/qapi-schema/doc-duplicated-arg.exit b/tests/qapi-schem=
a/doc-duplicated-arg.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/doc-duplicated-arg.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/doc-duplicated-return.err b/tests/qapi-sch=
ema/doc-duplicated-return.err
index 7631933093..fe97e3db8d 100644
--- a/tests/qapi-schema/doc-duplicated-return.err
+++ b/tests/qapi-schema/doc-duplicated-return.err
@@ -1 +1 @@
-tests/qapi-schema/doc-duplicated-return.json:7:1: duplicated 'Returns' s=
ection
+doc-duplicated-return.json:7:1: duplicated 'Returns' section
diff --git a/tests/qapi-schema/doc-duplicated-return.exit b/tests/qapi-sc=
hema/doc-duplicated-return.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/doc-duplicated-return.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/doc-duplicated-since.err b/tests/qapi-sche=
ma/doc-duplicated-since.err
index 5ee15ae2a1..abca141a2c 100644
--- a/tests/qapi-schema/doc-duplicated-since.err
+++ b/tests/qapi-schema/doc-duplicated-since.err
@@ -1 +1 @@
-tests/qapi-schema/doc-duplicated-since.json:7:1: duplicated 'Since' sect=
ion
+doc-duplicated-since.json:7:1: duplicated 'Since' section
diff --git a/tests/qapi-schema/doc-duplicated-since.exit b/tests/qapi-sch=
ema/doc-duplicated-since.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/doc-duplicated-since.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/doc-empty-arg.err b/tests/qapi-schema/doc-=
empty-arg.err
index 3c78a37ae1..2d0f35f310 100644
--- a/tests/qapi-schema/doc-empty-arg.err
+++ b/tests/qapi-schema/doc-empty-arg.err
@@ -1 +1 @@
-tests/qapi-schema/doc-empty-arg.json:5:1: invalid parameter name
+doc-empty-arg.json:5:1: invalid parameter name
diff --git a/tests/qapi-schema/doc-empty-arg.exit b/tests/qapi-schema/doc=
-empty-arg.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/doc-empty-arg.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/doc-empty-section.err b/tests/qapi-schema/=
doc-empty-section.err
index f6586c566f..ba7ba70125 100644
--- a/tests/qapi-schema/doc-empty-section.err
+++ b/tests/qapi-schema/doc-empty-section.err
@@ -1 +1 @@
-tests/qapi-schema/doc-empty-section.json:7:1: empty doc section 'Note'
+doc-empty-section.json:7:1: empty doc section 'Note'
diff --git a/tests/qapi-schema/doc-empty-section.exit b/tests/qapi-schema=
/doc-empty-section.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/doc-empty-section.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/doc-empty-symbol.err b/tests/qapi-schema/d=
oc-empty-symbol.err
index 2dcddca7f6..81b90e882a 100644
--- a/tests/qapi-schema/doc-empty-symbol.err
+++ b/tests/qapi-schema/doc-empty-symbol.err
@@ -1 +1 @@
-tests/qapi-schema/doc-empty-symbol.json:4:1: invalid name
+doc-empty-symbol.json:4:1: invalid name
diff --git a/tests/qapi-schema/doc-empty-symbol.exit b/tests/qapi-schema/=
doc-empty-symbol.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/doc-empty-symbol.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/doc-good.exit b/tests/qapi-schema/doc-good=
.exit
deleted file mode 100644
index 573541ac97..0000000000
--- a/tests/qapi-schema/doc-good.exit
+++ /dev/null
@@ -1 +0,0 @@
-0
diff --git a/tests/qapi-schema/doc-interleaved-section.err b/tests/qapi-s=
chema/doc-interleaved-section.err
index d373eabc55..715d58cd31 100644
--- a/tests/qapi-schema/doc-interleaved-section.err
+++ b/tests/qapi-schema/doc-interleaved-section.err
@@ -1 +1 @@
-tests/qapi-schema/doc-interleaved-section.json:15:1: '@foobar:' can't fo=
llow 'Note' section
+doc-interleaved-section.json:15:1: '@foobar:' can't follow 'Note' sectio=
n
diff --git a/tests/qapi-schema/doc-interleaved-section.exit b/tests/qapi-=
schema/doc-interleaved-section.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/doc-interleaved-section.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/doc-invalid-end.err b/tests/qapi-schema/do=
c-invalid-end.err
index 6345aa6a0f..919e4d317e 100644
--- a/tests/qapi-schema/doc-invalid-end.err
+++ b/tests/qapi-schema/doc-invalid-end.err
@@ -1 +1 @@
-tests/qapi-schema/doc-invalid-end.json:5:2: documentation comment must e=
nd with '##'
+doc-invalid-end.json:5:2: documentation comment must end with '##'
diff --git a/tests/qapi-schema/doc-invalid-end.exit b/tests/qapi-schema/d=
oc-invalid-end.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/doc-invalid-end.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/doc-invalid-end2.err b/tests/qapi-schema/d=
oc-invalid-end2.err
index 13ead36fd2..d88a15cc8a 100644
--- a/tests/qapi-schema/doc-invalid-end2.err
+++ b/tests/qapi-schema/doc-invalid-end2.err
@@ -1 +1 @@
-tests/qapi-schema/doc-invalid-end2.json:5:1: junk after '##' at end of d=
ocumentation comment
+doc-invalid-end2.json:5:1: junk after '##' at end of documentation comme=
nt
diff --git a/tests/qapi-schema/doc-invalid-end2.exit b/tests/qapi-schema/=
doc-invalid-end2.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/doc-invalid-end2.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/doc-invalid-return.err b/tests/qapi-schema=
/doc-invalid-return.err
index 5aaba33bb4..2ad89c5941 100644
--- a/tests/qapi-schema/doc-invalid-return.err
+++ b/tests/qapi-schema/doc-invalid-return.err
@@ -1 +1 @@
-tests/qapi-schema/doc-invalid-return.json:3: 'Returns:' is only valid fo=
r commands
+doc-invalid-return.json:3: 'Returns:' is only valid for commands
diff --git a/tests/qapi-schema/doc-invalid-return.exit b/tests/qapi-schem=
a/doc-invalid-return.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/doc-invalid-return.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/doc-invalid-section.err b/tests/qapi-schem=
a/doc-invalid-section.err
index bda93b44fd..d2d40e5704 100644
--- a/tests/qapi-schema/doc-invalid-section.err
+++ b/tests/qapi-schema/doc-invalid-section.err
@@ -1 +1 @@
-tests/qapi-schema/doc-invalid-section.json:5:1: '@note:' not allowed in =
free-form documentation
+doc-invalid-section.json:5:1: '@note:' not allowed in free-form document=
ation
diff --git a/tests/qapi-schema/doc-invalid-section.exit b/tests/qapi-sche=
ma/doc-invalid-section.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/doc-invalid-section.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/doc-invalid-start.err b/tests/qapi-schema/=
doc-invalid-start.err
index dcaa9699d6..276c033600 100644
--- a/tests/qapi-schema/doc-invalid-start.err
+++ b/tests/qapi-schema/doc-invalid-start.err
@@ -1 +1 @@
-tests/qapi-schema/doc-invalid-start.json:3:1: junk after '##' at start o=
f documentation comment
+doc-invalid-start.json:3:1: junk after '##' at start of documentation co=
mment
diff --git a/tests/qapi-schema/doc-invalid-start.exit b/tests/qapi-schema=
/doc-invalid-start.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/doc-invalid-start.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/doc-missing-colon.err b/tests/qapi-schema/=
doc-missing-colon.err
index 6fb5a380bd..cbcea00715 100644
--- a/tests/qapi-schema/doc-missing-colon.err
+++ b/tests/qapi-schema/doc-missing-colon.err
@@ -1 +1 @@
-tests/qapi-schema/doc-missing-colon.json:4:1: line should end with ':'
+doc-missing-colon.json:4:1: line should end with ':'
diff --git a/tests/qapi-schema/doc-missing-colon.exit b/tests/qapi-schema=
/doc-missing-colon.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/doc-missing-colon.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/doc-missing-expr.err b/tests/qapi-schema/d=
oc-missing-expr.err
index 622a37cc6c..c9b32a96fa 100644
--- a/tests/qapi-schema/doc-missing-expr.err
+++ b/tests/qapi-schema/doc-missing-expr.err
@@ -1 +1 @@
-tests/qapi-schema/doc-missing-expr.json:3: documentation for 'bar' is no=
t followed by the definition
+doc-missing-expr.json:3: documentation for 'bar' is not followed by the =
definition
diff --git a/tests/qapi-schema/doc-missing-expr.exit b/tests/qapi-schema/=
doc-missing-expr.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/doc-missing-expr.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/doc-missing-space.err b/tests/qapi-schema/=
doc-missing-space.err
index 1187ba12c4..350031d1d6 100644
--- a/tests/qapi-schema/doc-missing-space.err
+++ b/tests/qapi-schema/doc-missing-space.err
@@ -1 +1 @@
-tests/qapi-schema/doc-missing-space.json:5:1: missing space after #
+doc-missing-space.json:5:1: missing space after #
diff --git a/tests/qapi-schema/doc-missing-space.exit b/tests/qapi-schema=
/doc-missing-space.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/doc-missing-space.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/doc-missing.err b/tests/qapi-schema/doc-mi=
ssing.err
index 7fbf54ff65..b89d925bcc 100644
--- a/tests/qapi-schema/doc-missing.err
+++ b/tests/qapi-schema/doc-missing.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/doc-missing.json: In command 'undocumented':
-tests/qapi-schema/doc-missing.json:5: documentation comment required
+doc-missing.json: In command 'undocumented':
+doc-missing.json:5: documentation comment required
diff --git a/tests/qapi-schema/doc-missing.exit b/tests/qapi-schema/doc-m=
issing.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/doc-missing.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/doc-no-symbol.err b/tests/qapi-schema/doc-=
no-symbol.err
index 9a3057730c..1b4fa14a22 100644
--- a/tests/qapi-schema/doc-no-symbol.err
+++ b/tests/qapi-schema/doc-no-symbol.err
@@ -1 +1 @@
-tests/qapi-schema/doc-no-symbol.json:3: definition documentation require=
d
+doc-no-symbol.json:3: definition documentation required
diff --git a/tests/qapi-schema/doc-no-symbol.exit b/tests/qapi-schema/doc=
-no-symbol.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/doc-no-symbol.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/double-type.err b/tests/qapi-schema/double=
-type.err
index 23f88aae99..71fc4dbb52 100644
--- a/tests/qapi-schema/double-type.err
+++ b/tests/qapi-schema/double-type.err
@@ -1,3 +1,3 @@
-tests/qapi-schema/double-type.json: In struct 'bar':
-tests/qapi-schema/double-type.json:2: struct has unknown key 'command'
+double-type.json: In struct 'bar':
+double-type.json:2: struct has unknown key 'command'
 Valid keys are 'base', 'data', 'features', 'if', 'struct'.
diff --git a/tests/qapi-schema/double-type.exit b/tests/qapi-schema/doubl=
e-type.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/double-type.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/duplicate-key.err b/tests/qapi-schema/dupl=
icate-key.err
index 7f34a34eb6..7ea8e95e8c 100644
--- a/tests/qapi-schema/duplicate-key.err
+++ b/tests/qapi-schema/duplicate-key.err
@@ -1 +1 @@
-tests/qapi-schema/duplicate-key.json:3:10: duplicate key 'key'
+duplicate-key.json:3:10: duplicate key 'key'
diff --git a/tests/qapi-schema/duplicate-key.exit b/tests/qapi-schema/dup=
licate-key.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/duplicate-key.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/empty.exit b/tests/qapi-schema/empty.exit
deleted file mode 100644
index 573541ac97..0000000000
--- a/tests/qapi-schema/empty.exit
+++ /dev/null
@@ -1 +0,0 @@
-0
diff --git a/tests/qapi-schema/enum-bad-member.err b/tests/qapi-schema/en=
um-bad-member.err
index 2b1b4f98d0..f75d8c56ff 100644
--- a/tests/qapi-schema/enum-bad-member.err
+++ b/tests/qapi-schema/enum-bad-member.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/enum-bad-member.json: In enum 'MyEnum':
-tests/qapi-schema/enum-bad-member.json:2: 'data' member requires a strin=
g name
+enum-bad-member.json: In enum 'MyEnum':
+enum-bad-member.json:2: 'data' member requires a string name
diff --git a/tests/qapi-schema/enum-bad-member.exit b/tests/qapi-schema/e=
num-bad-member.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/enum-bad-member.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/enum-bad-name.err b/tests/qapi-schema/enum=
-bad-name.err
index 3273a9808a..d26044b8e3 100644
--- a/tests/qapi-schema/enum-bad-name.err
+++ b/tests/qapi-schema/enum-bad-name.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/enum-bad-name.json: In enum 'MyEnum':
-tests/qapi-schema/enum-bad-name.json:3: 'data' member 'not\possible' has=
 an invalid name
+enum-bad-name.json: In enum 'MyEnum':
+enum-bad-name.json:3: 'data' member 'not\possible' has an invalid name
diff --git a/tests/qapi-schema/enum-bad-name.exit b/tests/qapi-schema/enu=
m-bad-name.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/enum-bad-name.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/enum-bad-prefix.err b/tests/qapi-schema/en=
um-bad-prefix.err
index 933e33aa18..7a2b35787e 100644
--- a/tests/qapi-schema/enum-bad-prefix.err
+++ b/tests/qapi-schema/enum-bad-prefix.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/enum-bad-prefix.json: In enum 'MyEnum':
-tests/qapi-schema/enum-bad-prefix.json:2: 'prefix' must be a string
+enum-bad-prefix.json: In enum 'MyEnum':
+enum-bad-prefix.json:2: 'prefix' must be a string
diff --git a/tests/qapi-schema/enum-bad-prefix.exit b/tests/qapi-schema/e=
num-bad-prefix.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/enum-bad-prefix.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/enum-clash-member.err b/tests/qapi-schema/=
enum-clash-member.err
index 84e02db82c..5986571427 100644
--- a/tests/qapi-schema/enum-clash-member.err
+++ b/tests/qapi-schema/enum-clash-member.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/enum-clash-member.json: In enum 'MyEnum':
-tests/qapi-schema/enum-clash-member.json:2: value 'one_two' collides wit=
h value 'one-two'
+enum-clash-member.json: In enum 'MyEnum':
+enum-clash-member.json:2: value 'one_two' collides with value 'one-two'
diff --git a/tests/qapi-schema/enum-clash-member.exit b/tests/qapi-schema=
/enum-clash-member.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/enum-clash-member.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/enum-dict-member-unknown.err b/tests/qapi-=
schema/enum-dict-member-unknown.err
index 5df0236343..f8617ea179 100644
--- a/tests/qapi-schema/enum-dict-member-unknown.err
+++ b/tests/qapi-schema/enum-dict-member-unknown.err
@@ -1,3 +1,3 @@
-tests/qapi-schema/enum-dict-member-unknown.json: In enum 'MyEnum':
-tests/qapi-schema/enum-dict-member-unknown.json:2: 'data' member has unk=
nown key 'bad-key'
+enum-dict-member-unknown.json: In enum 'MyEnum':
+enum-dict-member-unknown.json:2: 'data' member has unknown key 'bad-key'
 Valid keys are 'if', 'name'.
diff --git a/tests/qapi-schema/enum-dict-member-unknown.exit b/tests/qapi=
-schema/enum-dict-member-unknown.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/enum-dict-member-unknown.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/enum-if-invalid.err b/tests/qapi-schema/en=
um-if-invalid.err
index 30c1f0e91c..0556dc967b 100644
--- a/tests/qapi-schema/enum-if-invalid.err
+++ b/tests/qapi-schema/enum-if-invalid.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/enum-if-invalid.json: In enum 'TestIfEnum':
-tests/qapi-schema/enum-if-invalid.json:2: 'if' condition of 'data' membe=
r 'bar' must be a string or a list of strings
+enum-if-invalid.json: In enum 'TestIfEnum':
+enum-if-invalid.json:2: 'if' condition of 'data' member 'bar' must be a =
string or a list of strings
diff --git a/tests/qapi-schema/enum-if-invalid.exit b/tests/qapi-schema/e=
num-if-invalid.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/enum-if-invalid.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/enum-int-member.err b/tests/qapi-schema/en=
um-int-member.err
index 27f06e334c..3a15294963 100644
--- a/tests/qapi-schema/enum-int-member.err
+++ b/tests/qapi-schema/enum-int-member.err
@@ -1 +1 @@
-tests/qapi-schema/enum-int-member.json:3:31: stray '1'
+enum-int-member.json:3:31: stray '1'
diff --git a/tests/qapi-schema/enum-int-member.exit b/tests/qapi-schema/e=
num-int-member.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/enum-int-member.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/enum-member-case.err b/tests/qapi-schema/e=
num-member-case.err
index e6b080c6e5..8b3aefe37a 100644
--- a/tests/qapi-schema/enum-member-case.err
+++ b/tests/qapi-schema/enum-member-case.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/enum-member-case.json: In enum 'NoWayThisWillGetWhitel=
isted':
-tests/qapi-schema/enum-member-case.json:4: 'data' member 'Value' uses up=
percase in name
+enum-member-case.json: In enum 'NoWayThisWillGetWhitelisted':
+enum-member-case.json:4: 'data' member 'Value' uses uppercase in name
diff --git a/tests/qapi-schema/enum-member-case.exit b/tests/qapi-schema/=
enum-member-case.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/enum-member-case.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/enum-missing-data.err b/tests/qapi-schema/=
enum-missing-data.err
index 4809b01f34..ec4bdae037 100644
--- a/tests/qapi-schema/enum-missing-data.err
+++ b/tests/qapi-schema/enum-missing-data.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/enum-missing-data.json: In enum 'MyEnum':
-tests/qapi-schema/enum-missing-data.json:2: enum misses key 'data'
+enum-missing-data.json: In enum 'MyEnum':
+enum-missing-data.json:2: enum misses key 'data'
diff --git a/tests/qapi-schema/enum-missing-data.exit b/tests/qapi-schema=
/enum-missing-data.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/enum-missing-data.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/enum-wrong-data.err b/tests/qapi-schema/en=
um-wrong-data.err
index ad5f0ce46f..a9f34481ba 100644
--- a/tests/qapi-schema/enum-wrong-data.err
+++ b/tests/qapi-schema/enum-wrong-data.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/enum-wrong-data.json: In enum 'MyEnum':
-tests/qapi-schema/enum-wrong-data.json:2: 'data' must be an array
+enum-wrong-data.json: In enum 'MyEnum':
+enum-wrong-data.json:2: 'data' must be an array
diff --git a/tests/qapi-schema/enum-wrong-data.exit b/tests/qapi-schema/e=
num-wrong-data.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/enum-wrong-data.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/escape-outside-string.err b/tests/qapi-sch=
ema/escape-outside-string.err
index 06f5f2ed55..c49fe0c285 100644
--- a/tests/qapi-schema/escape-outside-string.err
+++ b/tests/qapi-schema/escape-outside-string.err
@@ -1 +1 @@
-tests/qapi-schema/escape-outside-string.json:3:27: stray '\'
+escape-outside-string.json:3:27: stray '\'
diff --git a/tests/qapi-schema/event-boxed-empty.err b/tests/qapi-schema/=
event-boxed-empty.err
index 931c10b036..b3872cdab5 100644
--- a/tests/qapi-schema/event-boxed-empty.err
+++ b/tests/qapi-schema/event-boxed-empty.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/event-boxed-empty.json: In event 'FOO':
-tests/qapi-schema/event-boxed-empty.json:2: 'boxed': true requires 'data=
'
+event-boxed-empty.json: In event 'FOO':
+event-boxed-empty.json:2: 'boxed': true requires 'data'
diff --git a/tests/qapi-schema/event-boxed-empty.exit b/tests/qapi-schema=
/event-boxed-empty.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/event-boxed-empty.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/event-case.exit b/tests/qapi-schema/event-=
case.exit
deleted file mode 100644
index 573541ac97..0000000000
--- a/tests/qapi-schema/event-case.exit
+++ /dev/null
@@ -1 +0,0 @@
-0
diff --git a/tests/qapi-schema/event-member-invalid-dict.err b/tests/qapi=
-schema/event-member-invalid-dict.err
index 8406c43df7..c7a6a24305 100644
--- a/tests/qapi-schema/event-member-invalid-dict.err
+++ b/tests/qapi-schema/event-member-invalid-dict.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/event-member-invalid-dict.json: In event 'EVENT_A':
-tests/qapi-schema/event-member-invalid-dict.json:1: 'data' member 'a' mi=
sses key 'type'
+event-member-invalid-dict.json: In event 'EVENT_A':
+event-member-invalid-dict.json:1: 'data' member 'a' misses key 'type'
diff --git a/tests/qapi-schema/event-member-invalid-dict.exit b/tests/qap=
i-schema/event-member-invalid-dict.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/event-member-invalid-dict.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/event-nest-struct.err b/tests/qapi-schema/=
event-nest-struct.err
index 1a3254a73c..8c5f6ed311 100644
--- a/tests/qapi-schema/event-nest-struct.err
+++ b/tests/qapi-schema/event-nest-struct.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/event-nest-struct.json: In event 'EVENT_A':
-tests/qapi-schema/event-nest-struct.json:1: 'data' member 'a' should be =
a type name
+event-nest-struct.json: In event 'EVENT_A':
+event-nest-struct.json:1: 'data' member 'a' should be a type name
diff --git a/tests/qapi-schema/event-nest-struct.exit b/tests/qapi-schema=
/event-nest-struct.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/event-nest-struct.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/features-bad-type.err b/tests/qapi-schema/=
features-bad-type.err
index 30deb8b624..3c63591632 100644
--- a/tests/qapi-schema/features-bad-type.err
+++ b/tests/qapi-schema/features-bad-type.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/features-bad-type.json: In struct 'FeatureStruct0':
-tests/qapi-schema/features-bad-type.json:1: 'features' member requires a=
 string name
+features-bad-type.json: In struct 'FeatureStruct0':
+features-bad-type.json:1: 'features' member requires a string name
diff --git a/tests/qapi-schema/features-bad-type.exit b/tests/qapi-schema=
/features-bad-type.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/features-bad-type.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/features-duplicate-name.err b/tests/qapi-s=
chema/features-duplicate-name.err
index a99bbde737..0adbee6b0a 100644
--- a/tests/qapi-schema/features-duplicate-name.err
+++ b/tests/qapi-schema/features-duplicate-name.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/features-duplicate-name.json: In struct 'FeatureStruct=
0':
-tests/qapi-schema/features-duplicate-name.json:1: feature 'foo' collides=
 with feature 'foo'
+features-duplicate-name.json: In struct 'FeatureStruct0':
+features-duplicate-name.json:1: feature 'foo' collides with feature 'foo=
'
diff --git a/tests/qapi-schema/features-duplicate-name.exit b/tests/qapi-=
schema/features-duplicate-name.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/features-duplicate-name.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/features-if-invalid.err b/tests/qapi-schem=
a/features-if-invalid.err
index ffb39378af..f63b89535e 100644
--- a/tests/qapi-schema/features-if-invalid.err
+++ b/tests/qapi-schema/features-if-invalid.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/features-if-invalid.json: In struct 'Stru':
-tests/qapi-schema/features-if-invalid.json:2: 'if' condition of 'feature=
s' member 'f' must be a string or a list of strings
+features-if-invalid.json: In struct 'Stru':
+features-if-invalid.json:2: 'if' condition of 'features' member 'f' must=
 be a string or a list of strings
diff --git a/tests/qapi-schema/features-if-invalid.exit b/tests/qapi-sche=
ma/features-if-invalid.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/features-if-invalid.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/features-missing-name.err b/tests/qapi-sch=
ema/features-missing-name.err
index b8db328acc..ce02412d2e 100644
--- a/tests/qapi-schema/features-missing-name.err
+++ b/tests/qapi-schema/features-missing-name.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/features-missing-name.json: In struct 'FeatureStruct0'=
:
-tests/qapi-schema/features-missing-name.json:1: 'features' member misses=
 key 'name'
+features-missing-name.json: In struct 'FeatureStruct0':
+features-missing-name.json:1: 'features' member misses key 'name'
diff --git a/tests/qapi-schema/features-missing-name.exit b/tests/qapi-sc=
hema/features-missing-name.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/features-missing-name.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/features-name-bad-type.err b/tests/qapi-sc=
hema/features-name-bad-type.err
index 86db2c0ea2..4afcd5fdc3 100644
--- a/tests/qapi-schema/features-name-bad-type.err
+++ b/tests/qapi-schema/features-name-bad-type.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/features-name-bad-type.json: In struct 'FeatureStruct0=
':
-tests/qapi-schema/features-name-bad-type.json:1: 'features' member requi=
res a string name
+features-name-bad-type.json: In struct 'FeatureStruct0':
+features-name-bad-type.json:1: 'features' member requires a string name
diff --git a/tests/qapi-schema/features-name-bad-type.exit b/tests/qapi-s=
chema/features-name-bad-type.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/features-name-bad-type.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/features-no-list.err b/tests/qapi-schema/f=
eatures-no-list.err
index e493f85057..5cfaa3f216 100644
--- a/tests/qapi-schema/features-no-list.err
+++ b/tests/qapi-schema/features-no-list.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/features-no-list.json: In struct 'FeatureStruct0':
-tests/qapi-schema/features-no-list.json:1: 'features' must be an array
+features-no-list.json: In struct 'FeatureStruct0':
+features-no-list.json:1: 'features' must be an array
diff --git a/tests/qapi-schema/features-no-list.exit b/tests/qapi-schema/=
features-no-list.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/features-no-list.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/features-unknown-key.err b/tests/qapi-sche=
ma/features-unknown-key.err
index 22f5dcf4b0..13e359a216 100644
--- a/tests/qapi-schema/features-unknown-key.err
+++ b/tests/qapi-schema/features-unknown-key.err
@@ -1,3 +1,3 @@
-tests/qapi-schema/features-unknown-key.json: In struct 'FeatureStruct0':
-tests/qapi-schema/features-unknown-key.json:1: 'features' member has unk=
nown key 'colour'
+features-unknown-key.json: In struct 'FeatureStruct0':
+features-unknown-key.json:1: 'features' member has unknown key 'colour'
 Valid keys are 'if', 'name'.
diff --git a/tests/qapi-schema/features-unknown-key.exit b/tests/qapi-sch=
ema/features-unknown-key.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/features-unknown-key.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/flat-union-array-branch.err b/tests/qapi-s=
chema/flat-union-array-branch.err
index de07a7b32a..20a8ef1406 100644
--- a/tests/qapi-schema/flat-union-array-branch.err
+++ b/tests/qapi-schema/flat-union-array-branch.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/flat-union-array-branch.json: In union 'TestUnion':
-tests/qapi-schema/flat-union-array-branch.json:8: 'data' member 'value1'=
 cannot be an array
+flat-union-array-branch.json: In union 'TestUnion':
+flat-union-array-branch.json:8: 'data' member 'value1' cannot be an arra=
y
diff --git a/tests/qapi-schema/flat-union-array-branch.exit b/tests/qapi-=
schema/flat-union-array-branch.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/flat-union-array-branch.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/flat-union-bad-base.err b/tests/qapi-schem=
a/flat-union-bad-base.err
index 5da7602c20..e0a205a58c 100644
--- a/tests/qapi-schema/flat-union-bad-base.err
+++ b/tests/qapi-schema/flat-union-bad-base.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/flat-union-bad-base.json: In union 'TestUnion':
-tests/qapi-schema/flat-union-bad-base.json:8: member 'string' of type 'T=
estTypeA' collides with base member 'string'
+flat-union-bad-base.json: In union 'TestUnion':
+flat-union-bad-base.json:8: member 'string' of type 'TestTypeA' collides=
 with base member 'string'
diff --git a/tests/qapi-schema/flat-union-bad-base.exit b/tests/qapi-sche=
ma/flat-union-bad-base.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/flat-union-bad-base.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/flat-union-bad-discriminator.err b/tests/q=
api-schema/flat-union-bad-discriminator.err
index c1b4209ffd..b705439bd9 100644
--- a/tests/qapi-schema/flat-union-bad-discriminator.err
+++ b/tests/qapi-schema/flat-union-bad-discriminator.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/flat-union-bad-discriminator.json: In union 'TestUnion=
':
-tests/qapi-schema/flat-union-bad-discriminator.json:11: 'discriminator' =
requires a string name
+flat-union-bad-discriminator.json: In union 'TestUnion':
+flat-union-bad-discriminator.json:11: 'discriminator' requires a string =
name
diff --git a/tests/qapi-schema/flat-union-bad-discriminator.exit b/tests/=
qapi-schema/flat-union-bad-discriminator.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/flat-union-bad-discriminator.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/flat-union-base-any.err b/tests/qapi-schem=
a/flat-union-base-any.err
index 7ab3402396..c2d4de6a5d 100644
--- a/tests/qapi-schema/flat-union-base-any.err
+++ b/tests/qapi-schema/flat-union-base-any.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/flat-union-base-any.json: In union 'TestUnion':
-tests/qapi-schema/flat-union-base-any.json:8: 'base' requires a struct t=
ype, built-in type 'any' isn't
+flat-union-base-any.json: In union 'TestUnion':
+flat-union-base-any.json:8: 'base' requires a struct type, built-in type=
 'any' isn't
diff --git a/tests/qapi-schema/flat-union-base-any.exit b/tests/qapi-sche=
ma/flat-union-base-any.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/flat-union-base-any.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/flat-union-base-union.err b/tests/qapi-sch=
ema/flat-union-base-union.err
index 5db7b1e404..3b0087220e 100644
--- a/tests/qapi-schema/flat-union-base-union.err
+++ b/tests/qapi-schema/flat-union-base-union.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/flat-union-base-union.json: In union 'TestUnion':
-tests/qapi-schema/flat-union-base-union.json:14: 'base' requires a struc=
t type, union type 'UnionBase' isn't
+flat-union-base-union.json: In union 'TestUnion':
+flat-union-base-union.json:14: 'base' requires a struct type, union type=
 'UnionBase' isn't
diff --git a/tests/qapi-schema/flat-union-base-union.exit b/tests/qapi-sc=
hema/flat-union-base-union.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/flat-union-base-union.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/flat-union-clash-member.err b/tests/qapi-s=
chema/flat-union-clash-member.err
index 40f10681f8..07551e6ef5 100644
--- a/tests/qapi-schema/flat-union-clash-member.err
+++ b/tests/qapi-schema/flat-union-clash-member.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/flat-union-clash-member.json: In union 'TestUnion':
-tests/qapi-schema/flat-union-clash-member.json:11: member 'name' of type=
 'Branch1' collides with member 'name' of type 'Base'
+flat-union-clash-member.json: In union 'TestUnion':
+flat-union-clash-member.json:11: member 'name' of type 'Branch1' collide=
s with member 'name' of type 'Base'
diff --git a/tests/qapi-schema/flat-union-clash-member.exit b/tests/qapi-=
schema/flat-union-clash-member.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/flat-union-clash-member.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/flat-union-discriminator-bad-name.err b/te=
sts/qapi-schema/flat-union-discriminator-bad-name.err
index 2a0deb6a0e..28be49c31a 100644
--- a/tests/qapi-schema/flat-union-discriminator-bad-name.err
+++ b/tests/qapi-schema/flat-union-discriminator-bad-name.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/flat-union-discriminator-bad-name.json: In union 'MyUn=
ion':
-tests/qapi-schema/flat-union-discriminator-bad-name.json:6: discriminato=
r '*switch' is not a member of 'base'
+flat-union-discriminator-bad-name.json: In union 'MyUnion':
+flat-union-discriminator-bad-name.json:6: discriminator '*switch' is not=
 a member of 'base'
diff --git a/tests/qapi-schema/flat-union-discriminator-bad-name.exit b/t=
ests/qapi-schema/flat-union-discriminator-bad-name.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/flat-union-discriminator-bad-name.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/flat-union-empty.err b/tests/qapi-schema/f=
lat-union-empty.err
index 91a5b57f5d..89b0f25cb0 100644
--- a/tests/qapi-schema/flat-union-empty.err
+++ b/tests/qapi-schema/flat-union-empty.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/flat-union-empty.json: In union 'Union':
-tests/qapi-schema/flat-union-empty.json:4: union has no branches
+flat-union-empty.json: In union 'Union':
+flat-union-empty.json:4: union has no branches
diff --git a/tests/qapi-schema/flat-union-empty.exit b/tests/qapi-schema/=
flat-union-empty.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/flat-union-empty.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/flat-union-inline-invalid-dict.err b/tests=
/qapi-schema/flat-union-inline-invalid-dict.err
index d353bdd338..53e5416707 100644
--- a/tests/qapi-schema/flat-union-inline-invalid-dict.err
+++ b/tests/qapi-schema/flat-union-inline-invalid-dict.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/flat-union-inline-invalid-dict.json: In union 'TestUni=
on':
-tests/qapi-schema/flat-union-inline-invalid-dict.json:7: 'data' member '=
value1' misses key 'type'
+flat-union-inline-invalid-dict.json: In union 'TestUnion':
+flat-union-inline-invalid-dict.json:7: 'data' member 'value1' misses key=
 'type'
diff --git a/tests/qapi-schema/flat-union-inline-invalid-dict.exit b/test=
s/qapi-schema/flat-union-inline-invalid-dict.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/flat-union-inline-invalid-dict.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/flat-union-inline.err b/tests/qapi-schema/=
flat-union-inline.err
index 95b1e8c1b7..538283f5db 100644
--- a/tests/qapi-schema/flat-union-inline.err
+++ b/tests/qapi-schema/flat-union-inline.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/flat-union-inline.json: In union 'TestUnion':
-tests/qapi-schema/flat-union-inline.json:7: 'data' member 'value1' shoul=
d be a type name
+flat-union-inline.json: In union 'TestUnion':
+flat-union-inline.json:7: 'data' member 'value1' should be a type name
diff --git a/tests/qapi-schema/flat-union-inline.exit b/tests/qapi-schema=
/flat-union-inline.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/flat-union-inline.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/flat-union-int-branch.err b/tests/qapi-sch=
ema/flat-union-int-branch.err
index 416b696c8f..ae7f800603 100644
--- a/tests/qapi-schema/flat-union-int-branch.err
+++ b/tests/qapi-schema/flat-union-int-branch.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/flat-union-int-branch.json: In union 'TestUnion':
-tests/qapi-schema/flat-union-int-branch.json:8: branch 'value1' cannot u=
se built-in type 'int'
+flat-union-int-branch.json: In union 'TestUnion':
+flat-union-int-branch.json:8: branch 'value1' cannot use built-in type '=
int'
diff --git a/tests/qapi-schema/flat-union-int-branch.exit b/tests/qapi-sc=
hema/flat-union-int-branch.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/flat-union-int-branch.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/flat-union-invalid-branch-key.err b/tests/=
qapi-schema/flat-union-invalid-branch-key.err
index 6997b3387d..5576a25f9b 100644
--- a/tests/qapi-schema/flat-union-invalid-branch-key.err
+++ b/tests/qapi-schema/flat-union-invalid-branch-key.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/flat-union-invalid-branch-key.json: In union 'TestUnio=
n':
-tests/qapi-schema/flat-union-invalid-branch-key.json:13: branch 'value_w=
rong' is not a value of enum type 'TestEnum'
+flat-union-invalid-branch-key.json: In union 'TestUnion':
+flat-union-invalid-branch-key.json:13: branch 'value_wrong' is not a val=
ue of enum type 'TestEnum'
diff --git a/tests/qapi-schema/flat-union-invalid-branch-key.exit b/tests=
/qapi-schema/flat-union-invalid-branch-key.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/flat-union-invalid-branch-key.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/flat-union-invalid-discriminator.err b/tes=
ts/qapi-schema/flat-union-invalid-discriminator.err
index 3f80de3044..99bca2ddab 100644
--- a/tests/qapi-schema/flat-union-invalid-discriminator.err
+++ b/tests/qapi-schema/flat-union-invalid-discriminator.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/flat-union-invalid-discriminator.json: In union 'TestU=
nion':
-tests/qapi-schema/flat-union-invalid-discriminator.json:10: discriminato=
r 'enum_wrong' is not a member of 'base'
+flat-union-invalid-discriminator.json: In union 'TestUnion':
+flat-union-invalid-discriminator.json:10: discriminator 'enum_wrong' is =
not a member of 'base'
diff --git a/tests/qapi-schema/flat-union-invalid-discriminator.exit b/te=
sts/qapi-schema/flat-union-invalid-discriminator.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/flat-union-invalid-discriminator.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/flat-union-invalid-if-discriminator.err b/=
tests/qapi-schema/flat-union-invalid-if-discriminator.err
index d2b35be9ae..350f28da9d 100644
--- a/tests/qapi-schema/flat-union-invalid-if-discriminator.err
+++ b/tests/qapi-schema/flat-union-invalid-if-discriminator.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/flat-union-invalid-if-discriminator.json: In union 'Te=
stUnion':
-tests/qapi-schema/flat-union-invalid-if-discriminator.json:10: discrimin=
ator member 'enum1' of 'base' must not be conditional
+flat-union-invalid-if-discriminator.json: In union 'TestUnion':
+flat-union-invalid-if-discriminator.json:10: discriminator member 'enum1=
' of 'base' must not be conditional
diff --git a/tests/qapi-schema/flat-union-invalid-if-discriminator.exit b=
/tests/qapi-schema/flat-union-invalid-if-discriminator.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/flat-union-invalid-if-discriminator.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/flat-union-no-base.err b/tests/qapi-schema=
/flat-union-no-base.err
index a16f3231f1..9bd595bcfb 100644
--- a/tests/qapi-schema/flat-union-no-base.err
+++ b/tests/qapi-schema/flat-union-no-base.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/flat-union-no-base.json: In union 'TestUnion':
-tests/qapi-schema/flat-union-no-base.json:9: 'discriminator' requires 'b=
ase'
+flat-union-no-base.json: In union 'TestUnion':
+flat-union-no-base.json:9: 'discriminator' requires 'base'
diff --git a/tests/qapi-schema/flat-union-no-base.exit b/tests/qapi-schem=
a/flat-union-no-base.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/flat-union-no-base.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/flat-union-optional-discriminator.err b/te=
sts/qapi-schema/flat-union-optional-discriminator.err
index 49fbf5b04d..3d60a1b496 100644
--- a/tests/qapi-schema/flat-union-optional-discriminator.err
+++ b/tests/qapi-schema/flat-union-optional-discriminator.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/flat-union-optional-discriminator.json: In union 'MyUn=
ion':
-tests/qapi-schema/flat-union-optional-discriminator.json:6: discriminato=
r member 'switch' of base type 'Base' must not be optional
+flat-union-optional-discriminator.json: In union 'MyUnion':
+flat-union-optional-discriminator.json:6: discriminator member 'switch' =
of base type 'Base' must not be optional
diff --git a/tests/qapi-schema/flat-union-optional-discriminator.exit b/t=
ests/qapi-schema/flat-union-optional-discriminator.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/flat-union-optional-discriminator.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/flat-union-string-discriminator.err b/test=
s/qapi-schema/flat-union-string-discriminator.err
index fb499188aa..ff42c9728b 100644
--- a/tests/qapi-schema/flat-union-string-discriminator.err
+++ b/tests/qapi-schema/flat-union-string-discriminator.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/flat-union-string-discriminator.json: In union 'TestUn=
ion':
-tests/qapi-schema/flat-union-string-discriminator.json:13: discriminator=
 member 'kind' of base type 'TestBase' must be of enum type
+flat-union-string-discriminator.json: In union 'TestUnion':
+flat-union-string-discriminator.json:13: discriminator member 'kind' of =
base type 'TestBase' must be of enum type
diff --git a/tests/qapi-schema/flat-union-string-discriminator.exit b/tes=
ts/qapi-schema/flat-union-string-discriminator.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/flat-union-string-discriminator.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/funny-char.err b/tests/qapi-schema/funny-c=
har.err
index 132fac93ea..1c8abae2e0 100644
--- a/tests/qapi-schema/funny-char.err
+++ b/tests/qapi-schema/funny-char.err
@@ -1 +1 @@
-tests/qapi-schema/funny-char.json:2:36: stray ';'
+funny-char.json:2:36: stray ';'
diff --git a/tests/qapi-schema/funny-char.exit b/tests/qapi-schema/funny-=
char.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/funny-char.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/funny-word.err b/tests/qapi-schema/funny-w=
ord.err
index d9286c8962..a1d9ade970 100644
--- a/tests/qapi-schema/funny-word.err
+++ b/tests/qapi-schema/funny-word.err
@@ -1 +1 @@
-tests/qapi-schema/funny-word.json:1:3: stray 'command'
+funny-word.json:1:3: stray 'command'
diff --git a/tests/qapi-schema/funny-word.exit b/tests/qapi-schema/funny-=
word.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/funny-word.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/ident-with-escape.err b/tests/qapi-schema/=
ident-with-escape.err
index 1117283c81..3f6c1e423c 100644
--- a/tests/qapi-schema/ident-with-escape.err
+++ b/tests/qapi-schema/ident-with-escape.err
@@ -1 +1 @@
-tests/qapi-schema/ident-with-escape.json:3:3: unknown escape \u
+ident-with-escape.json:3:3: unknown escape \u
diff --git a/tests/qapi-schema/ident-with-escape.exit b/tests/qapi-schema=
/ident-with-escape.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/ident-with-escape.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/include-before-err.err b/tests/qapi-schema=
/include-before-err.err
index 098314bc49..16da03026f 100644
--- a/tests/qapi-schema/include-before-err.err
+++ b/tests/qapi-schema/include-before-err.err
@@ -1 +1 @@
-tests/qapi-schema/include-before-err.json:2:13: expected ':'
+include-before-err.json:2:13: expected ':'
diff --git a/tests/qapi-schema/include-before-err.exit b/tests/qapi-schem=
a/include-before-err.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/include-before-err.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/include-cycle.err b/tests/qapi-schema/incl=
ude-cycle.err
index 52028669b5..4c99f5642b 100644
--- a/tests/qapi-schema/include-cycle.err
+++ b/tests/qapi-schema/include-cycle.err
@@ -1,3 +1,3 @@
-In file included from tests/qapi-schema/include-cycle.json:1:
-In file included from tests/qapi-schema/include-cycle-b.json:1:
-tests/qapi-schema/include-cycle-c.json:1: inclusion loop for include-cyc=
le.json
+In file included from include-cycle.json:1:
+In file included from include-cycle-b.json:1:
+include-cycle-c.json:1: inclusion loop for include-cycle.json
diff --git a/tests/qapi-schema/include-cycle.exit b/tests/qapi-schema/inc=
lude-cycle.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/include-cycle.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/include-extra-junk.err b/tests/qapi-schema=
/include-extra-junk.err
index 854cec3ce3..1f7d2e1437 100644
--- a/tests/qapi-schema/include-extra-junk.err
+++ b/tests/qapi-schema/include-extra-junk.err
@@ -1 +1 @@
-tests/qapi-schema/include-extra-junk.json:3: invalid 'include' directive
+include-extra-junk.json:3: invalid 'include' directive
diff --git a/tests/qapi-schema/include-extra-junk.exit b/tests/qapi-schem=
a/include-extra-junk.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/include-extra-junk.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/include-nested-err.err b/tests/qapi-schema=
/include-nested-err.err
index 11928b4f7f..9eac9eaeea 100644
--- a/tests/qapi-schema/include-nested-err.err
+++ b/tests/qapi-schema/include-nested-err.err
@@ -1,2 +1,2 @@
-In file included from tests/qapi-schema/include-nested-err.json:1:
-tests/qapi-schema/missing-colon.json:1:10: expected ':'
+In file included from include-nested-err.json:1:
+missing-colon.json:1:10: expected ':'
diff --git a/tests/qapi-schema/include-nested-err.exit b/tests/qapi-schem=
a/include-nested-err.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/include-nested-err.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/include-no-file.err b/tests/qapi-schema/in=
clude-no-file.err
index 0a6c6bb4a9..3115a889fe 100644
--- a/tests/qapi-schema/include-no-file.err
+++ b/tests/qapi-schema/include-no-file.err
@@ -1 +1 @@
-tests/qapi-schema/include-no-file.json:1: can't read include file 'tests=
/qapi-schema/include-no-file-sub.json': No such file or directory
+include-no-file.json:1: can't read include file 'include-no-file-sub.jso=
n': No such file or directory
diff --git a/tests/qapi-schema/include-no-file.exit b/tests/qapi-schema/i=
nclude-no-file.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/include-no-file.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/include-non-file.err b/tests/qapi-schema/i=
nclude-non-file.err
index 65dd3c7c2c..ec8a331654 100644
--- a/tests/qapi-schema/include-non-file.err
+++ b/tests/qapi-schema/include-non-file.err
@@ -1 +1 @@
-tests/qapi-schema/include-non-file.json:1: value of 'include' must be a =
string
+include-non-file.json:1: value of 'include' must be a string
diff --git a/tests/qapi-schema/include-non-file.exit b/tests/qapi-schema/=
include-non-file.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/include-non-file.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/include-repetition.exit b/tests/qapi-schem=
a/include-repetition.exit
deleted file mode 100644
index 573541ac97..0000000000
--- a/tests/qapi-schema/include-repetition.exit
+++ /dev/null
@@ -1 +0,0 @@
-0
diff --git a/tests/qapi-schema/include-self-cycle.err b/tests/qapi-schema=
/include-self-cycle.err
index c84795d1dc..284b0d6f0e 100644
--- a/tests/qapi-schema/include-self-cycle.err
+++ b/tests/qapi-schema/include-self-cycle.err
@@ -1 +1 @@
-tests/qapi-schema/include-self-cycle.json:1: inclusion loop for include-=
self-cycle.json
+include-self-cycle.json:1: inclusion loop for include-self-cycle.json
diff --git a/tests/qapi-schema/include-self-cycle.exit b/tests/qapi-schem=
a/include-self-cycle.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/include-self-cycle.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/include-simple.exit b/tests/qapi-schema/in=
clude-simple.exit
deleted file mode 100644
index 573541ac97..0000000000
--- a/tests/qapi-schema/include-simple.exit
+++ /dev/null
@@ -1 +0,0 @@
-0
diff --git a/tests/qapi-schema/indented-expr.exit b/tests/qapi-schema/ind=
ented-expr.exit
deleted file mode 100644
index 573541ac97..0000000000
--- a/tests/qapi-schema/indented-expr.exit
+++ /dev/null
@@ -1 +0,0 @@
-0
diff --git a/tests/qapi-schema/leading-comma-list.err b/tests/qapi-schema=
/leading-comma-list.err
index cddf471f71..76eed2b5b3 100644
--- a/tests/qapi-schema/leading-comma-list.err
+++ b/tests/qapi-schema/leading-comma-list.err
@@ -1 +1 @@
-tests/qapi-schema/leading-comma-list.json:2:13: expected '{', '[', ']', =
string, boolean or 'null'
+leading-comma-list.json:2:13: expected '{', '[', ']', string, boolean or=
 'null'
diff --git a/tests/qapi-schema/leading-comma-list.exit b/tests/qapi-schem=
a/leading-comma-list.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/leading-comma-list.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/leading-comma-object.err b/tests/qapi-sche=
ma/leading-comma-object.err
index 2f3b193274..25f8b6ffd6 100644
--- a/tests/qapi-schema/leading-comma-object.err
+++ b/tests/qapi-schema/leading-comma-object.err
@@ -1 +1 @@
-tests/qapi-schema/leading-comma-object.json:1:3: expected string or '}'
+leading-comma-object.json:1:3: expected string or '}'
diff --git a/tests/qapi-schema/leading-comma-object.exit b/tests/qapi-sch=
ema/leading-comma-object.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/leading-comma-object.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/missing-colon.err b/tests/qapi-schema/miss=
ing-colon.err
index e642c7c549..d5fe235cb9 100644
--- a/tests/qapi-schema/missing-colon.err
+++ b/tests/qapi-schema/missing-colon.err
@@ -1 +1 @@
-tests/qapi-schema/missing-colon.json:1:10: expected ':'
+missing-colon.json:1:10: expected ':'
diff --git a/tests/qapi-schema/missing-colon.exit b/tests/qapi-schema/mis=
sing-colon.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/missing-colon.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/missing-comma-list.err b/tests/qapi-schema=
/missing-comma-list.err
index 5359499430..d0a790c2b3 100644
--- a/tests/qapi-schema/missing-comma-list.err
+++ b/tests/qapi-schema/missing-comma-list.err
@@ -1 +1 @@
-tests/qapi-schema/missing-comma-list.json:2:20: expected ',' or ']'
+missing-comma-list.json:2:20: expected ',' or ']'
diff --git a/tests/qapi-schema/missing-comma-list.exit b/tests/qapi-schem=
a/missing-comma-list.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/missing-comma-list.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/missing-comma-object.err b/tests/qapi-sche=
ma/missing-comma-object.err
index c9b02b0760..aa8efbc2f3 100644
--- a/tests/qapi-schema/missing-comma-object.err
+++ b/tests/qapi-schema/missing-comma-object.err
@@ -1 +1 @@
-tests/qapi-schema/missing-comma-object.json:2:3: expected ',' or '}'
+missing-comma-object.json:2:3: expected ',' or '}'
diff --git a/tests/qapi-schema/missing-comma-object.exit b/tests/qapi-sch=
ema/missing-comma-object.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/missing-comma-object.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/missing-type.err b/tests/qapi-schema/missi=
ng-type.err
index 19b7c495e7..5755386a18 100644
--- a/tests/qapi-schema/missing-type.err
+++ b/tests/qapi-schema/missing-type.err
@@ -1 +1 @@
-tests/qapi-schema/missing-type.json:2: expression is missing metatype
+missing-type.json:2: expression is missing metatype
diff --git a/tests/qapi-schema/missing-type.exit b/tests/qapi-schema/miss=
ing-type.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/missing-type.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/nested-struct-data-invalid-dict.err b/test=
s/qapi-schema/nested-struct-data-invalid-dict.err
index ed42d6323e..c044b2b17a 100644
--- a/tests/qapi-schema/nested-struct-data-invalid-dict.err
+++ b/tests/qapi-schema/nested-struct-data-invalid-dict.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/nested-struct-data-invalid-dict.json: In command 'foo'=
:
-tests/qapi-schema/nested-struct-data-invalid-dict.json:2: 'data' member =
'a' misses key 'type'
+nested-struct-data-invalid-dict.json: In command 'foo':
+nested-struct-data-invalid-dict.json:2: 'data' member 'a' misses key 'ty=
pe'
diff --git a/tests/qapi-schema/nested-struct-data-invalid-dict.exit b/tes=
ts/qapi-schema/nested-struct-data-invalid-dict.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/nested-struct-data-invalid-dict.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/nested-struct-data.err b/tests/qapi-schema=
/nested-struct-data.err
index b0ec410eb7..c7258a0182 100644
--- a/tests/qapi-schema/nested-struct-data.err
+++ b/tests/qapi-schema/nested-struct-data.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/nested-struct-data.json: In command 'foo':
-tests/qapi-schema/nested-struct-data.json:2: 'data' member 'a' should be=
 a type name
+nested-struct-data.json: In command 'foo':
+nested-struct-data.json:2: 'data' member 'a' should be a type name
diff --git a/tests/qapi-schema/nested-struct-data.exit b/tests/qapi-schem=
a/nested-struct-data.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/nested-struct-data.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/non-objects.err b/tests/qapi-schema/non-ob=
jects.err
index 9237af6939..3a4ea36966 100644
--- a/tests/qapi-schema/non-objects.err
+++ b/tests/qapi-schema/non-objects.err
@@ -1 +1 @@
-tests/qapi-schema/non-objects.json:1:1: expected '{'
+non-objects.json:1:1: expected '{'
diff --git a/tests/qapi-schema/non-objects.exit b/tests/qapi-schema/non-o=
bjects.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/non-objects.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/oob-test.err b/tests/qapi-schema/oob-test.=
err
index 3c2ba6e0fd..7b9a50b3d5 100644
--- a/tests/qapi-schema/oob-test.err
+++ b/tests/qapi-schema/oob-test.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/oob-test.json: In command 'oob-command-1':
-tests/qapi-schema/oob-test.json:2: flag 'allow-oob' may only use true va=
lue
+oob-test.json: In command 'oob-command-1':
+oob-test.json:2: flag 'allow-oob' may only use true value
diff --git a/tests/qapi-schema/oob-test.exit b/tests/qapi-schema/oob-test=
.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/oob-test.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/pragma-doc-required-crap.err b/tests/qapi-=
schema/pragma-doc-required-crap.err
index bcd981ada8..717062cb14 100644
--- a/tests/qapi-schema/pragma-doc-required-crap.err
+++ b/tests/qapi-schema/pragma-doc-required-crap.err
@@ -1 +1 @@
-tests/qapi-schema/pragma-doc-required-crap.json:3: pragma 'doc-required'=
 must be boolean
+pragma-doc-required-crap.json:3: pragma 'doc-required' must be boolean
diff --git a/tests/qapi-schema/pragma-doc-required-crap.exit b/tests/qapi=
-schema/pragma-doc-required-crap.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/pragma-doc-required-crap.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/pragma-extra-junk.err b/tests/qapi-schema/=
pragma-extra-junk.err
index 3ae48d3668..ba5cc23f56 100644
--- a/tests/qapi-schema/pragma-extra-junk.err
+++ b/tests/qapi-schema/pragma-extra-junk.err
@@ -1 +1 @@
-tests/qapi-schema/pragma-extra-junk.json:3: invalid 'pragma' directive
+pragma-extra-junk.json:3: invalid 'pragma' directive
diff --git a/tests/qapi-schema/pragma-extra-junk.exit b/tests/qapi-schema=
/pragma-extra-junk.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/pragma-extra-junk.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/pragma-name-case-whitelist-crap.err b/test=
s/qapi-schema/pragma-name-case-whitelist-crap.err
index 81f829ff36..fbea90d6c5 100644
--- a/tests/qapi-schema/pragma-name-case-whitelist-crap.err
+++ b/tests/qapi-schema/pragma-name-case-whitelist-crap.err
@@ -1 +1 @@
-tests/qapi-schema/pragma-name-case-whitelist-crap.json:3: pragma name-ca=
se-whitelist must be a list of strings
+pragma-name-case-whitelist-crap.json:3: pragma name-case-whitelist must =
be a list of strings
diff --git a/tests/qapi-schema/pragma-name-case-whitelist-crap.exit b/tes=
ts/qapi-schema/pragma-name-case-whitelist-crap.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/pragma-name-case-whitelist-crap.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/pragma-non-dict.err b/tests/qapi-schema/pr=
agma-non-dict.err
index 8221724b0a..802f1806c5 100644
--- a/tests/qapi-schema/pragma-non-dict.err
+++ b/tests/qapi-schema/pragma-non-dict.err
@@ -1 +1 @@
-tests/qapi-schema/pragma-non-dict.json:3: value of 'pragma' must be an o=
bject
+pragma-non-dict.json:3: value of 'pragma' must be an object
diff --git a/tests/qapi-schema/pragma-non-dict.exit b/tests/qapi-schema/p=
ragma-non-dict.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/pragma-non-dict.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/pragma-returns-whitelist-crap.err b/tests/=
qapi-schema/pragma-returns-whitelist-crap.err
index c0cae5de18..69784259df 100644
--- a/tests/qapi-schema/pragma-returns-whitelist-crap.err
+++ b/tests/qapi-schema/pragma-returns-whitelist-crap.err
@@ -1 +1 @@
-tests/qapi-schema/pragma-returns-whitelist-crap.json:3: pragma returns-w=
hitelist must be a list of strings
+pragma-returns-whitelist-crap.json:3: pragma returns-whitelist must be a=
 list of strings
diff --git a/tests/qapi-schema/pragma-returns-whitelist-crap.exit b/tests=
/qapi-schema/pragma-returns-whitelist-crap.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/pragma-returns-whitelist-crap.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/pragma-unknown.err b/tests/qapi-schema/pra=
gma-unknown.err
index f1335f0a0a..d99a772503 100644
--- a/tests/qapi-schema/pragma-unknown.err
+++ b/tests/qapi-schema/pragma-unknown.err
@@ -1 +1 @@
-tests/qapi-schema/pragma-unknown.json:1: unknown pragma 'no-such-pragma'
+pragma-unknown.json:1: unknown pragma 'no-such-pragma'
diff --git a/tests/qapi-schema/pragma-unknown.exit b/tests/qapi-schema/pr=
agma-unknown.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/pragma-unknown.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/qapi-schema-test.exit b/tests/qapi-schema/=
qapi-schema-test.exit
deleted file mode 100644
index 573541ac97..0000000000
--- a/tests/qapi-schema/qapi-schema-test.exit
+++ /dev/null
@@ -1 +0,0 @@
-0
diff --git a/tests/qapi-schema/quoted-structural-chars.err b/tests/qapi-s=
chema/quoted-structural-chars.err
index d8460a63a7..07d1561d1f 100644
--- a/tests/qapi-schema/quoted-structural-chars.err
+++ b/tests/qapi-schema/quoted-structural-chars.err
@@ -1 +1 @@
-tests/qapi-schema/quoted-structural-chars.json:1:1: expected '{'
+quoted-structural-chars.json:1:1: expected '{'
diff --git a/tests/qapi-schema/quoted-structural-chars.exit b/tests/qapi-=
schema/quoted-structural-chars.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/quoted-structural-chars.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/redefined-builtin.err b/tests/qapi-schema/=
redefined-builtin.err
index 47c8933759..58c7e42ffc 100644
--- a/tests/qapi-schema/redefined-builtin.err
+++ b/tests/qapi-schema/redefined-builtin.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/redefined-builtin.json: In struct 'size':
-tests/qapi-schema/redefined-builtin.json:2: built-in type 'size' is alre=
ady defined
+redefined-builtin.json: In struct 'size':
+redefined-builtin.json:2: built-in type 'size' is already defined
diff --git a/tests/qapi-schema/redefined-builtin.exit b/tests/qapi-schema=
/redefined-builtin.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/redefined-builtin.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/redefined-command.err b/tests/qapi-schema/=
redefined-command.err
index 54e366bbf3..888eea87ca 100644
--- a/tests/qapi-schema/redefined-command.err
+++ b/tests/qapi-schema/redefined-command.err
@@ -1,4 +1,4 @@
-tests/qapi-schema/redefined-command.json: In command 'foo':
-tests/qapi-schema/redefined-command.json:3: 'foo' is already defined
-tests/qapi-schema/redefined-command.json: In command 'foo':
-tests/qapi-schema/redefined-command.json:2: previous definition
+redefined-command.json: In command 'foo':
+redefined-command.json:3: 'foo' is already defined
+redefined-command.json: In command 'foo':
+redefined-command.json:2: previous definition
diff --git a/tests/qapi-schema/redefined-command.exit b/tests/qapi-schema=
/redefined-command.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/redefined-command.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/redefined-event.err b/tests/qapi-schema/re=
defined-event.err
index 606c6e4497..b1a6d99d2f 100644
--- a/tests/qapi-schema/redefined-event.err
+++ b/tests/qapi-schema/redefined-event.err
@@ -1,4 +1,4 @@
-tests/qapi-schema/redefined-event.json: In event 'EVENT_A':
-tests/qapi-schema/redefined-event.json:3: 'EVENT_A' is already defined
-tests/qapi-schema/redefined-event.json: In event 'EVENT_A':
-tests/qapi-schema/redefined-event.json:2: previous definition
+redefined-event.json: In event 'EVENT_A':
+redefined-event.json:3: 'EVENT_A' is already defined
+redefined-event.json: In event 'EVENT_A':
+redefined-event.json:2: previous definition
diff --git a/tests/qapi-schema/redefined-event.exit b/tests/qapi-schema/r=
edefined-event.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/redefined-event.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/redefined-type.err b/tests/qapi-schema/red=
efined-type.err
index 77786f98ae..b7103fc15f 100644
--- a/tests/qapi-schema/redefined-type.err
+++ b/tests/qapi-schema/redefined-type.err
@@ -1,4 +1,4 @@
-tests/qapi-schema/redefined-type.json: In enum 'foo':
-tests/qapi-schema/redefined-type.json:3: 'foo' is already defined
-tests/qapi-schema/redefined-type.json: In struct 'foo':
-tests/qapi-schema/redefined-type.json:2: previous definition
+redefined-type.json: In enum 'foo':
+redefined-type.json:3: 'foo' is already defined
+redefined-type.json: In struct 'foo':
+redefined-type.json:2: previous definition
diff --git a/tests/qapi-schema/redefined-type.exit b/tests/qapi-schema/re=
defined-type.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/redefined-type.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/reserved-command-q.err b/tests/qapi-schema=
/reserved-command-q.err
index 7f65cda02d..6fecbaa046 100644
--- a/tests/qapi-schema/reserved-command-q.err
+++ b/tests/qapi-schema/reserved-command-q.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/reserved-command-q.json: In command 'q-unix':
-tests/qapi-schema/reserved-command-q.json:5: command has an invalid name
+reserved-command-q.json: In command 'q-unix':
+reserved-command-q.json:5: command has an invalid name
diff --git a/tests/qapi-schema/reserved-command-q.exit b/tests/qapi-schem=
a/reserved-command-q.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/reserved-command-q.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/reserved-enum-q.err b/tests/qapi-schema/re=
served-enum-q.err
index e202f9ff7b..fc3c757874 100644
--- a/tests/qapi-schema/reserved-enum-q.err
+++ b/tests/qapi-schema/reserved-enum-q.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/reserved-enum-q.json: In enum 'Foo':
-tests/qapi-schema/reserved-enum-q.json:4: 'data' member 'q-Unix' has an =
invalid name
+reserved-enum-q.json: In enum 'Foo':
+reserved-enum-q.json:4: 'data' member 'q-Unix' has an invalid name
diff --git a/tests/qapi-schema/reserved-enum-q.exit b/tests/qapi-schema/r=
eserved-enum-q.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/reserved-enum-q.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/reserved-member-has.err b/tests/qapi-schem=
a/reserved-member-has.err
index c7ad721ad1..436e1749f2 100644
--- a/tests/qapi-schema/reserved-member-has.err
+++ b/tests/qapi-schema/reserved-member-has.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/reserved-member-has.json: In command 'oops':
-tests/qapi-schema/reserved-member-has.json:5: 'data' member 'has-a' uses=
 reserved name
+reserved-member-has.json: In command 'oops':
+reserved-member-has.json:5: 'data' member 'has-a' uses reserved name
diff --git a/tests/qapi-schema/reserved-member-has.exit b/tests/qapi-sche=
ma/reserved-member-has.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/reserved-member-has.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/reserved-member-q.err b/tests/qapi-schema/=
reserved-member-q.err
index 04078604fa..9ac8654a8b 100644
--- a/tests/qapi-schema/reserved-member-q.err
+++ b/tests/qapi-schema/reserved-member-q.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/reserved-member-q.json: In struct 'Foo':
-tests/qapi-schema/reserved-member-q.json:4: 'data' member 'q-unix' has a=
n invalid name
+reserved-member-q.json: In struct 'Foo':
+reserved-member-q.json:4: 'data' member 'q-unix' has an invalid name
diff --git a/tests/qapi-schema/reserved-member-q.exit b/tests/qapi-schema=
/reserved-member-q.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/reserved-member-q.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/reserved-member-u.err b/tests/qapi-schema/=
reserved-member-u.err
index 2e92c11ba5..231d552494 100644
--- a/tests/qapi-schema/reserved-member-u.err
+++ b/tests/qapi-schema/reserved-member-u.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/reserved-member-u.json: In struct 'Oops':
-tests/qapi-schema/reserved-member-u.json:7: 'data' member 'u' uses reser=
ved name
+reserved-member-u.json: In struct 'Oops':
+reserved-member-u.json:7: 'data' member 'u' uses reserved name
diff --git a/tests/qapi-schema/reserved-member-u.exit b/tests/qapi-schema=
/reserved-member-u.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/reserved-member-u.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/reserved-member-underscore.err b/tests/qap=
i-schema/reserved-member-underscore.err
index da62b48222..df3ab8a11a 100644
--- a/tests/qapi-schema/reserved-member-underscore.err
+++ b/tests/qapi-schema/reserved-member-underscore.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/reserved-member-underscore.json: In struct 'Oops':
-tests/qapi-schema/reserved-member-underscore.json:4: 'data' member '_oop=
s' has an invalid name
+reserved-member-underscore.json: In struct 'Oops':
+reserved-member-underscore.json:4: 'data' member '_oops' has an invalid =
name
diff --git a/tests/qapi-schema/reserved-member-underscore.exit b/tests/qa=
pi-schema/reserved-member-underscore.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/reserved-member-underscore.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/reserved-type-kind.err b/tests/qapi-schema=
/reserved-type-kind.err
index f8112cf92e..d8fb769f9d 100644
--- a/tests/qapi-schema/reserved-type-kind.err
+++ b/tests/qapi-schema/reserved-type-kind.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/reserved-type-kind.json: In enum 'UnionKind':
-tests/qapi-schema/reserved-type-kind.json:2: enum name should not end in=
 'Kind'
+reserved-type-kind.json: In enum 'UnionKind':
+reserved-type-kind.json:2: enum name should not end in 'Kind'
diff --git a/tests/qapi-schema/reserved-type-kind.exit b/tests/qapi-schem=
a/reserved-type-kind.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/reserved-type-kind.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/reserved-type-list.err b/tests/qapi-schema=
/reserved-type-list.err
index c6eee0585c..e09f5352f8 100644
--- a/tests/qapi-schema/reserved-type-list.err
+++ b/tests/qapi-schema/reserved-type-list.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/reserved-type-list.json: In struct 'FooList':
-tests/qapi-schema/reserved-type-list.json:5: struct name should not end =
in 'List'
+reserved-type-list.json: In struct 'FooList':
+reserved-type-list.json:5: struct name should not end in 'List'
diff --git a/tests/qapi-schema/reserved-type-list.exit b/tests/qapi-schem=
a/reserved-type-list.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/reserved-type-list.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/returns-alternate.err b/tests/qapi-schema/=
returns-alternate.err
index c1caf98c47..b6421a8917 100644
--- a/tests/qapi-schema/returns-alternate.err
+++ b/tests/qapi-schema/returns-alternate.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/returns-alternate.json: In command 'oops':
-tests/qapi-schema/returns-alternate.json:3: command's 'returns' cannot t=
ake alternate type 'Alt'
+returns-alternate.json: In command 'oops':
+returns-alternate.json:3: command's 'returns' cannot take alternate type=
 'Alt'
diff --git a/tests/qapi-schema/returns-alternate.exit b/tests/qapi-schema=
/returns-alternate.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/returns-alternate.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/returns-array-bad.err b/tests/qapi-schema/=
returns-array-bad.err
index 1b86777d8f..52712d139d 100644
--- a/tests/qapi-schema/returns-array-bad.err
+++ b/tests/qapi-schema/returns-array-bad.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/returns-array-bad.json: In command 'oops':
-tests/qapi-schema/returns-array-bad.json:2: 'returns': array type must c=
ontain single type name
+returns-array-bad.json: In command 'oops':
+returns-array-bad.json:2: 'returns': array type must contain single type=
 name
diff --git a/tests/qapi-schema/returns-array-bad.exit b/tests/qapi-schema=
/returns-array-bad.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/returns-array-bad.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/returns-dict.err b/tests/qapi-schema/retur=
ns-dict.err
index 52e4f3ad71..9b2d90c010 100644
--- a/tests/qapi-schema/returns-dict.err
+++ b/tests/qapi-schema/returns-dict.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/returns-dict.json: In command 'oops':
-tests/qapi-schema/returns-dict.json:2: 'returns' should be a type name
+returns-dict.json: In command 'oops':
+returns-dict.json:2: 'returns' should be a type name
diff --git a/tests/qapi-schema/returns-dict.exit b/tests/qapi-schema/retu=
rns-dict.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/returns-dict.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/returns-unknown.err b/tests/qapi-schema/re=
turns-unknown.err
index f0a989a175..bf59086d0c 100644
--- a/tests/qapi-schema/returns-unknown.err
+++ b/tests/qapi-schema/returns-unknown.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/returns-unknown.json: In command 'oops':
-tests/qapi-schema/returns-unknown.json:2: command's 'returns' uses unkno=
wn type 'NoSuchType'
+returns-unknown.json: In command 'oops':
+returns-unknown.json:2: command's 'returns' uses unknown type 'NoSuchTyp=
e'
diff --git a/tests/qapi-schema/returns-unknown.exit b/tests/qapi-schema/r=
eturns-unknown.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/returns-unknown.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/returns-whitelist.err b/tests/qapi-schema/=
returns-whitelist.err
index 5b0285220f..c6e46b9b86 100644
--- a/tests/qapi-schema/returns-whitelist.err
+++ b/tests/qapi-schema/returns-whitelist.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/returns-whitelist.json: In command 'no-way-this-will-g=
et-whitelisted':
-tests/qapi-schema/returns-whitelist.json:14: command's 'returns' cannot =
take array type ['int']
+returns-whitelist.json: In command 'no-way-this-will-get-whitelisted':
+returns-whitelist.json:14: command's 'returns' cannot take array type ['=
int']
diff --git a/tests/qapi-schema/returns-whitelist.exit b/tests/qapi-schema=
/returns-whitelist.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/returns-whitelist.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/string-code-point-127.err b/tests/qapi-sch=
ema/string-code-point-127.err
index b4fa2610a9..eb0d1c71a6 100644
--- a/tests/qapi-schema/string-code-point-127.err
+++ b/tests/qapi-schema/string-code-point-127.err
@@ -1 +1 @@
-tests/qapi-schema/string-code-point-127.json:2:14: funny character in st=
ring
+string-code-point-127.json:2:14: funny character in string
diff --git a/tests/qapi-schema/string-code-point-127.exit b/tests/qapi-sc=
hema/string-code-point-127.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/string-code-point-127.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/string-code-point-31.err b/tests/qapi-sche=
ma/string-code-point-31.err
index 0bb5ce37b8..ae969d6e10 100644
--- a/tests/qapi-schema/string-code-point-31.err
+++ b/tests/qapi-schema/string-code-point-31.err
@@ -1 +1 @@
-tests/qapi-schema/string-code-point-31.json:2:14: funny character in str=
ing
+string-code-point-31.json:2:14: funny character in string
diff --git a/tests/qapi-schema/string-code-point-31.exit b/tests/qapi-sch=
ema/string-code-point-31.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/string-code-point-31.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/struct-base-clash-deep.err b/tests/qapi-sc=
hema/struct-base-clash-deep.err
index 2b12b3c07f..79879681d9 100644
--- a/tests/qapi-schema/struct-base-clash-deep.err
+++ b/tests/qapi-schema/struct-base-clash-deep.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/struct-base-clash-deep.json: In struct 'Sub':
-tests/qapi-schema/struct-base-clash-deep.json:10: member 'name' collides=
 with member 'name' of type 'Base'
+struct-base-clash-deep.json: In struct 'Sub':
+struct-base-clash-deep.json:10: member 'name' collides with member 'name=
' of type 'Base'
diff --git a/tests/qapi-schema/struct-base-clash-deep.exit b/tests/qapi-s=
chema/struct-base-clash-deep.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/struct-base-clash-deep.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/struct-base-clash.err b/tests/qapi-schema/=
struct-base-clash.err
index 8c3ee1c435..46473947e6 100644
--- a/tests/qapi-schema/struct-base-clash.err
+++ b/tests/qapi-schema/struct-base-clash.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/struct-base-clash.json: In struct 'Sub':
-tests/qapi-schema/struct-base-clash.json:5: member 'name' collides with =
member 'name' of type 'Base'
+struct-base-clash.json: In struct 'Sub':
+struct-base-clash.json:5: member 'name' collides with member 'name' of t=
ype 'Base'
diff --git a/tests/qapi-schema/struct-base-clash.exit b/tests/qapi-schema=
/struct-base-clash.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/struct-base-clash.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/struct-data-invalid.err b/tests/qapi-schem=
a/struct-data-invalid.err
index aa868bf974..5ed4bec573 100644
--- a/tests/qapi-schema/struct-data-invalid.err
+++ b/tests/qapi-schema/struct-data-invalid.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/struct-data-invalid.json: In struct 'foo':
-tests/qapi-schema/struct-data-invalid.json:1: 'data' should be an object=
 or type name
+struct-data-invalid.json: In struct 'foo':
+struct-data-invalid.json:1: 'data' should be an object or type name
diff --git a/tests/qapi-schema/struct-data-invalid.exit b/tests/qapi-sche=
ma/struct-data-invalid.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/struct-data-invalid.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/struct-member-if-invalid.err b/tests/qapi-=
schema/struct-member-if-invalid.err
index 4c5983674b..42e7fdae3c 100644
--- a/tests/qapi-schema/struct-member-if-invalid.err
+++ b/tests/qapi-schema/struct-member-if-invalid.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/struct-member-if-invalid.json: In struct 'Stru':
-tests/qapi-schema/struct-member-if-invalid.json:2: 'if' condition of 'da=
ta' member 'member' must be a string or a list of strings
+struct-member-if-invalid.json: In struct 'Stru':
+struct-member-if-invalid.json:2: 'if' condition of 'data' member 'member=
' must be a string or a list of strings
diff --git a/tests/qapi-schema/struct-member-if-invalid.exit b/tests/qapi=
-schema/struct-member-if-invalid.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/struct-member-if-invalid.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/struct-member-invalid-dict.err b/tests/qap=
i-schema/struct-member-invalid-dict.err
index 46ec991c28..0621aecfbd 100644
--- a/tests/qapi-schema/struct-member-invalid-dict.err
+++ b/tests/qapi-schema/struct-member-invalid-dict.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/struct-member-invalid-dict.json: In struct 'foo':
-tests/qapi-schema/struct-member-invalid-dict.json:2: 'data' member '*a' =
misses key 'type'
+struct-member-invalid-dict.json: In struct 'foo':
+struct-member-invalid-dict.json:2: 'data' member '*a' misses key 'type'
diff --git a/tests/qapi-schema/struct-member-invalid-dict.exit b/tests/qa=
pi-schema/struct-member-invalid-dict.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/struct-member-invalid-dict.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/struct-member-invalid.err b/tests/qapi-sch=
ema/struct-member-invalid.err
index 92d4973832..9a2c934538 100644
--- a/tests/qapi-schema/struct-member-invalid.err
+++ b/tests/qapi-schema/struct-member-invalid.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/struct-member-invalid.json: In struct 'foo':
-tests/qapi-schema/struct-member-invalid.json:1: 'data' member 'a' should=
 be a type name
+struct-member-invalid.json: In struct 'foo':
+struct-member-invalid.json:1: 'data' member 'a' should be a type name
diff --git a/tests/qapi-schema/struct-member-invalid.exit b/tests/qapi-sc=
hema/struct-member-invalid.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/struct-member-invalid.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
old mode 100644
new mode 100755
index b0f770b9bd..42baa702b6
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -1,3 +1,4 @@
+#!/usr/bin/env python
 #
 # QAPI parser test harness
 #
@@ -11,7 +12,14 @@
 #
=20
 from __future__ import print_function
+import argparse
+import difflib
+import os
 import sys
+if sys.version_info[0] < 3:
+    from cStringIO import StringIO
+else:
+    from io import StringIO
 from qapi.common import QAPIError, QAPISchema, QAPISchemaVisitor
=20
=20
@@ -87,21 +95,102 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
             print('%sif %s' % (' ' * indent, ifcond))
=20
=20
-try:
-    schema =3D QAPISchema(sys.argv[1])
-except QAPIError as err:
-    print(err, file=3Dsys.stderr)
-    exit(1)
+def test_frontend(fname):
+    schema =3D QAPISchema(fname)
+    schema.visit(QAPISchemaTestVisitor())
=20
-schema.visit(QAPISchemaTestVisitor())
+    for doc in schema.docs:
+        if doc.symbol:
+            print('doc symbol=3D%s' % doc.symbol)
+        else:
+            print('doc freeform')
+        print('    body=3D\n%s' % doc.body.text)
+        for arg, section in doc.args.items():
+            print('    arg=3D%s\n%s' % (arg, section.text))
+        for section in doc.sections:
+            print('    section=3D%s\n%s' % (section.name, section.text))
=20
-for doc in schema.docs:
-    if doc.symbol:
-        print('doc symbol=3D%s' % doc.symbol)
+
+def test_and_diff(test_name, dir_name, update):
+    sys.stdout =3D StringIO()
+    try:
+        test_frontend(os.path.join(dir_name, test_name + '.json'))
+    except QAPIError as err:
+        if err.info.fname is None:
+            print("%s" % err, file=3Dsys.stderr)
+            return 2
+        errstr =3D str(err) + '\n'
+        if dir_name:
+            errstr =3D errstr.replace(dir_name + '/', '')
+        actual_err =3D errstr.splitlines(True)
     else:
-        print('doc freeform')
-    print('    body=3D\n%s' % doc.body.text)
-    for arg, section in doc.args.items():
-        print('    arg=3D%s\n%s' % (arg, section.text))
-    for section in doc.sections:
-        print('    section=3D%s\n%s' % (section.name, section.text))
+        actual_err =3D []
+    finally:
+        actual_out =3D sys.stdout.getvalue().splitlines(True)
+        sys.stdout.close()
+        sys.stdout =3D sys.__stdout__
+
+    mode =3D 'r+' if update else 'r'
+    try:
+        outfp =3D open(os.path.join(dir_name, test_name + '.out'), mode)
+        errfp =3D open(os.path.join(dir_name, test_name + '.err'), mode)
+        expected_out =3D outfp.readlines()
+        expected_err =3D errfp.readlines()
+    except IOError as err:
+        print("%s: can't open '%s': %s"
+              % (sys.argv[0], err.filename, err.strerror),
+              file=3Dsys.stderr)
+        return 2
+
+    if actual_out =3D=3D expected_out and actual_err =3D=3D expected_err=
:
+        return 0
+
+    print("%s %s" % (test_name, 'UPDATE' if update else 'FAIL'),
+          file=3Dsys.stderr)
+    out_diff =3D difflib.unified_diff(expected_out, actual_out, outfp.na=
me)
+    err_diff =3D difflib.unified_diff(expected_err, actual_err, errfp.na=
me)
+    sys.stdout.writelines(out_diff)
+    sys.stdout.writelines(err_diff)
+
+    if not update:
+        return 1
+
+    try:
+        outfp.truncate(0)
+        outfp.seek(0)
+        outfp.writelines(actual_out)
+        errfp.truncate(0)
+        errfp.seek(0)
+        errfp.writelines(actual_err)
+    except IOError as err:
+        print("%s: can't write '%s': %s"
+              % (sys.argv[0], err.filename, err.strerror),
+              file=3Dsys.stderr)
+        return 2
+
+    return 0
+
+
+def main(argv):
+    parser =3D argparse.ArgumentParser(
+        description=3D'QAPI schema tester')
+    parser.add_argument('-d', '--dir', action=3D'store', default=3D'',
+                        help=3D"directory containing tests")
+    parser.add_argument('-u', '--update', action=3D'store_true',
+                        help=3D"update expected test results")
+    parser.add_argument('tests', nargs=3D'*', metavar=3D'TEST', action=3D=
'store')
+    args =3D parser.parse_args()
+
+    status =3D 0
+    for t in args.tests:
+        (dir_name, base_name) =3D os.path.split(t)
+        dir_name =3D dir_name or args.dir
+        test_name =3D os.path.splitext(base_name)[0]
+        status |=3D test_and_diff(test_name, dir_name, args.update)
+
+    exit(status)
+
+
+if __name__ =3D=3D '__main__':
+    main(sys.argv)
+    exit(0)
diff --git a/tests/qapi-schema/trailing-comma-list.err b/tests/qapi-schem=
a/trailing-comma-list.err
index 167d688beb..ad2f2d7c97 100644
--- a/tests/qapi-schema/trailing-comma-list.err
+++ b/tests/qapi-schema/trailing-comma-list.err
@@ -1 +1 @@
-tests/qapi-schema/trailing-comma-list.json:2:36: expected '{', '[', stri=
ng, boolean or 'null'
+trailing-comma-list.json:2:36: expected '{', '[', string, boolean or 'nu=
ll'
diff --git a/tests/qapi-schema/trailing-comma-list.exit b/tests/qapi-sche=
ma/trailing-comma-list.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/trailing-comma-list.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/trailing-comma-object.err b/tests/qapi-sch=
ema/trailing-comma-object.err
index 186df0fa45..29aafc69cd 100644
--- a/tests/qapi-schema/trailing-comma-object.err
+++ b/tests/qapi-schema/trailing-comma-object.err
@@ -1 +1 @@
-tests/qapi-schema/trailing-comma-object.json:2:38: expected string
+trailing-comma-object.json:2:38: expected string
diff --git a/tests/qapi-schema/trailing-comma-object.exit b/tests/qapi-sc=
hema/trailing-comma-object.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/trailing-comma-object.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/type-bypass-bad-gen.err b/tests/qapi-schem=
a/type-bypass-bad-gen.err
index 1077651896..2ca95cd86d 100644
--- a/tests/qapi-schema/type-bypass-bad-gen.err
+++ b/tests/qapi-schema/type-bypass-bad-gen.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/type-bypass-bad-gen.json: In command 'foo':
-tests/qapi-schema/type-bypass-bad-gen.json:2: flag 'gen' may only use fa=
lse value
+type-bypass-bad-gen.json: In command 'foo':
+type-bypass-bad-gen.json:2: flag 'gen' may only use false value
diff --git a/tests/qapi-schema/type-bypass-bad-gen.exit b/tests/qapi-sche=
ma/type-bypass-bad-gen.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/type-bypass-bad-gen.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/unclosed-list.err b/tests/qapi-schema/uncl=
osed-list.err
index 6648a8e30b..aa2c430b22 100644
--- a/tests/qapi-schema/unclosed-list.err
+++ b/tests/qapi-schema/unclosed-list.err
@@ -1 +1 @@
-tests/qapi-schema/unclosed-list.json:1:20: expected ',' or ']'
+unclosed-list.json:1:20: expected ',' or ']'
diff --git a/tests/qapi-schema/unclosed-list.exit b/tests/qapi-schema/unc=
losed-list.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/unclosed-list.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/unclosed-object.err b/tests/qapi-schema/un=
closed-object.err
index 54d221e3a9..c08499b341 100644
--- a/tests/qapi-schema/unclosed-object.err
+++ b/tests/qapi-schema/unclosed-object.err
@@ -1 +1 @@
-tests/qapi-schema/unclosed-object.json:1:21: expected ',' or '}'
+unclosed-object.json:1:21: expected ',' or '}'
diff --git a/tests/qapi-schema/unclosed-object.exit b/tests/qapi-schema/u=
nclosed-object.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/unclosed-object.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/unclosed-string.err b/tests/qapi-schema/un=
closed-string.err
index 9439698fe0..175e192b24 100644
--- a/tests/qapi-schema/unclosed-string.err
+++ b/tests/qapi-schema/unclosed-string.err
@@ -1 +1 @@
-tests/qapi-schema/unclosed-string.json:1:11: missing terminating "'"
+unclosed-string.json:1:11: missing terminating "'"
diff --git a/tests/qapi-schema/unclosed-string.exit b/tests/qapi-schema/u=
nclosed-string.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/unclosed-string.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/union-base-empty.err b/tests/qapi-schema/u=
nion-base-empty.err
index b76542d47a..3630b341a6 100644
--- a/tests/qapi-schema/union-base-empty.err
+++ b/tests/qapi-schema/union-base-empty.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/union-base-empty.json: In union 'TestUnion':
-tests/qapi-schema/union-base-empty.json:5: discriminator 'type' is not a=
 member of 'base'
+union-base-empty.json: In union 'TestUnion':
+union-base-empty.json:5: discriminator 'type' is not a member of 'base'
diff --git a/tests/qapi-schema/union-base-empty.exit b/tests/qapi-schema/=
union-base-empty.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/union-base-empty.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/union-base-no-discriminator.err b/tests/qa=
pi-schema/union-base-no-discriminator.err
index f4c16a2c14..9cd5d11b0b 100644
--- a/tests/qapi-schema/union-base-no-discriminator.err
+++ b/tests/qapi-schema/union-base-no-discriminator.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/union-base-no-discriminator.json: In union 'TestUnion'=
:
-tests/qapi-schema/union-base-no-discriminator.json:11: 'base' requires '=
discriminator'
+union-base-no-discriminator.json: In union 'TestUnion':
+union-base-no-discriminator.json:11: 'base' requires 'discriminator'
diff --git a/tests/qapi-schema/union-base-no-discriminator.exit b/tests/q=
api-schema/union-base-no-discriminator.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/union-base-no-discriminator.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/union-branch-case.err b/tests/qapi-schema/=
union-branch-case.err
index a0684ae637..b1e9417303 100644
--- a/tests/qapi-schema/union-branch-case.err
+++ b/tests/qapi-schema/union-branch-case.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/union-branch-case.json: In union 'Uni':
-tests/qapi-schema/union-branch-case.json:2: 'data' member 'Branch' uses =
uppercase in name
+union-branch-case.json: In union 'Uni':
+union-branch-case.json:2: 'data' member 'Branch' uses uppercase in name
diff --git a/tests/qapi-schema/union-branch-case.exit b/tests/qapi-schema=
/union-branch-case.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/union-branch-case.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/union-branch-if-invalid.err b/tests/qapi-s=
chema/union-branch-if-invalid.err
index 14819bf8b8..dd4518233e 100644
--- a/tests/qapi-schema/union-branch-if-invalid.err
+++ b/tests/qapi-schema/union-branch-if-invalid.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/union-branch-if-invalid.json: In union 'Uni':
-tests/qapi-schema/union-branch-if-invalid.json:4: 'if' condition '' of '=
data' member 'branch1' makes no sense
+union-branch-if-invalid.json: In union 'Uni':
+union-branch-if-invalid.json:4: 'if' condition '' of 'data' member 'bran=
ch1' makes no sense
diff --git a/tests/qapi-schema/union-branch-if-invalid.exit b/tests/qapi-=
schema/union-branch-if-invalid.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/union-branch-if-invalid.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/union-branch-invalid-dict.err b/tests/qapi=
-schema/union-branch-invalid-dict.err
index 2967cd6260..8137c5a767 100644
--- a/tests/qapi-schema/union-branch-invalid-dict.err
+++ b/tests/qapi-schema/union-branch-invalid-dict.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/union-branch-invalid-dict.json: In union 'UnionInvalid=
Branch':
-tests/qapi-schema/union-branch-invalid-dict.json:2: 'data' member 'integ=
er' misses key 'type'
+union-branch-invalid-dict.json: In union 'UnionInvalidBranch':
+union-branch-invalid-dict.json:2: 'data' member 'integer' misses key 'ty=
pe'
diff --git a/tests/qapi-schema/union-branch-invalid-dict.exit b/tests/qap=
i-schema/union-branch-invalid-dict.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/union-branch-invalid-dict.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/union-clash-branches.err b/tests/qapi-sche=
ma/union-clash-branches.err
index 931399f076..73bbc2cabd 100644
--- a/tests/qapi-schema/union-clash-branches.err
+++ b/tests/qapi-schema/union-clash-branches.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/union-clash-branches.json: In union 'TestUnion':
-tests/qapi-schema/union-clash-branches.json:4: branch 'a_b' collides wit=
h branch 'a-b'
+union-clash-branches.json: In union 'TestUnion':
+union-clash-branches.json:4: branch 'a_b' collides with branch 'a-b'
diff --git a/tests/qapi-schema/union-clash-branches.exit b/tests/qapi-sch=
ema/union-clash-branches.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/union-clash-branches.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/union-empty.err b/tests/qapi-schema/union-=
empty.err
index 35c0d62eb0..59788c94ce 100644
--- a/tests/qapi-schema/union-empty.err
+++ b/tests/qapi-schema/union-empty.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/union-empty.json: In union 'Union':
-tests/qapi-schema/union-empty.json:2: union has no branches
+union-empty.json: In union 'Union':
+union-empty.json:2: union has no branches
diff --git a/tests/qapi-schema/union-empty.exit b/tests/qapi-schema/union=
-empty.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/union-empty.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/union-invalid-base.err b/tests/qapi-schema=
/union-invalid-base.err
index 10fecf0b56..a804028438 100644
--- a/tests/qapi-schema/union-invalid-base.err
+++ b/tests/qapi-schema/union-invalid-base.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/union-invalid-base.json: In union 'TestUnion':
-tests/qapi-schema/union-invalid-base.json:8: 'base' requires a struct ty=
pe, built-in type 'int' isn't
+union-invalid-base.json: In union 'TestUnion':
+union-invalid-base.json:8: 'base' requires a struct type, built-in type =
'int' isn't
diff --git a/tests/qapi-schema/union-invalid-base.exit b/tests/qapi-schem=
a/union-invalid-base.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/union-invalid-base.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/union-optional-branch.err b/tests/qapi-sch=
ema/union-optional-branch.err
index 9f24274923..b33f111de4 100644
--- a/tests/qapi-schema/union-optional-branch.err
+++ b/tests/qapi-schema/union-optional-branch.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/union-optional-branch.json: In union 'Union':
-tests/qapi-schema/union-optional-branch.json:2: 'data' member '*a' has a=
n invalid name
+union-optional-branch.json: In union 'Union':
+union-optional-branch.json:2: 'data' member '*a' has an invalid name
diff --git a/tests/qapi-schema/union-optional-branch.exit b/tests/qapi-sc=
hema/union-optional-branch.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/union-optional-branch.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/union-unknown.err b/tests/qapi-schema/unio=
n-unknown.err
index a7f340ddca..7aba9f94da 100644
--- a/tests/qapi-schema/union-unknown.err
+++ b/tests/qapi-schema/union-unknown.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/union-unknown.json: In union 'Union':
-tests/qapi-schema/union-unknown.json:2: union uses unknown type 'Missing=
Type'
+union-unknown.json: In union 'Union':
+union-unknown.json:2: union uses unknown type 'MissingType'
diff --git a/tests/qapi-schema/union-unknown.exit b/tests/qapi-schema/uni=
on-unknown.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/union-unknown.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/unknown-escape.err b/tests/qapi-schema/unk=
nown-escape.err
index e24bbaf046..759a5990d8 100644
--- a/tests/qapi-schema/unknown-escape.err
+++ b/tests/qapi-schema/unknown-escape.err
@@ -1 +1 @@
-tests/qapi-schema/unknown-escape.json:3:21: unknown escape \x
+unknown-escape.json:3:21: unknown escape \x
diff --git a/tests/qapi-schema/unknown-escape.exit b/tests/qapi-schema/un=
known-escape.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/unknown-escape.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/unknown-expr-key.err b/tests/qapi-schema/u=
nknown-expr-key.err
index be9f99c4ef..c5f395bf79 100644
--- a/tests/qapi-schema/unknown-expr-key.err
+++ b/tests/qapi-schema/unknown-expr-key.err
@@ -1,3 +1,3 @@
-tests/qapi-schema/unknown-expr-key.json: In struct 'bar':
-tests/qapi-schema/unknown-expr-key.json:2: struct has unknown keys 'bogu=
s', 'phony'
+unknown-expr-key.json: In struct 'bar':
+unknown-expr-key.json:2: struct has unknown keys 'bogus', 'phony'
 Valid keys are 'base', 'data', 'features', 'if', 'struct'.
diff --git a/tests/qapi-schema/unknown-expr-key.exit b/tests/qapi-schema/=
unknown-expr-key.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/unknown-expr-key.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
--=20
2.21.0


