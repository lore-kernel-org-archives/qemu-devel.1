Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E535C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 17:21:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38C5A20714
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 17:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5EihR+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C5A20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYCcZ-000219-DA
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 12:21:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iYC6V-0005Xu-AA
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:48:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iYC6T-00044D-LT
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:48:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59313
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iYC6T-00043W-HG
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:48:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574441295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TR5VQ/wS4D8xO1AOC7O3E9tsV1je5XGZwr/bhOGmKhc=;
 b=N5EihR+gS1FQlE1mo8F35i7+Michk1/reHQ1dcDPKHXbW8Ts6KIxmXP2YtgdutxaELM4xZ
 +7fOSqxtHxfNaDfyOWcMB2KFHd5ZrTEZd+TBlMbi6YJgJ2ZFEfYqewyFpfrDkjHTrJG+kr
 5IBHSP2LQrN83zZPzQsoYdUHrUdQZC8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-Qvjju3AnMn6-6WYiO6AMgw-1; Fri, 22 Nov 2019 11:48:12 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64347107ACC5;
 Fri, 22 Nov 2019 16:48:11 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 92732691A4;
 Fri, 22 Nov 2019 16:48:09 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/9] RFC: [for 5.0]: HMP monitor handlers cleanups
Date: Fri, 22 Nov 2019 18:47:58 +0200
Message-Id: <20191122164807.27938-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Qvjju3AnMn6-6WYiO6AMgw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Max Reitz <mreitz@redhat.com>
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

Best regards,
=09Maxim Levitsky

Maxim Levitsky (9):
  monitor/hmp: uninline add_init_drive
  monitor/hmp: rename device-hotplug.c to block/monitor/block-hmp-cmds.c
  monitor/hmp: move hmp_drive_del and hmp_commit to block-hmp-cmds.c
  monitor/hmp: move hmp_drive_mirror and hmp_drive_backup to
    block-hmp-cmds.c
  monitor/hmp: move hmp_block_job* to block-hmp-cmds.c
  monitor/hmp: move hmp_snapshot_* to block-hmp-cmds.c
  monitor/hmp: move remaining hmp_block* functions to block-hmp-cmds.c
  monitor/hmp: move hmp_info_block* to block-hmp-cmds.c
  monitor/hmp: Prefer to use hmp_handle_error for error reporting in
    block hmp commands

 MAINTAINERS                    |   1 +
 Makefile.objs                  |   2 +-
 block/Makefile.objs            |   1 +
 block/monitor/Makefile.objs    |   1 +
 block/monitor/block-hmp-cmds.c | 656 +++++++++++++++++++++++++++++++++
 blockdev.c                     |  95 -----
 device-hotplug.c               |  91 -----
 monitor/hmp-cmds.c             | 465 -----------------------
 8 files changed, 660 insertions(+), 652 deletions(-)
 create mode 100644 block/monitor/Makefile.objs
 create mode 100644 block/monitor/block-hmp-cmds.c
 delete mode 100644 device-hotplug.c

--=20
2.17.2


