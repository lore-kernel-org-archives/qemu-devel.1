Received: from eggs.gnu.org ([2001:4830:134:3::10]:43379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liuqing@huayun.com>) id 1dmDVn-0000fJ-Vr
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 02:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liuqing@huayun.com>) id 1dmDVk-0004Hp-Pp
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 02:27:03 -0400
Received: from mx0.ioa.cn ([103.231.69.96]:44045 helo=mx1.ioa.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liuqing@huayun.com>) id 1dmDVk-0004HH-29
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 02:27:00 -0400
Date: Mon, 28 Aug 2017 13:56:31 +0800
From: Liu Qing <liuqing@huayun.com>
Message-ID: <20170828055631.GB3258@host-172-16-90-85.openstacklocal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Qemu-devel] reduce write bandwidth of qcow2 driver while
 allocating new cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: liuqing@huayun.com

Dear list,
    Recently I used fio to test qcow2 driver in the guest os, and found out
that when a new cluster is allocated the 4K IO will occupy 64K(default cluster
size) bandwith.
    From the code qcow2 driver will fill the unused part of new allocated
cluster with 0 in perform_cow. These 0s are set in qcow2_co_readv when the read
destination is not allocated and it has no backing file. Could I forbidden any
further write in copy_sectors if the copy source is not allocated and it has
no backing file? So only the requested data is written to the cluster. Function
copy_sectors is only used by perform_cow in the master branch.
    Do you think this change is reasonable? Thanks.
