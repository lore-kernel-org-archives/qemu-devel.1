Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D502C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 14:25:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ED1D2184E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 14:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Ww71ekNQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED1D2184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49746 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEae4-0005Wa-9w
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 10:25:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hEacb-0004cp-MA
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:24:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hEaca-00012K-Nf
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:24:09 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:49198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hEaca-00011P-Bw; Thu, 11 Apr 2019 10:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Message-Id:Date:Subject:Cc:To:From;
	bh=8edIT6hfQTriU4BADE+MYfrkI9JtaqJStnE7WO3cMHI=; 
	b=Ww71ekNQINfGAtVo7xjsbqS5tKDMWkiNjDuP9s1KQGr+HrI0Ofw6GSVml7fCWqJ3y4MfXVNLkSwWkny6nqZf/VAc9PlfDi7EqfICcvTfqauNiaHP2notSwwbphW2IuqbXCK0pIi7xzrGKF8gy7iu4xwfWYGDUrdNu8O51ZFhQnDJYUoszNwb3jegwwB6FhKXniNAS1NUtaa338pFLGVOcxsWrzwMKn77lMb6MHYnd7sBWoaWC8KNRThV9ILrue1aGdLtL7PmQtiiJCar5HRC6uXxkzySTo6+dqi2byVhjwqa4iNaaZ/d1H3jU3hS7sipVipJNlinWyZy/supOp1b6g==;
Received: from 178-55-128-240.bb.dnainternet.fi ([178.55.128.240]
	helo=perseus.local) by fanzine.igalia.com with esmtpsa 
	(Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
	id 1hEacW-00019J-8I; Thu, 11 Apr 2019 16:24:04 +0200
Received: from berto by perseus.local with local (Exim 4.89)
	(envelope-from <berto@igalia.com>)
	id 1hEacG-0001hz-WA; Thu, 11 Apr 2019 17:23:49 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Apr 2019 17:23:44 +0300
Message-Id: <cover.1554992449.git.berto@igalia.com>
X-Mailer: git-send-email 2.11.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: [Qemu-devel] [PATCH for-4.1 0/2] Fix check for default backing
 files in bdrv_reopen_prepare()
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190411142344.2ERZE6Jjvve_22x9cxmZ5JE__KzKjoZysLn2PlJ_ILU@z>

Hi,

Patch 1 is the fix for the bug reported by Max here:

   https://lists.gnu.org/archive/html/qemu-block/2019-04/msg00293.html

Patch 2 fixes a different (but slightly related) issue that I found
while preparing the first patch.

Regards,

Berto

Alberto Garcia (2):
  block: Fix check for default backing files in bdrv_reopen_prepare()
  block: Clear the backing_file fields on detach

 block.c                | 6 +++++-
 tests/qemu-iotests/245 | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.11.0


