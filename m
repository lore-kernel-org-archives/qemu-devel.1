Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA84BCA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 15:27:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93E3320656
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 15:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MoB17RCp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E3320656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQYq6-0002Re-Nn
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 11:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iQYnk-0000ti-Es
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 11:25:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iQYni-0005OO-7P
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 11:25:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50012
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iQYni-0005Me-3v
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 11:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572621921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6Z6DIqEBbJVs0tlq3x60nzLRQkQEV3LugjKTB3HfUQg=;
 b=MoB17RCpj5bH5d9EKJE6mJuWGfv2D1SOO5267Nk03U2qTvRB0sLC//lccFowTmuDiNnC1K
 LOi9Ef3qb950PAcaIAI2T5iOGCICc/ADhm/KyJXe9DV9el+z7O55pixo7vG1yy/h7RvCi2
 Y5MQyNWSSQLdpaWY44SScL3Dh6vTw58=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-Dm_yL6T2Ntabh4ZJIHMmKA-1; Fri, 01 Nov 2019 11:25:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C61FD800D49;
 Fri,  1 Nov 2019 15:25:15 +0000 (UTC)
Received: from localhost (ovpn-117-28.ams2.redhat.com [10.36.117.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 32A2060BFB;
 Fri,  1 Nov 2019 15:25:11 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-4.2 v2 0/3] qcow2: Fix data corruption on XFS
Date: Fri,  1 Nov 2019 16:25:07 +0100
Message-Id: <20191101152510.11719-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Dm_yL6T2Ntabh4ZJIHMmKA-1
X-Mimecast-Spam-Score: 0
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

As I reasoned here:
https://lists.nongnu.org/archive/html/qemu-block/2019-11/msg00027.html
I=E2=80=99m no longer convinced of reverting c8bb23cbdbe.  I could see a
significant performance improvement from it on ext4 with aio=3Dnative in a
guest that does random 4k writes, and as such I feel it would be a
regression to revert it for 4.2.

To work around the XFS corruption, we still need the other three patches
from the series, of course.  We cannot restrict the workaround to just
XFS, because maybe the file is on a remote filesystem and then we don=E2=80=
=99t
know anything about the host configuration.

The performance impact should still be minimal because this just
serializes post-EOF write-zeroes and data writes, and that just doesn=E2=80=
=99t
happen very often, even with handle_alloc_space() in qcow2.


I would love to have more time to make a decision, but there simply
isn=E2=80=99t any.  Patches for 4.1.1 are to be collected on Monday, AFAIU.


v2:
- Dropped patch 1
- Forgot a =E2=80=9Ccoroutine_fn=E2=80=9D in patch 2 (it isn=E2=80=99t real=
ly important,
  qemu_coroutine_self() works in non-coroutine functions, too, but
  calling bdrv_(co_)get_self_request() from a non-coroutine just doesn=E2=
=80=99t
  make any sense)
- Patch 3:
  - Reverted the commit message to the RFC state to reflect that this is
    specifically because of handle_alloc_space()
  - Dropped the two lines that said there=E2=80=99d be no performance impac=
t at
    all because no driver would submit zero writes beyond the EOF
    (because qcow2 now still does)


git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respecti=
vely

001/3:[----] [--] 'block: Make wait/mark serialising requests public'
002/3:[0004] [FC] 'block: Add bdrv_co_get_self_request()'
003/3:[0002] [FC] 'block/file-posix: Let post-EOF fallocate serialize'


Max Reitz (3):
  block: Make wait/mark serialising requests public
  block: Add bdrv_co_get_self_request()
  block/file-posix: Let post-EOF fallocate serialize

 include/block/block_int.h |  4 ++++
 block/file-posix.c        | 36 +++++++++++++++++++++++++++++++++
 block/io.c                | 42 ++++++++++++++++++++++++++++-----------
 3 files changed, 70 insertions(+), 12 deletions(-)

--=20
2.21.0


