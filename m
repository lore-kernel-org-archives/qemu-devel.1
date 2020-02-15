Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478F4C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 13:08:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D8972067D
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 13:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxlGZ9In"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D8972067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2xBV-000466-A8
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 08:08:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2x8c-0000A1-98
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 08:05:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2x8Z-0002ga-0F
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 08:05:36 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29771)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2x8W-0002f2-Hp
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 08:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581771932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BuWEXsQ6pKOMnAC0pvaMuc+NT+XRgrp4FAIhw3wz0lM=;
 b=OxlGZ9InQ84btFT5HJLJ62C+Wj0G43laNKLMr1hlxVjNmFUyn15jzTN5FjxjLPfB4Hgbzb
 jyHuZVxaNMi8TiDXuwnUxgLdhCg4cNadH2c46VGqHCcIccIMKvSSjtC7uLBGg0baxD7N9V
 jhg5BmQhikd/KXCZQKH9hF9F/qMxygs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-6jhiPoivPde5oSVJDR038g-1; Sat, 15 Feb 2020 08:05:30 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 292171800D6B
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 13:05:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EEB895C12E
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 13:05:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 63CF211385C9; Sat, 15 Feb 2020 14:05:27 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] Monitor patches for 2020-02-15
Date: Sat, 15 Feb 2020 14:05:22 +0100
Message-Id: <20200215130527.28861-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 6jhiPoivPde5oSVJDR038g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit b29c3e23f64938784c42ef9fca896829e3c19120=
:

  Merge remote-tracking branch 'remotes/juanquintela/tags/pull-migration-pu=
ll-request' into staging (2020-02-14 17:57:15 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2020-02-15

for you to fetch changes up to 6fce5a08f89d4ebf197fca838d60239482db957f:

  qemu-doc: Clarify extent of build platform support (2020-02-15 12:44:28 +=
0100)

----------------------------------------------------------------
Monitor patches for 2020-02-15

* Refactoring in preparation for qemu-storage-daemon

* A doc clarification that's admittedly not about the monitor

----------------------------------------------------------------
Kevin Wolf (4):
      monitor: Move monitor option parsing to monitor/monitor.c
      qapi: Split control.json off misc.json
      monitor: Collect "control" command handlers in qmp-cmds.control.c
      monitor: Move qmp_query_qmp_schema to qmp-cmds-control.c

Markus Armbruster (1):
      qemu-doc: Clarify extent of build platform support

 qemu-doc.texi              |   9 +-
 qapi/control.json          | 218 +++++++++++++++++++++++++++++++++++++++++=
++++
 qapi/misc.json             | 212 -----------------------------------------=
--
 qapi/qapi-schema.json      |   1 +
 include/monitor/monitor.h  |   3 +
 include/sysemu/sysemu.h    |   1 -
 monitor/monitor-internal.h |   4 +
 monitor/hmp-cmds.c         |   1 +
 monitor/misc.c             | 127 +-------------------------
 monitor/monitor.c          |  48 ++++++++++
 monitor/qmp-cmds-control.c | 169 +++++++++++++++++++++++++++++++++++
 monitor/qmp-cmds.c         |  15 +---
 monitor/qmp.c              |   2 +-
 tests/qtest/qmp-test.c     |   2 +-
 ui/gtk.c                   |   1 +
 vl.c                       |  45 +---------
 monitor/Makefile.objs      |   3 +-
 qapi/Makefile.objs         |   6 +-
 18 files changed, 460 insertions(+), 407 deletions(-)
 create mode 100644 qapi/control.json
 create mode 100644 monitor/qmp-cmds-control.c

Kevin Wolf (4):
  monitor: Move monitor option parsing to monitor/monitor.c
  qapi: Split control.json off misc.json
  monitor: Collect "control" command handlers in qmp-cmds.control.c
  monitor: Move qmp_query_qmp_schema to qmp-cmds-control.c

Markus Armbruster (1):
  qemu-doc: Clarify extent of build platform support

 qemu-doc.texi              |   9 +-
 qapi/control.json          | 218 +++++++++++++++++++++++++++++++++++++
 qapi/misc.json             | 212 ------------------------------------
 qapi/qapi-schema.json      |   1 +
 include/monitor/monitor.h  |   3 +
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
 18 files changed, 460 insertions(+), 407 deletions(-)
 create mode 100644 qapi/control.json
 create mode 100644 monitor/qmp-cmds-control.c

--=20
2.21.1


