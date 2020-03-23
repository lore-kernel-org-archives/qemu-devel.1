Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55D7C1975A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 03:15:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86862206F8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 03:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86862206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGDZ8-0007CK-Kb
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 23:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xiaoyao.li@intel.com>) id 1jGDY4-0005if-NZ
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 23:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xiaoyao.li@intel.com>) id 1jGDY2-0003fm-Uu
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 23:14:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:56653)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xiaoyao.li@intel.com>)
 id 1jGDY2-0003ev-NJ
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 23:14:42 -0400
IronPort-SDR: /wDQkt6CI6r9NGhgxuRX7m+IwVaHjbdkOeMULOEkyIWdp5WYens9ow/jSiR6ktibFRQoi/eUBG
 VnmenyR/+0Qw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2020 20:14:38 -0700
IronPort-SDR: jFOHaTOf/TbRq7blbQLJLeIdgf9zS7fRX2leFtroj+bcuNV1wOz4P98aETg3smzoqnW9YHubT8
 CvJ+foaSKvwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,294,1580803200"; d="scan'208";a="292453678"
Received: from lxy-clx-4s.sh.intel.com ([10.239.43.161])
 by FMSMGA003.fm.intel.com with ESMTP; 22 Mar 2020 20:14:37 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 0/3] Misc patches for core_capabilites and split lock detection
Date: Mon, 23 Mar 2020 10:56:55 +0800
Message-Id: <20200323025658.4540-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.100
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
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch 1 renames core_capability to core_capabilities to align with the
latest SDM.

Patch 2 adds MSR_TEST_CTRL support.

Patch 3 prints info when guest is going to be killed due to split lock #AC

Xiaoyao Li (3):
  target/i386: Rename CORE_CAPABILITY to CORE_CAPABILITIES
  target/i386: Add support for TEST_CTRL MSR
  target/i386: Tell why guest exits to user space due to #AC

 target/i386/cpu.c     | 12 ++++++------
 target/i386/cpu.h     |  8 +++++---
 target/i386/kvm.c     | 30 +++++++++++++++++++++++++-----
 target/i386/machine.c | 20 ++++++++++++++++++++
 4 files changed, 56 insertions(+), 14 deletions(-)

-- 
2.20.1


