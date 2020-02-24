Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE73BC11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98CA620828
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/8ncsN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CA620828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6En4-0004dH-O1
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 09:32:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j6Ekj-0001Na-R1
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:30:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j6Eki-0001uw-8h
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:30:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39994
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j6Eki-0001rt-4h
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:30:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582554631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jcbAvH7+FUscnbAd3TKaAwZuIg4wq6vi18Fa0KSvaY0=;
 b=O/8ncsN3pZv6OI86izVdS7VPVqOeF8vGXgY44weksHbAZNFBG8mFGacwYSlf9ggOMFpQ28
 5Ba1jzR0Ek1F5t4kXG/iJ0aBGy8K2OXqR+k6B6gn80sa07+tBYJRuY9FQw8qdxkKE/GVv2
 pL2EDcJrDHGwHo72huKcL7AwqzyCkbw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-ezeyaaJ8Or6cs2U2WAwksw-1; Mon, 24 Feb 2020 09:30:27 -0500
X-MC-Unique: ezeyaaJ8Or6cs2U2WAwksw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE3CF801E72;
 Mon, 24 Feb 2020 14:30:26 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-134.ams2.redhat.com
 [10.36.117.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4DC4F5C114;
 Mon, 24 Feb 2020 14:30:22 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 00/20] Add qemu-storage-daemon
Date: Mon, 24 Feb 2020 15:29:48 +0100
Message-Id: <20200224143008.13362-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 coiby.xu@gmail.com, mreitz@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds a new tool 'qemu-storage-daemon', which can be used to
export and perform operations on block devices. There is some overlap
between qemu-img/qemu-nbd and the new qemu-storage-daemon, but there are
a few important differences:

* The qemu-storage-daemon has QMP support. The command set is obviously
  restricted compared to the system emulator because there is no guest,
  but all of the block operations that are not tied to gues devices are
  present.

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

  The exception is --chardev, for which not clear design for a QAPIfied
  command line exists yet. We'll consider this interface unstable until
  we've figured out how to solve it. For now it just uses the same
  QemuOpts-based code as the system emulator.

* While this series implements only NBD exports, the storage daemon is
  intended to serve multiple protocols and its syntax reflects this. In
  the past, we had proposals to add new one-off tools for exporting over
  new protocols like FUSE or TCMU.

  With a generic storage daemon, additional export methods have a home
  without adding a new tool for each of them.

The plan is to merge qemu-storage-daemon as an experimental feature with
a reduced API stability promise in 5.0.

Kevin Wolf (20):
  qemu-storage-daemon: Add barebone tool
  stubs: Add arch_type
  block: Move system emulator QMP commands to block/qapi-sysemu.c
  block: Move common QMP commands to block-core QAPI module
  block: Move sysemu QMP commands to QAPI block module
  qemu-storage-daemon: Add --blockdev option
  qapi: Flatten object-add
  qemu-storage-daemon: Add --object option
  qemu-storage-daemon: Add --nbd-server option
  blockdev-nbd: Boxed argument type for nbd-server-add
  qemu-storage-daemon: Add --export option
  qemu-storage-daemon: Add main loop
  qemu-storage-daemon: Add --chardev option
  stubs: Update monitor stubs for qemu-storage-daemon
  qapi: Create 'pragma' module
  monitor: Create QAPIfied monitor_init()
  qmp: Fail gracefully if chardev is already in use
  hmp: Fail gracefully if chardev is already in use
  monitor: Add allow_hmp parameter to monitor_init()
  qemu-storage-daemon: Add --monitor option

 qapi/block-core.json                 | 730 +++++++++++++--------------
 qapi/block.json                      | 512 +++++++++++--------
 qapi/control.json                    |  37 ++
 qapi/pragma.json                     |  24 +
 qapi/qapi-schema.json                |  25 +-
 qapi/qom.json                        |  12 +-
 qapi/transaction.json                |   2 +-
 configure                            |   2 +-
 include/block/nbd.h                  |   1 +
 include/monitor/monitor.h            |   6 +-
 include/qom/object_interfaces.h      |   7 +
 include/sysemu/arch_init.h           |   2 +
 block/qapi-sysemu.c                  | 590 ++++++++++++++++++++++
 blockdev-nbd.c                       |  40 +-
 blockdev.c                           | 559 --------------------
 chardev/char.c                       |   8 +-
 gdbstub.c                            |   2 +-
 hw/block/xen-block.c                 |  11 +-
 monitor/hmp-cmds.c                   |  21 +-
 monitor/hmp.c                        |   8 +-
 monitor/misc.c                       |   2 +
 monitor/monitor.c                    |  86 ++--
 monitor/qmp-cmds.c                   |   2 +-
 monitor/qmp.c                        |  11 +-
 qemu-storage-daemon.c                | 340 +++++++++++++
 qom/qom-qmp-cmds.c                   |  42 +-
 stubs/arch_type.c                    |   4 +
 stubs/monitor-core.c                 |  21 +
 stubs/monitor.c                      |  17 +-
 tests/test-util-sockets.c            |   4 +-
 scripts/qapi/gen.py                  |   5 +
 Makefile                             |  37 ++
 Makefile.objs                        |   9 +
 block/Makefile.objs                  |   4 +-
 monitor/Makefile.objs                |   2 +
 qapi/Makefile.objs                   |   7 +-
 qemu-deprecated.texi                 |   4 +
 qom/Makefile.objs                    |   1 +
 storage-daemon/Makefile.objs         |   1 +
 storage-daemon/qapi/Makefile.objs    |   1 +
 storage-daemon/qapi/qapi-schema.json |  26 +
 stubs/Makefile.objs                  |   2 +
 42 files changed, 1955 insertions(+), 1272 deletions(-)
 create mode 100644 qapi/pragma.json
 create mode 100644 block/qapi-sysemu.c
 create mode 100644 qemu-storage-daemon.c
 create mode 100644 stubs/arch_type.c
 create mode 100644 stubs/monitor-core.c
 create mode 100644 storage-daemon/Makefile.objs
 create mode 100644 storage-daemon/qapi/Makefile.objs
 create mode 100644 storage-daemon/qapi/qapi-schema.json

--=20
2.20.1


