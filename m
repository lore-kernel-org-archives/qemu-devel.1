Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA1EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 21:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C6C420772
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 21:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6C420772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqkcE-00020x-CO
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 17:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jqkZz-0000NX-Qy; Wed, 01 Jul 2020 17:47:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:61625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jqkZu-0004w1-5Z; Wed, 01 Jul 2020 17:47:43 -0400
IronPort-SDR: wAPfqycAn2aXBriNEhOpJfjLA00OgJd+nq2xV5x2nsY2T78BGbBLeEBYuQbHvAgLQm+Cs/QelM
 Z7ypJ93WCd8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="144226806"
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; d="scan'208";a="144226806"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 14:47:32 -0700
IronPort-SDR: UQdLyjLSavy3n9OI3EkLittYcv8E5j1DlX5cbY4bmwE7Juhb40W85CzV3i4mbvEmXIObRY1BJf
 W0MCzQ4WVj6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; d="scan'208";a="481447142"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.61.79])
 by fmsmga006.fm.intel.com with ESMTP; 01 Jul 2020 14:47:31 -0700
From: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
To: kbusch@kernel.org,
	kwolf@redhat.com,
	mreitz@redhat.com
Subject: [PATCH v4] nvme: allow cmb and pmr emulation on same device
Date: Wed,  1 Jul 2020 14:48:56 -0700
Message-Id: <20200701214858.28515-1-andrzej.jakowski@linux.intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.120;
 envelope-from=andrzej.jakowski@linux.intel.com; helo=mga04.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 17:47:32
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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

Hi All, 

Resending series recently posted on mailing list related to nvme device
extension with couple of fixes after review.

This patch series does following:
 - Fixes problem where CMBS bit was not set in controller capabilities
   register, so support for CMB was not correctly advertised to guest.
   This is resend of patch that has been submitted and reviewed by
   Klaus [1]
 - Introduces BAR4 sharing between MSI-X vectors and CMB. This allows
   to have CMB and PMR emulated on the same device. This extension
   was indicated by Keith [2]

v4:
 - modified BAR4 initialization, so now it consists of CMB, MSIX and
   PBA memory regions overlapping on top of it. This reduces patch
   complexity significantly (Klaus [5])

v3:
 - code style fixes including: removal of spurious line break, moving
   define into define section and code alignment (Klaus [4])
 - removed unintended code reintroduction (Klaus [4])

v2:
 - rebase on Kevin's latest block branch (Klaus [3])
 - improved comments section (Klaus [3])
 - simplified calculation of BAR4 size (Klaus [3])

v1:
 - initial push of the patch

[1]: https://lore.kernel.org/qemu-devel/20200408055607.g2ii7gwqbnv6cd3w@apples.localdomain/
[2]: https://lore.kernel.org/qemu-devel/20200330165518.GA8234@redsun51.ssa.fujisawa.hgst.com/
[3]: https://lore.kernel.org/qemu-devel/20200605181043.28782-1-andrzej.jakowski@linux.intel.com/
[4]: https://lore.kernel.org/qemu-devel/20200618092524.posxi5mysb3jjtpn@apples.localdomain/
[5]: https://lore.kernel.org/qemu-devel/20200626055033.6vxqvi4s5pll7som@apples.localdomain/



