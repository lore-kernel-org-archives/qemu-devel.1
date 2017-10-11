Received: from eggs.gnu.org ([2001:4830:134:3::10]:46971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <penguin-kernel@i-love.sakura.ne.jp>)
	id 1e26mU-0001kr-7N
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 22:29:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <penguin-kernel@i-love.sakura.ne.jp>)
	id 1e26mP-0002Kv-6L
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 22:29:58 -0400
Received: from www262.sakura.ne.jp ([2001:e42:101:1:202:181:97:72]:40914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <penguin-kernel@i-love.sakura.ne.jp>)
	id 1e26mO-0001aZ-LY
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 22:29:53 -0400
Message-Id: <201710110226.v9B2QGdx019779@www262.sakura.ne.jp>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
MIME-Version: 1.0
Date: Wed, 11 Oct 2017 11:26:16 +0900
References: <201710102209.DBE39528.MtFLOJQSFOFVOH@I-love.SAKURA.ne.jp>
	<59DD7932.3070106@intel.com>
In-Reply-To: <59DD7932.3070106@intel.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] =?iso-2022-jp?b?W1BBVENIIHYxNiAzLzVdIHZpcnRpby1i?=
 =?iso-2022-jp?b?YWxsb29uOiBWSVJUSU9fQkFMTE9PTl9GX1NH?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

Wei Wang wrote:
>On 10/10/2017 09:09 PM, Tetsuo Handa wrote:
>> Wei Wang wrote:
>>>> And even if we could remove balloon_lock, you still cannot use
>>>> __GFP_DIRECT_RECLAIM at xb_set_page(). I think you will need to use
>>>> "whether it is safe to wait" flag from
>>>> "[PATCH] virtio: avoid possible OOM lockup at virtballoon_oom_notify()" .
>>> Without the lock being held, why couldn't we use __GFP_DIRECT_RECLAIM at
>>> xb_set_page()?
>> Because of dependency shown below.
>>
>> leak_balloon()
>>    xb_set_page()
>>      xb_preload(GFP_KERNEL)
>>        kmalloc(GFP_KERNEL)
>>          __alloc_pages_may_oom()
>>            Takes oom_lock
>>            out_of_memory()
>>              blocking_notifier_call_chain()
>>                leak_balloon()
>>                  xb_set_page()
>>                    xb_preload(GFP_KERNEL)
>>                      kmalloc(GFP_KERNEL)
>>                        __alloc_pages_may_oom()
>>                          Fails to take oom_lock and loop forever
>
>__alloc_pages_may_oom() uses mutex_trylock(&oom_lock).

Yes. But this mutex_trylock(&oom_lock) is semantically mutex_lock(&oom_lock)
because __alloc_pages_slowpath() will continue looping until
mutex_trylock(&oom_lock) succeeds (or somebody releases memory).

>
>I think the second __alloc_pages_may_oom() will not continue since the
>first one is in progress.

The second __alloc_pages_may_oom() will be called repeatedly because
__alloc_pages_slowpath() will continue looping (unless somebody releases
memory).

>
>>
>> By the way, is xb_set_page() safe?
>> Sleeping in the kernel with preemption disabled is a bug, isn't it?
>> __radix_tree_preload() returns 0 with preemption disabled upon success.
>> xb_preload() disables preemption if __radix_tree_preload() fails.
>> Then, kmalloc() is called with preemption disabled, isn't it?
>> But xb_set_page() calls xb_preload(GFP_KERNEL) which might sleep with
>> preemption disabled.
>
>Yes, I think that should not be expected, thanks.
>
>I plan to change it like this:
>
>bool xb_preload(gfp_t gfp)
>{
>         if (!this_cpu_read(ida_bitmap)) {
>                 struct ida_bitmap *bitmap = kmalloc(sizeof(*bitmap), gfp);
>
>                 if (!bitmap)
>                         return false;
>                 bitmap = this_cpu_cmpxchg(ida_bitmap, NULL, bitmap);
>                 kfree(bitmap);
>         }

Excuse me, but you are allocating per-CPU memory when running CPU might
change at this line? What happens if running CPU has changed at this line?
Will it work even with new CPU's ida_bitmap == NULL ?

>
>         if (__radix_tree_preload(gfp, XB_PRELOAD_SIZE) < 0)
>                 return false;
>
>         return true;
>}
