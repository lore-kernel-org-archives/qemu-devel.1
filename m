Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D62ECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 12:11:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A7020867
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 12:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A7020867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHRrn-0002fz-OC
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 08:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iHRpq-0000sd-4x
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 08:09:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iHRpo-0003YD-Op
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 08:09:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29195)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1iHRpl-0003V7-IO; Mon, 07 Oct 2019 08:09:49 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B5F4150F63;
 Mon,  7 Oct 2019 12:09:46 +0000 (UTC)
Received: from localhost (unknown [10.36.118.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E21A3196B2;
 Mon,  7 Oct 2019 12:09:38 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/16] io_uring: add Linux io_uring AIO engine
Date: Mon,  7 Oct 2019 13:09:21 +0100
Message-Id: <20191007120937.5862-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Mon, 07 Oct 2019 12:09:47 +0000 (UTC)
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
Cc: oleksandr@redhat.com, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Julia Suvorova <jusual@mail.ru>, Julia Suvorova <jusual@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v10:
 * Dropped kernel submission queue polling, it requires root and has addi=
tional
   limitations.  It should be benchmarked and considered for inclusion la=
ter,
   maybe even together with kernel side changes.
 * Add io_uring_register_files() return value to trace_luring_fd_register=
()
 * Fix indentation in luring_fd_unregister()
 * Set s->fd_reg.fd_array to NULL after g_free() to avoid dangling pointe=
rs
 * Simplify fd registration code
 * Add luring_fd_unregister() and call it from file-posix.c to prevent
   fd leaks
 * Add trace_luring_fd_unregister() trace event
 * Add missing space to qemu-img command-line documentation
 * Update MAINTAINERS file [Julia]
 * Rename MAX_EVENTS to MAX_ENTRIES [Julia]
 * Define ioq_submit() before callers so the prototype isn't necessary [J=
ulia]
 * Declare variables at the beginning of the block in luring_init() [Juli=
a]

This patch series is a rebased and cleaned up version of Aarushi Mehta's =
v9
patch series written for Google Summer of Code 2019:

  https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg00179.html

It adds a new AIO engine that uses the new Linux io_uring API.  This is t=
he
successor to Linux AIO with a number of improvements:
1. Both O_DIRECT and buffered I/O work
2. fdatasync(2) is supported (no need for a separate thread pool!)
3. True async behavior so the syscall doesn't block (Linux AIO got there =
to some degree...)
4. Advanced performance optimizations are available (file registration, m=
emory
   buffer registration, completion polling, submission polling).

Since Aarushi has been busy, I have resolved code review comments from v9=
.
Booting a guest works with -drive aio=3Dio_uring and -drive
aio=3Dio_uring,cache=3Dnone with a raw file on XFS.

I currently recommend using -drive aio=3Dio_uring only with host block de=
vices
(like NVMe devices).  As of Linux v5.4-rc1 I still hit kernel bugs when u=
sing
image files on ext4 or XFS.

Aarushi Mehta (16):
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
  block/io_uring: adds fd registration

 MAINTAINERS                   |   9 +
 qapi/block-core.json          |   4 +-
 configure                     |  27 ++
 block/Makefile.objs           |   3 +
 stubs/Makefile.objs           |   1 +
 include/block/aio.h           |  16 +-
 include/block/block.h         |   2 +
 include/block/raw-aio.h       |  13 +
 block.c                       |  22 ++
 block/file-posix.c            | 117 +++++--
 block/io_uring.c              | 581 ++++++++++++++++++++++++++++++++++
 blockdev.c                    |  12 +-
 qemu-img.c                    |  11 +-
 qemu-io.c                     |  25 +-
 qemu-nbd.c                    |  12 +-
 stubs/io_uring.c              |  32 ++
 util/async.c                  |  36 +++
 block/trace-events            |  14 +
 qemu-img-cmds.hx              |   4 +-
 qemu-img.texi                 |   5 +-
 qemu-nbd.texi                 |   4 +-
 tests/qemu-iotests/028        |   3 +-
 tests/qemu-iotests/058        |   2 +-
 tests/qemu-iotests/089        |   4 +-
 tests/qemu-iotests/091        |   7 +-
 tests/qemu-iotests/109        |   3 +-
 tests/qemu-iotests/147        |   5 +-
 tests/qemu-iotests/181        |  10 +-
 tests/qemu-iotests/183        |   7 +-
 tests/qemu-iotests/185        |  17 +-
 tests/qemu-iotests/200        |   3 +-
 tests/qemu-iotests/201        |  10 +-
 tests/qemu-iotests/check      |  15 +-
 tests/qemu-iotests/common.rc  |  14 +
 tests/qemu-iotests/iotests.py |  12 +-
 35 files changed, 982 insertions(+), 80 deletions(-)
 create mode 100644 block/io_uring.c
 create mode 100644 stubs/io_uring.c

--=20
2.21.0


