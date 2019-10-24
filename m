Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54447CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:58:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DB1221872
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHFqzvS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB1221872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNcgp-0000Rg-Rg
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNcKd-0003g0-6p
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNcKb-00062h-ID
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51200
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNcKb-00062I-Di
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571920508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hmKmwiIl0XnTJvtIV2JlOi+M6+bPyXoNP5yMw43orPk=;
 b=dHFqzvS1FnupA9DpbVGEIphPG8v6D7MVs56NBDE+bjTeabdcbKyp3YR7qmsb4v5PBzN58J
 JqiJM5BMAGCplO3h2XRW1t85XRwjQK7CS7+0qjzeAtCXHWyfcUjaG6wJICL25YHC7bqXMn
 580z6TkgQ0AMDGGnYR4nlzxtf4sBJRc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-JHZ6giRqPqSFuzukaj2f8A-1; Thu, 24 Oct 2019 08:35:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BB661800D6B;
 Thu, 24 Oct 2019 12:35:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E0B61001B3F;
 Thu, 24 Oct 2019 12:35:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EFDD91138619; Thu, 24 Oct 2019 14:34:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 00/19] Configurable policy for handling deprecated
 interfaces
Date: Thu, 24 Oct 2019 14:34:39 +0200
Message-Id: <20191024123458.13505-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: JHZ6giRqPqSFuzukaj2f8A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: libvir-list@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series is RFC because it's incomplete, and the warning idea in
PATCH 18 is half-baked.  I'm soliciting feed back from the management
application crowd: is this going into a useful direction?

The series adresses only deprecated commands and events.  Good enough
to demonstrate the ideas, I think.  A complete solution should
additionally cover arguments and return values.  Feels feasible to me.

New option -compat deprecated-input=3D<in-policy>,deprecated-output=3Dout-p=
olicy
configures the policy.  Available input policies:

* accept: Accept deprecated commands with a warning (default)
* reject: Reject deprecated commands
* crash: Crash on deprecated command

Available output policies:

* accept: Emit deprecated events (default)
* hide: Suppress deprecated events

See also last item of
    Subject: Minutes of KVM Forum BoF on deprecating stuff
    Date: Fri, 26 Oct 2018 16:03:51 +0200
    Message-ID: <87mur0ls8o.fsf@dusky.pond.sub.org>
    https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg05828.html


Markus Armbruster (19):
  tests/test-qmp-cmds: Factor out qmp_dispatch() test helpers
  tests/test-qmp-cmds: Check responses more thoroughly
  tests/test-qmp-cmds: Simplify test data setup
  tests/test-qmp-event: Simplify test data setup
  tests/test-qmp-event: Use qobject_is_equal()
  tests/test-qmp-event: Check event is actually emitted
  qapi: Add feature flags to remaining definitions
  qapi: Consistently put @features parameter right after @ifcond
  qapi: Inline do_qmp_dispatch() into qmp_dispatch()
  qapi: Simplify how qmp_dispatch() deals with QCO_NO_SUCCESS_RESP
  qapi: Simplify how qmp_dispatch() gets the request ID
  qapi: Replace qmp_dispatch()'s TODO comment by an explanation
  qapi: New special feature flag "deprecated"
  qemu-options: New -compat to set policy for "funny" interfaces
  qapi: Mark deprecated QMP commands with feature 'deprecated'
  qapi: Implement -compat deprecated-input=3Dreject for commands
  qapi: Implement -compat deprecated-input=3Dcrash for commands
  qapi: Include a warning in the response to a deprecated command
  qapi: Implement -compat deprecated-output=3Dhide for events

 docs/devel/qapi-code-gen.txt                  |  21 +-
 tests/qapi-schema/doc-good.texi               |  32 ++-
 qapi/common.json                              |  48 ++++
 qapi/introspect.json                          |  28 ++-
 qapi/machine.json                             |  24 +-
 qapi/migration.json                           |  36 ++-
 qapi/misc.json                                |  25 +-
 include/qapi/compat-policy.h                  |  20 ++
 include/qapi/qmp/dispatch.h                   |   1 +
 qapi/qmp-dispatch.c                           | 140 +++++++-----
 tests/test-qmp-cmds.c                         | 216 +++++++++++-------
 tests/test-qmp-event.c                        | 181 ++++-----------
 vl.c                                          |  17 ++
 qemu-options.hx                               |  24 ++
 scripts/qapi/commands.py                      |  16 +-
 scripts/qapi/doc.py                           |  16 +-
 scripts/qapi/events.py                        |  16 +-
 scripts/qapi/expr.py                          |  11 +-
 scripts/qapi/introspect.py                    |  41 ++--
 scripts/qapi/schema.py                        | 138 ++++++-----
 scripts/qapi/types.py                         |   8 +-
 scripts/qapi/visit.py                         |   8 +-
 tests/Makefile.include                        |   1 +
 tests/qapi-schema/alternate-base.err          |   2 +-
 tests/qapi-schema/doc-good.json               |  18 +-
 tests/qapi-schema/doc-good.out                |  20 +-
 .../qapi-schema/features-deprecated-type.err  |   2 +
 .../qapi-schema/features-deprecated-type.json |   3 +
 .../qapi-schema/features-deprecated-type.out  |   0
 tests/qapi-schema/qapi-schema-test.json       |  31 ++-
 tests/qapi-schema/qapi-schema-test.out        |  29 ++-
 tests/qapi-schema/test-qapi.py                |  19 +-
 32 files changed, 731 insertions(+), 461 deletions(-)
 create mode 100644 include/qapi/compat-policy.h
 create mode 100644 tests/qapi-schema/features-deprecated-type.err
 create mode 100644 tests/qapi-schema/features-deprecated-type.json
 create mode 100644 tests/qapi-schema/features-deprecated-type.out

--=20
2.21.0


