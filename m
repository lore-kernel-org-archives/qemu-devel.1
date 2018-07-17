Received: from eggs.gnu.org ([2001:4830:134:3::10]:49353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ffYkt-0005Qg-D6
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 18:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ffYko-0000ha-If
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 18:47:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58878 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ffYko-0000gF-D2
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 18:47:34 -0400
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 17 Jul 2018 16:47:31 -0600
Message-ID: <20180717222721.14019.27548.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH 0/3] Balloon inhibit enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org

Directly assigned vfio devices have never been compatible with
ballooning.  Zapping MADV_DONTNEED pages happens completely
independent of vfio page pinning and IOMMU mapping, leaving us with
inconsistent GPA to HPA mapping between vCPUs and assigned devices
when the balloon deflates.  Mediated devices can theoretically do
better, if we make the assumption that the mdev vendor driver is fully
synchronized to the actual working set of the guest driver.  In that
case the guest balloon driver should never be able to allocate an mdev
pinned page for balloon inflation.  Unfortunately, QEMU can't know the
workings of the vendor driver pinning, and doesn't actually know the
difference between mdev devices and directly assigned devices.  Until
we can sort out how the vfio IOMMU backend can tell us if ballooning
is safe, the best approach is to disabling ballooning any time a vfio
devices is attached.

To do that, simply make the balloon inhibitor a counter rather than a
boolean, fixup a case where KVM can then simply use the inhibit
interface, and inhibit ballooning any time a vfio device is attached.
I'm expecting we'll expose some sort of flag similar to
KVM_CAP_SYNC_MMU from the vfio IOMMU for cases where we can resolve
this.  An addition we could consider here would be yet another device
option for vfio, such as x-disable-balloon-inhibit, in case there are
mdev devices that behave in a manner compatible with ballooning.

Please let me know if this looks like a good idea.  Thanks,

Alex

---

Alex Williamson (3):
      balloon: Allow nested inhibits
      kvm: Use inhibit to prevent ballooning without synchronous mmu
      vfio: Inhibit ballooning


 accel/kvm/kvm-all.c        |    4 ++++
 balloon.c                  |    7 ++++---
 hw/vfio/common.c           |    6 ++++++
 hw/virtio/virtio-balloon.c |    4 +---
 4 files changed, 15 insertions(+), 6 deletions(-)
