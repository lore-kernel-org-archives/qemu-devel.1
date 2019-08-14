Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656E2C32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 10:09:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F172067D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 10:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F172067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxqDF-0007pX-DY
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 06:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54245)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxqBy-0006I1-SC
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 06:07:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxqBx-0007Qn-V7
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 06:07:42 -0400
Received: from relay.sw.ru ([185.231.240.75]:39974)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxqBv-0007Nx-MN; Wed, 14 Aug 2019 06:07:39 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxqBs-00066c-Oa; Wed, 14 Aug 2019 13:07:36 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Wed, 14 Aug 2019 13:07:33 +0300
Message-Id: <20190814100735.24234-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 0/2] Deprecate implicit filters
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, libvir-list@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, jsnow@redhat.com,
 den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

Max's series to fix some problems around filters consists of 42 patches.
I'm sure that we didn't find all bugs around filters, and that filters
would be a constant source of bugs in future, as during developing new
feature nobody will consider all possible cases of dealing with filters
(OK, somebody will, but it's hard).

So, I'm thinking about starting some deprecations which will help us to
simplify all the picture at least in not far future. So, I'd really want
to deprecate implicit filters, ->file child based filters (move all
filters to use backing child), filename based interfaces (use node-names).

Most simple thing is implicit filters, so let's start from them.
drive-mirror don't support filter-node-name, so I propose to deprecate
it at all, together with drive-backup, instead of adding support of
filter-node-name, what do you think?

Vladimir Sementsov-Ogievskiy (2):
  qapi: deprecate drive-mirror and drive-backup
  qapi: deprecate implicit filters

 qemu-deprecated.texi      | 11 +++++++++++
 qapi/block-core.json      | 10 ++++++++--
 qapi/transaction.json     |  2 +-
 include/block/block_int.h | 10 +++++++++-
 blockdev.c                | 20 ++++++++++++++++++++
 5 files changed, 49 insertions(+), 4 deletions(-)

-- 
2.18.0


