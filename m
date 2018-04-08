Received: from eggs.gnu.org ([2001:4830:134:3::10]:60926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f50rQ-0007NC-Bj
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 23:19:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f50rL-0008RI-Bf
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 23:19:20 -0400
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:43576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1f50rL-0008Qg-2x
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 23:19:15 -0400
Received: by mail-pf0-x236.google.com with SMTP id j2so3523617pff.10
	for <qemu-devel@nongnu.org>; Sat, 07 Apr 2018 20:19:14 -0700 (PDT)
From: Xiao Guangrong <guangrong.xiao@gmail.com>
References: <20180330075128.26919-1-xiaoguangrong@tencent.com>
Message-ID: <c7f35243-3357-579b-3e68-40b0369dd1c7@gmail.com>
Date: Sun, 8 Apr 2018 11:19:08 +0800
MIME-Version: 1.0
In-Reply-To: <20180330075128.26919-1-xiaoguangrong@tencent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 00/10] migration: improve and cleanup
 compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>, Stefan Hajnoczi <stefanha@gmail.com>


Hi Paolo, Michael, Stefan and others,

Could anyone merge this patchset if it is okay to you guys?

On 03/30/2018 03:51 PM, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> Changelog in v3:
> Following changes are from Peter's review:
> 1) use comp_param[i].file and decomp_param[i].compbuf to indicate if
>     the thread is properly init'd or not
> 2) save the file which is used by ram loader to the global variable
>     instead it is cached per decompression thread
> 
> Changelog in v2:
> Thanks to the review from Dave, Peter, Wei and Jiang Biao, the changes
> in this version are:
> 1) include the performance number in the cover letter
> 2）add some comments to explain how to use z_stream->opaque in the
>     patchset
> 3) allocate a internal buffer for per thread to store the data to
>     be compressed
> 4) add a new patch that moves some code to ram_save_host_page() so
>     that 'goto' can be omitted gracefully
> 5) split the optimization of compression and decompress into two
>     separated patches
> 6) refine and correct code styles
> 
> 
> This is the first part of our work to improve compression to make it
> be more useful in the production.
> 
> The first patch resolves the problem that the migration thread spends
> too much CPU resource to compression memory if it jumps to a new block
> that causes the network is used very deficient.
> 
> The second patch fixes the performance issue that too many VM-exits
> happen during live migration if compression is being used, it is caused
> by huge memory returned to kernel frequently as the memory is allocated
> and freed for every signal call to compress2()
> 
> The remaining patches clean the code up dramatically
> 
> Performance numbers:
> We have tested it on my desktop, i7-4790 + 16G, by locally live migrate
> the VM which has 8 vCPUs + 6G memory and the max-bandwidth is limited to
> 350. During the migration, a workload which has 8 threads repeatedly
> written total 6G memory in the VM.
> 
> Before this patchset, its bandwidth is ~25 mbps, after applying, the
> bandwidth is ~50 mbp.
> 
> We also collected the perf data for patch 2 and 3 on our production,
> before the patchset:
> +  57.88%  kqemu  [kernel.kallsyms]        [k] queued_spin_lock_slowpath
> +  10.55%  kqemu  [kernel.kallsyms]        [k] __lock_acquire
> +   4.83%  kqemu  [kernel.kallsyms]        [k] flush_tlb_func_common
> 
> -   1.16%  kqemu  [kernel.kallsyms]        [k] lock_acquire                                       ▒
>     - lock_acquire                                                                                 ▒
>        - 15.68% _raw_spin_lock                                                                     ▒
>           + 29.42% __schedule                                                                      ▒
>           + 29.14% perf_event_context_sched_out                                                    ▒
>           + 23.60% tdp_page_fault                                                                  ▒
>           + 10.54% do_anonymous_page                                                               ▒
>           + 2.07% kvm_mmu_notifier_invalidate_range_start                                          ▒
>           + 1.83% zap_pte_range                                                                    ▒
>           + 1.44% kvm_mmu_notifier_invalidate_range_end
> 
> 
> apply our work:
> +  51.92%  kqemu  [kernel.kallsyms]        [k] queued_spin_lock_slowpath
> +  14.82%  kqemu  [kernel.kallsyms]        [k] __lock_acquire
> +   1.47%  kqemu  [kernel.kallsyms]        [k] mark_lock.clone.0
> +   1.46%  kqemu  [kernel.kallsyms]        [k] native_sched_clock
> +   1.31%  kqemu  [kernel.kallsyms]        [k] lock_acquire
> +   1.24%  kqemu  libc-2.12.so             [.] __memset_sse2
> 
> -  14.82%  kqemu  [kernel.kallsyms]        [k] __lock_acquire                                     ▒
>     - __lock_acquire                                                                               ▒
>        - 99.75% lock_acquire                                                                       ▒
>           - 18.38% _raw_spin_lock                                                                  ▒
>              + 39.62% tdp_page_fault                                                               ▒
>              + 31.32% __schedule                                                                   ▒
>              + 27.53% perf_event_context_sched_out                                                 ▒
>              + 0.58% hrtimer_interrupt
> 
> 
> We can see the TLB flush and mmu-lock contention have gone.
> 
> Xiao Guangrong (10):
>    migration: stop compressing page in migration thread
>    migration: stop compression to allocate and free memory frequently
>    migration: stop decompression to allocate and free memory frequently
>    migration: detect compression and decompression errors
>    migration: introduce control_save_page()
>    migration: move some code to ram_save_host_page
>    migration: move calling control_save_page to the common place
>    migration: move calling save_zero_page to the common place
>    migration: introduce save_normal_page()
>    migration: remove ram_save_compressed_page()
> 
>   migration/qemu-file.c |  43 ++++-
>   migration/qemu-file.h |   6 +-
>   migration/ram.c       | 482 ++++++++++++++++++++++++++++++--------------------
>   3 files changed, 324 insertions(+), 207 deletions(-)
> 
