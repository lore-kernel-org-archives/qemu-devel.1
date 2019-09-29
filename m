Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE09BC4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 01:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A55F5214AE
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 01:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A55F5214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEOU8-0002Xi-J4
	for qemu-devel@archiver.kernel.org; Sat, 28 Sep 2019 21:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iEOSm-0001GA-T1
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 21:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iEOSj-0004Aq-DG
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 21:57:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:19352)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iEOSj-0004AH-5o
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 21:57:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Sep 2019 18:57:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,561,1559545200"; d="scan'208";a="204501449"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.159.36])
 by fmsmga001.fm.intel.com with ESMTP; 28 Sep 2019 18:57:20 -0700
From: Tao Xu <tao3.xu@intel.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 mtosatti@redhat.com
Subject: [PATCH v5 0/2] x86: Enable user wait instructions
Date: Sun, 29 Sep 2019 09:57:16 +0800
Message-Id: <20190929015718.19562-1-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
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
Cc: jingqi.liu@intel.com, tao3.xu@intel.com, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UMONITOR, UMWAIT and TPAUSE are a set of user wait instructions.

UMONITOR arms address monitoring hardware using an address. A store
to an address within the specified address range triggers the
monitoring hardware to wake up the processor waiting in umwait.

UMWAIT instructs the processor to enter an implementation-dependent
optimized state while monitoring a range of addresses. The optimized
state may be either a light-weight power/performance optimized state
(c0.1 state) or an improved power/performance optimized state
(c0.2 state).

TPAUSE instructs the processor to enter an implementation-dependent
optimized state c0.1 or c0.2 state and wake up when time-stamp counter
reaches specified timeout.

Availability of the user wait instructions is indicated by the presence
of the CPUID feature flag WAITPKG CPUID.0x07.0x0:ECX[5].

The patches enable the umonitor, umwait and tpause features in KVM.
Because umwait and tpause can put a (psysical) CPU into a power saving
state, by default we dont't expose it in kvm and provide a capability to
enable it. Use kvm capability to enable UMONITOR, UMWAIT and TPAUSE when
QEMU use "-overcommit cpu-pm=on, a VM can use UMONITOR, UMWAIT and TPAUSE
instructions. If the instruction causes a delay, the amount of time
delayed is called here the physical delay. The physical delay is first
computed by determining the virtual delay (the time to delay relative to
the VM’s timestamp counter). Otherwise, UMONITOR, UMWAIT and TPAUSE cause
an invalid-opcode exception(#UD).

The release document ref below link:
https://software.intel.com/sites/default/files/\
managed/39/c5/325462-sdm-vol-1-2abcd-3abcd.pdf

Changelog:
v5:
	Remove CPUID_7_0_ECX_WAITPKG if enable_cpu_pm is not set. (Paolo)
v4:
	Set IA32_UMWAIT_CONTROL 32bits
v3:
	Simplify the patches, expose user wait instructions when the guest
	has CPUID (Paolo)
v2:
	Separated from the series
	https://www.mail-archive.com/qemu-devel@nongnu.org/msg549526.html
	Use kvm capability to enable UMONITOR, UMWAIT and TPAUSE when
	QEMU use "-overcommit cpu-pm=on"	
v1:
	Sent out with MOVDIRI/MOVDIR64B instructions patches

Tao Xu (2):
  x86/cpu: Add support for UMONITOR/UMWAIT/TPAUSE
  target/i386: Add support for save/load IA32_UMWAIT_CONTROL MSR

 target/i386/cpu.c     |  3 ++-
 target/i386/cpu.h     |  3 +++
 target/i386/kvm.c     | 19 +++++++++++++++++++
 target/i386/machine.c | 20 ++++++++++++++++++++
 4 files changed, 44 insertions(+), 1 deletion(-)

-- 
2.20.1


