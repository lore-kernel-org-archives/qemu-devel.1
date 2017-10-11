Received: from eggs.gnu.org ([2001:4830:134:3::10]:40969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1e269p-0003Pf-8S
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 21:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1e269k-0000tq-DV
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 21:50:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:57705)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1e269k-0000rn-4z
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 21:49:56 -0400
Message-ID: <59DD7932.3070106@intel.com>
Date: Wed, 11 Oct 2017 09:51:46 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1506744354-20979-4-git-send-email-wei.w.wang@intel.com>	<20171009181612-mutt-send-email-mst@kernel.org>	<59DC76BA.7070202@intel.com>	<201710102008.FIG57851.QFJLMtVOFOHFOS@I-love.SAKURA.ne.jp>	<59DCBDE9.4050404@intel.com>
	<201710102209.DBE39528.MtFLOJQSFOFVOH@I-love.SAKURA.ne.jp>
In-Reply-To: <201710102209.DBE39528.MtFLOJQSFOFVOH@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v16 3/5] virtio-balloon: VIRTIO_BALLOON_F_SG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

On 10/10/2017 09:09 PM, Tetsuo Handa wrote:
> Wei Wang wrote:
>>> And even if we could remove balloon_lock, you still cannot use
>>> __GFP_DIRECT_RECLAIM at xb_set_page(). I think you will need to use
>>> "whether it is safe to wait" flag from
>>> "[PATCH] virtio: avoid possible OOM lockup at virtballoon_oom_notify()" .
>> Without the lock being held, why couldn't we use __GFP_DIRECT_RECLAIM at
>> xb_set_page()?
> Because of dependency shown below.
>
> leak_balloon()
>    xb_set_page()
>      xb_preload(GFP_KERNEL)
>        kmalloc(GFP_KERNEL)
>          __alloc_pages_may_oom()
>            Takes oom_lock
>            out_of_memory()
>              blocking_notifier_call_chain()
>                leak_balloon()
>                  xb_set_page()
>                    xb_preload(GFP_KERNEL)
>                      kmalloc(GFP_KERNEL)
>                        __alloc_pages_may_oom()
>                          Fails to take oom_lock and loop forever

__alloc_pages_may_oom() uses mutex_trylock(&oom_lock).

I think the second __alloc_pages_may_oom() will not continue since the
first one is in progress.

>
> By the way, is xb_set_page() safe?
> Sleeping in the kernel with preemption disabled is a bug, isn't it?
> __radix_tree_preload() returns 0 with preemption disabled upon success.
> xb_preload() disables preemption if __radix_tree_preload() fails.
> Then, kmalloc() is called with preemption disabled, isn't it?
> But xb_set_page() calls xb_preload(GFP_KERNEL) which might sleep with
> preemption disabled.

Yes, I think that should not be expected, thanks.

I plan to change it like this:

bool xb_preload(gfp_t gfp)
{
         if (!this_cpu_read(ida_bitmap)) {
                 struct ida_bitmap *bitmap = kmalloc(sizeof(*bitmap), gfp);

                 if (!bitmap)
                         return false;
                 bitmap = this_cpu_cmpxchg(ida_bitmap, NULL, bitmap);
                 kfree(bitmap);
         }

         if (__radix_tree_preload(gfp, XB_PRELOAD_SIZE) < 0)
                 return false;

         return true;
}


Best,
Wei
