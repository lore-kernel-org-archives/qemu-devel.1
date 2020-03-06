Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35929C3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 02:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 076E02073B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 02:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 076E02073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA2dS-0006rL-4e
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 21:22:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luwei.kang@intel.com>) id 1jA2cW-0005KV-LL
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 21:21:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luwei.kang@intel.com>) id 1jA2cU-0003QP-VT
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 21:21:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:23293)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luwei.kang@intel.com>)
 id 1jA2cU-0003Ca-MZ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 21:21:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Mar 2020 18:21:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,520,1574150400"; d="scan'208";a="413742155"
Received: from snr.bj.intel.com ([10.240.193.90])
 by orsmga005.jf.intel.com with ESMTP; 05 Mar 2020 18:21:35 -0800
From: Luwei Kang <luwei.kang@intel.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com
Subject: [PATCH v1 0/3] PEBS virtualization enabling via DS in Qemu
Date: Fri,  6 Mar 2020 18:20:02 +0800
Message-Id: <1583490005-27761-1-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
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
 kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The PEBS virtualization will be first supported on ICELAKE server.
This patchset introduce a new CPU parameter "pebs"(e.g.
"-cpu Icelake-Server,pmu=true,pebs=true") that use for enable PEBS
feature in KVM guest, and add the support for save/load PEBS MSRs.

Luwei Kang (3):
  i386: Add "pebs" parameter to enable PEBS feature
  i386: Add support for save/load PEBS MSRs
  i386: Add support for save/load IA32_PEBS_DATA_CFG MSR

 hw/i386/pc.c          |  1 +
 target/i386/cpu.c     | 14 ++++++++++++++
 target/i386/cpu.h     | 15 +++++++++++++++
 target/i386/kvm.c     | 43 +++++++++++++++++++++++++++++++++++++++++++
 target/i386/machine.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 122 insertions(+)

-- 
1.8.3.1


