Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A150CC04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67A9221019
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="GJXDbLsn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A9221019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57673 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQBNJ-00049B-7Z
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 09:52:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hQBLZ-0002eJ-7V
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:50:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hQBHr-0005da-OO
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:46:42 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:36073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hQBHr-0005ck-7o; Mon, 13 May 2019 09:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Message-Id:Date:Subject:Cc:To:From;
	bh=btReAHRHCuFvfQx+iG6AzyW0yUEQEzXCyNk3tScU0jU=; 
	b=GJXDbLsnRaAKSlSsOti0XE9nlazNF67/9JFIek3jIp6qc+XHsnaMqbdFSOHls15NtdMp84/1s6VVrPRiJCQcAZxic87t52ld/yg3WSoJRd35LEuiefKEEVSVeWnFotzqmH/U4ilCmmw1nW0mJR9dF53NjznJvaRC+uoYlmQ6Btbzdb36RaV35a7Ua60v6owLxD3M5Ve8NsOughh8yTeI4iStc5Ifw6lDAM1e7FnASiQO6Zdmcjfre531IJI+cBE8sfUaox+As/pT+oAWcon+Vt15z2LoiW7NvLYGQO8CYnTLiksQ1Yyu/WQaJCuBtJBg2IQn5xW0tl6ecFfwNN6Dmg==;
Received: from mobile-access-bcee32-86.dhcp.inet.fi ([188.238.50.86]
	helo=perseus.local) by fanzine.igalia.com with esmtpsa 
	(Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
	id 1hQBHo-0003gg-DY; Mon, 13 May 2019 15:46:36 +0200
Received: from berto by perseus.local with local (Exim 4.89)
	(envelope-from <berto@igalia.com>)
	id 1hQBHb-0003Bu-7O; Mon, 13 May 2019 16:46:23 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 16:46:16 +0300
Message-Id: <cover.1557754872.git.berto@igalia.com>
X-Mailer: git-send-email 2.11.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: [Qemu-devel] [PATCH v3 0/2] block: Use bdrv_unref_child() for all
 children in bdrv_close()
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
	qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

the first patch is the same as in v2 (with an updated commit
message). The second patch is new and makes bdrv_root_attach_child()
unref child_bs on failure, as suggested by Max.

Regards,

Berto

v2: https://lists.gnu.org/archive/html/qemu-block/2019-05/msg00325.html
v1: https://lists.gnu.org/archive/html/qemu-block/2019-03/msg01040.html

Alberto Garcia (2):
  block: Use bdrv_unref_child() for all children in bdrv_close()
  block: Make bdrv_root_attach_child() unref child_bs on failure

 block.c                     | 41 ++++++++++++++++++++---------------------
 block/block-backend.c       |  3 +--
 block/quorum.c              |  1 -
 blockjob.c                  |  2 +-
 tests/test-bdrv-drain.c     |  6 ------
 tests/test-bdrv-graph-mod.c |  1 -
 6 files changed, 22 insertions(+), 32 deletions(-)

-- 
2.11.0


