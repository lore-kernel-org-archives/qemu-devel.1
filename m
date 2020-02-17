Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D254C33FA1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 13:31:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 281DB2070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 13:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYX1gqp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 281DB2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3gV8-0000xY-8Q
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 08:31:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j3gRh-0004Gj-SC
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:28:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j3gRg-0000sU-1a
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:28:21 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30738
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j3gRf-0000rh-Pb
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:28:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581946099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ohy+qzEbkWVza5tujlOYKwVDW93/pZDUJZRYiXcF5z4=;
 b=eYX1gqp0OCwglBp1uVqO/dtQVj/7dAK067DBEhfQisPhN7H0c5ZnCtOX4MsLUYcAtrpwSA
 uPhd9IkjYF2uX5Klyoc2P7besMQ8DkEh8e5vlSB8r9mU2xSY02h6Zo+erFPBze8X5oYz+G
 pE13I19+Zjku6BXh4JrmcRL9gxPQlt8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-DXZhFl5UPoeTmvrEnCXmnQ-1; Mon, 17 Feb 2020 08:28:17 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 566881857341
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 13:28:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 278C25D9CA
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 13:28:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A16EE11385C9; Mon, 17 Feb 2020 14:28:14 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 0/5] Monitor patches for 2020-02-15
Date: Mon, 17 Feb 2020 14:28:09 +0100
Message-Id: <20200217132814.9018-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: DXZhFl5UPoeTmvrEnCXmnQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 9ced5c7c20cb16dff0c2fa3242c3ee96b68cec2a=
:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2020-02-15' i=
nto staging (2020-02-16 21:15:26 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2020-02-15-v2

for you to fetch changes up to ec95fcc8bae624e87c7601d2d4baf7c519c3814e:

  qemu-doc: Clarify extent of build platform support (2020-02-17 13:53:47 +=
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

--=20
2.21.1


