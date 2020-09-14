Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A735CC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:55:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16BA420756
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehtCVqGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BA420756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHkGQ-0002cF-31
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 04:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kHkAI-0007Yk-Dq
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 04:48:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36882)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kHkAG-0005Ha-CZ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 04:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600073323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Eqe6jzNVCvqhhysl8dr/WHjnrsvI9u0ipOBYUdjomBg=;
 b=ehtCVqGeDURK+XMIQkFBvcZuywx8rQlkf7F5oATrmOGR51av7fHamiNa55ifV/p53VSA/Z
 E6qyLNbbqAYNwxjBAUVfsrurCmup/SJQPJckPO+gJ5X32frGoffU/IYKu+GLtWvY2fv570
 Xx1fqyeVqXWi2amY9dIvyAwPjnKxkVk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-Sqwxnv-rNR6FPiebcbYp-Q-1; Mon, 14 Sep 2020 04:48:40 -0400
X-MC-Unique: Sqwxnv-rNR6FPiebcbYp-Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EF741009462;
 Mon, 14 Sep 2020 08:48:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EFAAF282FC;
 Mon, 14 Sep 2020 08:48:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7387A113865F; Mon, 14 Sep 2020 10:48:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/8] Configurable policy for handling deprecated interfaces
Date: Mon, 14 Sep 2020 10:47:54 +0200
Message-Id: <20200914084802.4185028-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:55:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, libvir-list@redhat.com,
 mdroth@linux.vnet.ibm.com, marcandre.lureau@gmail.com, libguestfs@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

New option -compat lets you configure what to do when deprecated
interfaces get used.  This is intended for testing users of the
management interfaces.  It is experimental.

-compat deprecated-input=<in-policy> configures what to do when
deprecated input is received.  Available policies:

* accept: Accept deprecated commands and arguments (default)
* reject: Reject them
* crash: Crash

-compat deprecated-output=<out-policy> configures what to do when
deprecated output is sent.  Available output policies:

* accept: Emit deprecated command results and events (default)
* hide: Suppress them

For now, -compat covers only deprecated syntactic aspects of QMP.  We
may want to extend it to cover semantic aspects, CLI, and experimental
features.

v5:
* Old PATCH 01-26 merged in commit f57587c7d47.
* Rebased, non-trivial conflicts in PATCH 1 due to Meson, and in PATCH
  7 due to visitor changes
* PATCH 1: Comments updated for 5.2 [Eric]
* PATCH 2: Harmless missing initialization fixed [Eric]
* PATCH 3+4: Harmless missing has_FOO = true fixed [Eric]
* PATCH 6+7: Commit message tweaked

v4:
* PATCH 05+07: Temporary memory leak plugged [Marc-André]
* PATCH 23: Rewritten [Marc-André]
* PATCH 24: Comment typo [Marc-André]
* PATCH 30: Memory leaks plugged

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

Cc: Lukáš Doktor <ldoktor@redhat.com>
Cc: libguestfs@redhat.com
Cc: libvir-list@redhat.com
Cc: Daniel P. Berrange <berrange@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>

Markus Armbruster (8):
  qemu-options: New -compat to set policy for deprecated interfaces
  qapi: Implement deprecated-output=hide for QMP command results
  qapi: Implement deprecated-output=hide for QMP events
  qapi: Implement deprecated-output=hide for QMP event data
  qapi: Implement deprecated-output=hide for QMP introspection
  qapi: Implement deprecated-input=reject for QMP commands
  qapi: Implement deprecated-input=reject for QMP command arguments
  qapi: New -compat deprecated-input=crash

 qapi/compat.json                        |  52 ++++++++++++
 qapi/introspect.json                    |   2 +-
 qapi/qapi-schema.json                   |   1 +
 include/qapi/compat-policy.h            |  20 +++++
 include/qapi/qmp/dispatch.h             |   1 +
 include/qapi/qobject-input-visitor.h    |   9 +++
 include/qapi/qobject-output-visitor.h   |   9 +++
 include/qapi/visitor-impl.h             |   6 ++
 include/qapi/visitor.h                  |  18 +++++
 monitor/monitor-internal.h              |   3 -
 monitor/misc.c                          |   2 -
 monitor/qmp-cmds-control.c              | 100 +++++++++++++++++++++---
 qapi/qapi-visit-core.c                  |  18 +++++
 qapi/qmp-dispatch.c                     |  17 ++++
 qapi/qobject-input-visitor.c            |  29 +++++++
 qapi/qobject-output-visitor.c           |  19 +++++
 softmmu/vl.c                            |  17 ++++
 storage-daemon/qemu-storage-daemon.c    |   2 -
 tests/test-qmp-cmds.c                   |  91 +++++++++++++++++++--
 tests/test-qmp-event.c                  |  41 ++++++++++
 qapi/meson.build                        |   1 +
 qapi/trace-events                       |   2 +
 qemu-options.hx                         |  22 ++++++
 scripts/qapi/commands.py                |  14 ++--
 scripts/qapi/events.py                  |  22 +++++-
 scripts/qapi/visit.py                   |  15 ++++
 tests/qapi-schema/qapi-schema-test.json |  20 +++--
 tests/qapi-schema/qapi-schema-test.out  |  20 ++---
 28 files changed, 522 insertions(+), 51 deletions(-)
 create mode 100644 qapi/compat.json
 create mode 100644 include/qapi/compat-policy.h

-- 
2.26.2


