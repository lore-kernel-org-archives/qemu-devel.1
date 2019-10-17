Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE866FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:08:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C41CF20640
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41CF20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5W7-000659-Db
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iL5S3-0000dH-RU
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iL5Ry-0008ND-Bp
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:04:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52852)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iL5Rn-0008Gq-Cy; Thu, 17 Oct 2019 09:04:07 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 670673082B6D;
 Thu, 17 Oct 2019 13:04:06 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-24.ams2.redhat.com
 [10.36.117.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CAF410002A2;
 Thu, 17 Oct 2019 13:04:01 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 00/18] Add qemu-storage-daemon
Date: Thu, 17 Oct 2019 15:01:46 +0200
Message-Id: <20191017130204.16131-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 17 Oct 2019 13:04:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds a new tool 'qemu-storage-daemon', which can be used to
export and perform operations on block devices. There is some overlap
between qemu-img/qemu-nbd and the new qemu-storage-daemon, but there are
a few important differences:

* The qemu-storage-daemon has QMP support. The command set is obviously
  restricted compared to the system emulator because there is no guest,
  but all of the block operations are present.

  This means that it can access advanced options or operations that the
  qemu-img command line doesn't expose. For example, blockdev-create is
  a lot more powerful than 'qemu-img create', and qemu-storage-daemon
  allows to execute it without starting a guest.

  Compared to qemu-nbd it means that, for example, block jobs can now be
  executed on the server side, and backing chains shared by multiple VMs
  can be modified this way.

* The existing tools all have a separately invented one-off syntax for
  the job at hand, which usually comes with restrictions compared to the
  system emulator. qemu-storage-daemon shares the same syntax with the
  system emulator for most options and prefers QAPI based interfaces
  where possible (such as --blockdev), so it should be easy to make use
  of in libvirt.

* While this series implements only NBD exports, the storage daemon is
  intended to serve multiple protocols and its syntax reflects this. In
  the past, we had proposals to add new one-off tools for exporting over
  new protocols like FUSE or TCMU.

  With a generic storage daemon, additional export methods have a home
  without adding a new tool for each of them.

I'm posting this as an RFC mainly for two reasons:

1. The monitor integration, which could be argued to be a little hackish
   (some generated QAPI source files are built from a separate QAPI
   schema, but the per-module ones are taken from the system emulator)
   and Markus will want to have a closer look there. But from the IRC
   discussions we had, we seem to agree on the general approach here.

2. I'm not completely sure if the command line syntax is the final
   version that we want to support long-term. Many options directly use
   QAPI visitors (--blockdev, --export, --nbd-server) and should be
   fine. However, others use QemuOpts (--chardev, --monitor, --object).

   This is the same as in the system emulator, so we wouldn't be adding
   a new problem, but as there was talk about QAPIfying the command
   line, and I wouldn't want later syntax changes or adding lots of
   compatibility code to a new tool, I thought we should probably
   discuss whether QAPIfying from the start would be an option.

I would like to have something merged for 4.2, but I'm considering
marking the whole tool as experimental and unstable ABI by requiring a
command line option like --experimental for the tool to even start if we
know that we want to change some things later.

This series is based on:
* [PATCH] blockdev: Use error_report() in hmp_commit()
* [PATCH 0/7] qapi: Cleanups and test speedup

Based-on: <20191015123932.12214-1-kwolf@redhat.com>
Based-on: <20191001191514.11208-1-armbru@redhat.com>

Kevin Wolf (18):
  qemu-storage-daemon: Add barebone tool
  qemu-storage-daemon: Add --object option
  stubs: Add arch_type
  stubs: Add blk_by_qdev_id()
  qemu-storage-daemon: Add --blockdev option
  qemu-storage-daemon: Add --nbd-server option
  blockdev-nbd: Boxed argument type for nbd-server-add
  qemu-storage-daemon: Add --export option
  qemu-storage-daemon: Add main loop
  qemu-storage-daemon: Add --chardev option
  monitor: Move monitor option parsing to monitor/monitor.c
  stubs: Update monitor stubs for qemu-storage-daemon
  qapi: Create module 'monitor'
  monitor: Create monitor/qmp-cmds-monitor.c
  qapi: Support empty modules
  qapi: Create 'pragma' module
  monitor: Move qmp_query_qmp_schema to qmp-cmds-monitor.c
  qemu-storage-daemon: Add --monitor option

 qapi/block.json                          |  65 ++++-
 qapi/misc.json                           | 212 ---------------
 qapi/monitor.json                        | 218 +++++++++++++++
 qapi/pragma.json                         |  24 ++
 qapi/qapi-schema.json                    |  26 +-
 storage-daemon/qapi/qapi-schema.json     |  15 ++
 configure                                |   2 +-
 include/block/nbd.h                      |   1 +
 include/monitor/monitor.h                |   4 +
 include/sysemu/arch_init.h               |   2 +
 include/sysemu/sysemu.h                  |   1 -
 monitor/monitor-internal.h               |   4 +
 blockdev-nbd.c                           |  30 ++-
 monitor/hmp-cmds.c                       |  22 +-
 monitor/misc.c                           | 126 ---------
 monitor/monitor.c                        |  52 ++++
 monitor/qmp-cmds-monitor.c               | 169 ++++++++++++
 monitor/qmp-cmds.c                       |  15 +-
 monitor/qmp.c                            |   2 +-
 qemu-storage-daemon.c                    | 326 +++++++++++++++++++++++
 stubs/arch_type.c                        |   4 +
 stubs/blk-by-qdev-id.c                   |   9 +
 stubs/monitor-core.c                     |  21 ++
 stubs/monitor.c                          |  15 +-
 tests/qmp-test.c                         |   2 +-
 ui/gtk.c                                 |   1 +
 vl.c                                     |  45 +---
 Makefile                                 |  34 +++
 Makefile.objs                            |   9 +
 block/Makefile.objs                      |   2 +-
 monitor/Makefile.objs                    |   5 +-
 qapi/Makefile.objs                       |   9 +-
 qom/Makefile.objs                        |   1 +
 scripts/qapi/gen.py                      |   5 +
 scripts/qapi/schema.py                   |   9 +
 storage-daemon/Makefile.objs             |   1 +
 storage-daemon/qapi/Makefile.objs        |   1 +
 stubs/Makefile.objs                      |   3 +
 tests/qapi-schema/comments.out           |   2 +
 tests/qapi-schema/doc-bad-section.out    |   2 +
 tests/qapi-schema/doc-good.out           |   2 +
 tests/qapi-schema/empty.out              |   2 +
 tests/qapi-schema/event-case.out         |   2 +
 tests/qapi-schema/include-repetition.out |   4 +
 tests/qapi-schema/include-simple.out     |   3 +
 tests/qapi-schema/indented-expr.out      |   2 +
 tests/qapi-schema/qapi-schema-test.out   |   4 +
 47 files changed, 1052 insertions(+), 463 deletions(-)
 create mode 100644 qapi/monitor.json
 create mode 100644 qapi/pragma.json
 create mode 100644 storage-daemon/qapi/qapi-schema.json
 create mode 100644 monitor/qmp-cmds-monitor.c
 create mode 100644 qemu-storage-daemon.c
 create mode 100644 stubs/arch_type.c
 create mode 100644 stubs/blk-by-qdev-id.c
 create mode 100644 stubs/monitor-core.c
 create mode 100644 storage-daemon/Makefile.objs
 create mode 100644 storage-daemon/qapi/Makefile.objs

--=20
2.20.1


