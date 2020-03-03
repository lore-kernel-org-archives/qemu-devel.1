Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E150C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 16:37:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69A9420863
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 16:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RWJoNocb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A9420863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9AXg-000787-Gt
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 11:37:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j9AVy-0004Tx-90
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 11:35:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j9AVw-00035i-9A
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 11:35:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26322
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j9AVw-00035G-3i
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 11:35:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583253323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VCkw8TmGB1PJa9cGgegVrhURaYkQ9tG3kmuzwLsYUGs=;
 b=RWJoNocbsSJ8dQ0+61OSq75TNECt2IDm8kCE2tuxtd/px84xVg6+go27QiJ3c9a3Ed3MDf
 OxZf2/fnCQj6sqZHWJrS2UM/B34hscKHvo7tg2sGxErJLk2YyHucl3x5/1Ps5XRuux2QZc
 OcaXwhcwD9XiYd5Wf066y9Gf/8+lpkc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-s8f1vOgFMGe4xuW2n5Kfpw-1; Tue, 03 Mar 2020 11:35:11 -0500
X-MC-Unique: s8f1vOgFMGe4xuW2n5Kfpw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 886A118CA244;
 Tue,  3 Mar 2020 16:35:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A1AD5D9C9;
 Tue,  3 Mar 2020 16:35:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B023F11386A6; Tue,  3 Mar 2020 17:35:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/30] Configurable policy for handling deprecated
 interfaces
Date: Tue,  3 Mar 2020 17:34:35 +0100
Message-Id: <20200303163505.32041-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: libvir-list@redhat.com, berrange@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: <20200227144531.24309-1-armbru@redhat.com>

This series extends QMP introspection to cover deprecation.
Additionally, new option -compat lets you configure what to do when
deprecated interfaces get used.  This is intended for testing users of
the management interfaces.  It is experimental.

-compat deprecated-input=3D<in-policy> configures what to do when
deprecated input is received.  Available policies:

* accept: Accept deprecated commands and arguments (default)
* reject: Reject them
* crash: Crash

-compat deprecated-output=3D<out-policy> configures what to do when
deprecated output is sent.  Available output policies:

* accept: Emit deprecated command results and events (default)
* hide: Suppress them

For now, -compat covers only deprecated syntactic aspects of QMP.  We
may want to extend it to cover semantic aspects, CLI, and experimental
features.

PATCH 01-04: Documentation fixes
PATCH 05-10: Test improvements
PATCH 11-24: Add feature flags to remaining user-defined types and to
      =09     struct members
PATCH 25-26: New special feature 'deprecated', visible in
      =09     introspection
PATCH 27-30: New -compat to set policy for handling stuff marked with
      =09     feature 'deprecated'

Comparison to RFC (24 Oct 2019):
* Cover arguments and results in addition to commands and events
* Half-baked "[RFC PATCH 18/19] qapi: Include a warning in the
  response to a deprecated command" dropped

See also last item of
    Subject: Minutes of KVM Forum BoF on deprecating stuff
    Date: Fri, 26 Oct 2018 16:03:51 +0200
    Message-ID: <87mur0ls8o.fsf@dusky.pond.sub.org>
    https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg05828.html

Markus Armbruster (30):
  qemu-doc: Belatedly document QMP command arg & result deprecation
  qapi: Belatedly update doc comment for @wait deprecation
  docs/devel/qapi-code-gen: Clarify allow-oob introspection
  docs/devel/qapi-code-gen: Document 'features' introspection
  tests/test-qmp-cmds: Factor out qmp_dispatch() test helpers
  tests/test-qmp-cmds: Check responses more thoroughly
  tests/test-qmp-cmds: Simplify test data setup
  tests/test-qmp-event: Simplify test data setup
  tests/test-qmp-event: Use qobject_is_equal()
  tests/test-qmp-event: Check event is actually emitted
  qapi/schema: Clean up around QAPISchemaEntity.connect_doc()
  qapi: Add feature flags to remaining definitions
  qapi: Consistently put @features parameter right after @ifcond
  qapi/introspect: Rename *qlit* to reduce confusion
  qapi/introspect: Factor out _make_tree()
  qapi/schema: Change _make_features() to a take feature list
  qapi/schema: Reorder classes so related ones are together
  qapi/schema: Rename QAPISchemaObjectType{Variant,Variants}
  qapi/schema: Call QAPIDoc.connect_member() in just one place
  qapi: Add feature flags to struct members
  qapi: Inline do_qmp_dispatch() into qmp_dispatch()
  qapi: Simplify how qmp_dispatch() deals with QCO_NO_SUCCESS_RESP
  qapi: Simplify how qmp_dispatch() gets the request ID
  qapi: Replace qmp_dispatch()'s TODO comment by an explanation
  qapi: New special feature flag "deprecated"
  qapi: Mark deprecated QMP parts with feature 'deprecated'
  qemu-options: New -compat to set policy for deprecated interfaces
  qapi: Implement -compat deprecated-output=3Dhide
  qapi: Implement -compat deprecated-input=3Dreject
  qapi: New -compat deprecated-input=3Dcrash

 docs/devel/qapi-code-gen.txt                  |  79 ++-
 qemu-deprecated.texi                          |  38 +-
 tests/qapi-schema/doc-good.texi               |  32 ++
 qapi/block-core.json                          |  69 ++-
 qapi/block.json                               |   9 +-
 qapi/char.json                                |   1 +
 qapi/compat.json                              |  52 ++
 qapi/control.json                             |  11 +-
 qapi/introspect.json                          |  26 +-
 qapi/machine.json                             |  34 +-
 qapi/migration.json                           |  36 +-
 qapi/misc.json                                |  13 +-
 qapi/qapi-schema.json                         |   1 +
 include/qapi/compat-policy.h                  |  20 +
 include/qapi/qmp/dispatch.h                   |   1 +
 include/qapi/qobject-input-visitor.h          |   9 +
 include/qapi/qobject-output-visitor.h         |   9 +
 include/qapi/visitor-impl.h                   |   3 +
 include/qapi/visitor.h                        |   9 +
 qapi/qapi-visit-core.c                        |   9 +
 qapi/qmp-dispatch.c                           | 137 ++---
 qapi/qobject-input-visitor.c                  |  29 ++
 qapi/qobject-output-visitor.c                 |  20 +
 softmmu/vl.c                                  |  17 +
 tests/test-qmp-cmds.c                         | 249 +++++----
 tests/test-qmp-event.c                        | 183 ++-----
 qapi/Makefile.objs                            |   8 +-
 qapi/trace-events                             |   1 +
 qemu-options.hx                               |  23 +
 scripts/qapi/commands.py                      |  20 +-
 scripts/qapi/doc.py                           |  16 +-
 scripts/qapi/events.py                        |  16 +-
 scripts/qapi/expr.py                          |  14 +-
 scripts/qapi/introspect.py                    | 104 ++--
 scripts/qapi/schema.py                        | 488 ++++++++++--------
 scripts/qapi/types.py                         |   8 +-
 scripts/qapi/visit.py                         |  28 +-
 tests/Makefile.include                        |   1 +
 tests/qapi-schema/alternate-base.err          |   2 +-
 tests/qapi-schema/doc-good.json               |  22 +-
 tests/qapi-schema/doc-good.out                |  18 +
 .../qapi-schema/features-deprecated-type.err  |   2 +
 .../qapi-schema/features-deprecated-type.json |   3 +
 .../qapi-schema/features-deprecated-type.out  |   0
 tests/qapi-schema/qapi-schema-test.json       |  48 +-
 tests/qapi-schema/qapi-schema-test.out        |  46 +-
 tests/qapi-schema/test-qapi.py                |  26 +-
 47 files changed, 1259 insertions(+), 731 deletions(-)
 create mode 100644 qapi/compat.json
 create mode 100644 include/qapi/compat-policy.h
 create mode 100644 tests/qapi-schema/features-deprecated-type.err
 create mode 100644 tests/qapi-schema/features-deprecated-type.json
 create mode 100644 tests/qapi-schema/features-deprecated-type.out

--=20
2.21.1


