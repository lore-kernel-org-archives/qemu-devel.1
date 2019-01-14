Received: from eggs.gnu.org ([209.51.188.92]:41055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1giu1h-0000Hu-Pm
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 23:39:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1giu1g-00043R-QE
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 23:39:05 -0500
Received: from mga05.intel.com ([192.55.52.43]:15386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
	id 1giu1g-0002Qu-HT
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 23:39:04 -0500
From: Like Xu <like.xu@linux.intel.com>
Date: Mon, 14 Jan 2019 20:24:54 +0800
Message-Id: <1547468699-17633-1-git-send-email-like.xu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v1 0/5] Introduce cpu die topology and enable
 CPUID.1F for i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: like.xu@intel.com, imammedo@redhat.com, drjones@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

As we know, die is a rectangular piece of a semiconductor wafer. It's very common
that chip manufacturers put a multi-core die in one package and one die always has
a one-to-one relationship with one socket. Inside the die, it cotains multi-cores
and core contains threads topologically. We apply this socket/core/thread model to
the qemu -smp configurable space and save it into APIC_IDs for identification.

The undercurrent Is surging. Multi-chip packaging technology allows for integration
of multi-die devices in a single package, for example Intel CLX-AP or AMD EPYC.
Integration can be enabled by high-performance, heterogeneous, multi-dies interconnect
technology, providing a more cost-effective manner. QEMU and guests may take advantages
of multi-dies host for such as guest placing or energy efficiency management...

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

Like Xu (5):
  cpu: introduce die, the new cpu toppolgy emulation level
  vl.c: add -smp,dies=* command line support
  i386: extend x86_apicid_* functions for smp_dies support
  i386: enable CPUID.1F leaf generation based on spec
  i386: add CPUID.1F to cpuid_data with host_cpuid check

 cpus.c                     |  1 +
 hmp.c                      |  3 ++
 hw/core/machine.c          | 12 +++++++
 hw/i386/pc.c               | 37 +++++++++++++++-------
 include/hw/i386/topology.h | 79 ++++++++++++++++++++++++++++++++++------------
 include/qom/cpu.h          |  1 +
 include/sysemu/cpus.h      |  1 +
 qapi/misc.json             |  1 +
 target/i386/cpu.c          | 57 +++++++++++++++++++++++++++++----
 target/i386/cpu.h          |  5 +++
 target/i386/kvm.c          | 34 +++++++++++++++++++-
 target/i386/kvm_i386.h     |  1 +
 vl.c                       | 33 +++++++++++--------
 13 files changed, 213 insertions(+), 52 deletions(-)

-- 
1.8.3.1
