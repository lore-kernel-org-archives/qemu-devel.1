Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC49CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:12:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7FD02053B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d53d+jUN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7FD02053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO2CV-0003Jl-G4
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 12:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iO25H-0002Xm-Tg
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:05:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iO25F-0002uL-H8
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:05:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39891
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iO25F-0002tx-AN
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572019499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2YYRP6MRcDJkjwfNL/iCRFseoLbMRbGLdzo8Cnwzv9U=;
 b=d53d+jUNyWFw0LcD00136CxqrLRo2364FjXkfQBiWsmx9O2s/O9AJa6DSQqPn08PSkLF99
 162DJiuWOoKOjRLz5qMwKxDHRHi9tXXyk/A6K7mbbMGWX7PtG3oSCWSywiBMqWI7XRFKDw
 ff3mTYMMvPo06Rfo9sF91T3UpOptAWw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-ZoO8sFtCNfewx88sSScl9A-1; Fri, 25 Oct 2019 12:04:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C7A9476;
 Fri, 25 Oct 2019 16:04:53 +0000 (UTC)
Received: from localhost (ovpn-117-215.ams2.redhat.com [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CCC1660BF4;
 Fri, 25 Oct 2019 16:04:45 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/15] io_uring: add Linux io_uring AIO engine
Date: Fri, 25 Oct 2019 18:04:29 +0200
Message-Id: <20191025160444.31632-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: ZoO8sFtCNfewx88sSScl9A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Fam Zheng <fam@euphon.net>, oleksandr@redhat.com, qemu-block@nongnu.org,
 Julia Suvorova <jusual@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v11:
 * Drop fd registration because it breaks QEMU's file locking and will need=
 to
   be resolved in a separate patch series
 * Drop line-wrapping changes that accidentally broke several qemu-iotests

v10:
 * Dropped kernel submission queue polling, it requires root and has additi=
onal
   limitations.  It should be benchmarked and considered for inclusion late=
r,
   maybe even together with kernel side changes.
 * Add io_uring_register_files() return value to trace_luring_fd_register()
 * Fix indentation in luring_fd_unregister()
 * Set s->fd_reg.fd_array to NULL after g_free() to avoid dangling pointers
 * Simplify fd registration code
 * Add luring_fd_unregister() and call it from file-posix.c to prevent
   fd leaks
 * Add trace_luring_fd_unregister() trace event
 * Add missing space to qemu-img command-line documentation
 * Update MAINTAINERS file [Julia]
 * Rename MAX_EVENTS to MAX_ENTRIES [Julia]
 * Define ioq_submit() before callers so the prototype isn't necessary [Jul=
ia]
 * Declare variables at the beginning of the block in luring_init() [Julia]

This patch series is based on Aarushi Mehta's v9 patch series written for
Google Summer of Code 2019:

  https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg00179.html

It adds a new AIO engine that uses the new Linux io_uring API.  This is the
successor to Linux AIO with a number of improvements:
1. Both O_DIRECT and buffered I/O work
2. fdatasync(2) is supported (no need for a separate thread pool!)
3. True async behavior so the syscall doesn't block (Linux AIO got there to=
 some degree...)
4. Advanced performance optimizations are available (file registration, mem=
ory
   buffer registration, completion polling, submission polling).

Since Aarushi has been busy, I have taken up this patch series.  Booting a
guest works with -drive aio=3Dio_uring and -drive aio=3Dio_uring,cache=3Dno=
ne with a
raw file on XFS.

I currently recommend using -drive aio=3Dio_uring only with host block devi=
ces
(like NVMe devices).  As of Linux v5.4-rc1 I still hit kernel bugs when usi=
ng
image files on ext4 or XFS.

Aarushi Mehta (15):
  configure: permit use of io_uring
  qapi/block-core: add option for io_uring
  block/block: add BDRV flag for io_uring
  block/io_uring: implements interfaces for io_uring
  stubs: add stubs for io_uring interface
  util/async: add aio interfaces for io_uring
  blockdev: adds bdrv_parse_aio to use io_uring
  block/file-posix.c: extend to use io_uring
  block: add trace events for io_uring
  block/io_uring: adds userspace completion polling
  qemu-io: adds option to use aio engine
  qemu-img: adds option to use aio engine for benchmarking
  qemu-nbd: adds option for aio engines
  tests/qemu-iotests: enable testing with aio options
  tests/qemu-iotests: use AIOMODE with various tests

 MAINTAINERS                   |   9 +
 qapi/block-core.json          |   4 +-
 configure                     |  27 +++
 block/Makefile.objs           |   3 +
 stubs/Makefile.objs           |   1 +
 include/block/aio.h           |  16 +-
 include/block/block.h         |   2 +
 include/block/raw-aio.h       |  12 +
 block.c                       |  22 ++
 block/file-posix.c            |  99 ++++++--
 block/io_uring.c              | 433 ++++++++++++++++++++++++++++++++++
 blockdev.c                    |  12 +-
 qemu-img.c                    |  11 +-
 qemu-io.c                     |  25 +-
 qemu-nbd.c                    |  12 +-
 stubs/io_uring.c              |  32 +++
 util/async.c                  |  36 +++
 block/trace-events            |  12 +
 qemu-img-cmds.hx              |   4 +-
 qemu-img.texi                 |   5 +-
 qemu-nbd.texi                 |   4 +-
 tests/qemu-iotests/028        |   2 +-
 tests/qemu-iotests/058        |   2 +-
 tests/qemu-iotests/089        |   4 +-
 tests/qemu-iotests/091        |   4 +-
 tests/qemu-iotests/109        |   2 +-
 tests/qemu-iotests/147        |   5 +-
 tests/qemu-iotests/181        |   8 +-
 tests/qemu-iotests/183        |   4 +-
 tests/qemu-iotests/185        |  10 +-
 tests/qemu-iotests/200        |   2 +-
 tests/qemu-iotests/201        |   8 +-
 tests/qemu-iotests/check      |  15 +-
 tests/qemu-iotests/common.rc  |  14 ++
 tests/qemu-iotests/iotests.py |  12 +-
 35 files changed, 797 insertions(+), 76 deletions(-)
 create mode 100644 block/io_uring.c
 create mode 100644 stubs/io_uring.c

--=20
2.21.0


