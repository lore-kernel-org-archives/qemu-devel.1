Received: from eggs.gnu.org ([2001:4830:134:3::10]:60403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e5AVq-00060y-QA
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 09:05:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e5AVl-000584-RZ
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 09:05:26 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e5AVl-00057S-KS
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 09:05:21 -0400
Received: by mail-wm0-f68.google.com with SMTP id b189so15769479wmd.4
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 06:05:21 -0700 (PDT)
References: <20171016172609.23422-1-richard.henderson@linaro.org>
	<20171018224518.GA28532@flamenco>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5381cf3d-00c9-1c05-c973-5934311d654d@redhat.com>
Date: Thu, 19 Oct 2017 15:05:17 +0200
MIME-Version: 1.0
In-Reply-To: <20171018224518.GA28532@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 00/50] tcg tb_lock removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

On 19/10/2017 00:45, Emilio G. Cota wrote:
> On Mon, Oct 16, 2017 at 10:25:19 -0700, Richard Henderson wrote:
>> I've fixed two bugs within v5 of Emilio's patch set:
>>
>>  - The step_next_tb patch fixes the "rep movsb" bug that appeared
>>    when we included CF_COUNT_MASK into CF_HASH_MASK.  We had been
>>    relying on magic to single-step the next guest insn.
>>
>>  - The original "allocate optimizer temps with tcg_malloc" patch
>>    failed testing on arm32 host.  I didn't really look into exactly
>>    what was wrong because I had an older patch set that touched the
>>    same portion of the optimizer.
> 
> Thanks a lot for fixing these issues and respinning the series.
> 
> I have just pushed a branch on top of this series that includes
> 10 patches that further pave the way for the removal of tb_lock:
> 
>   https://github.com/cota/qemu/tree/multi-tcg-v6-plus

I started reviewing those, I have a few questions:

1) why is tcg_region_tree separate from tcg_region_state?  Would it make
sense to prepare a linked list of tcg_region_state structs, and reuse
the region lock for the region tree?

2) in tb_for_each_tagged_safe, could the "prev" argument instead be
"next", like


+    for (n = (head) & 1,                                        \
+             tb = (TranslationBlock *)((head) & ~1);            \
+         tb && ((next = (TranslationBlock *)tb->field[n]), 1);  \
+             n = (uintptr_t)next & 1,                           \
+             tb = (TranslationBlock *)((uintptr_t)next & ~1))

(also please make the iterator macros UPPERCASE)

3) "translate-all: exit from tb_phys_invalidate if qht_remove fails" may
be worth posting now?

Paolo

> These patches are a subset of the ones that I posted on the
> tb_lock removal patchset [1]. In particular, these patches are
> groundwork that doesn't change anything fundamental wrt locking,
> which does get tricky.
> 
> Given how close we are to the soft freeze for 2.11 [2], do you want
> me to post these patches on the list for review? Otherwise I can wait
> for the 2.12 dev cycle to post them with the complete tb_lock removal
> work.
> 
> That said, I think we should at least cherry-pick "translate-all: exit
> from tb_phys_invalidate if qht_remove fails" for 2.11, since it
> fixes a real bug. Stable should also get it.
> 
> Thanks,
> 
> 		Emilio
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg01199.html
> [2] https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg02217.html
> 
> 
