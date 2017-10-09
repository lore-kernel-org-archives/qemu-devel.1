Received: from eggs.gnu.org ([2001:4830:134:3::10]:44061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1e1XBC-0003ti-57
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 08:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1e1XB8-00005s-4T
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 08:29:06 -0400
Received: from www262.sakura.ne.jp ([2001:e42:101:1:202:181:97:72]:17255)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1e1XB7-0008Vu-Me
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 08:29:02 -0400
References: <1506744354-20979-1-git-send-email-wei.w.wang@intel.com>
	<1506744354-20979-2-git-send-email-wei.w.wang@intel.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <3b575060-e30b-1afe-96a8-6a9f732d5528@I-love.SAKURA.ne.jp>
Date: Mon, 9 Oct 2017 20:30:00 +0900
MIME-Version: 1.0
In-Reply-To: <1506744354-20979-2-git-send-email-wei.w.wang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v16 1/5] lib/xbitmap: Introduce xbitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

On 2017/09/30 13:05, Wei Wang wrote:
>  /**
> + *  xb_preload - preload for xb_set_bit()
> + *  @gfp_mask: allocation mask to use for preloading
> + *
> + * Preallocate memory to use for the next call to xb_set_bit(). This function
> + * returns with preemption disabled. It will be enabled by xb_preload_end().
> + */
> +void xb_preload(gfp_t gfp)
> +{
> +	if (__radix_tree_preload(gfp, XB_PRELOAD_SIZE) < 0)
> +		preempt_disable();
> +
> +	if (!this_cpu_read(ida_bitmap)) {
> +		struct ida_bitmap *bitmap = kmalloc(sizeof(*bitmap), gfp);
> +
> +		if (!bitmap)
> +			return;
> +		bitmap = this_cpu_cmpxchg(ida_bitmap, NULL, bitmap);
> +		kfree(bitmap);
> +	}
> +}

I'm not sure whether this function is safe.

__radix_tree_preload() returns 0 with preemption disabled upon success.
xb_preload() disables preemption if __radix_tree_preload() fails.
Then, kmalloc() is called with preemption disabled, isn't it?
But xb_set_page() calls xb_preload(GFP_KERNEL) which might sleep...
