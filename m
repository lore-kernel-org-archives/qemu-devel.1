Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93485C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:12:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67FAF2077D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67FAF2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGoz-0005K0-JR
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 14:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jhGnt-0003tl-VS; Fri, 05 Jun 2020 14:10:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:20704)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jhGnt-0002Cu-2B; Fri, 05 Jun 2020 14:10:53 -0400
IronPort-SDR: 0yB8bz2bQc+QU6D8B8vo7FR6fM00a1cIyfGpAQCRYi8bSMCTkv2hE3YoD//FYjq8jKo/zOY6pM
 Tp2T4s2hRW0w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2020 11:09:49 -0700
IronPort-SDR: zVIv3vpg18G7WUQjuSoWEguqU0tRAe1aVEwBmHqlHpu4uhCffUa060PnWaGoBppfaFsLOxuM2N
 47gliLGp6mAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,477,1583222400"; d="scan'208";a="258094447"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.28.117])
 by fmsmga007.fm.intel.com with ESMTP; 05 Jun 2020 11:09:48 -0700
From: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
To: kbusch@kernel.org,
	kwolf@redhat.com,
	mreitz@redhat.com
Subject: [PATCH v1] nvme: allow cmb and pmr emulation on same device
Date: Fri,  5 Jun 2020 11:10:41 -0700
Message-Id: <20200605181043.28782-1-andrzej.jakowski@linux.intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.100;
 envelope-from=andrzej.jakowski@linux.intel.com; helo=mga07.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 14:09:49
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_DNSWL_MED=-2.3 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series does following:
 - Fixes problem where CMBS bit was not set in controller capabilities
   register, so support for CMB was not correctly advertised to guest.
   This is resend of patch that has been submitted and reviewed by
   Klaus [1]
 - Introduces BAR4 sharing between MSI-X vectors and CMB. This allows
   to have CMB and PMR emulated on the same device. This extension
   was indicated by Keith [2]

[1]: https://lore.kernel.org/qemu-devel/20200408055607.g2ii7gwqbnv6cd3w@apples.localdomain/
[2]: https://lore.kernel.org/qemu-devel/20200330165518.GA8234@redsun51.ssa.fujisawa.hgst.com/


