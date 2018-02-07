Received: from eggs.gnu.org ([2001:4830:134:3::10]:56273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ejDZ0-0007JI-C2
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 19:26:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ejDYx-0004ZS-7d
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 19:26:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ejDYx-0004XP-1Q
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 19:26:11 -0500
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 06 Feb 2018 17:26:07 -0700
Message-ID: <20180207001615.1156.10547.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH 0/5] vfio: ioeventfd support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, kvm@vger.kernel.org

For the matching kernel patch, see:

https://lkml.org/lkml/2018/2/6/866

This series enables ioeventfd support and makes use of a proposed vfio
kernel ioeventfd interface for accelerating high frequency writes
through to the device.  In the specific case addressed, the writes are
to a range of MMIO space virtualized in QEMU for NVIDIA GeForce
support, but which also hosts a register which is used to allow the
MSI interrupt for the device to re-trigger.  Applications which
generate a very high interrupt rate on the GPU can see noticeable
overhead as a result of this trap through QEMU.  We added an option
for users to disable these quirks entirely for non-Geforce cards[1]
for optimal performance, but for GeForce users and users that can't
tweak their VM config, this gets us to within 95% of that performance
for an interrupt intensive micro-benchmark (from 83%).  I'd be
interested in more typical benchmark results to understand if there's
an improvement there as well.  Thanks,

Alex

[1] https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg06878.html

---

Alex Williamson (5):
      vfio/quirks: Add common quirk alloc helper
      vfio/quirks: Add generic support for ioveventfds
      vfio/quirks: Automatic ioeventfd enabling for NVIDIA BAR0 quirks
      vfio: Update linux header
      vfio/quirks: Enable ioeventfd quirks to be handled by vfio directly


 hw/vfio/pci-quirks.c       |  184 +++++++++++++++++++++++++++++++++++++-------
 hw/vfio/pci.h              |   13 +++
 linux-headers/linux/vfio.h |   24 ++++++
 3 files changed, 192 insertions(+), 29 deletions(-)
