Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CE8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 16:05:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD71D20714
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 16:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD71D20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jydin-000743-4a
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 12:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jydfL-0003FT-4n; Thu, 23 Jul 2020 12:01:51 -0400
Received: from mga03.intel.com ([134.134.136.65]:36921)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jydfI-0006j0-Th; Thu, 23 Jul 2020 12:01:50 -0400
IronPort-SDR: PUB0xZmN9AR9iW64Y/21XjUG+n1HzlJ68nVKtoK/CTrtQlSHJeFpyV5sb6RTN87gJikNkokpy0
 cHmVnf0dBijA==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="150543439"
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; d="scan'208";a="150543439"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2020 09:01:44 -0700
IronPort-SDR: le3jLSxsTdOFK2JLlUbzHlpTKowP6WG47YfYzy/0pHBj3Uf8ePxBGOFS/NAUsjlEsGFJQQIB0b
 leruSdkng6Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; d="scan'208";a="319033149"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.61.79])
 by orsmga008.jf.intel.com with ESMTP; 23 Jul 2020 09:01:44 -0700
From: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
To: kbusch@kernel.org,
	kwolf@redhat.com,
	mreitz@redhat.com
Subject: [PATCH v5] nvme: allow cmb and pmr emulation on same device
Date: Thu, 23 Jul 2020 09:03:22 -0700
Message-Id: <20200723160325.41734-1-andrzej.jakowski@linux.intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.65;
 envelope-from=andrzej.jakowski@linux.intel.com; helo=mga03.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 12:01:45
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Resending series recently posted on mailing list related to nvme device
extension with couple of fixes after review.

This patch series does following:
 - Exports memory_region_to_absolute_addr() function so it is avaialbe
   for use by drivers. This function is needed by 3rd patch in this
   series
 - Fixes problem where CMBS bit was not set in controller capabilities
   register, so support for CMB was not correctly advertised to guest.
   This is resend of patch that has been submitted and reviewed by
   Klaus [1]
 - Introduces BAR4 sharing between MSI-X vectors and CMB. This allows
   to have CMB and PMR emulated on the same device. This extension
   was indicated by Keith [2]

v5:
 - fixed problem introduced in v4 where CMB buffer was represented as
   subregion of BAR4 memory region. In that case CMB address was used
   incorrectly as it was relative to BAR4 and not absolute. Appropriate
   changes were added to v5 to calculate CMB address properly ([6])

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
[6]: https://lore.kernel.org/qemu-devel/9143a543-d32d-f3e7-c37b-b3df7f853952@linux.intel.com/



