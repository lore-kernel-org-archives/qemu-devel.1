Received: from eggs.gnu.org ([2001:4830:134:3::10]:55951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gChOv-00048q-7r
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:42:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gChOh-0007WQ-RC
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:41:52 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:58222 helo=mxct.zte.com.cn)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peng.hao2@zte.com.cn>)
	id 1gChOc-0007HN-GD
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:41:39 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Thu, 18 Oct 2018 00:52:52 +0800
Message-Id: <1539795177-21038-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH 0/5] target/i386: introduce coalesced pio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rkrcmar@redhat.com, mst@redhat.com, ehabkost@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>

Coalesced pio is base on coalesced mmio and can be used for some port
like rtc port, pci-host config port and so on.

Specially in case of rtc as coalesced pio, some versions of windows guest
access rtc frequently because of rtc as system tick. guest access rtc like
this: write register index to 0x70, then write or read data from 0x71.
writing 0x70 port is just as index and do nothing else. So we can use
coalesced pio to handle this scene to reduce VM-EXIT time.

When it starts and closes the virtual machine, it will access pci-host config
port or virtio-pci config port frequently. So setting these port as
coalesced pio can reduce startup and shutdown time. In qemu I just realize
piixfx's pci-host, it is convenient for other pci-host type implementations.

without my patch, get the vm-exit time of accessing rtc 0x70 and piix 0xcf8
using perf tools: (guest OS : windows 7 64bit)
IO Port Access  Samples Samples%  Time%  Min Time  Max Time  Avg time
0x70:POUT        86     30.99%    74.59%   9us      29us    10.75us (+- 3.41%)
0xcf8:POUT     1119     2.60%     2.12%   2.79us    56.83us 3.41us (+- 2.23%)

with my patch
IO Port Access  Samples Samples%  Time%   Min Time  Max Time   Avg time
0x70:POUT       106    32.02%    29.47%    0us      10us     1.57us (+- 7.38%)
0xcf8:POUT      1065    1.67%     0.28%   0.41us    65.44us   0.66us (+- 10.55%)

These are just qemu's patches, another patches are for kernel.

Changes v4 --> v5:
    update kvm header, improve compatibility.

Changes v3 --> v4
    modify coalesced_mmio_{add|del} to coalesced_io_{add|del}
    delete unnecessary macro define

Peng Hao (5):
  target-i386: add rtc 0x70 port as coalesced_pio
  target-i386: add i440fx 0xcf8 port as coalesced_pio
  target-i386: add q35 0xcf8 port as coalesced_pio
  target/i386: add coalesced pio support
  target-i386: add coalesced_pio API

 accel/kvm/kvm-all.c       | 60 +++++++++++++++++++++++++++++++++++++++++++----
 hw/pci-host/piix.c        |  4 ++++
 hw/pci-host/q35.c         |  4 ++++
 hw/timer/mc146818rtc.c    |  8 +++++++
 include/exec/memory.h     |  4 ++--
 linux-headers/linux/kvm.h |  9 ++++++-
 memory.c                  |  4 ++--
 7 files changed, 83 insertions(+), 10 deletions(-)

-- 
1.8.3.1
