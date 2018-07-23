Received: from eggs.gnu.org ([2001:4830:134:3::10]:33268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fhV1Z-0001Kn-Fi
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 03:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fhV1W-00086x-8r
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 03:12:53 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:36378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fhV1V-00086C-VT
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 03:12:50 -0400
Received: by mail-pl0-x244.google.com with SMTP id e11-v6so7879252plb.3
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 00:12:49 -0700 (PDT)
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-7-xiaoguangrong@tencent.com>
	<20180619073034.GA14814@xz-mi>
	<e945c2af-ccfb-f777-fdbf-724d4572dd0a@gmail.com>
	<20180629094213.GD2568@work-vm>
	<83856901-3986-ada7-7069-bcf3619f89db@gmail.com>
	<20180716185800.GD2664@work-vm>
	<ccb56d2e-c2db-3cb0-0e35-1b6ebf8ddc3a@gmail.com>
	<20180722190317-mutt-send-email-mst@kernel.org>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <8f0b6fe4-8fad-6f07-d2cf-1cf4bd49592c@gmail.com>
Date: Mon, 23 Jul 2018 15:12:40 +0800
MIME-Version: 1.0
In-Reply-To: <20180722190317-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, pbonzini@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 07/23/2018 12:05 AM, Michael S. Tsirkin wrote:
> On Wed, Jul 18, 2018 at 04:46:21PM +0800, Xiao Guangrong wrote:
>>
>>
>> On 07/17/2018 02:58 AM, Dr. David Alan Gilbert wrote:
>>> * Xiao Guangrong (guangrong.xiao@gmail.com) wrote:
>>>>
>>>>
>>>> On 06/29/2018 05:42 PM, Dr. David Alan Gilbert wrote:
>>>>> * Xiao Guangrong (guangrong.xiao@gmail.com) wrote:
>>>>>>
>>>>>> Hi Peter,
>>>>>>
>>>>>> Sorry for the delay as i was busy on other things.
>>>>>>
>>>>>> On 06/19/2018 03:30 PM, Peter Xu wrote:
>>>>>>> On Mon, Jun 04, 2018 at 05:55:14PM +0800, guangrong.xiao@gmail.com wrote:
>>>>>>>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>>>>>>>
>>>>>>>> Detecting zero page is not a light work, we can disable it
>>>>>>>> for compression that can handle all zero data very well
>>>>>>>
>>>>>>> Is there any number shows how the compression algo performs better
>>>>>>> than the zero-detect algo?  Asked since AFAIU buffer_is_zero() might
>>>>>>> be fast, depending on how init_accel() is done in util/bufferiszero.c.
>>>>>>
>>>>>> This is the comparison between zero-detection and compression (the target
>>>>>> buffer is all zero bit):
>>>>>>
>>>>>> Zero 810 ns Compression: 26905 ns.
>>>>>> Zero 417 ns Compression: 8022 ns.
>>>>>> Zero 408 ns Compression: 7189 ns.
>>>>>> Zero 400 ns Compression: 7255 ns.
>>>>>> Zero 412 ns Compression: 7016 ns.
>>>>>> Zero 411 ns Compression: 7035 ns.
>>>>>> Zero 413 ns Compression: 6994 ns.
>>>>>> Zero 399 ns Compression: 7024 ns.
>>>>>> Zero 416 ns Compression: 7053 ns.
>>>>>> Zero 405 ns Compression: 7041 ns.
>>>>>>
>>>>>> Indeed, zero-detection is faster than compression.
>>>>>>
>>>>>> However during our profiling for the live_migration thread (after reverted this patch),
>>>>>> we noticed zero-detection cost lots of CPU:
>>>>>>
>>>>>>     12.01%  kqemu  qemu-system-x86_64            [.] buffer_zero_sse2                                                                                                                                                                           ◆
>>>>>
>>>>> Interesting; what host are you running on?
>>>>> Some hosts have support for the faster buffer_zero_ss4/avx2
>>>>
>>>> The host is:
>>>>
>>>> model name	: Intel(R) Xeon(R) Gold 6142 CPU @ 2.60GHz
>>>> ...
>>>> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi
>>>>    mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts
>>>>    rep_good nopl xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq dtes64 monitor
>>>>    ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt
>>>>    tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3
>>>>    cdp_l3 intel_ppin intel_pt mba tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1
>>>>    hle avx2 smep bmi2 erms invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt
>>>>    clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total
>>>>    cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req pku ospke
>>>>
>>>> I checked and noticed "CONFIG_AVX2_OPT" has not been enabled, maybe is due to too old glib/gcc
>>>> version:
>>>>      gcc version 4.4.6 20110731 (Red Hat 4.4.6-4) (GCC)
>>>>      glibc.x86_64                     2.12
>>>
>>> Yes, that's pretty old (RHEL6 ?) - I think you should get AVX2 in RHEL7.
>>
>> Er, it is not easy to update glibc in the production env.... :(
> 
> But neither is QEMU updated in production all that easily. While we do
> want to support older hosts functionally, it does not make
> much sense to devel complex optimizations that only benefit
> older hosts.
> 

Can not agree with you more. :)

So i benchmarked in on the production with newer distribution installed.
Here is the data:
  27.48%  kqemu  [kernel.kallsyms]             [k] copy_user_enhanced_fast_string
  12.63%  kqemu  [kernel.kallsyms]             [k] copy_page_rep
  10.82%  kqemu  qemu-system-x86_64            [.] buffer_zero_avx2
   5.69%  kqemu  [kernel.kallsyms]             [k] native_queued_spin_lock_slowpath
   4.61%  kqemu  qemu-system-x86_64            [.] threads_submit_request_prepare
   4.39%  kqemu  qemu-system-x86_64            [.] qemu_event_set
   4.12%  kqemu  qemu-system-x86_64            [.] ram_find_and_save_block.part.24
   3.61%  kqemu  [kernel.kallsyms]             [k] tcp_sendmsg
   2.62%  kqemu  libc-2.17.so                  [.] __memcpy_ssse3_back
   1.89%  kqemu  qemu-system-x86_64            [.] qemu_put_qemu_file
   1.32%  kqemu  qemu-system-x86_64            [.] compress_thread_data_done

It does not help...
