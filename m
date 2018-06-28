Received: from eggs.gnu.org ([2001:4830:134:3::10]:51225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fYTJb-0004Nk-0x
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 05:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fYTJW-0007TS-Bo
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 05:34:11 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:36203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fYTJW-0007SY-4x
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 05:34:06 -0400
Received: by mail-io0-x241.google.com with SMTP id k3-v6so4606188iog.3
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 02:34:06 -0700 (PDT)
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-8-xiaoguangrong@tencent.com>
	<20180619073650.GB14814@xz-mi>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <5745f752-50b5-0645-21a7-3336ea0dd5c2@gmail.com>
Date: Thu, 28 Jun 2018 17:33:58 +0800
MIME-Version: 1.0
In-Reply-To: <20180619073650.GB14814@xz-mi>
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
To: Peter Xu <peterx@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 06/19/2018 03:36 PM, Peter Xu wrote:
> On Mon, Jun 04, 2018 at 05:55:15PM +0800, guangrong.xiao@gmail.com wrote:
>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>
>> Try to hold src_page_req_mutex only if the queue is not
>> empty
> 
> Pure question: how much this patch would help?  Basically if you are
> running compression tests then I think it means you are with precopy
> (since postcopy cannot work with compression yet), then here the lock
> has no contention at all.

Yes, you are right, however we can observe it is in the top functions
(after revert this patch):

Samples: 29K of event 'cycles', Event count (approx.): 22263412260
+   7.99%  kqemu  qemu-system-x86_64       [.] ram_bytes_total
+   6.95%  kqemu  [kernel.kallsyms]        [k] copy_user_enhanced_fast_string
+   6.23%  kqemu  qemu-system-x86_64       [.] qemu_put_qemu_file
+   6.20%  kqemu  qemu-system-x86_64       [.] qemu_event_set
+   5.80%  kqemu  qemu-system-x86_64       [.] __ring_put
+   4.82%  kqemu  qemu-system-x86_64       [.] compress_thread_data_done
+   4.11%  kqemu  qemu-system-x86_64       [.] ring_is_full
+   3.07%  kqemu  qemu-system-x86_64       [.] threads_submit_request_prepare
+   2.83%  kqemu  qemu-system-x86_64       [.] ring_mp_get
+   2.71%  kqemu  qemu-system-x86_64       [.] __ring_is_full
+   2.46%  kqemu  qemu-system-x86_64       [.] buffer_zero_sse2
+   2.40%  kqemu  qemu-system-x86_64       [.] add_to_iovec
+   2.21%  kqemu  qemu-system-x86_64       [.] ring_get
+   1.96%  kqemu  [kernel.kallsyms]        [k] __lock_acquire
+   1.90%  kqemu  libc-2.12.so             [.] memcpy
+   1.55%  kqemu  qemu-system-x86_64       [.] ring_len
+   1.12%  kqemu  libpthread-2.12.so       [.] pthread_mutex_unlock
+   1.11%  kqemu  qemu-system-x86_64       [.] ram_find_and_save_block
+   1.07%  kqemu  qemu-system-x86_64       [.] ram_save_host_page
+   1.04%  kqemu  qemu-system-x86_64       [.] qemu_put_buffer
+   0.97%  kqemu  qemu-system-x86_64       [.] compress_page_with_multi_thread
+   0.96%  kqemu  qemu-system-x86_64       [.] ram_save_target_page
+   0.93%  kqemu  libpthread-2.12.so       [.] pthread_mutex_lock

I guess its atomic operations cost CPU resource and check-before-lock is
a common tech, i think it shouldn't have side effect, right? :)
