Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC58C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 12:44:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 114A120639
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 12:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114A120639
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb16M-0004OV-QH
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 07:44:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kb14i-0002ad-K5; Fri, 06 Nov 2020 07:42:40 -0500
Received: from relay.sw.ru ([185.231.240.75]:48018 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kb14c-0001CE-MK; Fri, 06 Nov 2020 07:42:39 -0500
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.94)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kb146-007cZw-CZ; Fri, 06 Nov 2020 15:42:02 +0300
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jcody@redhat.com, kwolf@redhat.com,
 mreitz@redhat.com, armbru@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, marcandre.lureau@redhat.com,
 den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com
Subject: [PATCH 0/2] Increase amount of data for monitor to read
Date: Fri,  6 Nov 2020 15:42:00 +0300
Message-Id: <1604666522-545580-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 07:42:29
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
From: Andrey Shinkevich via <qemu-devel@nongnu.org>

The subject was discussed here:
https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg00206.html

This series is a solution for the issue with QMP monitor buffered input.
A little parser is introduced to throttle JSON commands read from the
buffer so that QMP requests do not overwhelm the monitor input queue.
A side effect raised in the test #247 was managed in the first patch.
It may be considered as a workaround. Any sane fix suggested will be
appreciated.

Note:
This series goes after the Vladimir's one:
'[PATCH v3 00/25] backup performance: block_status + async"'
To make the test #129 passed, the following patch should be applied first:
'[PATCH v3 01/25] iotests: 129 don't check backup "busy"'.

Andrey Shinkevich (2):
  iotests: add another bash sleep command to 247
  monitor: increase amount of data for monitor to read

 chardev/char-fd.c          | 64 +++++++++++++++++++++++++++++++++++++++++++++-
 chardev/char-socket.c      | 54 +++++++++++++++++++++++++++-----------
 chardev/char.c             | 40 +++++++++++++++++++++++++++++
 include/chardev/char.h     | 15 +++++++++++
 monitor/monitor.c          |  2 +-
 tests/qemu-iotests/247     |  2 ++
 tests/qemu-iotests/247.out |  1 +
 7 files changed, 161 insertions(+), 17 deletions(-)

-- 
1.8.3.1


