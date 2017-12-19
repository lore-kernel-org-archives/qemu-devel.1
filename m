Received: from eggs.gnu.org ([2001:4830:134:3::10]:40342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eRMNu-0007cC-1T
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 13:12:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eRMNp-00053p-7z
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 13:12:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:64224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1eRMNp-00052q-29
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 13:12:53 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3E868C059B60
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 18:12:52 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Tue, 19 Dec 2017 19:11:26 +0100
Message-Id: <20171219181129.24189-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] Vhost: no more leak QEMU virtual addresses
 to user backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com
Cc: mlureau@redhat.com, Maxime Coquelin <maxime.coquelin@redhat.com>

Before this series, QEMU process virtual addresses are sent to the
user backend as user addresses.

Passing these virtual addresses aren't useful, as the backend doesn't
direct access to QEMU address space.

It does make sense however for kernel backend, which can access QEMU
address space.

This series introduce a new enum set by the backend stating whether it
prefers using QEMU Virtual addresses or Guest physical addresses as
User address, and make vhost-user backend to use Guest physical
addresses.

Maxime Coquelin (3):
  vhost-user: rename VhostUserMemory userspace_addr field to user_addr
  vhost: introduce backend's user address type
  vhost-user: no more leak QEMU virtual addresses to user backend

 hw/virtio/vhost-backend.c         |  1 +
 hw/virtio/vhost-user.c            |  6 ++++--
 hw/virtio/vhost.c                 | 16 ++++++++++++----
 include/hw/virtio/vhost-backend.h |  6 ++++++
 4 files changed, 23 insertions(+), 6 deletions(-)

-- 
2.14.3
