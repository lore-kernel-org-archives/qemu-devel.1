Return-Path: <SRS0=GiFh=S6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2C3C43218
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 10:02:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58F0D20644
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 10:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F0D20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=didiglobal.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42055 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKgdq-0008SS-58
	for qemu-devel@archiver.kernel.org; Sun, 28 Apr 2019 06:02:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liliangleo@didiglobal.com>) id 1hKgcv-00087s-3H
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 06:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liliangleo@didiglobal.com>) id 1hKgct-0004pd-Us
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 06:01:41 -0400
Received: from mx2.didichuxing.com ([36.110.17.22]:27867
	helo=bsf02.didichuxing.com) by eggs.gnu.org with smtp (Exim 4.71)
	(envelope-from <liliangleo@didiglobal.com>) id 1hKgcs-0004ml-6L
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 06:01:39 -0400
X-ASG-Debug-ID: 1556445690-0e41087d3ba24550001-jgbH7p
Received: from BJEXCAS01.didichuxing.com (bogon [172.20.36.235]) by
	bsf02.didichuxing.com with ESMTP id Rz9F7CnSQkZZLQnb;
	Sun, 28 Apr 2019 18:01:30 +0800 (CST)
X-Barracuda-Envelope-From: liliangleo@didiglobal.com
Received: from localhost (172.30.32.122) by BJSGEXMBX04.didichuxing.com
	(172.20.15.134) with Microsoft SMTP Server (TLS) id 15.0.1263.5;
	Sun, 28 Apr 2019 18:01:29 +0800
Date: Sun, 28 Apr 2019 18:01:17 +0800
From: Liang Li <liliangleo@didiglobal.com>
To: <qemu-block@nongnu.org>, <qemu-devel@nongnu.org>
Message-ID: <20190428100052.GA63525@localhost>
X-ASG-Orig-Subj: [PATCH 0/2] buffer and delay backup COW write operation
Mail-Followup-To: qemu-block@nongnu.org, qemu-devel@nongnu.org,
	John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
	Max Reitz <mreitz@redhat.com>,
	Wen Congyang <wencongyang2@huawei.com>,
	Xie Changlong <xiechanglong.d@gmail.com>,
	Markus Armbruster <armbru@redhat.com>,
	Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [172.30.32.122]
X-ClientProxiedBy: BJEXCAS06.didichuxing.com (172.20.36.207) To
	BJSGEXMBX04.didichuxing.com (172.20.15.134)
X-Barracuda-Connect: bogon[172.20.36.235]
X-Barracuda-Start-Time: 1556445690
X-Barracuda-URL: https://bsf02.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 1851
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
	SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
	QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.70512
	Rule breakdown below
	pts rule name              description
	---- ----------------------
	--------------------------------------------------
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 36.110.17.22
Subject: [Qemu-devel] [PATCH 0/2] buffer and delay backup COW write operation
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
	Wen Congyang <wencongyang2@huawei.com>,
	Xie Changlong <xiechanglong.d@gmail.com>,
	Markus Armbruster <armbru@redhat.com>,
	Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190428100117.sf7JdWCjCBT2SCu8uuoVzHh2R5zwG0x2HorEFHG7Tjs@z>

If the backup target is a slow device like ceph rbd, the backup
process will affect guest BLK write IO performance seriously,
it's cause by the drawback of COW mechanism, if guest overwrite the
backup BLK area, the IO can only be processed after the data has
been written to backup target.
The impact can be relieved by buffering data read from backup
source and writing to backup target later, so the guest BLK write
IO can be processed in time.
Data area with no overwrite will be process like before without
buffering, in most case, we don't need a very large buffer.

An fio test was done when the backup was going on, the test resut
show a obvious performance improvement by buffering.

Test result(1GB buffer):
========================
fio setting:
[random-writers]
ioengine=libaio
iodepth=8
rw=randwrite
bs=32k
direct=1
size=1G
numjobs=1

result:
                      IOPS        AVG latency
       no backup:     19389         410 us
          backup:      1402        5702 us
backup w/ buffer:      8684         918 us
==============================================

Cc: John Snow <jsnow@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Wen Congyang <wencongyang2@huawei.com>
Cc: Xie Changlong <xiechanglong.d@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Fam Zheng <fam@euphon.net>

Liang Li (2):
  backup: buffer COW request and delay the write operation
  qapi: add interface for setting backup cow buffer size

 block/backup.c            | 118 +++++++++++++++++++++++++++++++++++++++++-----
 block/replication.c       |   2 +-
 blockdev.c                |   5 ++
 include/block/block_int.h |   2 +
 qapi/block-core.json      |   5 ++
 5 files changed, 118 insertions(+), 14 deletions(-)

-- 
2.14.1


