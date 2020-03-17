Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFDBC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:13:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87A582076B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3DY9aDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A582076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEB6G-0006zr-OL
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 08:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEAok-0008UE-Hs
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEAoi-0007kW-QB
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:30 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:30402)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEAoi-0007iV-KP
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584446128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=slU8dcyqFr+FZoZuBz/UpDyrlVwuxE3bBm1UKV0w8Lc=;
 b=e3DY9aDAq84eMrpPePAQ3frOHyekRCCb2EkfjnTogUnXK+tEBdDEX0c/i2vx5Qn3CfswSU
 9b5LU+LRyuUrgL49kdI19aig531Qd3aAbxG5+4K+pxh3qZPcfzNjVGarzKQLbWzQya3GrU
 WAygGk777ExJwEE6qsZjIxRClGOuD8k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-Bl60_3NHMHertcMQrArz7w-1; Tue, 17 Mar 2020 07:55:24 -0400
X-MC-Unique: Bl60_3NHMHertcMQrArz7w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 946728010EA;
 Tue, 17 Mar 2020 11:55:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 66DA6953A5;
 Tue, 17 Mar 2020 11:55:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EBF701138404; Tue, 17 Mar 2020 12:54:59 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/34] Configurable policy for handling deprecated
 interfaces
Date: Tue, 17 Mar 2020 12:54:25 +0100
Message-Id: <20200317115459.31821-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, libvir-list@redhat.com,
 mdroth@linux.vnet.ibm.com, marcandre.lureau@gmail.com, libguestfs@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
PATCH 27-34: New -compat to set policy for handling stuff marked with
      =09     feature 'deprecated'

v4:
PATCH 05+07: Temporary memory leak plugged [Marc-Andr=C3=A9]
PATCH 23: Rewritten [Marc-Andr=C3=A9]
PATCH 24: Comment typo [Marc-Andr=C3=A9]
PATCH 30: Memory leaks plugged

v3:
* Rebased, non-trivial conflicts in PATCH 01+26+27+34 due to RST
  conversion and code motion
* PATCH 28-29: Old PATCH 28 split up to ease review
* PATCH 30-31: New
* PATCH 32-33: Old PATCH 29 split up to ease review

Comparison to RFC (24 Oct 2019):
* Cover arguments and results in addition to commands and events
* Half-baked "[RFC PATCH 18/19] qapi: Include a warning in the
  response to a deprecated command" dropped

See also last item of
    Subject: Minutes of KVM Forum BoF on deprecating stuff
    Date: Fri, 26 Oct 2018 16:03:51 +0200
    Message-ID: <87mur0ls8o.fsf@dusky.pond.sub.org>
    https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg05828.html

Cc: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Cc: libguestfs@redhat.com
Cc: libvir-list@redhat.com
Cc: Daniel P. Berrange <berrange@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>

Markus Armbruster (34):
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
  qapi: Implement deprecated-output=3Dhide for QMP command results
  qapi: Implement deprecated-output=3Dhide for QMP events
  qapi: Implement deprecated-output=3Dhide for QMP event data
  qapi: Implement deprecated-output=3Dhide for QMP introspection
  qapi: Implement deprecated-input=3Dreject for QMP commands
  qapi: Implement deprecated-input=3Dreject for QMP command arguments
  qapi: New -compat deprecated-input=3Dcrash

 docs/devel/qapi-code-gen.txt                  |  79 ++-
 docs/system/deprecated.rst                    |  48 +-
 tests/qapi-schema/doc-good.texi               |  32 ++
 qapi/block-core.json                          |  48 +-
 qapi/block.json                               |  30 +-
 qapi/char.json                                |   1 +
 qapi/compat.json                              |  52 ++
 qapi/control.json                             |  11 +-
 qapi/introspect.json                          |  28 +-
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
 monitor/monitor-internal.h                    |   3 -
 monitor/misc.c                                |   2 -
 monitor/qmp-cmds-control.c                    | 102 +++-
 qapi/qapi-visit-core.c                        |   9 +
 qapi/qmp-dispatch.c                           | 149 +++---
 qapi/qobject-input-visitor.c                  |  29 ++
 qapi/qobject-output-visitor.c                 |  20 +
 qemu-storage-daemon.c                         |   2 -
 softmmu/vl.c                                  |  17 +
 tests/test-qmp-cmds.c                         | 249 +++++----
 tests/test-qmp-event.c                        | 203 +++-----
 qapi/Makefile.objs                            |   8 +-
 qapi/trace-events                             |   1 +
 qemu-options.hx                               |  22 +
 scripts/qapi/commands.py                      |  20 +-
 scripts/qapi/doc.py                           |  16 +-
 scripts/qapi/events.py                        |  24 +-
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
 tests/qapi-schema/qapi-schema-test.json       |  51 +-
 tests/qapi-schema/qapi-schema-test.out        |  48 +-
 tests/qapi-schema/test-qapi.py                |  26 +-
 51 files changed, 1393 insertions(+), 762 deletions(-)
 create mode 100644 qapi/compat.json
 create mode 100644 include/qapi/compat-policy.h
 create mode 100644 tests/qapi-schema/features-deprecated-type.err
 create mode 100644 tests/qapi-schema/features-deprecated-type.json
 create mode 100644 tests/qapi-schema/features-deprecated-type.out

--=20
2.21.1


