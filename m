Received: from eggs.gnu.org ([2001:4830:134:3::10]:49998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d3fzc-0004Uy-0n
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:45:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d3fzY-0000sI-3O
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:45:44 -0400
Received: from 6.mo5.mail-out.ovh.net ([178.32.119.138]:44012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d3fzX-0000rP-T0
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:45:40 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 4165BE820E
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 11:45:37 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 27 Apr 2017 11:45:32 +0200
Message-ID: <149328633283.30266.4224847428546759127.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 0/4] 9pfs: handle transport errors
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

Changes since v1:
- dropped the "virtio: Error object based virtio_error()" patch
- see patches for detailed changes

--
Greg

---

Greg Kurz (4):
      fsdev: don't allow unknown format in marshal/unmarshal
      9pfs: drop pdu_push_and_notify()
      virtio-9p: factor out virtio_9p_error_err()
      9pfs: handle broken transport


 fsdev/9p-iov-marshal.c     |    4 ++-
 hw/9pfs/9p.c               |   52 ++++++++++++++++++++++++++++++++------------
 hw/9pfs/9p.h               |    1 +
 hw/9pfs/virtio-9p-device.c |   51 +++++++++++++++++++++++++++++--------------
 4 files changed, 75 insertions(+), 33 deletions(-)
