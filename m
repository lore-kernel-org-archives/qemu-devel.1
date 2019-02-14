Received: from eggs.gnu.org ([209.51.188.92]:46006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gu8p7-0002G7-3K
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:40:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gu8os-0006yj-NF
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:40:26 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 14 Feb 2019 15:39:11 +1100
Message-Id: <20190214043916.22128-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/5] Improve balloon handling of pagesizes
 other than 4kiB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

I posted some RFCs for this back in December, but didn't wrap it up in
time for 3.1.  Posting again for inclusion in 4.0.

The virtio-balloon devices was never really thought out for cases
other than 4kiB pagesize on both guest and host.  It works in some
cases, but in others can be ineffectual or even cause guest memory
corruption.

This series makes a handful of preliminary cleanups, then makes a
change to safely, though not perfectly, handle cases with non 4kiB
pagesizes.

Changes since RFC:
 * Further refinement of when to issue warnings in 5/5

David Gibson (5):
  virtio-balloon: Remove unnecessary MADV_WILLNEED on deflate
  virtio-balloon: Corrections to address verification
  virtio-balloon: Rework ballon_page() interface
  virtio-balloon: Use ram_block_discard_range() instead of raw madvise()
  virtio-balloon: Safely handle BALLOON_PAGE_SIZE < host page size

 hw/virtio/virtio-balloon.c         | 102 ++++++++++++++++++++++++-----
 include/hw/virtio/virtio-balloon.h |   3 +
 2 files changed, 89 insertions(+), 16 deletions(-)

--=20
2.20.1
