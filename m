Received: from eggs.gnu.org ([2001:4830:134:3::10]:44885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cc46l-0008IX-Kz
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 00:51:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cc46i-0001yc-GK
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 00:50:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cc46i-0001xw-A4
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 00:50:56 -0500
Date: Fri, 10 Feb 2017 13:50:50 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170210055050.GF22153@pxdev.xzpeter.org>
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
	<1486456099-7345-3-git-send-email-peterx@redhat.com>
	<20170210011222.GA19188@umbus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170210011222.GA19188@umbus>
Subject: Re: [Qemu-devel] [PATCH v7 02/17] vfio: introduce vfio_get_vaddr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com

On Fri, Feb 10, 2017 at 12:12:22PM +1100, David Gibson wrote:
> On Tue, Feb 07, 2017 at 04:28:04PM +0800, Peter Xu wrote:
> > A cleanup for vfio_iommu_map_notify(). Now we will fetch vaddr even if
> > the operation is unmap, but it won't hurt much.
> > 
> > One thing to mention is that we need the RCU read lock to protect the
> > whole translation and map/unmap procedure.
> > 
> > Acked-by: Alex Williamson <alex.williamson@redhat.com>
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> So, I know I reviewed this already, but looking again I'm confused.
> 
> I'm not sure how the original code ever worked: if this is an unmap
> (perm == IOMMU_NONE), then I wouldn't even expect
> iotlb->translated_addr to have a valid value, but we're passing it to
> address_space_translate() and failing if it it doesn't give us
> sensible results.

Hmm, right.

Looks like it is just because we have accidentally inited
iotlb->translated_addr in all the callers of
memory_region_notify_iommu (one is put_tce_emu(), the other one is
rpcit_service_call()). If so, patch 3 (maybe, along with this one)
would be more essential imho to make sure we don't have such an
assumption.

Thanks,

-- peterx
