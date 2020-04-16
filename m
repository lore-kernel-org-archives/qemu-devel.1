Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5B4C2BB85
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 14:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E9D2223D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 14:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vg7m4f2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E9D2223D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP5sI-0006oa-3r
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 10:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jP5rS-0005nB-G6
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:51:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jP5rQ-00047r-OL
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:51:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24940
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jP5rQ-00047O-KV
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587048684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=t7k5bc5BV6Mp9jMMCMnEh+W1wZb9nXdWbqtxDmVEYsM=;
 b=Vg7m4f2sV9JtluQ1PYKNpEB84QqoaOwi/2ng3cDkYkQpZCpHQY6ptx2Q022zeaF5cheS8N
 7xbk/26wFzGnP6f4Lr65uQBDiFdr2c4vGDD+t4RdOtp3gIzp3OiNQNw4TvUzvEw8LLeOVS
 smL68F7czN6I84V0HObt4dQN/XnJUDo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-6UROJtNeMb-kvQ8g_bsRHg-1; Thu, 16 Apr 2020 10:51:17 -0400
X-MC-Unique: 6UROJtNeMb-kvQ8g_bsRHg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 365488017F6;
 Thu, 16 Apr 2020 14:51:16 +0000 (UTC)
Received: from blue.redhat.com (ovpn-115-59.phx2.redhat.com [10.3.115.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ACDC91001DD8;
 Thu, 16 Apr 2020 14:51:15 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] qemu-img: Add convert --bitmaps
Date: Thu, 16 Apr 2020 09:51:12 -0500
Message-Id: <20200416145115.699033-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: nsoffer@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Without this series, the process for copying one qcow2 image to
another including all of its bitmaps involves running qemu and doing
the copying by hand with a series of QMP commands.  This makes the
process a bit more convenient.

I still think that someday we will need a 'qemu-img bitmap' with
various subcommands for manipulating bitmaps within an offline image,
but in the meantime, this seems like a useful addition on its own.

Series can also be downloaded at:
https://repo.or.cz/qemu/ericb.git/shortlog/refs/tags/qemu-img-bitmaps-v1

Eric Blake (3):
  blockdev: Split off basic bitmap operations for qemu-img
  qemu-img: Add convert --bitmaps option
  iotests: Add test 291 to for qemu-img convert --bitmaps

 docs/tools/qemu-img.rst    |   6 +-
 Makefile.objs              |   2 +-
 include/sysemu/blockdev.h  |  10 ++
 blockbitmaps.c             | 217 +++++++++++++++++++++++++++++++++++++
 blockdev.c                 | 184 -------------------------------
 qemu-img.c                 |  81 +++++++++++++-
 MAINTAINERS                |   1 +
 qemu-img-cmds.hx           |   4 +-
 tests/qemu-iotests/291     | 143 ++++++++++++++++++++++++
 tests/qemu-iotests/291.out |  56 ++++++++++
 tests/qemu-iotests/group   |   1 +
 11 files changed, 514 insertions(+), 191 deletions(-)
 create mode 100644 blockbitmaps.c
 create mode 100755 tests/qemu-iotests/291
 create mode 100644 tests/qemu-iotests/291.out

--=20
2.26.0


