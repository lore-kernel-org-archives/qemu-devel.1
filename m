Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8ADC33CB7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 10:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 888A120702
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 10:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErJuSGnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888A120702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw1mk-0004CZ-M8
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 05:38:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iw1lS-0002PF-NC
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:37:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iw1lQ-0002Y5-R7
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:37:06 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47062
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iw1lQ-0002XT-O9
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:37:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580121424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bEZBUSI+T2V8TDYRTQq0xDhrQPT8zUv9+CBFdQ3L8sA=;
 b=ErJuSGnZ10wFjHdI85TBLkdcznE2z8JSIt0ALnP+g8TJWeFM/V2rm8pGvpx4oapH56BPXB
 DrQ1b+oxEtzxAmAhuzFBHULbo+e0JK36OC0eEsVMpGsEi0MgkoTE9dO+UUKCgl/Mc0loMt
 oJcnhbFAtwAeO8mV7dVqPSxyjX6Qfrk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-YgtqEWhZOW2bsdRiTNacVg-1; Mon, 27 Jan 2020 05:36:56 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA39C10054E3;
 Mon, 27 Jan 2020 10:36:54 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 311353B7;
 Mon, 27 Jan 2020 10:36:49 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/13] RFC: [for 5.0]: HMP monitor handlers cleanups
Date: Mon, 27 Jan 2020 12:36:34 +0200
Message-Id: <20200127103647.17761-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: YgtqEWhZOW2bsdRiTNacVg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series is bunch of cleanups
to the hmp monitor code.

This series only touched blockdev related hmp handlers.

No functional changes expected other that
light error message changes by the last patch.

This was inspired by this bugzilla:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1719169

Basically some users still parse hmp error messages,
and they would like to have them prefixed with 'Error:'

In commit 66363e9a43f649360a3f74d2805c9f864da027eb we added
the hmp_handle_error which does exactl that but some hmp handlers
don't use it.

In this patch series, I moved all the block related hmp handlers
into blockdev-hmp-cmds.c, and then made them use this function
to report the errors.

I hope I didn't change too much code, I just felt that if
I touch this code, I can also make it easier to find these
handlers, that were scattered over 3 different files.

Changes from V1:
   * move the handlers to block/monitor/block-hmp-cmds.c
   * tiny cleanup for the commit messages

Changes from V2:
   * Moved all the function prototypes to new header (blockdev-hmp-cmds.h)
   * Set the license of blockdev-hmp-cmds.c to GPLv2+
   * Moved hmp_snapshot_* functions to blockdev-hmp-cmds.c
   * Moved hmp_drive_add_node to blockdev-hmp-cmds.c
     (this change needed some new exports, thus in separate new patch)
   * Moved hmp_qemu_io and hmp_eject to blockdev-hmp-cmds.c
   * Added 'error:' prefix to vreport, and updated the iotests
     This is invasive change, but really feels like the right one
   * Added minor refactoring patch that drops an unused #include

Best regards,
=09Maxim Levitsky

Maxim Levitsky (13):
  usb/dev-storage: remove unused include
  monitor/hmp: uninline add_init_drive
  monitor/hmp: rename device-hotplug.c to block/monitor/block-hmp-cmds.c
  monitor/hmp: move hmp_drive_del and hmp_commit to block-hmp-cmds.c
  monitor/hmp: move hmp_drive_mirror and hmp_drive_backup to
    block-hmp-cmds.c
  monitor/hmp: move hmp_block_job* to block-hmp-cmds.c
  monitor/hmp: move hmp_snapshot_* to block-hmp-cmds.c
  monitor/hmp: move hmp_nbd_server* to block-hmp-cmds.c
  monitor/hmp: move remaining hmp_block* functions to block-hmp-cmds.c
  monitor/hmp: move hmp_info_block* to block-hmp-cmds.c
  monitor: Move hmp_drive_add_node to block-hmp-cmds.c
  add 'error' prefix to vreport
  monitor/hmp: Prefer to use hmp_handle_error for error reporting in
    block hmp commands

 MAINTAINERS                        |   1 +
 Makefile.objs                      |   2 +-
 block/Makefile.objs                |   1 +
 block/monitor/Makefile.objs        |   1 +
 block/monitor/block-hmp-cmds.c     | 980 +++++++++++++++++++++++++++++
 blockdev.c                         | 137 +---
 device-hotplug.c                   |  91 ---
 hw/usb/dev-storage.c               |   1 -
 include/block/block-hmp-commands.h |  42 ++
 include/block/block_int.h          |   5 +-
 include/monitor/hmp.h              |  24 -
 include/sysemu/blockdev.h          |   4 -
 include/sysemu/sysemu.h            |   3 -
 monitor/hmp-cmds.c                 | 771 +----------------------
 monitor/misc.c                     |   1 +
 tests/qemu-iotests/020.out         |   2 +-
 tests/qemu-iotests/026.out         | 260 ++++----
 tests/qemu-iotests/036.out         |  16 +-
 tests/qemu-iotests/043.out         |   6 +-
 tests/qemu-iotests/049.out         |  30 +-
 tests/qemu-iotests/051.pc.out      | 150 ++---
 tests/qemu-iotests/054.out         |   4 +-
 tests/qemu-iotests/060.out         |  20 +-
 tests/qemu-iotests/061.out         |  26 +-
 tests/qemu-iotests/069.out         |   2 +-
 tests/qemu-iotests/071.out         |   4 +-
 tests/qemu-iotests/074.out         |   4 +-
 tests/qemu-iotests/079.out         |   2 +-
 tests/qemu-iotests/080.out         |  72 +--
 tests/qemu-iotests/081.out         |   2 +-
 tests/qemu-iotests/082.out         |  38 +-
 tests/qemu-iotests/083.out         |  68 +-
 tests/qemu-iotests/098.out         |   8 +-
 tests/qemu-iotests/103.out         |  14 +-
 tests/qemu-iotests/106.out         |   4 +-
 tests/qemu-iotests/111.out         |   2 +-
 tests/qemu-iotests/112.out         |  24 +-
 tests/qemu-iotests/113.out         |   6 +-
 tests/qemu-iotests/114.out         |   2 +-
 tests/qemu-iotests/122.out         |   4 +-
 tests/qemu-iotests/133.out         |  30 +-
 tests/qemu-iotests/137.out         |  28 +-
 tests/qemu-iotests/140.out         |   2 +-
 tests/qemu-iotests/142.out         |  38 +-
 tests/qemu-iotests/143.out         |   2 +-
 tests/qemu-iotests/153.out         | 118 ++--
 tests/qemu-iotests/162.out         |  10 +-
 tests/qemu-iotests/172.out         |  16 +-
 tests/qemu-iotests/178.out.qcow2   |  30 +-
 tests/qemu-iotests/178.out.raw     |  26 +-
 tests/qemu-iotests/182.out         |   2 +-
 tests/qemu-iotests/187.out         |   6 +-
 tests/qemu-iotests/188.out         |   2 +-
 tests/qemu-iotests/197.out         |   2 +-
 tests/qemu-iotests/205             |   2 +-
 tests/qemu-iotests/215.out         |   2 +-
 tests/qemu-iotests/217.out         |   2 +-
 tests/qemu-iotests/226.out         |  12 +-
 tests/qemu-iotests/232.out         |  12 +-
 tests/qemu-iotests/233.out         |  24 +-
 tests/qemu-iotests/242.out         |   2 +-
 tests/qemu-iotests/244.out         |  14 +-
 tests/qemu-iotests/249.out         |   6 +-
 tests/qemu-iotests/261.out         |  24 +-
 tests/qemu-iotests/267.out         |  16 +-
 tests/qemu-iotests/common.filter   |   2 +-
 util/qemu-error.c                  |   1 +
 67 files changed, 1640 insertions(+), 1625 deletions(-)
 create mode 100644 block/monitor/Makefile.objs
 create mode 100644 block/monitor/block-hmp-cmds.c
 delete mode 100644 device-hotplug.c
 create mode 100644 include/block/block-hmp-commands.h

--=20
2.17.2


