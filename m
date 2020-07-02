Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CDCC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:08:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E512206E2
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E512206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr0pJ-0007Ma-AA
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 11:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jr0oc-0006pz-FD; Thu, 02 Jul 2020 11:07:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:5855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jr0oa-0001FY-DR; Thu, 02 Jul 2020 11:07:54 -0400
IronPort-SDR: IQ0AkU8C+nH/ZID27F3o/oazGgpqC/+mFgRGiBsTX3X4LPuZpAgLdLdiUEef1a3Q63snJorOPD
 8gV7rID0Fqzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="208446638"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; d="scan'208";a="208446638"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 08:07:39 -0700
IronPort-SDR: 2CyEMk2ROlb7lxp/dPbOkydJ6IWUt36k46ukxuiX8P7dkVDvsZ/Xg/Whm3KhOIWrVEjhWIfWbt
 s1NrGwYh45gQ==
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; d="scan'208";a="482034956"
Received: from ajakowsk-mobl1.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.212.130.2])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 08:07:38 -0700
Subject: Re: [PATCH v4 2/2] nvme: allow cmb and pmr to be enabled on same
 device
To: Klaus Jensen <its@irrelevant.dk>
References: <20200701214858.28515-1-andrzej.jakowski@linux.intel.com>
 <20200701214858.28515-3-andrzej.jakowski@linux.intel.com>
 <20200702101318.rmd65uzwfpcmb24n@apples.localdomain>
 <20200702103127.hoonqkas3bw2v7re@apples.localdomain>
From: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Message-ID: <8f871a0d-47f1-1c8a-fcc2-aab2638c70cf@linux.intel.com>
Date: Thu, 2 Jul 2020 08:07:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702103127.hoonqkas3bw2v7re@apples.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=134.134.136.31;
 envelope-from=andrzej.jakowski@linux.intel.com; helo=mga06.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 11:07:49
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
Cc: kbusch@kernel.org, kwolf@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/2/20 3:31 AM, Klaus Jensen wrote:
> Aight, an update here. This only happens when QEMU is run with a virtual
> IOMMU. Otherwise, the kernel is happy.
> 
> With the vIOMMU, qemu also craps out a bit:
> 
> qemu-system-x86_64: vtd_iova_to_slpte: detected slpte permission error (iova=0xfd200000, level=0x2, slpte=0x0, write=0)
> qemu-system-x86_64: vtd_iommu_translate: detected translation failure (dev=03:00:00, iova=0xfd200000)
> 
> So I think we are back in QEMU land for the bug.

Can you share command line for that?


