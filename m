Received: from eggs.gnu.org ([2001:4830:134:3::10]:46048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fYSyv-0004PI-EY
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 05:12:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fYSys-0000If-8A
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 05:12:49 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:45707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fYSys-0000Hf-07
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 05:12:46 -0400
Received: by mail-pg0-x244.google.com with SMTP id z1-v6so2185540pgv.12
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 02:12:45 -0700 (PDT)
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-7-xiaoguangrong@tencent.com>
	<20180619073034.GA14814@xz-mi>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <e945c2af-ccfb-f777-fdbf-724d4572dd0a@gmail.com>
Date: Thu, 28 Jun 2018 17:12:39 +0800
MIME-Version: 1.0
In-Reply-To: <20180619073034.GA14814@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/12] migration: do not detect zero page
 for compression
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


Hi Peter,

Sorry for the delay as i was busy on other things.

On 06/19/2018 03:30 PM, Peter Xu wrote:
> On Mon, Jun 04, 2018 at 05:55:14PM +0800, guangrong.xiao@gmail.com wrote:
>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>
>> Detecting zero page is not a light work, we can disable it
>> for compression that can handle all zero data very well
> 
> Is there any number shows how the compression algo performs better
> than the zero-detect algo?  Asked since AFAIU buffer_is_zero() might
> be fast, depending on how init_accel() is done in util/bufferiszero.c.

This is the comparison between zero-detection and compression (the target
buffer is all zero bit):

Zero 810 ns Compression: 26905 ns.
Zero 417 ns Compression: 8022 ns.
Zero 408 ns Compression: 7189 ns.
Zero 400 ns Compression: 7255 ns.
Zero 412 ns Compression: 7016 ns.
Zero 411 ns Compression: 7035 ns.
Zero 413 ns Compression: 6994 ns.
Zero 399 ns Compression: 7024 ns.
Zero 416 ns Compression: 7053 ns.
Zero 405 ns Compression: 7041 ns.

Indeed, zero-detection is faster than compression.

However during our profiling for the live_migration thread (after reverted this patch),
we noticed zero-detection cost lots of CPU:

  12.01%  kqemu  qemu-system-x86_64            [.] buffer_zero_sse2                                                                                                                                                                           ◆
   7.60%  kqemu  qemu-system-x86_64            [.] ram_bytes_total                                                                                                                                                                            ▒
   6.56%  kqemu  qemu-system-x86_64            [.] qemu_event_set                                                                                                                                                                             ▒
   5.61%  kqemu  qemu-system-x86_64            [.] qemu_put_qemu_file                                                                                                                                                                         ▒
   5.00%  kqemu  qemu-system-x86_64            [.] __ring_put                                                                                                                                                                                 ▒
   4.89%  kqemu  [kernel.kallsyms]             [k] copy_user_enhanced_fast_string                                                                                                                                                             ▒
   4.71%  kqemu  qemu-system-x86_64            [.] compress_thread_data_done                                                                                                                                                                  ▒
   3.63%  kqemu  qemu-system-x86_64            [.] ring_is_full                                                                                                                                                                               ▒
   2.89%  kqemu  qemu-system-x86_64            [.] __ring_is_full                                                                                                                                                                             ▒
   2.68%  kqemu  qemu-system-x86_64            [.] threads_submit_request_prepare                                                                                                                                                             ▒
   2.60%  kqemu  qemu-system-x86_64            [.] ring_mp_get                                                                                                                                                                                ▒
   2.25%  kqemu  qemu-system-x86_64            [.] ring_get                                                                                                                                                                                   ▒
   1.96%  kqemu  libc-2.12.so                  [.] memcpy

After this patch, the workload is moved to the worker thread, is it
acceptable?

> 
>  From compression rate POV of course zero page algo wins since it
> contains no data (but only a flag).
> 

Yes it is. The compressed zero page is 45 bytes that is small enough i think.

Hmm, if you do not like, how about move detecting zero page to the work thread?

Thanks!
