Received: from eggs.gnu.org ([2001:4830:134:3::10]:37174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dIXze-00087o-GO
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 06:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dIXza-0002gh-Da
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 06:15:14 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:36392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dIXza-0002eG-5r
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 06:15:10 -0400
Received: by mail-wr0-x22d.google.com with SMTP id v111so3953673wrc.3
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 03:15:08 -0700 (PDT)
References: <CAJhHMCBwu-pVAyxN+w8SSo19wi3DW3JCRRF-K1Sj9zYqGYkFvQ@mail.gmail.com>
	<20170606171320.GA8115@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170606171320.GA8115@flamenco>
Date: Wed, 07 Jun 2017 11:15:32 +0100
Message-ID: <87ink8cddn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] GSoC 2017 Proposal: TCG performance enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Pranith Kumar <bobby.prani@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>


Emilio G. Cota <cota@braap.org> writes:

> On Sat, Mar 25, 2017 at 12:52:35 -0400, Pranith Kumar wrote:
> (snip)
>> * Implement an LRU translation block code cache.
>>
>>   In the current TCG design, when the translation cache fills up, we flush all
>>   the translated blocks (TBs) to free up space. We can improve this situation
>>   by not flushing the TBs that were recently used i.e., by implementing an LRU
>>   policy for freeing the blocks. This should avoid the re-translation overhead
>>   for frequently used blocks and improve performance.
>
> I doubt this will yield any benefits because:
>
> - I still have not found a workload where the performance bottleneck is
>   code retranslation due to unnecessary flushes (unless of course we
>   artificially restrict the size of code_gen_buffer.)
> - To keep track of LRU you need at least one extra instruction on every
>   TB, e.g. to increase a counter or add a timestamp. This might be expensive
>   and possibly a scalability bottleneck (e.g. what to do when several
>   cores are executing the same TB?).
> - tb_find_pc now does a simple binary search. This is easy because we
>   know that TB's are allocated from code_gen_buffer in order. If they
>   were out of order, we'd need another data structure (e.g. some sort of
>   tree) to have quick searches. This is not a fast path though so this
>   could be OK.

Certainly to make changes here we would need some proper numbers showing
it is a problem. Even my re-compile stress-ng test only flushes every
now an then.

>
> (snip)
>> Please let me know if you have any comments or suggestions. Also please let me
>> know if there are other enhancements that are easily implementable to increase
>> TCG performance as part of this project or otherwise.
>
> My not-necessarily-easy-to-implement wishlist would be:
>
> - Reduction of tb_lock contention when booting many cores. For instance,
>   booting 64 aarch64 cores on a 64-core host shows quite a bit of contention (host
>   cores are 80% idle, i.e. waiting to acquire tb_lock); fortunately this is not a
>   big deal (e.g. 4s for booting 1 core vs. ~14s to boot 64) and anyway most
>   long-running workloads are cached a lot more effectively.
>   Still, it would make sense to consider the option of not going through tb_lock
>   etc. (via a private cache? or simply not caching at all) for code that is not
>   executed many times. Another option is to translate privately, and only acquire
>   tb_lock to copy the translated code to the shared buffer.

Currently tb_lock protects the whole translation cycle. However to get
any sort of parallelism in a different translation cache we would also
need to make the translators thread safe. Currently translation involves
too many shared globals across the core TCG state as well as the
per-arch translate.c functions.

>
> - Instrumentation. I think QEMU should have a good interface to enable
>   dynamic binary instrumentation. This has many uses and in fact there
>   are quite a few forks of QEMU doing this.
>   I think Lluís Vilanova's work [1] is a good start to eventually get
>   something upstream.

I too want to see more here. It would be nice to have a hit count for
each block and some live introspection so we could investigate the
hotest blocks and examine the code the generate more closely.

I think there is scope for a big improvement if you could create a
hot-path series of basic blocks with multiple exit points and avoid the
spill/fills of registers in the hot path. However this is a fairly major
change to the current design.

Outside of performance improvements having a good instrumentation story
would be good for people who want to do analysis of guest behaviour.

>
> 		Emilio
>
> [1] https://projects.gso.ac.upc.edu/projects/qemu-dbi


--
Alex Bennée
