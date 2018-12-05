Received: from eggs.gnu.org ([2001:4830:134:3::10]:49171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gUPOf-0008K5-Rh
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 00:06:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gUPOd-0004MJ-SO
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 00:06:53 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  5 Dec 2018 16:06:36 +1100
Message-Id: <20181205050641.864-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFCv2 for-4.0 0/5] Improve balloon handling of
 pagesizes other than 4kiB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dhildenb@redhat.com, imammedo@redhat.com, ehabkost@redhat.com
Cc: mst@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The virtio-balloon devices was never really thought out for cases
other than 4kiB pagesize on both guest and host.  It works in some
cases, but in others can be ineffectual or even cause guest memory
corruption.

This series makes a handful of preliminary cleanups, then makes a
change to safely, though not perfectly, handle cases with non 4kiB
pagesizes.

Changes since RFCv1:
 * Tweak warning reports in 5/5
 * More detailed motiviation in commit message for 1/5
 * Assorted minor adjustments

David Gibson (5):
  virtio-balloon: Remove unnecessary MADV_WILLNEED on deflate
  virtio-balloon: Corrections to address verification
  virtio-balloon: Rework ballon_page() interface
  virtio-balloon: Use ram_block_discard_range() instead of raw madvise()
  virtio-balloon: Safely handle BALLOON_PAGE_SIZE < host page size

 hw/virtio/virtio-balloon.c         | 100 ++++++++++++++++++++++++-----
 include/hw/virtio/virtio-balloon.h |   3 +
 2 files changed, 87 insertions(+), 16 deletions(-)

--=20
2.19.2
