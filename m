Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CAFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95F832173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+dWw7pL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F832173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwV5h-0008As-KB
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 12:55:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iwV2F-0002oW-I5
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:52:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iwV2D-0004Tq-Sq
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:52:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21016
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iwV2D-0004TG-Oa
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:52:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580233941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=csXYjXKL3C2/fAF05Px2TAhJFsA5fhxqExrlBfivEVQ=;
 b=e+dWw7pLOQ9ituTaoAj09FhheXj3RxwqpgYK3btE8WSUalQkKDAt6/K2kKNcEbohfUkdL4
 TzoJrtRq2gXE5pBQrAUzyCfYYTNHZBCazQcGE9kOENn9+mjaojP5n/jwugIleKJ+hmyOmR
 YlmCL1FuRUNPu7fMWNpRg+Hl1zHsrqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263--Qdwolf5NkCRcnARZux-tw-1; Tue, 28 Jan 2020 12:52:17 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6AFD189F760;
 Tue, 28 Jan 2020 17:52:16 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-106.ams2.redhat.com
 [10.36.117.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC0A760BE0;
 Tue, 28 Jan 2020 17:52:15 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 0/4] monitor: Refactoring in preparation for
 qemu-storage-daemon
Date: Tue, 28 Jan 2020 18:52:07 +0100
Message-Id: <20200128175211.30007-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: -Qdwolf5NkCRcnARZux-tw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series creates a QAPI module 'control' that can be used from tools
outside the system emulator and moves some monitor initialisation code
from vl.c to monitor code.

It is split from the series to introduce qemu-storage-daemon because
these refactorings make sense on their own as cleanups.

v2:
- Removed allow_hmp parameter from monitor_init_opts() [Markus]
- Renamed monitor.json to control.json [Markus]

Kevin Wolf (4):
  monitor: Move monitor option parsing to monitor/monitor.c
  qapi: Create module 'control'
  monitor: Create monitor/qmp-cmds-control.c
  monitor: Move qmp_query_qmp_schema to qmp-cmds-control.c

 qapi/control.json          | 218 +++++++++++++++++++++++++++++++++++++
 qapi/misc.json             | 212 ------------------------------------
 qapi/qapi-schema.json      |   1 +
 include/monitor/monitor.h  |   4 +
 include/sysemu/sysemu.h    |   1 -
 monitor/monitor-internal.h |   4 +
 monitor/hmp-cmds.c         |   1 +
 monitor/misc.c             | 127 +--------------------
 monitor/monitor.c          |  48 ++++++++
 monitor/qmp-cmds-control.c | 169 ++++++++++++++++++++++++++++
 monitor/qmp-cmds.c         |  15 +--
 monitor/qmp.c              |   2 +-
 tests/qtest/qmp-test.c     |   2 +-
 ui/gtk.c                   |   1 +
 vl.c                       |  45 +-------
 monitor/Makefile.objs      |   3 +-
 qapi/Makefile.objs         |   6 +-
 17 files changed, 456 insertions(+), 403 deletions(-)
 create mode 100644 qapi/control.json
 create mode 100644 monitor/qmp-cmds-control.c

--=20
2.20.1


