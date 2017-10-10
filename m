Received: from eggs.gnu.org ([2001:4830:134:3::10]:53437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1e1uL3-0000Vq-Li
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:12:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1e1uL0-0007Dn-HB
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:12:49 -0400
Received: from www262.sakura.ne.jp ([2001:e42:101:1:202:181:97:72]:45046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1e1uL0-0006Vw-36
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:12:46 -0400
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <1506744354-20979-4-git-send-email-wei.w.wang@intel.com>
	<20171009181612-mutt-send-email-mst@kernel.org>
	<59DC76BA.7070202@intel.com>
	<201710102008.FIG57851.QFJLMtVOFOHFOS@I-love.SAKURA.ne.jp>
	<59DCBDE9.4050404@intel.com>
In-Reply-To: <59DCBDE9.4050404@intel.com>
Message-Id: <201710102209.DBE39528.MtFLOJQSFOFVOH@I-love.SAKURA.ne.jp>
Date: Tue, 10 Oct 2017 22:09:43 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Qemu-devel] [PATCH v16 3/5] virtio-balloon: VIRTIO_BALLOON_F_SG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wei.w.wang@intel.com, mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

Wei Wang wrote:
> > And even if we could remove balloon_lock, you still cannot use
> > __GFP_DIRECT_RECLAIM at xb_set_page(). I think you will need to use
> > "whether it is safe to wait" flag from
> > "[PATCH] virtio: avoid possible OOM lockup at virtballoon_oom_notify()" .
> 
> Without the lock being held, why couldn't we use __GFP_DIRECT_RECLAIM at 
> xb_set_page()?

Because of dependency shown below.

leak_balloon()
  xb_set_page()
    xb_preload(GFP_KERNEL)
      kmalloc(GFP_KERNEL)
        __alloc_pages_may_oom()
          Takes oom_lock
          out_of_memory()
            blocking_notifier_call_chain()
              leak_balloon()
                xb_set_page()
                  xb_preload(GFP_KERNEL)
                    kmalloc(GFP_KERNEL)
                      __alloc_pages_may_oom()
                        Fails to take oom_lock and loop forever

By the way, is xb_set_page() safe?
Sleeping in the kernel with preemption disabled is a bug, isn't it?
__radix_tree_preload() returns 0 with preemption disabled upon success.
xb_preload() disables preemption if __radix_tree_preload() fails.
Then, kmalloc() is called with preemption disabled, isn't it?
But xb_set_page() calls xb_preload(GFP_KERNEL) which might sleep with
preemption disabled.
