Received: from eggs.gnu.org ([2001:4830:134:3::10]:34673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dibqL-00011y-5f
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 03:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dibqG-0004dD-4T
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 03:37:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:19318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dibqF-0004bx-Rt
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 03:37:16 -0400
Message-ID: <599699AF.1090705@intel.com>
Date: Fri, 18 Aug 2017 15:39:27 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1502940416-42944-1-git-send-email-wei.w.wang@intel.com>
	<1502940416-42944-4-git-send-email-wei.w.wang@intel.com>
	<20170818051451-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170818051451-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v14 3/5] virtio-balloon: VIRTIO_BALLOON_F_SG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

On 08/18/2017 10:22 AM, Michael S. Tsirkin wrote:
> +static void send_balloon_page_sg(struct virtio_balloon *vb,
> +				 struct virtqueue *vq,
> +				 void *addr,
> +				 uint32_t size)
> +{
> +	unsigned int len;
> +	int ret;
> +
> +	do {
> +		ret = add_one_sg(vq, addr, size);
> +		virtqueue_kick(vq);
> +		wait_event(vb->acked, virtqueue_get_buf(vq, &len));
> +		/*
> +		 * It is uncommon to see the vq is full, because the sg is sent
> +		 * one by one and the device is able to handle it in time. But
> +		 * if that happens, we go back to retry after an entry gets
> +		 * released.
> +		 */
> Why send one by one though? Why not batch some s/gs and wait for all
> of them to be completed? If memory if fragmented, waiting every time is
> worse than what we have now (VIRTIO_BALLOON_ARRAY_PFNS_MAX at a time).
>

OK, I'll do batching in some fashion.


Best,
Wei
