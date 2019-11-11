Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9D0C17441
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:18:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1330B21783
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1330B21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54741 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUCOt-0001l6-F6
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 11:18:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39612)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iUCBO-0001Ls-SD
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:04:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iUCBN-0003SS-3z
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:04:50 -0500
Received: from relay.sw.ru ([185.231.240.75]:58212)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iUCBL-0003RS-AR; Mon, 11 Nov 2019 11:04:49 -0500
Received: from dhcp-172-16-25-136.sw.ru ([172.16.25.136])
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iUCBC-0003my-IZ; Mon, 11 Nov 2019 19:04:38 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Subject: [PATCH v6 0/3] qcow2: advanced compression options
Date: Mon, 11 Nov 2019 19:04:34 +0300
Message-Id: <1573488277-794975-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com,
 mreitz@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The compression filter driver is introduced as suggested by Max.
A sample usage of the filter can be found in the test #214.
Now, multiple clusters can be written compressed.
It is useful for the backup job.

v6: The new approach to write compressed data was applied. The patch
    v5 4/4 with the block-stream compress test case was removed from
    the series.
    Discussed in the email thread with the message ID
    <1571603828-185910-1-git-send-email-andrey.shinkevich@virtuozzo.com>

Andrey Shinkevich (3):
  block: introduce compress filter driver
  qcow2: Allow writing compressed data of multiple clusters
  tests/qemu-iotests: add case to write compressed data of multiple
    clusters

 block/Makefile.objs        |   1 +
 block/filter-compress.c    | 212 +++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c              | 102 ++++++++++++++++------
 qapi/block-core.json       |  10 ++-
 tests/qemu-iotests/214     |  43 +++++++++
 tests/qemu-iotests/214.out |  14 +++
 6 files changed, 351 insertions(+), 31 deletions(-)
 create mode 100644 block/filter-compress.c

-- 
1.8.3.1


