Received: from eggs.gnu.org ([2001:4830:134:3::10]:58962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fSoK3-00077q-LU
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 14:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fSoK0-0005Jq-Gu
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 14:47:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45222 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fSoK0-0005Jk-CD
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 14:47:12 -0400
Date: Tue, 12 Jun 2018 21:47:11 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180612184616.90838-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH v2 0/2] kvm: x86 CPU power management
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

This adds ability to expose host CPU power management capabilities to
guests. For intel guests, this is sufficient for guest to enable
low power CPU power management. For AMD guests it isn't sufficient,
deeper C-states are entered using System-IO.

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

Michael S. Tsirkin (2):
  kvm: support -realtime cpu-pm=on|off
  i386/cpu: make -cpu host support monitor/mwait

 include/sysemu/sysemu.h |  1 +
 target/i386/cpu.h       |  9 +++++++++
 target/i386/cpu.c       | 19 ++++++++++++++-----
 target/i386/kvm.c       | 30 ++++++++++++++++++++++++++++++
 vl.c                    |  6 ++++++
 qemu-options.hx         |  9 +++++++--
 6 files changed, 67 insertions(+), 7 deletions(-)

-- 
MST
