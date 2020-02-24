Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872ABC11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 13:41:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 611AF2080D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 13:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 611AF2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Dz3-0003Zq-Hu
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 08:41:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luwei.kang@intel.com>) id 1j6Dxt-0001oX-Rk
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 08:40:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luwei.kang@intel.com>) id 1j6Dxs-0004Ih-3I
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 08:40:04 -0500
Received: from mga04.intel.com ([192.55.52.120]:21081)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luwei.kang@intel.com>)
 id 1j6Dxr-0004GT-Re
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 08:40:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Feb 2020 05:39:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,480,1574150400"; d="scan'208";a="284354722"
Received: from snr.bj.intel.com ([10.240.193.90])
 by FMSMGA003.fm.intel.com with ESMTP; 24 Feb 2020 05:39:51 -0800
From: Luwei Kang <luwei.kang@intel.com>
To: pbonzini@redhat.com,
	rth@twiddle.net,
	ehabkost@redhat.com
Subject: [PATCH v1 0/3] Remove the limitation of Intel PT CPUID info
Date: Tue, 25 Feb 2020 05:38:29 +0800
Message-Id: <1582580312-19864-1-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
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
Cc: Luwei Kang <luwei.kang@intel.com>, qemu-devel@nongnu.org,
 beeman.strong@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Intel PT feature includes some sub-features(CPUID.(EAX=14H,ECX=0H)) and
these sub-features are different on different HW platforms. To make the live
migration safety(get the same CPUID info with same cpu model on different HW
platform), the current Intel PT CPUID information is set to a constant
value(from ICELAKE Server).

It will block the new feature in the later HW platform. what's more, the
support of "IP payloads" will disable the Intel PT in KVM guest(patch 1) but
it will come soon.

This patchset remove this limitation and expose all the capabilities to
KVM guest. As it will break the live migration safe, Intel PT will be
masked as unmigratable.

Luwei Kang (3):
  i386: Remove the limitation of IP payloads for Intel PT
  i386: Remove the CPUID limitation of Intel PT
  i386: Mark the 'INTEL_PT' CPUID bit as unmigratable

 target/i386/cpu.c | 69 ++++---------------------------------------------------
 1 file changed, 5 insertions(+), 64 deletions(-)

-- 
1.8.3.1


