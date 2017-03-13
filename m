Received: from eggs.gnu.org ([2001:4830:134:3::10]:53965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cnZoZ-00006Y-0p
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 19:55:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cnZoV-0004U7-2m
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 19:55:47 -0400
Received: from mail.kernel.org ([198.145.29.136]:46614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cnZoU-0004T8-S0
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 19:55:43 -0400
Date: Mon, 13 Mar 2017 16:55:37 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <alpine.DEB.2.10.1703131650550.21520@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Qemu-devel] [PATCH v2 0/9] xen/9pfs: introduce the Xen 9pfs backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, sstabellini@kernel.org, anthony.perard@citrix.com, jgross@suse.com, aneesh.kumar@linux.vnet.ibm.com, groug@kaod.org

Hi all,

This patch series implements a new transport for 9pfs, aimed at Xen
systems.

The transport is based on a traditional Xen frontend and backend drivers
pair. This patch series implements the backend, which typically runs in
Dom0. I sent another series to implement the frontend in Linux
(http://marc.info/?l=linux-kernel&m=148883047125960&w=2).

The backend complies to the Xen transport for 9pfs specification
version 1, available here:

http://xenbits.xen.org/gitweb/?p=xen.git;a=blob_plain;f=docs/misc/9pfs.markdown;hb=HEAD


Changes in v2:
- fix coding style
- compile xen-9p-backend.c if CONFIG_XEN_BACKEND
- add patch to set CONFIG_XEN_BACKEND only for the right targets
- add review-bys

Stefano Stabellini (9):
      configure: change CONFIG_XEN_BACKEND to be a target property
      xen: import ring.h from xen
      xen: introduce the header file for the Xen 9pfs transport protocol
      xen/9pfs: introduce Xen 9pfs backend
      xen/9pfs: connect to the frontend
      xen/9pfs: receive requests from the frontend
      xen/9pfs: implement in/out_iov_from_pdu and vmarshal/vunmarshal
      xen/9pfs: send responses back to the frontend
      xen/9pfs: build and register Xen 9pfs backend

 configure                    |   2 +-
 hw/9pfs/Makefile.objs        |   1 +
 hw/9pfs/xen-9p-backend.c     | 403 ++++++++++++++++++++++++++++++++++++++
 hw/9pfs/xen_9pfs.h           |  20 ++
 hw/block/xen_blkif.h         |   2 +-
 hw/usb/xen-usb.c             |   2 +-
 hw/xen/xen_backend.c         |   3 +
 include/hw/xen/io/ring.h     | 455 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/xen/xen_backend.h |   3 +
 9 files changed, 888 insertions(+), 3 deletions(-)
 create mode 100644 hw/9pfs/xen-9p-backend.c
 create mode 100644 hw/9pfs/xen_9pfs.h
 create mode 100644 include/hw/xen/io/ring.h
