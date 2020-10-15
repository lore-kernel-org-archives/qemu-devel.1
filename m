Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F3FC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 17:02:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7681622210
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 17:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OluS92nC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7681622210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT6eU-00064A-AK
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 13:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kT6V2-0002a1-Aw
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:53:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29323)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kT6V0-0001Ts-Be
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602780785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5bDOVT8w2FtTvJ/chV5aSaKe2r3ugkDuQIUh8P3i/lg=;
 b=OluS92nCotuDb2k1kPGVshIAEGIgUqbJGE41sZThLWXSzacjcCvoDBrYiyq+qKgE53k7yG
 mj5VQFuIsOOAu2kf66R0VNU60Cw5ChAtBqBRe2oajvk+49sV7S6xfNg9P9TDrDA9rBJJhh
 ZLh40r7FoIufxqWBHTCwv5+osd90R5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-EoCu1OmqN_-INhkTJjCaKA-1; Thu, 15 Oct 2020 12:53:03 -0400
X-MC-Unique: EoCu1OmqN_-INhkTJjCaKA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D7E08D4428;
 Thu, 15 Oct 2020 16:53:02 +0000 (UTC)
Received: from localhost (unknown [10.36.110.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2037D76676;
 Thu, 15 Oct 2020 16:52:57 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 0/9] qapi: untie 'if' conditions from C preprocessor
Date: Thu, 15 Oct 2020 20:52:46 +0400
Message-Id: <20201015165255.1573897-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: jsnow@redhat.com, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>=0D

Hi,=0D
=0D
This series makes the 'if' conditions less liberal, by formalizing a simple=
=0D
expression tree based on bare boolean logic of configure option identifiers=
.=0D
=0D
(this will allow to express conditions in Rust in my QAPI-Rust PoC series, =
but=0D
it is worth a standalone post)=0D
=0D
This is based on John Snow QAPI cleanup branch:=0D
https://gitlab.com/jsnow/qemu/-/tree/python-qapi-cleanup-pt6=0D
=0D
thanks=0D
=0D
Marc-Andr=C3=A9 Lureau (9):=0D
  qapi: replace List[str] by IfCond=0D
  qapi: move gen_if/gen_endif to IfCond=0D
  qapi: start building an 'if' predicate tree=0D
  qapi: introduce IfPredicateList and IfAny=0D
  qapi: add IfNot=0D
  qapi: normalize 'if' condition to IfPredicate=0D
  qapi: convert 'if' C expressions to literal form=0D
  qapi: make 'if' condition strings simple identifiers=0D
  docs: update the documentation about schema configuration=0D
=0D
 docs/devel/qapi-code-gen.txt                  |  32 ++---=0D
 docs/sphinx/qapidoc.py                        |   6 +-=0D
 qapi/block-core.json                          |  16 +--=0D
 qapi/char.json                                |   8 +-=0D
 qapi/machine-target.json                      |  28 +++--=0D
 qapi/migration.json                           |  10 +-=0D
 qapi/misc-target.json                         |  35 ++++--=0D
 qapi/ui.json                                  |  48 ++++----=0D
 scripts/qapi/commands.py                      |   4 +-=0D
 scripts/qapi/common.py                        | 113 +++++++++++++++---=0D
 scripts/qapi/events.py                        |   4 +-=0D
 scripts/qapi/expr.py                          |  55 +++++----=0D
 scripts/qapi/gen.py                           |  15 ++-=0D
 scripts/qapi/introspect.py                    |  27 ++---=0D
 scripts/qapi/schema.py                        |  91 +++++++-------=0D
 scripts/qapi/types.py                         |  33 +++--=0D
 scripts/qapi/visit.py                         |  23 ++--=0D
 .../alternate-branch-if-invalid.err           |   2 +-=0D
 tests/qapi-schema/bad-if-empty.err            |   2 +-=0D
 tests/qapi-schema/bad-if-list.err             |   2 +-=0D
 tests/qapi-schema/bad-if.err                  |   3 +-=0D
 tests/qapi-schema/bad-if.json                 |   2 +-=0D
 tests/qapi-schema/doc-good.json               |   6 +-=0D
 tests/qapi-schema/doc-good.out                |  12 +-=0D
 tests/qapi-schema/enum-if-invalid.err         |   3 +-=0D
 tests/qapi-schema/features-if-invalid.err     |   2 +-=0D
 tests/qapi-schema/features-missing-name.json  |   2 +-=0D
 tests/qapi-schema/qapi-schema-test.json       |  55 +++++----=0D
 tests/qapi-schema/qapi-schema-test.out        |  63 +++++-----=0D
 .../qapi-schema/struct-member-if-invalid.err  |   2 +-=0D
 tests/qapi-schema/union-branch-if-invalid.err |   2 +-=0D
 tests/test-qmp-cmds.c                         |   1 +=0D
 32 files changed, 423 insertions(+), 284 deletions(-)=0D
=0D
--=20=0D
2.28.0=0D
=0D


