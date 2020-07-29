Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873F6C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:04:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57CD22070B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57CD22070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0uBF-00066S-I2
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 18:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1k0u8V-0003MV-9U; Wed, 29 Jul 2020 18:01:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:41639)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1k0u8P-0007ro-Vr; Wed, 29 Jul 2020 18:01:18 -0400
IronPort-SDR: zzT09mbtrBHNCit/tRuCuW3Zj6DNBgw6P2OAMUZN0hqgswVSbbDMCSEZxDTTL8wZz3eYe9S+58
 MwJoI41VHUsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="149342742"
X-IronPort-AV: E=Sophos;i="5.75,412,1589266800"; d="scan'208";a="149342742"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2020 15:01:11 -0700
IronPort-SDR: RiZ58BlH/zkJseVlsG8cbk9wPTm6XwUW3OPAUnhtODa829kJKsg0PLkbqytF66Kfa/FzU6xzWT
 0qfRy81evwCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,412,1589266800"; d="scan'208";a="304361597"
Received: from ajakowsk-mobl1.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.209.191.249])
 by orsmga002.jf.intel.com with ESMTP; 29 Jul 2020 15:01:09 -0700
From: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
To: kbusch@kernel.org,
	kwolf@redhat.com,
	mreitz@redhat.com
Subject: [PATCH v6] nvme: allow cmb and pmr emulation on same device
Date: Wed, 29 Jul 2020 15:01:05 -0700
Message-Id: <20200729220107.37758-1-andrzej.jakowski@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.93;
 envelope-from=andrzej.jakowski@linux.intel.com; helo=mga11.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 18:01:11
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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

v6:
 - instead of using memory_region_to_absolute_addr() function local helper has
   been defined (nvme_cmb_to_absolute_addr()) to calculate absolute address of
   CMB in simplified way. Also a number of code style changes has been done
   (function rename, use literal instead of macro definition, etc.)

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



