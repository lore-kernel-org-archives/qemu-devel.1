Received: from eggs.gnu.org ([2001:4830:134:3::10]:58237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liuqing@huayun.com>) id 1dmWov-0000t4-1i
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 23:04:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liuqing@huayun.com>) id 1dmWou-0006bI-7Z
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 23:04:05 -0400
Date: Tue, 29 Aug 2017 11:05:04 +0800
From: Liu Qing <liuqing@huayun.com>
Message-ID: <20170829030504.GB30307@host-172-16-90-85.openstacklocal>
References: <20170828055631.GB3258@host-172-16-90-85.openstacklocal>
	<f3668e32-27bd-ba30-0575-1d6b3a93a151@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f3668e32-27bd-ba30-0575-1d6b3a93a151@redhat.com>
Subject: Re: [Qemu-devel] reduce write bandwidth of qcow2 driver while
 allocating new cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>

On Mon, Aug 28, 2017 at 05:40:48PM -0400, John Snow wrote:
> 
> 
> On 08/28/2017 01:56 AM, Liu Qing wrote:
> > Dear list,
> >     Recently I used fio to test qcow2 driver in the guest os, and found out
> > that when a new cluster is allocated the 4K IO will occupy 64K(default cluster
> > size) bandwith.
> >     From the code qcow2 driver will fill the unused part of new allocated
> > cluster with 0 in perform_cow. These 0s are set in qcow2_co_readv when the read
> > destination is not allocated and it has no backing file. Could I forbidden any
> > further write in copy_sectors if the copy source is not allocated and it has
> > no backing file? So only the requested data is written to the cluster. Function
> > copy_sectors is only used by perform_cow in the master branch.
> >     Do you think this change is reasonable? Thanks.
> > 
> > 
> 
> CCing qemu-block.
> 
> If I am understanding you correctly, you're noticing an adverse
> performance impact from initial writes to unallocated clusters through
> the qcow2 driver, when qcow2 performs zero-fill of uninitiated clusters.
Yes, that's it.
> 
> First, can you look at sources for current master branch? it hasn't been
> named "copy_sectors" since June 2016, and the function looks a bit
> differently than it did in the version you're looking at, I think.
I checkout the latest master branch and the code path has some changes, but the
zero-fill process still exists. Eric has replied a patch from Anton
which could improve the write performance. Thanks all.
> 
> John
> 
