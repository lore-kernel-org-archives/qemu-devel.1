Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072E6C33CAD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 12:00:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C715F207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 12:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kz9oCppl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C715F207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqyOI-0002vD-TY
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 07:00:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52575)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iqyN3-0002Oi-SD
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 06:59:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iqyN2-0008IE-Cs
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 06:59:01 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40529
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iqyN2-0008HM-8Y
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 06:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578916739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kMNKVyABPlIk6UJgm5HtAouQThBJN84/ajuclTe9WBQ=;
 b=Kz9oCpplBJlDsF7CbAeKVojbIbE2Kr0fw8HfufQPe19/wPl2pNoQLdtFeGY/1Bb5OFgCqz
 suVW+/lH8bke/sAqZi71Oz+bSjQTtOcHTJlUQo6/ryk2o0Cbgu4u3bTiQE7aXpkfOj6GZ9
 c3tHLDmUzt2Uu49w8jSIxjFOpYUgMiM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-HeoZ6d1CMJCp6YiEAlUZPA-1; Mon, 13 Jan 2020 06:58:58 -0500
Received: by mail-wm1-f72.google.com with SMTP id t4so2437182wmf.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 03:58:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qnzbM3DCETvXRh37tJdNU8cgWIlMtq0MWy96CN+O+50=;
 b=XAvzNzSdeKapK3d9Ezkgo6nWcV7/2w2foQ3A8vEcc2gpO8thrRw9seWsaj0AbqEEo/
 zv0nskzFpUo5mafTLQWtNDBxUewBgkGFoXHWBaZAYkXIwfkEBN3O7qRoW9nAZdHA4SxS
 OyOOA2wUcaxF7/y0S4uDun9XW8t1/NpmAYYtdthw+e/rR7T72ft0z8Dw4OEempPuUqhu
 PQLltHMiJ2DT6vApK9eyAnFPP8wlBUAIz+VTdFjyQmjyCtEMn3ZD9yGzDascqJavCXnw
 MkXtBP7Zod+KeSzzT+aIyu01xJ5KwnLoD2+X+h92k5oa/uhz34CG3ti10MnyxEM8SYnf
 HXJQ==
X-Gm-Message-State: APjAAAWhGScYW5p2nOcYdzaQN+tnesY408HfPJDcAUtzUZllDwy2D0to
 lVOYMP9q8gnRdGBHOgH982jU1nD6w955ItZh3bNgCwyLaIymeT8FuRrvg4DRV1umpa+Jv2ojShT
 aLssaiEzuPFdGdmM=
X-Received: by 2002:a1c:99ce:: with SMTP id
 b197mr19652267wme.108.1578916736943; 
 Mon, 13 Jan 2020 03:58:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqyE0dvGtXAomy5Mi0dXk01pcgtSHKZxErQ77SJ85j5BWTIY2GPmRNV01hgZNnFQXh9aLVOW7w==
X-Received: by 2002:a1c:99ce:: with SMTP id
 b197mr19652233wme.108.1578916736629; 
 Mon, 13 Jan 2020 03:58:56 -0800 (PST)
Received: from steredhat (host84-49-dynamic.31-79-r.retail.telecomitalia.it.
 [79.31.49.84])
 by smtp.gmail.com with ESMTPSA id z4sm14302662wma.2.2020.01.13.03.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2020 03:58:55 -0800 (PST)
Date: Mon, 13 Jan 2020 12:58:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3 00/15] io_uring: add Linux io_uring AIO engine
Message-ID: <20200113115853.jbzlirpqboxg5q3b@steredhat>
References: <20191218163228.1613099-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191218163228.1613099-1-stefanha@redhat.com>
X-MC-Unique: HeoZ6d1CMJCp6YiEAlUZPA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, oleksandr@redhat.com,
 Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The series LGTM, just some comments on patches 4 and 8.

I succefully tried iotests on raw and qcow2 with io_uring, so

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

On Wed, Dec 18, 2019 at 04:32:13PM +0000, Stefan Hajnoczi wrote:
> v12:
>  * Reword BlockdevAioOptions QAPI schema commit description [Markus]
>  * Increase QAPI "Since: 4.2" to "Since: 5.0"
>  * Explain rationale for io_uring stubs in commit description [Kevin]
>  * Tried to use file.aio=3Dio_uring instead of BDRV_O_IO_URING but it's r=
eally
>    hard to make qemu-iotests work.  Tests build blkdebug: and other graph=
s so
>    the syntax for io_uring is dependent on the test case.  I scrapped thi=
s
>    approach and went back to a global flag.
>=20
> v11:
>  * Drop fd registration because it breaks QEMU's file locking and will ne=
ed to
>    be resolved in a separate patch series
>  * Drop line-wrapping changes that accidentally broke several qemu-iotest=
s
>=20
> v10:
>  * Dropped kernel submission queue polling, it requires root and has addi=
tional
>    limitations.  It should be benchmarked and considered for inclusion la=
ter,
>    maybe even together with kernel side changes.
>  * Add io_uring_register_files() return value to trace_luring_fd_register=
()
>  * Fix indentation in luring_fd_unregister()
>  * Set s->fd_reg.fd_array to NULL after g_free() to avoid dangling pointe=
rs
>  * Simplify fd registration code
>  * Add luring_fd_unregister() and call it from file-posix.c to prevent
>    fd leaks
>  * Add trace_luring_fd_unregister() trace event
>  * Add missing space to qemu-img command-line documentation
>  * Update MAINTAINERS file [Julia]
>  * Rename MAX_EVENTS to MAX_ENTRIES [Julia]
>  * Define ioq_submit() before callers so the prototype isn't necessary [J=
ulia]
>  * Declare variables at the beginning of the block in luring_init() [Juli=
a]
>=20
> This patch series is based on Aarushi Mehta's v9 patch series written for
> Google Summer of Code 2019:
>=20
>   https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg00179.html
>=20
> It adds a new AIO engine that uses the new Linux io_uring API.  This is t=
he
> successor to Linux AIO with a number of improvements:
> 1. Both O_DIRECT and buffered I/O work
> 2. fdatasync(2) is supported (no need for a separate thread pool!)
> 3. True async behavior so the syscall doesn't block (Linux AIO got there =
to some degree...)
> 4. Advanced performance optimizations are available (file registration, m=
emory
>    buffer registration, completion polling, submission polling).
>=20
> Since Aarushi has been busy, I have taken up this patch series.  Booting =
a
> guest works with -drive aio=3Dio_uring and -drive aio=3Dio_uring,cache=3D=
none with a
> raw file on XFS.
>=20
> I currently recommend using -drive aio=3Dio_uring only with host block de=
vices
> (like NVMe devices).  As of Linux v5.4-rc1 I still hit kernel bugs when u=
sing
> image files on ext4 or XFS.
>=20
> Aarushi Mehta (15):
>   configure: permit use of io_uring
>   qapi/block-core: add option for io_uring
>   block/block: add BDRV flag for io_uring
>   block/io_uring: implements interfaces for io_uring
>   stubs: add stubs for io_uring interface
>   util/async: add aio interfaces for io_uring
>   blockdev: adds bdrv_parse_aio to use io_uring
>   block/file-posix.c: extend to use io_uring
>   block: add trace events for io_uring
>   block/io_uring: adds userspace completion polling
>   qemu-io: adds option to use aio engine
>   qemu-img: adds option to use aio engine for benchmarking
>   qemu-nbd: adds option for aio engines
>   tests/qemu-iotests: enable testing with aio options
>   tests/qemu-iotests: use AIOMODE with various tests
>=20
>  MAINTAINERS                   |   9 +
>  block.c                       |  22 ++
>  block/Makefile.objs           |   3 +
>  block/file-posix.c            |  95 ++++++--
>  block/io_uring.c              | 433 ++++++++++++++++++++++++++++++++++
>  block/trace-events            |  12 +
>  blockdev.c                    |  12 +-
>  configure                     |  27 +++
>  include/block/aio.h           |  16 +-
>  include/block/block.h         |   2 +
>  include/block/raw-aio.h       |  12 +
>  qapi/block-core.json          |   4 +-
>  qemu-img-cmds.hx              |   4 +-
>  qemu-img.c                    |  11 +-
>  qemu-img.texi                 |   5 +-
>  qemu-io.c                     |  25 +-
>  qemu-nbd.c                    |  12 +-
>  qemu-nbd.texi                 |   4 +-
>  stubs/Makefile.objs           |   1 +
>  stubs/io_uring.c              |  32 +++
>  tests/qemu-iotests/028        |   2 +-
>  tests/qemu-iotests/058        |   2 +-
>  tests/qemu-iotests/089        |   4 +-
>  tests/qemu-iotests/091        |   4 +-
>  tests/qemu-iotests/109        |   2 +-
>  tests/qemu-iotests/147        |   5 +-
>  tests/qemu-iotests/181        |   8 +-
>  tests/qemu-iotests/183        |   4 +-
>  tests/qemu-iotests/185        |  10 +-
>  tests/qemu-iotests/200        |   2 +-
>  tests/qemu-iotests/201        |   8 +-
>  tests/qemu-iotests/check      |  15 +-
>  tests/qemu-iotests/common.rc  |  14 ++
>  tests/qemu-iotests/iotests.py |  12 +-
>  util/async.c                  |  36 +++
>  35 files changed, 793 insertions(+), 76 deletions(-)
>  create mode 100644 block/io_uring.c
>  create mode 100644 stubs/io_uring.c
>=20
> --=20
> 2.23.0
>=20
>=20


