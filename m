Received: from eggs.gnu.org ([2001:4830:134:3::10]:49557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7ia-0004Ub-9j
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:13:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7iX-0005yo-08
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:13:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34128 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ey7iW-0005yh-Qt
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:13:40 -0400
Date: Tue, 20 Mar 2018 05:13:39 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180320051202-mutt-send-email-mst@kernel.org>
References: <1520241169-22892-1-git-send-email-jianjay.zhou@huawei.com>
	<20180320033051-mutt-send-email-mst@kernel.org>
	<B2D15215269B544CADD246097EACE7473ABF2941@DGGEMM505-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B2D15215269B544CADD246097EACE7473ABF2941@DGGEMM505-MBS.china.huawei.com>
Subject: Re: [Qemu-devel] [PATCH v9] vhost: used_memslots refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "imammedo@redhat.com" <imammedo@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "Liuzhe (Ahriy, Euler)" <liuzhe13@huawei.com>

On Tue, Mar 20, 2018 at 02:09:34AM +0000, Zhoujian (jay) wrote:
> Hi Michael,
> 
> > -----Original Message-----
> > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > Sent: Tuesday, March 20, 2018 9:34 AM
> > To: Zhoujian (jay) <jianjay.zhou@huawei.com>
> > Cc: qemu-devel@nongnu.org; imammedo@redhat.com; Huangweidong (C)
> > <weidong.huang@huawei.com>; wangxin (U) <wangxinxin.wang@huawei.com>; Gonglei
> > (Arei) <arei.gonglei@huawei.com>; Liuzhe (Ahriy, Euler) <liuzhe13@huawei.com>
> > Subject: Re: [PATCH v9] vhost: used_memslots refactoring
> > 
> > On Mon, Mar 05, 2018 at 05:12:49PM +0800, Jay Zhou wrote:
> > > Used_memslots is shared by vhost kernel and user, it is equal to
> > > dev->mem->nregions, which is correct for vhost kernel, but not for
> > > vhost user, the latter one uses memory regions that have file
> > > descriptor. E.g. a VM has a vhost-user NIC and 8(vhost user memslot
> > > upper limit) memory slots, it will be failed to hotplug a new DIMM
> > > device since vhost_has_free_slot() finds no free slot left. It should
> > > be successful if only part of memory slots have file descriptor, so
> > > setting used memslots for vhost-user and vhost-kernel respectively.
> > 
> > 
> > Below should go after ---
> 
> Thanks for reminding.
> 
> > 
> > > v7 ... v9:
> > >  - rebased on the master
> > > v2 ... v6:
> > >  - delete the "used_memslots" global variable, and add it
> > >    for vhost-user and vhost-kernel separately
> > >  - refine the function, commit log
> > >  - used_memslots refactoring
> > >
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> > > Signed-off-by: Liuzhe <liuzhe13@huawei.com>
> > 
> > When built with clang this causes runtime warnings (during make check) about
> > misaligned access to structures.
> > 
> > The issue is that vhost_user_prepare_msg requests VhostUserMemory which
> > compiler assumes but is then used with a pointer into a packed structure -
> > where fields are not aligned.
> 
> Sorry I missed the patch you have sent to fix the alignment, I have replied
> to that thread.

I've dropped this from the pull for now.  Sorry about that.  Once next
pull is merged, pls rebase and post a version fixing up the alignment
issues.

Thanks for your effort!

-- 
MST
