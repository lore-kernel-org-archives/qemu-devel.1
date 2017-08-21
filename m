Received: from eggs.gnu.org ([2001:4830:134:3::10]:49350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1djtMz-0001Ij-42
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 16:32:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1djtMu-0006Iz-7b
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 16:32:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1djtMu-0006GV-1L
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 16:32:16 -0400
Date: Mon, 21 Aug 2017 23:22:17 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170821232052-mutt-send-email-mst@kernel.org>
References: <1502940416-42944-1-git-send-email-wei.w.wang@intel.com>
	<1502940416-42944-4-git-send-email-wei.w.wang@intel.com>
	<20170818051451-mutt-send-email-mst@kernel.org>
	<599699AF.1090705@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <599699AF.1090705@intel.com>
Subject: Re: [Qemu-devel] [PATCH v14 3/5] virtio-balloon: VIRTIO_BALLOON_F_SG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

On Fri, Aug 18, 2017 at 03:39:27PM +0800, Wei Wang wrote:
> On 08/18/2017 10:22 AM, Michael S. Tsirkin wrote:
> > +static void send_balloon_page_sg(struct virtio_balloon *vb,
> > +				 struct virtqueue *vq,
> > +				 void *addr,
> > +				 uint32_t size)
> > +{
> > +	unsigned int len;
> > +	int ret;
> > +
> > +	do {
> > +		ret = add_one_sg(vq, addr, size);
> > +		virtqueue_kick(vq);
> > +		wait_event(vb->acked, virtqueue_get_buf(vq, &len));
> > +		/*
> > +		 * It is uncommon to see the vq is full, because the sg is sent
> > +		 * one by one and the device is able to handle it in time. But
> > +		 * if that happens, we go back to retry after an entry gets
> > +		 * released.
> > +		 */
> > Why send one by one though? Why not batch some s/gs and wait for all
> > of them to be completed? If memory if fragmented, waiting every time is
> > worse than what we have now (VIRTIO_BALLOON_ARRAY_PFNS_MAX at a time).
> > 
> 
> OK, I'll do batching in some fashion.
> 
> 
> Best,
> Wei
> 
> 

btw you need to address the build errors that kbot has found.

-- 
MST
