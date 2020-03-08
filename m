Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D912CC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 09:25:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A694206D7
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 09:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZ1/43cH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A694206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAsBx-00048R-Nf
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 05:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jAsB5-0002bv-4K
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 05:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jAsB2-0008Op-RW
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 05:24:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55449
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jAsB2-0008OX-G9
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 05:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583659491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nkqlY11AWDmDrD7JSnTXC+Ubh1gfw7A65YoDbQrYD2o=;
 b=UZ1/43cHD/EA1BKf1VwEgaUok6kSeAq45MpzC0RnmbHUxBh/4Zkeb6/I+2FKmhYhu1Ve0X
 3DSUk5eIfS2CgDMc0poPLIOycPF/xV1CHqebOIX9CdRGmUjq6VeFKgLSM12yr1uRXZyxEq
 s0IRUCnUzs5usiESNylL9UkdQlD4t9g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-LeG1pit_Ps-J3-EPNtaMMw-1; Sun, 08 Mar 2020 05:24:48 -0400
X-MC-Unique: LeG1pit_Ps-J3-EPNtaMMw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25A60107ACC7;
 Sun,  8 Mar 2020 09:24:47 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7725A10027B8;
 Sun,  8 Mar 2020 09:24:42 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 00/11] HMP monitor handlers refactoring
Date: Sun,  8 Mar 2020 11:24:29 +0200
Message-Id: <20200308092440.23564-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series is bunch of cleanups to the hmp monitor code.
It mostly moves the blockdev related hmp handlers to its own file,
and does some minor refactoring.

No functional changes expected.

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

Changes from V3:
   * Dropped the error prefix patches for now due to fact that it seems
     that libvirt doesn't need that after all. Oh well...
     I'll send them in a separate series.

   * Hopefully correctly merged the copyright info the new files
     Both files are GPLv2 now (due to code from hmp.h/hmp-cmds.c)

   * Addressed review feedback
   * Renamed the added header to block-hmp-cmds.h

   * Got rid of checkpatch.pl warnings in the moved code
     (cosmetic code changes only)

   * I kept the reviewed-by tags, since the changes I did are minor.
     I hope that this is right thing to do.

Changes from V4:
   * Rebase with recent changes
   * Fixed review feedback

Best regards,
=09Maxim Levitsky

Maxim Levitsky (11):
  usb/dev-storage: remove unused include
  monitor/hmp: inline add_init_drive
  monitor/hmp: rename device-hotplug.c to block/monitor/block-hmp-cmds.c
  monitor/hmp: move hmp_drive_del and hmp_commit to block-hmp-cmds.c
  monitor/hmp: move hmp_drive_mirror and hmp_drive_backup to
    block-hmp-cmds.c Moved code was added after 2012-01-13, thus under
    GPLv2+
  monitor/hmp: move hmp_block_job* to block-hmp-cmds.c
  monitor/hmp: move hmp_snapshot_* to block-hmp-cmds.c
  monitor/hmp: move hmp_nbd_server* to block-hmp-cmds.c
  monitor/hmp: move remaining hmp_block* functions to block-hmp-cmds.c
  monitor/hmp: move hmp_info_block* to block-hmp-cmds.c
  monitor/hmp: Move hmp_drive_add_node to block-hmp-cmds.c

 MAINTAINERS                    |    1 +
 Makefile.objs                  |    2 +-
 block/Makefile.objs            |    1 +
 block/monitor/Makefile.objs    |    1 +
 block/monitor/block-hmp-cmds.c | 1015 ++++++++++++++++++++++++++++++++
 blockdev.c                     |  137 +----
 device-hotplug.c               |   91 ---
 hw/usb/dev-storage.c           |    1 -
 include/block/block-hmp-cmds.h |   54 ++
 include/block/block_int.h      |    5 +-
 include/monitor/hmp.h          |   24 -
 include/sysemu/blockdev.h      |    4 -
 include/sysemu/sysemu.h        |    3 -
 monitor/hmp-cmds.c             |  782 ------------------------
 monitor/misc.c                 |    1 +
 15 files changed, 1085 insertions(+), 1037 deletions(-)
 create mode 100644 block/monitor/Makefile.objs
 create mode 100644 block/monitor/block-hmp-cmds.c
 delete mode 100644 device-hotplug.c
 create mode 100644 include/block/block-hmp-cmds.h

--=20
2.17.2


