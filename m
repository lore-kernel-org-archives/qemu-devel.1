Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722A7C43457
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 05:12:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF49220878
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 05:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF49220878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSCbw-0003do-Ov
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 01:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weijiang.yang@intel.com>)
 id 1kSCa3-0001t4-8O
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 01:10:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:57340)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weijiang.yang@intel.com>)
 id 1kSCa0-0006XA-2y
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 01:10:34 -0400
IronPort-SDR: u+aASQv7pgYfMBZB0AOfACwNcygeZYsG+Hri/4GFySdP75BDVo3ExmKvXCUxTCcMY8yjtbVkyj
 Wp9u02ITE4RQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="162385615"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; d="scan'208";a="162385615"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2020 22:10:25 -0700
IronPort-SDR: OAglrBHPPAV0/ZDF07KZzoCZA4mseiaWU8Jbk0TYZ+vWb/VQNcWO5LE6MYrbfa8q7EHteZkpep
 7ptW/26axd3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; d="scan'208";a="420427109"
Received: from unknown (HELO local-michael-cet-test.sh.intel.com)
 ([10.239.159.128])
 by fmsmga001.fm.intel.com with ESMTP; 12 Oct 2020 22:10:23 -0700
From: Yang Weijiang <weijiang.yang@intel.com>
To: pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net,
 ehabkost@redhat.com, sean.j.christopherson@intel.com, qemu-devel@nongnu.org
Subject: [Qemu-devel][PATCH v6 0/6] Enable CET support for guest
Date: Tue, 13 Oct 2020 13:19:29 +0800
Message-Id: <20201013051935.6052-1-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.2
Received-SPF: pass client-ip=192.55.52.93;
 envelope-from=weijiang.yang@intel.com; helo=mga11.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 01:10:25
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Yang Weijiang <weijiang.yang@intel.com>, hao.wu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Control-flow Enforcement Technology (CET) provides protection against
Return/Jump-Oriented Programming (ROP/JOP). It includes two sub-features:
Shadow Stack(SHSTK) and Indirect Branch Tracking(IBT).
This patchset is for guest CET enabling. It enclosed patches for
XSS feature report and CET CPUID enumeration, XSAVE support and MSR
access interface etc.

Related patch series:
CET KVM patches v14:
https://github.com/sean-jc/linux/releases/tag/kvm-cet-v14-rc1

Intel 64 and IA-32 Architectures Software Developer's Manual:
https://software.intel.com/en-us/download/intel-64-and-ia-32-
architectures-sdm-combined-volumes-1-2a-2b-2c-2d-3a-3b-3c-3d-and-4

CET Shadow Stack patches v14:
https://lkml.kernel.org/r/20201012153850.26996-1-yu-cheng.yu@intel.com/

[3] Indirect Branch Tracking patches v14.
https://lkml.kernel.org/r/20201012154530.28382-1-yu-cheng.yu@intel.com/

v6:
  - Cleaned up XSAVE related naming for adding XSS features.
  - Refactored patches based on new QEMU code base.
v5:
  - Checked CET states before access related MSRs.
  - Added new MSR MSR_KVM_GUEST_SSP for live-migration.
  - Refactored patches to make them more structured.

v4:
  - Added MSR read/write interface for PL1_SSP/PL2_SSP.
  - Removed CET structures from X86XSaveArea.
  - Cleared ebx in return of CPUID.(EAX=d, ECX=1).
 
v3:
  - Add CET MSR save/restore support for live-migration.
 
v2:
  - In CPUID.(EAX=d, ECX=1), set return ECX[n] = 0 if bit n corresponds
    to a bit in MSR_IA32_XSS.
  - In CPUID.(EAX=d, ECX=n), set return ECX = 1 if bit n corresponds
    to a bit in MSR_IA32_XSS.
  - Skip Supervisor mode xsave component when calculate User mode
    xave component size in xsave_area_size() and x86_cpu_reset().

Yang Weijiang (6):
  x86/cpu: Rename XSAVE related feature words.
  x86/cpuid: Enable XSS feature enumeration for CPUID
  x86/cpu: Enable CET components support for XSAVE
  x86/cpu: Add user-space MSR access interface for CET
  x86/cpu: Add CET state support for guest migration
  x86/cpu: Advise CET bits in CPU/MSR feature words

 target/i386/cpu.c        | 132 +++++++++++++++++++++++---------
 target/i386/cpu.h        |  57 +++++++++++++-
 target/i386/fpu_helper.c |   2 +-
 target/i386/kvm.c        |  73 ++++++++++++++++++
 target/i386/machine.c    | 161 +++++++++++++++++++++++++++++++++++++++
 target/i386/translate.c  |   2 +-
 6 files changed, 384 insertions(+), 43 deletions(-)

-- 
2.26.2


