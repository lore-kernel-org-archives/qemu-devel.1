Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136FCC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 16:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3EFE20717
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 16:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWjXAqis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3EFE20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihc4t-0001NW-P3
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 11:21:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihc3a-0008Kz-3x
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:20:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihc3Y-0003pK-Av
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:20:13 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49336
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihc3Y-0003lW-5u
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:20:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576686011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Q5dDdW5vZDCHASdKkqeU2JEIFBD/s8W+F24Ne9K8NJY=;
 b=VWjXAqisG0ShX4TE+xsxo0y6ASxTr1EQrfOH7iIm1Te1T1ubIYwRsLnErIfOzMTlaVZE4V
 uEC+p6jXp0HwEXtoc14NETBHkqE9ayHDJmA62us7cdf0EyJsSKx0zSALQzJ0KV0ISISArj
 3vqWzOXVKPh76Hjd3k22txiYyTKgPtM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-dK2W5W8xMUa9dwTqRGUzvA-1; Wed, 18 Dec 2019 11:20:08 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30A22477;
 Wed, 18 Dec 2019 16:20:07 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-210.ams2.redhat.com
 [10.36.116.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94EB01000325;
 Wed, 18 Dec 2019 16:20:04 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 0/4] monitor: Refactoring in preparation for
 qemu-storage-daemon
Date: Wed, 18 Dec 2019 17:19:48 +0100
Message-Id: <20191218161952.10202-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: dK2W5W8xMUa9dwTqRGUzvA-1
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series creates a QAPI module 'monitor' that can be used from tools
outside the system emulator and movees some monitor initialisation code
from vl.c to monitor code.

It is split from the series to introduce qemu-storage-daemon because
these refactorings make sense on their own as cleanups.

Kevin Wolf (4):
  monitor: Move monitor option parsing to monitor/monitor.c
  qapi: Create module 'monitor'
  monitor: Create monitor/qmp-cmds-monitor.c
  monitor: Move qmp_query_qmp_schema to qmp-cmds-monitor.c

 qapi/misc.json             | 212 ------------------------------------
 qapi/monitor.json          | 218 +++++++++++++++++++++++++++++++++++++
 qapi/qapi-schema.json      |   1 +
 include/monitor/monitor.h  |   4 +
 include/sysemu/sysemu.h    |   1 -
 monitor/monitor-internal.h |   4 +
 monitor/hmp-cmds.c         |   1 +
 monitor/misc.c             | 126 ---------------------
 monitor/monitor.c          |  52 +++++++++
 monitor/qmp-cmds-monitor.c | 169 ++++++++++++++++++++++++++++
 monitor/qmp-cmds.c         |  15 +--
 monitor/qmp.c              |   2 +-
 tests/qmp-test.c           |   2 +-
 ui/gtk.c                   |   1 +
 vl.c                       |  45 +-------
 monitor/Makefile.objs      |   3 +-
 qapi/Makefile.objs         |   4 +-
 17 files changed, 458 insertions(+), 402 deletions(-)
 create mode 100644 qapi/monitor.json
 create mode 100644 monitor/qmp-cmds-monitor.c

--=20
2.20.1


