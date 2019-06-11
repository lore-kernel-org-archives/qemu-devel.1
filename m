Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28460C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 13:52:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F380F20896
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 13:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F380F20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59188 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hahC2-000630-72
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 09:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56071)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hah1M-0005qw-HL
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:41:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hah1L-0000vP-AL
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:41:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45346)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hah1I-0000tV-6Z; Tue, 11 Jun 2019 09:41:00 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 86C3D30F1BA4;
 Tue, 11 Jun 2019 13:40:54 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-58.ams2.redhat.com [10.36.117.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 03BD819C59;
 Tue, 11 Jun 2019 13:40:52 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 15:40:32 +0200
Message-Id: <20190611134043.9524-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 11 Jun 2019 13:40:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 00/11] monitor: Split monitor.c in
 core/HMP/QMP/misc
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
Cc: kwolf@redhat.com, berrange@redhat.com, qemu-block@nongnu.org,
 armbru@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

monitor.c mixes a lot of different things in a single file: The core
monitor infrastructure, HMP infrastrcture, QMP infrastructure, and the
implementation of several HMP and QMP commands. Almost worse, struct
Monitor mixes state for HMP, for QMP, and state actually shared between
all monitors. monitor.c must be linked with a system emulator and even
requires per-target compilation because some of the commands it
implements access system emulator state.

The reason why I care about this is that I'm working on a protoype for a
storage daemon, which wants to use QMP (but probably not HMP) and
obviously doesn't have any system emulator state. So I'm interested in
some core monitor parts that can be linked to non-system-emulator tools.

This series first creates separate structs MonitorQMP and MonitorHMP
which inherit from Monitor, and then moves the associated infrastructure
code into separate source files.

While the split is probably not perfect, I think it's an improvement of
the current state even for QEMU proper, and it's good enough so I can
link my storage daemon against just monitor/core.o and monitor/qmp.o and
get a useless QMP monitor that parses the JSON input and rejects
everything as an unknown command.

Next I'll try to teach it a subset of QMP commands that can actually be
supported in a tool, but while there will be a few follow-up patches to
achieve this, I don't expect that this work will bring up much that
needs to be changed in the splitting process done in this series.

v2:
- Fix coding style while moving files to make checkpatch happier
- Updated file name references in docs/devel/writing-qmp-commands.txt
- Updated MAINTAINERS for moved and newly created files
- Created monitor/trace-events instead of using the root directory one
- Move {hmp,qmp}.c to monitor/{hmp,qmp}-cmds.c

Kevin Wolf (11):
  monitor: Remove unused password prompting fields
  monitor: Split monitor_init in HMP and QMP function
  monitor: Make MonitorQMP a child class of Monitor
  monitor: Create MonitorHMP with readline state
  monitor: Move cmd_table to MonitorHMP
  Move monitor.c to monitor/misc.c
  monitor: Move {hmp,qmp}.c to monitor/{hmp,qmp}-cmds.c
  monitor: Create monitor_int.h with common definitions
  monitor: Split out monitor/qmp.c
  monitor: Split out monitor/hmp.c
  monitor: Split out monitor/monitor.c

 docs/devel/writing-qmp-commands.txt |   11 +-
 include/monitor/monitor.h           |    8 +-
 monitor/monitor_int.h               |  208 ++
 monitor.c                           | 4727 ---------------------------
 hmp.c =3D> monitor/hmp-cmds.c         |    6 +-
 monitor/hmp.c                       | 1387 ++++++++
 monitor/misc.c                      | 2407 ++++++++++++++
 monitor/monitor.c                   |  605 ++++
 qmp.c =3D> monitor/qmp-cmds.c         |    2 +-
 monitor/qmp.c                       |  404 +++
 MAINTAINERS                         |   13 +-
 Makefile.objs                       |    4 +-
 Makefile.target                     |    3 +-
 monitor/Makefile.objs               |    3 +
 monitor/trace-events                |   15 +
 trace-events                        |   10 -
 16 files changed, 5060 insertions(+), 4753 deletions(-)
 create mode 100644 monitor/monitor_int.h
 delete mode 100644 monitor.c
 rename hmp.c =3D> monitor/hmp-cmds.c (99%)
 create mode 100644 monitor/hmp.c
 create mode 100644 monitor/misc.c
 create mode 100644 monitor/monitor.c
 rename qmp.c =3D> monitor/qmp-cmds.c (99%)
 create mode 100644 monitor/qmp.c
 create mode 100644 monitor/Makefile.objs
 create mode 100644 monitor/trace-events

--=20
2.20.1


