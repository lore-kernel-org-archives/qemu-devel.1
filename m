Received: from eggs.gnu.org ([2001:4830:134:3::10]:46315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1faEmO-0001rp-A9
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 02:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1faEmL-0006Mk-5m
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 02:27:12 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:34049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1faEmK-0006MV-SF
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 02:27:09 -0400
Received: by mail-pf0-x241.google.com with SMTP id e10-v6so499854pfn.1
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 23:27:08 -0700 (PDT)
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-8-xiaoguangrong@tencent.com>
	<20180619073650.GB14814@xz-mi>
	<5745f752-50b5-0645-21a7-3336ea0dd5c2@gmail.com>
	<20180629112224.GG2568@work-vm>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <4e365b59-9859-c5b6-5d45-7940507eb7a9@gmail.com>
Date: Tue, 3 Jul 2018 14:27:01 +0800
MIME-Version: 1.0
In-Reply-To: <20180629112224.GG2568@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/12] migration: hold the lock only if it
 is really needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 06/29/2018 07:22 PM, Dr. David Alan Gilbert wrote:
> * Xiao Guangrong (guangrong.xiao@gmail.com) wrote:
>>
>>
>> On 06/19/2018 03:36 PM, Peter Xu wrote:
>>> On Mon, Jun 04, 2018 at 05:55:15PM +0800, guangrong.xiao@gmail.com wrote:
>>>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>>>
>>>> Try to hold src_page_req_mutex only if the queue is not
>>>> empty
>>>
>>> Pure question: how much this patch would help?  Basically if you are
>>> running compression tests then I think it means you are with precopy
>>> (since postcopy cannot work with compression yet), then here the lock
>>> has no contention at all.
>>
>> Yes, you are right, however we can observe it is in the top functions
>> (after revert this patch):
> 
> Can you show the matching trace with the patch in?

Sure, there is:

+   8.38%  kqemu  [kernel.kallsyms]        [k] copy_user_enhanced_fast_string
+   8.03%  kqemu  qemu-system-x86_64       [.] ram_bytes_total
+   6.62%  kqemu  qemu-system-x86_64       [.] qemu_event_set
+   6.02%  kqemu  qemu-system-x86_64       [.] qemu_put_qemu_file
+   5.81%  kqemu  qemu-system-x86_64       [.] __ring_put
+   5.04%  kqemu  qemu-system-x86_64       [.] compress_thread_data_done
+   4.48%  kqemu  qemu-system-x86_64       [.] ring_is_full
+   4.44%  kqemu  qemu-system-x86_64       [.] ring_mp_get
+   3.39%  kqemu  qemu-system-x86_64       [.] __ring_is_full
+   2.61%  kqemu  qemu-system-x86_64       [.] add_to_iovec
+   2.48%  kqemu  qemu-system-x86_64       [.] threads_submit_request_prepare
+   2.08%  kqemu  libc-2.12.so             [.] memcpy
+   2.07%  kqemu  qemu-system-x86_64       [.] ring_len
+   1.91%  kqemu  [kernel.kallsyms]        [k] __lock_acquire
+   1.60%  kqemu  qemu-system-x86_64       [.] buffer_zero_sse2
+   1.16%  kqemu  qemu-system-x86_64       [.] ram_find_and_save_block
+   1.14%  kqemu  qemu-system-x86_64       [.] ram_save_target_page
+   1.12%  kqemu  qemu-system-x86_64       [.] compress_page_with_multi_thread
+   1.09%  kqemu  qemu-system-x86_64       [.] ram_save_host_page
+   1.07%  kqemu  qemu-system-x86_64       [.] test_and_clear_bit
+   1.07%  kqemu  qemu-system-x86_64       [.] qemu_put_buffer
+   1.03%  kqemu  qemu-system-x86_64       [.] qemu_put_byte
+   0.80%  kqemu  qemu-system-x86_64       [.] threads_submit_request_commit
+   0.74%  kqemu  qemu-system-x86_64       [.] migration_bitmap_clear_dirty
+   0.70%  kqemu  qemu-system-x86_64       [.] control_save_page
+   0.69%  kqemu  qemu-system-x86_64       [.] test_bit
+   0.69%  kqemu  qemu-system-x86_64       [.] ram_save_iterate
+   0.63%  kqemu  qemu-system-x86_64       [.] migration_bitmap_find_dirty
+   0.63%  kqemu  qemu-system-x86_64       [.] ram_control_save_page
+   0.62%  kqemu  qemu-system-x86_64       [.] rcu_read_lock
+   0.56%  kqemu  qemu-system-x86_64       [.] qemu_file_get_error
+   0.55%  kqemu  [kernel.kallsyms]        [k] lock_acquire
+   0.55%  kqemu  qemu-system-x86_64       [.] find_dirty_block
+   0.54%  kqemu  qemu-system-x86_64       [.] ring_index
+   0.53%  kqemu  qemu-system-x86_64       [.] ring_put
+   0.51%  kqemu  qemu-system-x86_64       [.] unqueue_page
+   0.50%  kqemu  qemu-system-x86_64       [.] migrate_use_compression
+   0.48%  kqemu  qemu-system-x86_64       [.] get_queued_page
+   0.46%  kqemu  qemu-system-x86_64       [.] ring_get
+   0.46%  kqemu  [i40e]                   [k] i40e_clean_tx_irq
+   0.45%  kqemu  [kernel.kallsyms]        [k] lock_release
+   0.44%  kqemu  [kernel.kallsyms]        [k] native_sched_clock
+   0.38%  kqemu  qemu-system-x86_64       [.] migrate_get_current
+   0.38%  kqemu  [kernel.kallsyms]        [k] find_held_lock
+   0.34%  kqemu  [kernel.kallsyms]        [k] __lock_release
+   0.34%  kqemu  qemu-system-x86_64       [.] qemu_ram_pagesize
+   0.29%  kqemu  [kernel.kallsyms]        [k] lock_is_held_type
+   0.27%  kqemu  [kernel.kallsyms]        [k] update_load_avg
+   0.27%  kqemu  qemu-system-x86_64       [.] save_page_use_compression
+   0.24%  kqemu  qemu-system-x86_64       [.] qemu_file_rate_limit
+   0.23%  kqemu  [kernel.kallsyms]        [k] tcp_sendmsg
+   0.23%  kqemu  [kernel.kallsyms]        [k] match_held_lock
+   0.22%  kqemu  [kernel.kallsyms]        [k] do_raw_spin_trylock
+   0.22%  kqemu  [kernel.kallsyms]        [k] cyc2ns_read_begin
