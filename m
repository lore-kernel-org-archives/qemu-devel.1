Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA9DC48BE1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 05:53:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BCF620B1F
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 05:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BCF620B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43846 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdq0c-00012u-OB
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 01:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56405)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <like.xu@linux.intel.com>) id 1hdpwW-0006Vv-Oj
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 01:49:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <like.xu@linux.intel.com>) id 1hdpwU-0002hg-PK
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 01:49:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:20325)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
 id 1hdpwT-0001ds-2U
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 01:49:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Jun 2019 22:47:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,395,1557212400"; d="scan'208";a="162243081"
Received: from unknown (HELO likexu-E5-2699-v4.sh.intel.com) ([10.239.48.178])
 by fmsmga007.fm.intel.com with ESMTP; 19 Jun 2019 22:47:57 -0700
From: Like Xu <like.xu@linux.intel.com>
To: qemu-devel@nongnu.org,
	Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 20 Jun 2019 13:45:22 +0800
Message-Id: <20190620054525.37188-1-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
Subject: [Qemu-devel] [PATCH v4 0/3] Introduce cpu die topology and enable
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
Cc: like.xu@intel.com, Marcelo Tosatti <mtosatti@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series introduces a new cpu topolgy 'die' for PCMachine,
which extends virtual cpu topology to the socket/die/core/thread model,
allowing the setting of dies number per one socket via -smp qemu command.

For i386, it upgrades APIC-IDs generation and reversion functions with a
new exposed leaf called CPUID.1F, which is a preferred superset to leaf 0BH.
The CPUID.1F spec is on the latest Inetl SDM, 3-190 Vol 2A.

Guest system could discover multi-die/package topology through CPUID.1F.
and its benefit is primarily for _reporting_ of the guest CPU topology.
The guest kernel with multi-die/package support have no impact on its
cache topology, NUMA topology, Linux scheduler, or system performance.

==changelog==

v4:

- base commit: 22fa84da on github.com/ehabkost/qemu.git:machine-next
- refine comments for pc_smp_parse()
- remove the use of cpu->enable_cpuid_0x1f
- apply new logic for cpuid_min_level adjustment and drop the legacy one
- refine the way of MachineState casting in pc_smp_parse()
- [QUEUED] move test_topo_bits to the previous patch for bisectability

v3: https://patchwork.kernel.org/cover/10989013/

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

Like Xu (3):
  target/i386: Add CPUID.1F generation support for multi-dies PCMachine
  machine: Refactor smp_parse() in vl.c as MachineClass::smp_parse()
  vl.c: Add -smp, dies=* command line support and update doc

 hw/core/machine.c    | 76 ++++++++++++++++++++++++++++++++++++++++
 hw/i386/pc.c         | 83 ++++++++++++++++++++++++++++++++++++++++++++
 include/hw/boards.h  |  5 +++
 include/hw/i386/pc.h |  1 +
 qemu-options.hx      | 17 ++++-----
 target/i386/cpu.c    | 41 ++++++++++++++++++++++
 target/i386/cpu.h    |  1 +
 target/i386/kvm.c    | 12 +++++++
 vl.c                 | 78 +++--------------------------------------
 9 files changed, 233 insertions(+), 81 deletions(-)

-- 
2.21.0


