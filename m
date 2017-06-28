Received: from eggs.gnu.org ([2001:4830:134:3::10]:40100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dQJoq-0006ml-MV
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 16:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dQJon-0003yM-LC
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 16:44:12 -0400
Received: from 4.mo5.mail-out.ovh.net ([178.33.111.247]:36897)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dQJon-0003xa-E4
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 16:44:09 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id E84DC10DD64
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 22:44:07 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 28 Jun 2017 22:43:57 +0200
Message-ID: <149868263738.23385.16723444264552987199.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v5 0/5] 9pfs: handle transport errors
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

This series modifies both virtio and xen transports to take appropriate
actions when hitting misconfigured buffers.

--
Greg

---

Greg Kurz (4):
      virtio-9p: record element after sanity checks
      virtio-9p: message header is 7-byte long
      virtio-9p: break device if buffers are misconfigured
      9pfs: handle transport errors in pdu_complete()

Stefano Stabellini (1):
      xen-9pfs: disconnect if buffers are misconfigured


 hw/9pfs/9p.c               |   25 ++++++++-----
 hw/9pfs/9p.h               |    7 +++-
 hw/9pfs/virtio-9p-device.c |   51 +++++++++++++++++++++-----
 hw/9pfs/xen-9p-backend.c   |   88 +++++++++++++++++++++++++++++++++-----------
 4 files changed, 129 insertions(+), 42 deletions(-)
