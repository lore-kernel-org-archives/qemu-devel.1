Received: from eggs.gnu.org ([2001:4830:134:3::10]:47903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1dvMk1-0000kX-5c
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:07:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1dvMjx-0007IG-5Z
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:07:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:33094 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jgross@suse.com>) id 1dvMjw-0007Hl-VN
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:07:29 -0400
From: Juergen Gross <jgross@suse.com>
Date: Fri, 22 Sep 2017 14:07:23 +0200
Message-Id: <20170922120725.10910-1-jgross@suse.com>
Subject: [Qemu-devel] [PATCH v2 0/2] xen: fix gnttab handling with old dom0
 kernels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: anthony.perard@citrix.com, kraxel@redhat.com, sstabellini@kernel.org, Juergen Gross <jgross@suse.com>

Trying to start a domain with a qdisk backend on an old dom0 kernel
(non-pvops xen kernel) will fail as xengnttab_set_max_grants() will
succeed only if called directly after opening the gnttab device.

These two patches address the issue by:

- moving the test for availability of xengnttab_grant_copy() from
  the qdisk backend to generic backend handling in order to not have
  to issue the grant copy ioctl with the qdisk specific file handle
- opening the gnttab device in blk_connect() only in order to
  guarantee xengnttab_set_max_grants() is called just after opening
  the gnttab device

Juergen Gross (2):
  xen: add a global indicator for grant copy being available
  xen: dont try setting max grants multiple times

 hw/block/xen_disk.c          | 34 ++++++++++++++++++----------------
 hw/xen/xen_backend.c         | 11 +++++++++++
 include/hw/xen/xen_backend.h |  1 +
 3 files changed, 30 insertions(+), 16 deletions(-)

-- 
2.12.3
