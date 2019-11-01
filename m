Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C67CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 10:03:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C3CB2086D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 10:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddOyWIAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3CB2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQTmg-00007C-JS
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 06:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iQTjQ-00071I-2U
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 06:00:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iQTjM-0004bM-61
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 06:00:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49558
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iQTjL-0004Ry-Vx
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 06:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572602430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IvlS1i7GvVarZQWEF8BnedWSy8g7h93rb5mAYUYvq7U=;
 b=ddOyWIAm1B78BH+jY18x3V3azq2850a6DVYvfFRyh7bqVO09yd0JanuY88usjgjai/Hris
 RlLuYnZmHkxDXuAD7Lr57aXDLATrIE4MFYAAQqVbSWloY5aU+oZnAjOUxXuppUG6x8wu1E
 +zZP6u86cTIpiJDsFRfnqsreXLOSvjw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-PpH9KEJGMSilfeCKbtrY7w-1; Fri, 01 Nov 2019 06:00:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B6F4800A1A;
 Fri,  1 Nov 2019 10:00:25 +0000 (UTC)
Received: from localhost (ovpn-117-28.ams2.redhat.com [10.36.117.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C8F55D6B7;
 Fri,  1 Nov 2019 10:00:21 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-4.2 0/4] qcow2: Fix data corruption on XFS
Date: Fri,  1 Nov 2019 11:00:15 +0100
Message-Id: <20191101100019.9512-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: PpH9KEJGMSilfeCKbtrY7w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series builds on the previous RFC.  The workaround is now applied
unconditionally of AIO mode and filesystem because we don=E2=80=99t know th=
ose
things for remote filesystems.  Furthermore, bdrv_co_get_self_request()
has been moved to block/io.c.

Applying the workaround unconditionally is fine from a performance
standpoint, because it should actually be dead code, thanks to patch 1
(the elephant in the room).  As far as I know, there is no other block
driver but qcow2 in handle_alloc_space() that would submit zero writes
as part of normal I/O so it can occur concurrently to other write
requests.  It still makes sense to take the workaround for file-posix
because we can=E2=80=99t really prevent that any other block driver will su=
bmit
zero writes as part of normal I/O in the future.

Anyway, let=E2=80=99s get to the elephant.

From input by XFS developers
(https://bugzilla.redhat.com/show_bug.cgi?id=3D1765547#c7) it seems clear
that c8bb23cbdbe causes fundamental performance problems on XFS with
aio=3Dnative that cannot be fixed.  In other cases, c8bb23cbdbe improves
performance or we wouldn=E2=80=99t have it.

In general, avoiding performance regressions is more important than
improving performance, unless the regressions are just a minor corner
case or insignificant when compared to the improvement.  The XFS
regression is no minor corner case, and it isn=E2=80=99t insignificant.  La=
urent
Vivier has found performance to decrease by as much as 88 % (on ppc64le,
fio in a guest with 4k blocks, iodepth=3D8: 1662 kB/s from 13.9 MB/s).

Thus, I believe we should revert the commit for now (and most
importantly for 4.1.1).  We can think about reintroducing it for 5.0,
but that would require more extensive benchmarks on a variety of
systems, and we must see how subclusters change the picture.


I would have liked to do benchmarks myself before making this decision,
but as far as I=E2=80=99m informed, patches for 4.1.1 are to be collected o=
n
Monday, so we need to be quick.


git-backport-diff against the RFC:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respecti=
vely

001/4:[down] 'Revert "qcow2: skip writing zero buffers to empty COW areas"'
002/4:[----] [-C] 'block: Make wait/mark serialising requests public'
003/4:[down] 'block: Add bdrv_co_get_self_request()'
004/4:[0036] [FC] 'block/file-posix: Let post-EOF fallocate serialize'


Max Reitz (4):
  Revert "qcow2: skip writing zero buffers to empty COW areas"
  block: Make wait/mark serialising requests public
  block: Add bdrv_co_get_self_request()
  block/file-posix: Let post-EOF fallocate serialize

 qapi/block-core.json       |  4 +-
 block/qcow2.h              |  6 ---
 include/block/block_int.h  |  4 ++
 block/file-posix.c         | 38 +++++++++++++++++
 block/io.c                 | 42 +++++++++++++------
 block/qcow2-cluster.c      |  2 +-
 block/qcow2.c              | 86 --------------------------------------
 block/trace-events         |  1 -
 tests/qemu-iotests/060     |  7 +---
 tests/qemu-iotests/060.out |  5 +--
 10 files changed, 76 insertions(+), 119 deletions(-)

--=20
2.21.0


