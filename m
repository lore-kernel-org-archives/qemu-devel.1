Received: from eggs.gnu.org ([2001:4830:134:3::10]:49200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eBcca-0005IB-7U
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 03:19:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eBccV-0005qB-A5
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 03:19:04 -0500
Received: from mga14.intel.com ([192.55.52.115]:64029)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eBccV-0005pm-0q
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 03:18:59 -0500
Message-ID: <5A001B72.1010204@intel.com>
Date: Mon, 06 Nov 2017 16:21:06 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1509696786-1597-1-git-send-email-wei.w.wang@intel.com>	<1509696786-1597-5-git-send-email-wei.w.wang@intel.com>	<201711032025.HJC78622.SFFOMLOtFQHVJO@I-love.SAKURA.ne.jp>	<59FD9FE3.5090409@intel.com>
	<201711042028.EGB64074.FOLMHtFJVQOOFS@I-love.SAKURA.ne.jp>
In-Reply-To: <201711042028.EGB64074.FOLMHtFJVQOOFS@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v17 4/6] virtio-balloon: VIRTIO_BALLOON_F_SG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com
Cc: david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

On 11/04/2017 07:28 PM, Tetsuo Handa wrote:
> Wei Wang wrote:
>> On 11/03/2017 07:25 PM, Tetsuo Handa wrote:
>>
>> If this is inside vb->balloon_lock mutex (isn't this?), xb_set_page() must not
>> use __GFP_DIRECT_RECLAIM allocation, for leak_balloon_sg_oom() will be blocked
>> on vb->balloon_lock mutex.
>> OK. Since the preload() doesn't need too much memory (< 4K in total),
>> how about GFP_NOWAIT here?
> Maybe GFP_NOWAIT | __GFP_NOWARN ?

Sounds good to me. I also plan to move "xb_set_page()" under mutex_lock, 
that is,

     fill_balloon()
     {
         ...
         mutex_lock(&vb->balloon_lock);

         vb->num_pfns = 0;
         while ((page = balloon_page_pop(&pages))) {
==>        xb_set_page(..,page,..);
                 balloon_page_enqueue(&vb->vb_dev_info, page);
         ...
     }

As explained in the xbitmap patch, we need the lock to avoid concurrent 
access to the bitmap.

Best,
Wei
