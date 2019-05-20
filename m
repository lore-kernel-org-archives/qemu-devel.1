Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AF1C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 08:57:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A790E21019
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 08:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A790E21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49393 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT0aa-0004wj-U4
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 04:57:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hT0W8-0001J9-91
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:53:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hT0W6-0000Xd-VJ
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:53:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:1677)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
	id 1hT0W6-0000SF-NN
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:53:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	21 May 2019 01:52:56 -0700
X-ExtLoop1: 1
Received: from clx-ap-likexu.sh.intel.com ([10.239.48.98])
	by fmsmga007.fm.intel.com with ESMTP; 21 May 2019 01:52:53 -0700
From: Like Xu <like.xu@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 00:50:51 +0800
Message-Id: <20190520165056.175475-1-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.120
Subject: [Qemu-devel] [PATCH v2 0/5] Introduce cpu die topology and enable
 CPUID.1F for i386
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jones <drjones@redhat.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Peter Crosthwaite <crosthwaite.peter@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Brice Goglin <Brice.Goglin@inria.fr>, Paolo Bonzini <pbonzini@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Multi-chip packaging technology allows integration of multi-cores in one die
and multi-dies in one single package, for example Intel CLX-AP or AMD EPYC.

This kind of integration can be enabled by high-performance, heterogeneous,
multi-dies interconnect technology, providing a more cost-effective manner. 
QEMU and guests may take advantages of multi-dies host for such as guest
placing or energy efficiency management...

This patch series extend the CPU topology to the socket/dies/core/thread model,
allowing the setting of dies number per one socket on -smp qemu command. For
i386, it upgrades APIC_IDs generation and reversion functions with a new exposed
leaf called CPUID.1F, which is a preferred superset to leaf 0BH. The CPUID.1F
spec is on https://software.intel.com/en-us/articles/intel-sdm, 3-190 Vol 2A.

E.g. we use -smp 4,dies=2,cores=2,threads=1 to run an MCP kvm-guest,
check raw cpuid data and the expected output from guest is following:
0x0000001f 0x00: eax=0x00000000 ebx=0x00000001 ecx=0x00000100 edx=0x00000002
0x0000001f 0x01: eax=0x00000001 ebx=0x00000002 ecx=0x00000201 edx=0x00000001
0x0000001f 0x02: eax=0x00000002 ebx=0x00000004 ecx=0x00000502 edx=0x00000003
0x0000001f 0x03: eax=0x00000000 ebx=0x00000000 ecx=0x00000003 edx=0x00000001

==changelog==

v2:

- Enable cpu die-level topolgy only for PCMachine and X86CPU
- Minimize cpuid.0.eax to the setting value actually used by guest
- Update cmd line -smps docs for die-level configurations
- Refactoring topo-bit tests for x86_apicid_from_cpu_idx() with nr_dies
- Based on "[PATCH v3 00/10] Refactor cpu topo into machine properties"
- Rebase to commit 2259637b95bef3116cc262459271de08e038cc66

v1: https://patchwork.kernel.org/cover/10876667/

Like Xu (5):
  target/i386: Add cpu die-level topology support for X86CPU
  i386/cpu: Consolidate die-id validity in smp context
  vl.c: Add -smp, dies=* command line support and update -smp doc
  i386/cpu: Update apicid parsing rules and topo-bit tests for dies
  target/i386: Add CPUID.1F generation support for multi-die PCMachine

 hmp.c                      |  3 ++
 hw/core/machine.c          | 12 +++++
 hw/i386/pc.c               | 52 +++++++++++++++++-----
 include/hw/i386/pc.h       |  2 +
 include/hw/i386/topology.h | 76 +++++++++++++++++++++++---------
 qapi/misc.json             |  6 ++-
 qemu-options.hx            | 17 ++++----
 target/i386/cpu.c          | 59 ++++++++++++++++++++++---
 target/i386/cpu.h          |  7 +++
 target/i386/kvm.c          | 30 ++++++++++++-
 tests/test-x86-cpuid.c     | 84 ++++++++++++++++++-----------------
 vl.c                       | 89 +++++++++++++++++++++++++++++++++++++-
 12 files changed, 347 insertions(+), 90 deletions(-)

-- 
2.21.0


