Received: from eggs.gnu.org ([2001:4830:134:3::10]:34227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dz120-0003lF-Ev
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:45:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dz11w-0001t4-E5
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:45:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dz11w-0001qQ-3t
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:45:08 -0400
Date: Mon, 2 Oct 2017 16:44:52 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171002160757-mutt-send-email-mst@kernel.org>
References: <1506744354-20979-1-git-send-email-wei.w.wang@intel.com>
	<1506744354-20979-4-git-send-email-wei.w.wang@intel.com>
	<20171002072106-mutt-send-email-mst@kernel.org>
	<286AC319A985734F985F78AFA26841F73931FDB5@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F73931FDB5@shsmsx102.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH v16 3/5] virtio-balloon: VIRTIO_BALLOON_F_SG
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mhocko@kernel.org" <mhocko@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "david@redhat.com" <david@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "aarcange@redhat.com" <aarcange@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "willy@infradead.org" <willy@infradead.org>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>
List-ID: <qemu-devel.nongnu.org>

On Mon, Oct 02, 2017 at 12:39:30PM +0000, Wang, Wei W wrote:
> On Monday, October 2, 2017 12:30 PM, Michael S. Tsirkin wrote:
> > On Sat, Sep 30, 2017 at 12:05:52PM +0800, Wei Wang wrote:
> > > +static int send_balloon_page_sg(struct virtio_balloon *vb,
> > > +				 struct virtqueue *vq,
> > > +				 void *addr,
> > > +				 uint32_t size,
> > > +				 bool batch)
> > > +{
> > > +	int err;
> > > +
> > > +	err = add_one_sg(vq, addr, size);
> > > +
> > > +	/* If batchng is requested, we batch till the vq is full */
> > 
> > typo
> > 
> > > +	if (!batch || !vq->num_free)
> > > +		kick_and_wait(vq, vb->acked);
> > > +
> > > +	return err;
> > > +}
> > 
> > If add_one_sg fails, kick_and_wait will hang forever.
> > 
> > The reason this might work in because
> > 1. with 1 sg there are no memory allocations 2. if adding fails on vq full, then
> > something
> >    is in queue and will wake up kick_and_wait.
> > 
> > So in short this is expected to never fail.
> > How about a BUG_ON here then?
> > And make it void, and add a comment with above explanation.
> > 
> 
> 
> Yes, agree that this wouldn't fail - the worker thread performing the ballooning operations has been put into sleep when the vq is full, so I think there shouldn't be anyone else to put more sgs onto the vq then.
> Btw, not sure if we need to mention memory allocation in the comment, I found virtqueue_add() doesn't return any error when allocation (for indirect desc-s) fails - it simply avoids the use of indirect desc.
> 
> What do you think of the following? 
> 
> err = add_one_sg(vq, addr, size);
> /* 
>   * This is expected to never fail: there is always at least 1 entry available on the vq,
>   * because when the vq is full the worker thread that adds the sg will be put into
>   * sleep until at least 1 entry is available to use.
>   */
> BUG_ON(err);
> 
> Best,
> Wei
> 
> 
> 
>  

Sounds good.
