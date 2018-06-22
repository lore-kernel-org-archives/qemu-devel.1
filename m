Received: from eggs.gnu.org ([2001:4830:134:3::10]:43176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fWRdI-0005Tx-TP
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fWRdF-0002dx-Kn
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:22:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53472 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fWRdF-0002dr-Bn
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:22:05 -0400
Date: Fri, 22 Jun 2018 22:22:01 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180622192148.178309-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH v6 0/2] kvm: limited x86 CPU power management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org

This adds ability to expose some host CPU power management capabilities
to guests. For intel guests, this is sufficient for guest to enable low
power CPU states on idle. For AMD guests it isn't sufficient, deeper
C-states are entered using System-IO.

When enabled this puts CPU in a low power state with exit latencies that
can go up to multiple milliseconds, and makes host scheduler as well as
host utilities such as top and powertop think the CPU is constantly
busy.  Thus it has the effect of dedicating a host CPU for this guest.

mwait based power management is tied closely to specifics of CPUID,
making migration challenging. At this point only the non-migrateable
-cpu host is supported.

With this patch applied, VM latency is within the noise of
baremetal for some benchmarks.

perf bench sched pipe results:
Before:
    6.452 sec
After:
    4.382 sec
Baremetal:
    4.136 sec

Changes since v5:
    Typo fix.

Changes since v4:
    See v3, now for real.

Changes since v3:
    At Paolo's suggestion, rename -dedicated to -overcommit.

Changes since v2:
    At Daniel's suggestion, don't use the -realtime flag.

    At Paolo's suggestion, group this with memory lock flag
    which has a similar effect of dedicating memory to this VM.

Michael S. Tsirkin (2):
  kvm: support -overcommit cpu-pm=on|off
  i386/cpu: make -cpu host support monitor/mwait

 include/sysemu/sysemu.h |  1 +
 target/i386/cpu.h       |  9 +++++++++
 target/i386/cpu.c       | 19 ++++++++++++++-----
 target/i386/kvm.c       | 32 ++++++++++++++++++++++++++++++++
 vl.c                    | 32 +++++++++++++++++++++++++++++++-
 qemu-options.hx         | 27 +++++++++++++++++++++++++--
 6 files changed, 112 insertions(+), 8 deletions(-)

-- 
MST
