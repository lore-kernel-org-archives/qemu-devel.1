Received: from eggs.gnu.org ([2001:4830:134:3::10]:36956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1duMpP-0005si-KB
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1duMpJ-0008G1-Iv
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:00:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1duMpJ-00087q-9p
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:00:53 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 19 Sep 2017 19:00:33 +0100
Message-Id: <20170919180038.26056-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] migration: let pre_save fail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com
Cc: peter.maydell@linaro.org, cohuck@redhat.com, rth@twiddle.net

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

At the moment the pre-save method on VMStateDescription returns void
which means there's no sane way of a pre_save routine failing.  There
are quite a few pre_save's that abort or do other nasty things, and it
would be better if they could fail cleanly.

This patch series doesn't fix any of those pre_save's - it just changes
pre_save to return an error value and routes that back up so the
migration fails.  I'll leave that up to the individual device owners.

There are a bunch of corner cases that I've not fixed yet;  these are
mostly places that call vmstate_save_state which have been partially
converted to modern migration code;  often the functions they're called
from return void as well - they can get fixed later.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Dr. David Alan Gilbert (5):
  migration: pre_save return int
  migration: check pre_save return in vmstate_save_state
  migration: wire vmstate_save_state errors up to
    vmstate_subsection_save
  migration: Route errors up through vmstate_save
  migration: Route more error paths

 docs/devel/migration.txt       |  2 +-
 hw/arm/pxa2xx.c                |  4 +++-
 hw/arm/strongarm.c             |  4 +++-
 hw/audio/wm8750.c              |  4 +++-
 hw/block/fdc.c                 |  4 +++-
 hw/block/m25p80.c              |  4 +++-
 hw/block/nand.c                |  4 +++-
 hw/block/onenand.c             |  4 +++-
 hw/char/serial.c               |  4 +++-
 hw/display/qxl.c               |  4 +++-
 hw/display/virtio-gpu.c        |  4 +---
 hw/i2c/core.c                  |  4 +++-
 hw/i386/kvm/clock.c            |  4 +++-
 hw/ide/core.c                  |  4 +++-
 hw/ide/pci.c                   |  4 +++-
 hw/input/ps2.c                 |  8 ++++++--
 hw/input/tsc210x.c             |  4 +++-
 hw/intc/apic_common.c          |  4 +++-
 hw/intc/arm_gic_common.c       |  4 +++-
 hw/intc/arm_gicv3_common.c     |  4 +++-
 hw/intc/arm_gicv3_its_common.c |  4 +++-
 hw/intc/i8259_common.c         |  4 +++-
 hw/intc/ioapic_common.c        |  4 +++-
 hw/intc/s390_flic_kvm.c        |  6 ++++--
 hw/intc/xics.c                 |  8 ++++++--
 hw/net/e1000.c                 |  4 +++-
 hw/net/e1000e.c                |  4 +++-
 hw/net/rtl8139.c               |  4 +++-
 hw/net/virtio-net.c            | 16 ++++++++++++----
 hw/net/vmxnet3.c               |  4 +++-
 hw/pci-host/piix.c             |  4 +++-
 hw/ppc/ppc.c                   |  4 +++-
 hw/ppc/spapr_iommu.c           |  4 +++-
 hw/ppc/spapr_pci.c             |  6 ++++--
 hw/s390x/css.c                 | 10 +++++++---
 hw/s390x/virtio-ccw.c          |  4 +++-
 hw/scsi/lsi53c895a.c           |  4 +++-
 hw/scsi/vmw_pvscsi.c           |  4 +++-
 hw/timer/cadence_ttc.c         |  4 +++-
 hw/timer/hpet.c                |  4 +++-
 hw/timer/i8254_common.c        |  4 +++-
 hw/timer/mc146818rtc.c         |  4 +++-
 hw/timer/pl031.c               |  4 +++-
 hw/timer/twl92230.c            |  4 +++-
 hw/usb/dev-smartcard-reader.c  |  4 +++-
 hw/usb/hcd-ehci.c              |  4 +++-
 hw/usb/redirect.c              |  4 +++-
 hw/virtio/vhost-vsock.c        |  4 +++-
 hw/virtio/virtio.c             | 13 +++++++------
 include/hw/virtio/virtio.h     |  2 +-
 include/migration/vmstate.h    |  6 +++---
 migration/colo-comm.c          |  4 +++-
 migration/global_state.c       |  4 +++-
 migration/savevm.c             | 23 +++++++++++++++++------
 migration/trace-events         |  1 +
 migration/vmstate-types.c      | 11 ++++++++---
 migration/vmstate.c            | 34 +++++++++++++++++++++++++---------
 replay/replay-snapshot.c       |  4 +++-
 slirp/slirp.c                  |  8 ++++++--
 target/arm/machine.c           |  4 +++-
 target/i386/machine.c          |  7 +++++--
 target/ppc/machine.c           |  4 +++-
 target/s390x/machine.c         |  4 +++-
 target/sparc/machine.c         |  4 +++-
 tests/test-vmstate.c           | 10 ++++++----
 65 files changed, 261 insertions(+), 102 deletions(-)

-- 
2.13.5
