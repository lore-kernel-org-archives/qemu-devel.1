Received: from eggs.gnu.org ([2001:4830:134:3::10]:47414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dOIL7-0001hf-GN
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 02:45:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dOIL2-0007sE-KM
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 02:45:09 -0400
Received: from 15.mo5.mail-out.ovh.net ([178.33.107.29]:50564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dOIL2-0007rq-Cy
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 02:45:04 -0400
Received: from player695.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 90D00105703
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 08:45:02 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 23 Jun 2017 08:44:52 +0200
Message-ID: <149820029273.7187.14110849422638329192.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4 0/4] 9pfs: handle transport errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>

The 9p protocol relies on a reliable transport, but the current code
treats transport errors (ie, failure to marshal or unmarshal) as if
they were coming from the backend. This doesn't make sense: if the
transport failed, we should notify the guest that the transport is
broken and needs to be reset, using transport specific means.

This series only modifies the virtio transport so that it can notify
the guest about transport failures.

Changes since v3:
- addressed comment from MST (patch 3)

--
Greg

---

Greg Kurz (4):
      virtio-9p: record element after sanity checks
      virtio-9p: message header is 7-byte long
      virtio-9p: break device if buffers are misconfigured
      9pfs: handle transport errors in pdu_complete()


 hw/9pfs/9p.c               |   25 ++++++++++++-------
 hw/9pfs/9p.h               |    7 ++++-
 hw/9pfs/virtio-9p-device.c |   59 ++++++++++++++++++++++++++++++++++++--------
 hw/9pfs/xen-9p-backend.c   |    3 +-
 4 files changed, 72 insertions(+), 22 deletions(-)
