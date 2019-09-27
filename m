Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4C7C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 15:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 438E62075D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 15:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438E62075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDrvO-0005lk-Ip
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 11:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iDqa8-0001D6-GN
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:46:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iDqa4-00061o-UY
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:46:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52996)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iDqa4-00061A-K3
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:46:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CF4B4C001F03;
 Fri, 27 Sep 2019 13:46:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CFA2760606;
 Fri, 27 Sep 2019 13:46:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 611B5113864E; Fri, 27 Sep 2019 15:46:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/26] qapi: Pay back some frontend technical debt
Date: Fri, 27 Sep 2019 15:46:13 +0200
Message-Id: <20190927134639.4284-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 27 Sep 2019 13:46:43 +0000 (UTC)
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
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When we introduced the QAPISchema intermediate representation (commit
ac88219a6c7), we took a shortcut: we left check_exprs() & friends
alone instead of moving the semantic checks to their proper place.
Time to finish this job.  Topped off with error message gardening.

v2:
* PATCH 22: New
* PATCH 03,26: Commit message typos [Eric]
* PATCH 06: Accidental file additions dropped [Eric]
* PATCH 06,07,12,16,21: More consistent line breaks in raise operand
  [Eric]
* PATCH 21: Improve check_name_str() messages [Eric]
  Reuse args in check_command(), check_event() [Eric]
  R-by dropped

Markus Armbruster (26):
  qapi: Tighten QAPISchemaFOO.check() assertions
  qapi: Rename .owner to .defined_in
  qapi: New QAPISourceInfo, replacing dict
  qapi: Prefix frontend errors with an "in definition" line
  qapi: Clean up member name case checking
  qapi: Change frontend error messages to start with lower case
  qapi: Improve reporting of member name clashes
  qapi: Reorder check_FOO() parameters for consistency
  qapi: Improve reporting of invalid name errors
  qapi: Use check_name_str() where it suffices
  qapi: Report invalid '*' prefix like any other invalid name
  qapi: Move check for reserved names out of add_name()
  qapi: Make check_type()'s array case a bit more obvious
  qapi: Plumb info to the QAPISchemaMember
  qapi: Inline check_name() into check_union()
  qapi: Move context-sensitive checking to the proper place
  qapi: Move context-free checking to the proper place
  qapi: Improve reporting of invalid 'if' errors
  qapi: Improve reporting of invalid flags
  qapi: Improve reporting of missing / unknown definition keys
  qapi: Avoid redundant definition references in error messages
  qapi: Improve reporting of invalid 'if' further
  qapi: Eliminate check_keys(), rename check_known_keys()
  qapi: Improve reporting of missing documentation comment
  qapi: Improve reporting of redefinition
  qapi: Improve source file read error handling

 qapi/qapi-schema.json                         |    2 +-
 scripts/qapi/common.py                        | 1052 +++++++++--------
 scripts/qapi/events.py                        |    2 +-
 tests/qapi-schema/allow-preconfig-test.err    |    3 +-
 tests/qapi-schema/alternate-any.err           |    3 +-
 tests/qapi-schema/alternate-array.err         |    3 +-
 tests/qapi-schema/alternate-base.err          |    3 +-
 .../alternate-branch-if-invalid.err           |    3 +-
 tests/qapi-schema/alternate-clash.err         |    3 +-
 .../alternate-conflict-bool-string.err        |    3 +-
 tests/qapi-schema/alternate-conflict-dict.err |    3 +-
 .../alternate-conflict-enum-bool.err          |    3 +-
 .../alternate-conflict-enum-int.err           |    3 +-
 .../alternate-conflict-num-string.err         |    3 +-
 .../qapi-schema/alternate-conflict-string.err |    3 +-
 tests/qapi-schema/alternate-empty.err         |    3 +-
 tests/qapi-schema/alternate-invalid-dict.err  |    3 +-
 tests/qapi-schema/alternate-nested.err        |    3 +-
 tests/qapi-schema/alternate-unknown.err       |    3 +-
 tests/qapi-schema/args-alternate.err          |    3 +-
 tests/qapi-schema/args-any.err                |    3 +-
 tests/qapi-schema/args-array-empty.err        |    3 +-
 tests/qapi-schema/args-array-unknown.err      |    3 +-
 tests/qapi-schema/args-bad-boxed.err          |    3 +-
 tests/qapi-schema/args-boxed-anon.err         |    3 +-
 tests/qapi-schema/args-boxed-string.err       |    3 +-
 tests/qapi-schema/args-int.err                |    3 +-
 tests/qapi-schema/args-invalid.err            |    3 +-
 tests/qapi-schema/args-member-array-bad.err   |    3 +-
 tests/qapi-schema/args-member-case.err        |    3 +-
 tests/qapi-schema/args-member-case.json       |    2 +-
 tests/qapi-schema/args-member-unknown.err     |    3 +-
 tests/qapi-schema/args-name-clash.err         |    3 +-
 tests/qapi-schema/args-union.err              |    3 +-
 tests/qapi-schema/args-unknown.err            |    3 +-
 tests/qapi-schema/bad-base.err                |    3 +-
 tests/qapi-schema/bad-data.err                |    3 +-
 tests/qapi-schema/bad-ident.err               |    3 +-
 tests/qapi-schema/bad-if-empty-list.err       |    3 +-
 tests/qapi-schema/bad-if-empty.err            |    3 +-
 tests/qapi-schema/bad-if-list.err             |    3 +-
 tests/qapi-schema/bad-if.err                  |    3 +-
 tests/qapi-schema/bad-type-bool.err           |    2 +-
 tests/qapi-schema/bad-type-dict.err           |    2 +-
 tests/qapi-schema/bad-type-int.err            |    2 +-
 tests/qapi-schema/base-cycle-direct.err       |    3 +-
 tests/qapi-schema/base-cycle-indirect.err     |    3 +-
 tests/qapi-schema/command-int.err             |    3 +-
 .../qapi-schema/doc-bad-alternate-member.err  |    2 +-
 tests/qapi-schema/doc-bad-command-arg.err     |    2 +-
 tests/qapi-schema/doc-bad-symbol.err          |    3 +-
 tests/qapi-schema/doc-bad-union-member.err    |    2 +-
 tests/qapi-schema/doc-before-include.err      |    2 +-
 tests/qapi-schema/doc-before-pragma.err       |    2 +-
 tests/qapi-schema/doc-duplicated-return.err   |    2 +-
 tests/qapi-schema/doc-duplicated-since.err    |    2 +-
 tests/qapi-schema/doc-empty-arg.err           |    2 +-
 tests/qapi-schema/doc-empty-section.err       |    2 +-
 tests/qapi-schema/doc-empty-symbol.err        |    2 +-
 tests/qapi-schema/doc-invalid-end.err         |    2 +-
 tests/qapi-schema/doc-invalid-end2.err        |    2 +-
 tests/qapi-schema/doc-invalid-start.err       |    2 +-
 tests/qapi-schema/doc-missing-colon.err       |    2 +-
 tests/qapi-schema/doc-missing-expr.err        |    2 +-
 tests/qapi-schema/doc-missing-space.err       |    2 +-
 tests/qapi-schema/doc-missing.err             |    3 +-
 tests/qapi-schema/doc-no-symbol.err           |    2 +-
 tests/qapi-schema/double-type.err             |    3 +-
 tests/qapi-schema/duplicate-key.err           |    2 +-
 tests/qapi-schema/enum-bad-member.err         |    3 +-
 tests/qapi-schema/enum-bad-name.err           |    3 +-
 tests/qapi-schema/enum-bad-prefix.err         |    3 +-
 tests/qapi-schema/enum-clash-member.err       |    3 +-
 .../qapi-schema/enum-dict-member-unknown.err  |    3 +-
 tests/qapi-schema/enum-if-invalid.err         |    3 +-
 tests/qapi-schema/enum-int-member.err         |    2 +-
 tests/qapi-schema/enum-member-case.err        |    3 +-
 tests/qapi-schema/enum-missing-data.err       |    3 +-
 tests/qapi-schema/enum-wrong-data.err         |    3 +-
 tests/qapi-schema/escape-outside-string.err   |    2 +-
 tests/qapi-schema/event-boxed-empty.err       |    3 +-
 .../qapi-schema/event-member-invalid-dict.err |    3 +-
 tests/qapi-schema/event-nest-struct.err       |    3 +-
 tests/qapi-schema/features-bad-type.err       |    3 +-
 tests/qapi-schema/features-duplicate-name.err |    3 +-
 tests/qapi-schema/features-if-invalid.err     |    3 +-
 tests/qapi-schema/features-missing-name.err   |    3 +-
 tests/qapi-schema/features-name-bad-type.err  |    3 +-
 tests/qapi-schema/features-no-list.err        |    3 +-
 tests/qapi-schema/features-unknown-key.err    |    3 +-
 tests/qapi-schema/flat-union-array-branch.err |    3 +-
 tests/qapi-schema/flat-union-bad-base.err     |    3 +-
 .../flat-union-bad-discriminator.err          |    3 +-
 tests/qapi-schema/flat-union-base-any.err     |    3 +-
 tests/qapi-schema/flat-union-base-union.err   |    3 +-
 tests/qapi-schema/flat-union-clash-member.err |    3 +-
 .../flat-union-discriminator-bad-name.err     |    3 +-
 .../flat-union-discriminator-bad-name.json    |    1 -
 tests/qapi-schema/flat-union-empty.err        |    3 +-
 .../flat-union-inline-invalid-dict.err        |    3 +-
 tests/qapi-schema/flat-union-inline.err       |    3 +-
 tests/qapi-schema/flat-union-int-branch.err   |    3 +-
 .../flat-union-invalid-branch-key.err         |    3 +-
 .../flat-union-invalid-discriminator.err      |    3 +-
 .../flat-union-invalid-if-discriminator.err   |    3 +-
 tests/qapi-schema/flat-union-no-base.err      |    3 +-
 .../flat-union-optional-discriminator.err     |    3 +-
 .../flat-union-optional-discriminator.json    |    1 -
 .../flat-union-string-discriminator.err       |    3 +-
 tests/qapi-schema/funny-char.err              |    2 +-
 tests/qapi-schema/funny-word.err              |    2 +-
 tests/qapi-schema/ident-with-escape.err       |    2 +-
 tests/qapi-schema/include-before-err.err      |    2 +-
 tests/qapi-schema/include-cycle.err           |    2 +-
 tests/qapi-schema/include-extra-junk.err      |    2 +-
 tests/qapi-schema/include-nested-err.err      |    2 +-
 tests/qapi-schema/include-no-file.err         |    2 +-
 tests/qapi-schema/include-non-file.err        |    2 +-
 tests/qapi-schema/include-self-cycle.err      |    2 +-
 tests/qapi-schema/leading-comma-list.err      |    2 +-
 tests/qapi-schema/leading-comma-object.err    |    2 +-
 tests/qapi-schema/missing-colon.err           |    2 +-
 tests/qapi-schema/missing-comma-list.err      |    2 +-
 tests/qapi-schema/missing-comma-object.err    |    2 +-
 tests/qapi-schema/missing-type.err            |    2 +-
 .../nested-struct-data-invalid-dict.err       |    3 +-
 tests/qapi-schema/nested-struct-data.err      |    3 +-
 tests/qapi-schema/non-objects.err             |    2 +-
 tests/qapi-schema/oob-test.err                |    3 +-
 .../qapi-schema/pragma-doc-required-crap.err  |    2 +-
 tests/qapi-schema/pragma-extra-junk.err       |    2 +-
 .../pragma-name-case-whitelist-crap.err       |    2 +-
 tests/qapi-schema/pragma-non-dict.err         |    2 +-
 .../pragma-returns-whitelist-crap.err         |    2 +-
 tests/qapi-schema/pragma-unknown.err          |    2 +-
 tests/qapi-schema/quoted-structural-chars.err |    2 +-
 tests/qapi-schema/redefined-builtin.err       |    3 +-
 tests/qapi-schema/redefined-command.err       |    5 +-
 tests/qapi-schema/redefined-event.err         |    5 +-
 tests/qapi-schema/redefined-type.err          |    5 +-
 tests/qapi-schema/reserved-command-q.err      |    3 +-
 tests/qapi-schema/reserved-enum-q.err         |    3 +-
 tests/qapi-schema/reserved-member-has.err     |    3 +-
 tests/qapi-schema/reserved-member-q.err       |    3 +-
 tests/qapi-schema/reserved-member-u.err       |    3 +-
 .../reserved-member-underscore.err            |    3 +-
 tests/qapi-schema/reserved-type-kind.err      |    3 +-
 tests/qapi-schema/reserved-type-list.err      |    3 +-
 tests/qapi-schema/returns-alternate.err       |    3 +-
 tests/qapi-schema/returns-array-bad.err       |    3 +-
 tests/qapi-schema/returns-dict.err            |    3 +-
 tests/qapi-schema/returns-unknown.err         |    3 +-
 tests/qapi-schema/returns-whitelist.err       |    3 +-
 tests/qapi-schema/string-code-point-127.err   |    2 +-
 tests/qapi-schema/string-code-point-31.err    |    2 +-
 tests/qapi-schema/struct-base-clash-deep.err  |    3 +-
 tests/qapi-schema/struct-base-clash.err       |    3 +-
 tests/qapi-schema/struct-data-invalid.err     |    3 +-
 .../qapi-schema/struct-member-if-invalid.err  |    3 +-
 .../struct-member-invalid-dict.err            |    3 +-
 tests/qapi-schema/struct-member-invalid.err   |    3 +-
 tests/qapi-schema/trailing-comma-list.err     |    2 +-
 tests/qapi-schema/trailing-comma-object.err   |    2 +-
 tests/qapi-schema/type-bypass-bad-gen.err     |    3 +-
 tests/qapi-schema/unclosed-list.err           |    2 +-
 tests/qapi-schema/unclosed-object.err         |    2 +-
 tests/qapi-schema/unclosed-string.err         |    2 +-
 tests/qapi-schema/union-base-empty.err        |    3 +-
 .../union-base-no-discriminator.err           |    3 +-
 tests/qapi-schema/union-branch-case.err       |    3 +-
 tests/qapi-schema/union-branch-case.json      |    4 +-
 tests/qapi-schema/union-branch-if-invalid.err |    3 +-
 .../qapi-schema/union-branch-invalid-dict.err |    3 +-
 tests/qapi-schema/union-clash-branches.err    |    3 +-
 tests/qapi-schema/union-empty.err             |    3 +-
 tests/qapi-schema/union-invalid-base.err      |    3 +-
 tests/qapi-schema/union-optional-branch.err   |    3 +-
 tests/qapi-schema/union-unknown.err           |    3 +-
 tests/qapi-schema/union-unknown.json          |    2 +-
 tests/qapi-schema/unknown-escape.err          |    2 +-
 tests/qapi-schema/unknown-expr-key.err        |    3 +-
 181 files changed, 842 insertions(+), 694 deletions(-)

--=20
2.21.0


