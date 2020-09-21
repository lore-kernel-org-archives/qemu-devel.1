Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624ADC43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:35:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8DC220708
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="fycE8xRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8DC220708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKMv0-0007EK-Tn
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 10:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kKMqb-0003jR-Ho; Mon, 21 Sep 2020 10:31:17 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:47073)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kKMqV-000489-Po; Mon, 21 Sep 2020 10:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
 bh=v4gKZaqKz1G+sKMjhNDHmeGnrnmkuq3yo8FI13XopGw=; 
 b=fycE8xRFlW204ERnaYgctSRQD7P6MmH1BOI39smnolN/QBcskMzGEZLkLrl09ovInsf5eWnlfEsr1soE/Jl0cTezpNPLz9Hh3EQcQ6kOJ0qb63UmMX+ZAuTDQLVsc8CKTEfmBT3yFvXpSLKPT1tPx1WGPXZsa6Zl/+4tWbEIG/CVm8HKUL5JhWuF560O2vnrveI1dpDFx32q/f+HTug/IHNrAdtGNWqytzKOxlETeaIhmZAsAAj8DkGWSsKJWjIDRWBFKZLq0E96fRdRAX0KSwAD5hx1P7mr7OvR+NLVSOM9gHH1NO3WFdfC5S4SK2Xs8h/j9S/0VBRgO9FdIdkRlA==;
Received: from [81.0.34.134] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1kKMqQ-0000Wd-Bd; Mon, 21 Sep 2020 16:31:06 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1kKMqD-0005yT-2a; Mon, 21 Sep 2020 16:30:53 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/2] Skip copy-on-write when allocating a zero cluster
Date: Mon, 21 Sep 2020 16:30:48 +0200
Message-Id: <cover.1600698425.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 10:31:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I had to rebase the series due to conflicting changes on master. There
are no other differences.

Berto

v4:
- Fix rebase conflicts after cb8503159a

v3: https://lists.gnu.org/archive/html/qemu-block/2020-09/msg00912.html
- Add a new patch to improve the reporting of BDRV_BLOCK_ZERO [Vladimir]
- Rename function to bdrv_co_is_zero_fast() [Vladimir, Kevin]
- Don't call bdrv_common_block_status_above() if bytes == 0

v2: https://lists.gnu.org/archive/html/qemu-block/2020-08/msg01165.html
- Add new, simpler API: bdrv_is_unallocated_or_zero_above()

v1: https://lists.gnu.org/archive/html/qemu-block/2020-08/msg00403.html

Alberto Garcia (2):
  qcow2: Report BDRV_BLOCK_ZERO more accurately in
    bdrv_co_block_status()
  qcow2: Skip copy-on-write when allocating a zero cluster

 include/block/block.h |  2 ++
 block/io.c            | 35 +++++++++++++++++++++++++++++++----
 block/qcow2.c         | 35 +++++++++++++++++++----------------
 3 files changed, 52 insertions(+), 20 deletions(-)

-- 
2.20.1


