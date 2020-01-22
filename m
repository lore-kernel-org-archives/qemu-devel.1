Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EF0C3F68F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 16:48:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D8A924656
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 16:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXfrzQZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8A924656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuJAt-0000jl-7e
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 11:48:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iuJ8c-0007no-TD
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 11:45:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iuJ8b-0000le-Kb
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 11:45:54 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44201
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iuJ8b-0000lI-Gm
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 11:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579711553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gcKMsZpNgSvAK8P9tia0i9rqlwqqjR77MqNWjqV+ha4=;
 b=WXfrzQZBOFJtNq0n7LD/qBSv9jAZs9/kxczPV56y4tQ3E6PhAozJn2yVLPHSGVBqrXoEve
 Od3cReVfGZVY3n2X6R0K09SkdZdUA+RvytxHNDj64Gxc3/pzr+gnR2mJchQ3P3JNAygkIE
 YXNJUJMhqg6DWZvk++Y24BHXDVAOkCY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-3ZX365a8NFaVfOP2Zy4BRg-1; Wed, 22 Jan 2020 11:45:36 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3DF610054E3;
 Wed, 22 Jan 2020 16:45:34 +0000 (UTC)
Received: from localhost (unknown [10.36.118.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 708E88642E;
 Wed, 22 Jan 2020 16:45:34 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 0/5] block: Generic file creation fallback
Date: Wed, 22 Jan 2020 17:45:27 +0100
Message-Id: <20200122164532.178040-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 3ZX365a8NFaVfOP2Zy4BRg-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

As version 1, this series adds a fallback path for creating files (on
the protocol layer) if the protocol driver does not support file
creation, but the file already exists.


Branch: https://github.com/XanClic/qemu.git skip-proto-create-v2
Branch: https://git.xanclic.moe/XanClic/qemu.git skip-proto-create-v2


v2:
- Drop blk_truncate_for_formatting(): It doesn=E2=80=99t make sense to intr=
oduce
  this function any more after 26536c7fc25917d1bd13781f81fe3ab039643bff
  (=E2=80=9Cblock: Do not truncate file node when formatting=E2=80=9D), bec=
ause we=E2=80=99d
  only use it in bdrv_create_file_fallback().
  Thus, it makes more sense to create special helper functions
  specifically for bdrv_create_file_fallback().

- Thus, dropped patches 2 and 3.

- And changed patch 4 to include those helper functions.

- Rebased, which was a bit of a pain.


git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respecti=
vely

001/5:[----] [-C] 'block/nbd: Fix hang in .bdrv_close()'
002/5:[0080] [FC] 'block: Generic file creation fallback'
003/5:[----] [--] 'file-posix: Drop hdev_co_create_opts()'
004/5:[----] [--] 'iscsi: Drop iscsi_co_create_opts()'
005/5:[----] [-C] 'iotests: Add test for image creation fallback'


Max Reitz (5):
  block/nbd: Fix hang in .bdrv_close()
  block: Generic file creation fallback
  file-posix: Drop hdev_co_create_opts()
  iscsi: Drop iscsi_co_create_opts()
  iotests: Add test for image creation fallback

 block.c                    | 159 ++++++++++++++++++++++++++++++++++---
 block/file-posix.c         |  67 ----------------
 block/iscsi.c              |  56 -------------
 block/nbd.c                |  14 +++-
 tests/qemu-iotests/259     |  61 ++++++++++++++
 tests/qemu-iotests/259.out |  14 ++++
 tests/qemu-iotests/group   |   1 +
 7 files changed, 236 insertions(+), 136 deletions(-)
 create mode 100755 tests/qemu-iotests/259
 create mode 100644 tests/qemu-iotests/259.out

--=20
2.24.1


