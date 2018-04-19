Received: from eggs.gnu.org ([2001:4830:134:3::10]:57455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f9DLQ-00048b-Ck
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:27:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f9DLM-0001MT-Cn
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:27:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49696 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1f9DLM-0001Kc-77
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:27:36 -0400
Date: Thu, 19 Apr 2018 20:27:24 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180419200049-mutt-send-email-mst@kernel.org>
References: <20180412151232.17506-1-tiwei.bie@intel.com>
	<20180412151232.17506-7-tiwei.bie@intel.com>
	<20180418192154-mutt-send-email-mst@kernel.org>
	<20180419111439.i6gfhnept6wy7uzp@debian>
	<D0158A423229094DA7ABF71CF2FA0DA34E94E895@SHSMSX104.ccr.corp.intel.com>
	<20180419182035-mutt-send-email-mst@kernel.org>
	<f123c3a5-f7a3-a0e3-ffc7-b57e19610a9b@redhat.com>
	<D0158A423229094DA7ABF71CF2FA0DA34E950C67@SHSMSX104.ccr.corp.intel.com>
	<28ab1675-15ae-dab4-fd71-7632666f57fc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28ab1675-15ae-dab4-fd71-7632666f57fc@redhat.com>
Subject: Re: [Qemu-devel] [virtio-dev] RE: [PATCH v3 6/6] vhost-user:
 support registering external host notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Liang, Cunming" <cunming.liang@intel.com>, "Bie, Tiwei" <tiwei.bie@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Daly, Dan" <dan.daly@intel.com>, "Tan, Jianfeng" <jianfeng.tan@intel.com>, "Wang, Zhihong" <zhihong.wang@intel.com>, "Wang, Xiao W" <xiao.w.wang@intel.com>

On Thu, Apr 19, 2018 at 06:59:39PM +0200, Paolo Bonzini wrote:
> On 19/04/2018 18:52, Liang, Cunming wrote:
> >>> Oh you are right.
> >>> 
> >>> So it's only needed for non-intel platforms or when packets are
> >>> in WC memory then. And I don't know whether dpdk ever puts
> >>> packets in WC memory.
> >>> 
> >>> I guess we'll cross this bridge when we get to it.
> >> Non-TSO architectures seem important...
> >
> > I'm not familiar with Non-TSO, trying to understand the difference
> > according to the feature set. Let's say non-TSO architectures do not
> > set 'weak_barriers'. Then mandatory barrier is used for software. HW
> > offload on that platform would choose different feature set against
> > software? If it's not, essentially we're worried about live migration
> > from a TSO to a non-TSO architectures platform?
> 
> I'm worried about live migration from software virtio to hardware virtio
> on non-TSO architectures.  For example, on ARM you would have a "dmb
> ishst" (smp_wmb) for software virtio and a "dsb st" (wmb) or "dmb oshst"
> (dma_wmb) for hardware virtio.
> 
> For this to work, you would have to set up the VM so that it uses the
> heavier barriers from the beginning, even when backed by software virtio.
> 
> Paolo

Right. Or disallow hardware to software migrations.

But generally the mandatory and even dma barriers in Linux are often an overkill.

See ARM for example: 

#if defined(CONFIG_ARM_DMA_MEM_BUFFERABLE) || defined(CONFIG_SMP)
#define mb()            __arm_heavy_mb()
#define rmb()           dsb()
#define wmb()           __arm_heavy_mb(st)
#define dma_rmb()       dmb(osh)
#define dma_wmb()       dmb(oshst)
#else
#define mb()            barrier()
#define rmb()           barrier()
#define wmb()           barrier()
#define dma_rmb()       barrier()
#define dma_wmb()       barrier()
#endif

That CONFIG_SMP here is clearly wrong but I don't really know what
to set it to. Also, we probably should switch virtio_wmb to dma_XX
barriers.

That's actually easy. Will try to do.

-- 
MST
