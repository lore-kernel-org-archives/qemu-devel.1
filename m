Received: from eggs.gnu.org ([209.51.188.92]:44654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hIimn-00058J-35
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 19:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hIif4-0005hY-Q5
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 19:47:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hIif4-0005gt-L2
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 19:47:46 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 22 Apr 2019 20:47:40 -0300
Message-Id: <20190422234742.15780-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] i386: "unavailable-features" QOM property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

Currently, libvirt uses the "filtered-features" QOM property at
runtime to ensure no feature was accidentally disabled on VCPUs
because it's not available on the host.

However, the code for "feature-words" assumes that all missing
features have a corresponding CPUID bit, which is not true for
MSR-based features like the ones at FEAT_ARCH_CAPABILITIES.

We could extend X86CPUFeatureWordInfo to include information
about MSR features, but it's impossible to do that while keeping
compatibility with clients that (reasonably) expect all elements
of "filtered-features" to have the cpuid-* fields.

We have a field in "query-cpu-definitions" that already describes
all features that are missing on a CPU, including MSR features:
CpuDefinitionInfo.unavailable-features.  The existing code for
building the unavailable-features array even uses
X86CPU::filtered_features to build the feature list.

This series adds a "unavailable-features" QOM property to X86CPU
objects that have the same semantics of "unavailable-features" on
query-cpu-definitions.  The new property has the same goal of
"filtered-features", but is generic enough to let any kind of CPU
feature to be listed there without relying on low level details
like CPUID leaves or MSR numbers.

Eduardo Habkost (2):
  i386: x86_cpu_list_feature_names() function
  i386: "unavailable-features" QOM property

 target/i386/cpu.c | 55 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 13 deletions(-)

-- 
2.18.0.rc1.1.g3f1ff2140
