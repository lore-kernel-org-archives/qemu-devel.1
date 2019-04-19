Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1B1C282DA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 14:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D5A222C8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 14:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D5A222C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57006 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHUAA-0005fk-NC
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 10:06:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hHU8A-000450-NN
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 10:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hHTvg-00075R-Cv
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 09:51:49 -0400
Received: from relay.sw.ru ([185.231.240.75]:33730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hHTvg-0006z7-54; Fri, 19 Apr 2019 09:51:48 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hHTva-0008V2-Qa; Fri, 19 Apr 2019 16:51:43 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Fri, 19 Apr 2019 16:51:39 +0300
Message-Id: <20190419135142.91810-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v2 0/3] Fix overflow bug in qcow2 discard
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
	den@virtuozzo.com, mreitz@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190419135139.nbiWMfj-G2ZqjThVfocmzIAEPWTYbodVUH0fQ_MvSPU@z>

v2: [mostly by Eric's review]
01: new
02: point to bug introducing commit in cover letter [Eric]
     [but I failed to compile it, to check]
    drop s/INT_MAX/BDRV_REQUEST_MAX_BYTES/ chunk
03: - improve wording
    - cheating with preallocation=metadata and discards
      to make test quick and not eating disk space
    - use new trace-point
    - move it to be 250 iotest
    - filter out extra qemu-img info output

Vladimir Sementsov-Ogievskiy (3):
  block/qcow2-refcount: add trace-point to qcow2_process_discards
  block/io: bdrv_pdiscard: support int64_t bytes parameter
  iotests: test big qcow2 shrink

 include/block/block.h      |  4 +--
 block/io.c                 | 16 ++++-----
 block/qcow2-refcount.c     |  7 +++-
 block/trace-events         |  3 ++
 tests/qemu-iotests/250     | 72 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/250.out | 21 +++++++++++
 tests/qemu-iotests/group   |  1 +
 7 files changed, 113 insertions(+), 11 deletions(-)
 create mode 100755 tests/qemu-iotests/250
 create mode 100644 tests/qemu-iotests/250.out

-- 
2.18.0


