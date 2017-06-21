Received: from eggs.gnu.org ([2001:4830:134:3::10]:54040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNjdf-0002Ol-4J
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 13:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNjdb-0003k9-KJ
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 13:41:59 -0400
Received: from 14.mo5.mail-out.ovh.net ([188.165.51.82]:44346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dNjdb-0003j7-Dr
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 13:41:55 -0400
Received: from player695.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id B47BC1082FA
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 19:41:53 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 21 Jun 2017 19:41:43 +0200
Message-ID: <149806690313.3840.13274158676579302242.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 0/4] 9pfs: handle transport errors
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

Changes since v2:
- complete rework

--
Greg

---

Greg Kurz (4):
      virtio-9p: record element after sanity checks
      virtio-9p: message header is 7-byte long
      virtio-9p: break device if buffers are misconfigured
      9pfs: handle transport errors in pdu_complete()


 hw/9pfs/9p.c               |   25 +++++++++++++-------
 hw/9pfs/9p.h               |    7 +++++-
 hw/9pfs/virtio-9p-device.c |   56 ++++++++++++++++++++++++++++++++++++--------
 hw/9pfs/xen-9p-backend.c   |    3 ++
 4 files changed, 70 insertions(+), 21 deletions(-)
