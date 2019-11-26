Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5DEC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 15:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 935D420722
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 15:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 935D420722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZd7o-00055b-I8
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 10:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iZd5G-0003Ej-Fr
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 10:48:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iZd5E-0002e9-Ug
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 10:48:57 -0500
Received: from relay.sw.ru ([185.231.240.75]:52198)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iZd5E-0002c5-N2; Tue, 26 Nov 2019 10:48:56 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iZd57-00069i-Dj; Tue, 26 Nov 2019 18:48:49 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Subject: [PATCH for-5.0 v2 0/3] benchmark util
Date: Tue, 26 Nov 2019 18:48:45 +0300
Message-Id: <20191126154848.193407-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, ehabkost@redhat.com,
 stefanha@gmail.com, mreitz@redhat.com, crosa@redhat.com, den@openvz.org,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

Here is simple benchmarking utility, to generate performance
comparison tables, like the following:

----------  -------------  -------------  -------------
            backup-1       backup-2       mirror
ssd -> ssd  0.43 +- 0.00   4.48 +- 0.06   4.38 +- 0.02
ssd -> hdd  10.60 +- 0.08  10.69 +- 0.18  10.57 +- 0.05
ssd -> nbd  33.81 +- 0.37  10.67 +- 0.17  10.07 +- 0.07
----------  -------------  -------------  -------------

This is a v2, as v1 was inside
 "[RFC 00/24] backup performance: block_status + async"

I'll use this benchmark in other series, hope someone
will like it.

Vladimir Sementsov-Ogievskiy (3):
  python: add simplebench.py
  python: add qemu/bench_block_job.py
  python: add example usage of simplebench

 python/bench-example.py        |  80 +++++++++++++++++++++
 python/qemu/bench_block_job.py | 115 +++++++++++++++++++++++++++++
 python/simplebench.py          | 128 +++++++++++++++++++++++++++++++++
 3 files changed, 323 insertions(+)
 create mode 100644 python/bench-example.py
 create mode 100755 python/qemu/bench_block_job.py
 create mode 100644 python/simplebench.py

-- 
2.18.0


