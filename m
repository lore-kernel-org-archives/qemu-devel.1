Received: from eggs.gnu.org ([2001:4830:134:3::10]:53138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1csYiY-0002fA-Uu
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:46:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1csYiV-0000eI-TK
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:46:11 -0400
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:57704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1csYiV-0000bU-MM
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:46:07 -0400
Received: from player796.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 6D15C765F9
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 19:45:58 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 27 Mar 2017 19:45:47 +0200
Message-ID: <149063674781.4447.14258971700726134711.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 0/5] 9pfs: handle transport errors
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

This series modifies the existing virtio-9p transport so that it can
notify the guest about transport failures. The core 9p code is modified
as well so that it stops handling requests when the transport fails.

---

Greg Kurz (5):
      virtio: Error object based virtio_error()
      virtio-9p: factor out virtio_9p_error_err()
      fsdev: don't allow unknown format in marshal/unmarshal
      9pfs: drop pdu_push_and_notify()
      9pfs: handle broken transport


 fsdev/9p-iov-marshal.c     |    4 +--
 hw/9pfs/9p.c               |   43 +++++++++++++++++++++----------
 hw/9pfs/9p.h               |    1 +
 hw/9pfs/virtio-9p-device.c |   61 ++++++++++++++++++++++++++++++++------------
 hw/virtio/virtio.c         |   21 ++++++++++++---
 include/hw/virtio/virtio.h |    1 +
 6 files changed, 93 insertions(+), 38 deletions(-)

--
Greg
