Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE79C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 08:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE0F62080A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 08:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE0F62080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57660 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hayzx-0000yZ-1R
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 04:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57771)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <like.xu@linux.intel.com>) id 1hayro-00038W-Sv
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 04:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <like.xu@linux.intel.com>) id 1hayri-0006Da-If
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 04:44:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:10698)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
 id 1hayqz-0005un-Mg
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 04:44:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Jun 2019 01:43:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,363,1557212400"; d="scan'208";a="184175068"
Received: from likexu-e5-2699-v4.sh.intel.com ([10.239.48.178])
 by fmsmga002.fm.intel.com with ESMTP; 12 Jun 2019 01:43:26 -0700
From: Like Xu <like.xu@linux.intel.com>
To: qemu-devel@nongnu.org,
	Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 12 Jun 2019 16:40:55 +0800
Message-Id: <20190612084104.34984-1-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
Subject: [Qemu-devel] [PATCH v3 0/9] Introduce cpu die topology and enable
 CPUID.1F for i386
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, like.xu@linux.intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Multi-chip packaging technology allows integration of multi-cores in one die
and multi-dies in one single package, for example Intel CLX-AP or AMD EPYC.

This patch series extend the CPU topology to the socket/dies/core/thread model,
allowing the setting of dies number per one socket on -smp qemu command. For
i386, it upgrades APIC_IDs generation and reversion functions with a new exposed
leaf called CPUID.1F, which is a preferred superset to leaf 0BH. The CPUID.1F
spec is on https://software.intel.com/en-us/articles/intel-sdm, 3-190 Vol 2A.

E.g. we use -smp 4,dies=2,cores=2,threads=1 to run a multi-dies guest and
check raw cpuid data and the expected output from guest is following:
0x0000001f 0x00: eax=0x00000000 ebx=0x00000001 ecx=0x00000100 edx=0x00000002
0x0000001f 0x01: eax=0x00000001 ebx=0x00000002 ecx=0x00000201 edx=0x00000001
0x0000001f 0x02: eax=0x00000002 ebx=0x00000004 ecx=0x00000502 edx=0x00000003
0x0000001f 0x03: eax=0x00000000 ebx=0x00000000 ecx=0x00000003 edx=0x00000001

Guest system could discover multi-die/package topology through CPUID.1F.
and its benefit is primarily for _reporting_ of the (virtual) CPU topology.
The guest kernel with multi-die/package support have no impact on its 
cache topology, NUMA topology, Linux scheduler, or system performance. 

==changelog==

v3:

- add a MachineClass::smp_parse function pointer
- place the PC-specific function inside hw/i386/pc.c
- introduce die_id in a separate patch with default value 0
- set env->nr_dies in pc_new_cpu() and pc_cpu_pre_plug()
- fix a circular dependency between target/i386/cpu.c and hw/i386/pc.c
- fix cpu->die_id check in pc_cpu_pre_plug()
- Based on "[PATCH v3 00/10] Refactor cpu topo into machine properties"
- Rebase to commit 219dca61ebf41625831d4f96a720852baf44b762

v2: https://patchwork.kernel.org/cover/10953191/

- Enable cpu die-level topolgy only for PCMachine and X86CPU
- Minimize cpuid.0.eax to the setting value actually used by guest
- Update cmd line -smps docs for die-level configurations
- Refactoring topo-bit tests for x86_apicid_from_cpu_idx() with nr_dies
- Based on "[PATCH v3 00/10] Refactor cpu topo into machine properties"
- Rebase to commit 2259637b95bef3116cc262459271de08e038cc66

v1: https://patchwork.kernel.org/cover/10876667/

Like Xu (9):
  i386: Add die-level cpu topology to x86CPU on PCMachine
  hw/i386: Adjust nr_dies with configured smp_dies for PCMachine
  i386/cpu: Consolidate die-id validity in smp context
  i386: Update new x86_apicid parsing rules with die_offset support
  tests/x86-cpuid: Update testcases in test_topo_bits() with multiple dies
  i386/cpu: Add CPUID.1F generation support for multi-dies PCMachine
  target/i386: Support multi-dies when host doesn't support CPUID.1F
  machine: Refactor smp_parse() in vl.c as MachineClass::smp_parse()
  vl.c: Add -smp, dies=* command line support and update doc

 hmp.c                      |   3 +
 hw/core/machine.c          |  89 ++++++++++++++++++++++
 hw/i386/pc.c               | 148 ++++++++++++++++++++++++++++++++-----
 include/hw/boards.h        |   5 ++
 include/hw/i386/pc.h       |   3 +
 include/hw/i386/topology.h |  76 +++++++++++++------
 qapi/misc.json             |   6 +-
 qemu-options.hx            |  17 +++--
 target/i386/cpu.c          |  53 +++++++++++--
 target/i386/cpu.h          |   7 ++
 target/i386/kvm.c          |  36 ++++++++-
 tests/test-x86-cpuid.c     |  84 +++++++++++----------
 vl.c                       |  78 ++-----------------
 13 files changed, 438 insertions(+), 167 deletions(-)

-- 
2.21.0


