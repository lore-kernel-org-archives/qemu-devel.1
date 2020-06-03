Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FA3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 23:00:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03E25208E4
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 23:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E25208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgcNI-00036I-96
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 19:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joe.slater@windriver.com>)
 id 1jgcMk-0002aJ-AN; Wed, 03 Jun 2020 19:00:10 -0400
Received: from mail1.windriver.com ([147.11.146.13]:59560)
 by eggs.gnu.org with esmtps (TLS1.1:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <joe.slater@windriver.com>)
 id 1jgcMi-0005ZV-1U; Wed, 03 Jun 2020 19:00:09 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
 [147.11.189.40])
 by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 053Mn4hG013995
 (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
 Wed, 3 Jun 2020 15:49:04 -0700 (PDT)
Received: from ala-lpggp3.wrs.com (147.11.105.124) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.487.0;
 Wed, 3 Jun 2020 15:49:03 -0700
From: Joe Slater <joe.slater@windriver.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 0/2] Use QLNULL for null lockable
Date: Wed, 3 Jun 2020 15:49:01 -0700
Message-ID: <20200603224903.26268-1-joe.slater@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=147.11.146.13;
 envelope-from=joe.slater@windriver.com; helo=mail1.windriver.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 18:49:05
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We currently will fail to build for optimizations like -Og because they do not
eliminate dead code.  We do not need such clean up if we use QLNULL.  There is no
need to produce a QemuLockable that will be thrown away.

Only testing:

$ ../configure
$ make -j16 CFLAGS="$CFLAGS"      # which I set to use -Og, then -O2

Joe Slater (2):
  lockable:  use QLNULL for a null lockable
  lockable: do not rely on optimization for null lockables

 block/block-backend.c          |  4 ++--
 block/block-copy.c             |  2 +-
 block/mirror.c                 |  5 +++--
 fsdev/qemu-fsdev-throttle.c    |  6 +++---
 hw/9pfs/9p.c                   |  2 +-
 include/qemu/lockable.h        | 16 ++++++----------
 util/qemu-co-shared-resource.c |  2 +-
 7 files changed, 17 insertions(+), 20 deletions(-)

-- 
2.7.4


