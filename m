Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D255AC76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:27:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0E3321849
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9LySCUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E3321849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoSvW-000379-NV
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35590)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hoSvA-0001np-UJ
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hoSv9-0000zY-Nf
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:27:36 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:37330)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hoSv9-0000yg-IG
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:27:35 -0400
Received: by mail-pg1-x543.google.com with SMTP id i70so3734612pgd.4
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 06:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SoHFuIb8qMT9oZXOEL0EMG5W0djtXLWjWyK7Xrjx2RU=;
 b=D9LySCUkGw4n+hP1y/g0bAiDjgmmbiWx4/RrhzBhY9e0+FtZCoC/49RHfwtw+j6w12
 xN8ozk7EepSYwlMs4mbJiapQ5gLcor+pYtNxCYWjVkcvELscBYxaRuIe574ePuKuh+la
 FfnrNUGhPqHWpEXWTNymrI7SN9tLkxKqxhjk1WszkQx6w8oQMQxZSSXyGBoej0twrqMZ
 W7K91Ri+qXA1aRZHOAAgXVZ1fR1ezBS4CCr6/XIa4QGEIpQxq6s9EsnNY4rHEs7KE68C
 099VyH/dTWjsMNmfbD7T/9eZw81a+Cqe/TRHjeIivDTAoR+TRiDzZnzW6FPPRiwpATLg
 4jwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SoHFuIb8qMT9oZXOEL0EMG5W0djtXLWjWyK7Xrjx2RU=;
 b=gMqty1x+n0EeasqoI7Do6Ovf0/xsV06qJQMEOl6Usn7kz9rxdutLZmoob+c3XfDbqC
 TOeLYOsfKh1tE4OVZQwprEeEwj6VmUBD7NYF8Rj/nbyq9aHm7Des0T2ePWWq+FKS8IPV
 hVcnVJ690yigXYxcYIgL3Kz++now6Hb9TzTQWMHXKtEwB5Js1E1x/pByxwqtWx8oC6rI
 y8TYUkpdzm4PnLHdcC0pFu5yEs/PfbaR26oOWcCF1Pa0TV1ya6V+cGTH0b3rqC08rpNF
 jGReweuKP2bRDOZmgkiB7CNc2yEurLOoW1mfuOWkwUdm7zSWZKAtukWAi4fqQiIxTQW7
 f+oA==
X-Gm-Message-State: APjAAAV8Em3S40wAcAa1FpC9y8xe12226ybowLl8hMLUAUtw0I6MlR/T
 DqiFdlfnLapUpnuNUlFqpJClYStq
X-Google-Smtp-Source: APXvYqzBDZtfyfQpn94Oj33aIZQiUbXGc0OCHlCtl9BMlhe4Y1REpNRlS2c3/2e/4WvLQT2o+7+OPQ==
X-Received: by 2002:a17:90a:374a:: with SMTP id
 u68mr57675779pjb.4.1563542853486; 
 Fri, 19 Jul 2019 06:27:33 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:433:31a4:f2fb:dab8:3a89:c056])
 by smtp.gmail.com with ESMTPSA id s7sm26520357pjn.28.2019.07.19.06.27.31
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 06:27:32 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 18:57:06 +0530
Message-Id: <20190719132720.27519-1-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v6 00/14] Add support for io_uring
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
Cc: Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series adds support for the newly developed io_uring Linux AIO
interface. Linux io_uring is faster than Linux's AIO asynchronous I/O code,
offers efficient buffered asynchronous I/O support, the ability to do I/O
without performing a system call via polled I/O, and other efficiency enhancements.

Testing it requires a host kernel (5.1+) and the liburing library.
Use the option -drive aio=io_uring to enable it.

Benchmarks for the system at https://github.com/rooshm/benchmarks
io_uring has similar performance as libaio but supports cache=writeback.
Further performance enhancement will be implemented

There is currently an -EIO output when guests are booted from io_uring
disks for the second time with clean shutdowns that is being investigated.

v6:
- add slow path for short-read
- hooks up fsync
- enables qemu-iotests with aio options
- adds bdrv_parse_aio

v5:
- Adds completion polling
- Extends qemu-io
- Adds qemu-iotest

v4:
- Add error handling
- Add trace events
- Remove aio submission based code

Aarushi Mehta (14):
  configure: permit use of io_uring
  qapi/block-core: add option for io_uring
  block/block: add BDRV flag for io_uring
  block/io_uring: implements interfaces for io_uring
  stubs: add stubs for io_uring interface
  util/async: add aio interfaces for io_uring
  blockdev: accept io_uring as option
  block/file-posix.c: extend to use io_uring
  block: add trace events for io_uring
  block/io_uring: adds userspace completion polling
  qemu-io: adds option to use aio engine
  qemu-img: adds option to use aio engine
  qemu-nbd: adds option for aio engines
  tests/qemu-iotest: enable testing with qemu-io aio options

 MAINTAINERS                  |   8 +
 block.c                      |  22 ++
 block/Makefile.objs          |   3 +
 block/file-posix.c           |  99 ++++++--
 block/io_uring.c             | 439 +++++++++++++++++++++++++++++++++++
 block/trace-events           |  12 +
 blockdev.c                   |  12 +-
 configure                    |  27 +++
 include/block/aio.h          |  16 +-
 include/block/block.h        |   2 +
 include/block/raw-aio.h      |  12 +
 qapi/block-core.json         |   4 +-
 qemu-img.c                   |  11 +-
 qemu-io.c                    |  25 +-
 qemu-nbd.c                   |  12 +-
 stubs/Makefile.objs          |   1 +
 stubs/io_uring.c             |  32 +++
 tests/qemu-iotests/check     |  14 +-
 tests/qemu-iotests/common.rc |  10 +
 util/async.c                 |  36 +++
 20 files changed, 746 insertions(+), 51 deletions(-)
 create mode 100644 block/io_uring.c
 create mode 100644 stubs/io_uring.c

-- 
2.21.0


