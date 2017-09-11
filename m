Received: from eggs.gnu.org ([2001:4830:134:3::10]:42352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1drTZi-0001RO-6u
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1drTZc-0005iY-6j
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:36:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1drTZc-0005hU-09
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:36:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 07BEC5D685
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 18:36:42 +0000 (UTC)
From: wexu@redhat.com
Date: Tue, 12 Sep 2017 02:56:29 +0800
Message-Id: <1505156192-18994-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [Patch 0/3] vfio: reusing address space for the same
 iommu group devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, marcel@redhat.com, alex.williamson@redhat.com, Wei Xu <wexu@redhat.com>

From: Wei Xu <wexu@redhat.com>

Recently I have been testing passing through 2 ixgbe(82599ES) nics which
belong to the same iommu group to a guest with virtual iommu(vIOMMU) on
my desktop, while vfio failed to realize the second device and prompted
error message as 'group xxx used in multiple address spaces'.

It turned out to be that vtd doesn't know any group info while choosing
an address space for the two devices, therefore it creates two separate
address space for each which breaks granularity isolation.

This patch fixes this by looking up if there is any exist device within
the same iommu group and shares the address space before creating a new
one.

I am not sure if this fixes the problem in a correct way due to my limited
knowledge about vfio, please come back to me for any feedback & comments,
Thanks.

Wei Xu (3):
  vfio: reusing address space for the same iommu group devices
  vfio: invoke looking up address space.
  vfio: remove checking duplicated vfio device

 hw/vfio/common.c              | 28 ++++++++++++++++++++++++++++
 hw/vfio/pci.c                 | 15 ++++++---------
 include/hw/vfio/vfio-common.h |  1 +
 3 files changed, 35 insertions(+), 9 deletions(-)

-- 
1.8.3.1
