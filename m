Received: from eggs.gnu.org ([2001:4830:134:3::10]:54707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXJNI-00021K-ER
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXJNF-0000Wb-5j
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:40:40 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:34704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXJNE-0000WF-Vh
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:40:37 -0400
Received: by mail-pf0-x242.google.com with SMTP id o88so1106068pfk.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 20:40:36 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-11-git-send-email-cota@braap.org>
	<92056605-c95b-b19b-0216-5d83be64e13d@twiddle.net>
	<20170718002700.GA7414@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5382470b-120c-1cdd-32f3-d246d75059d2@twiddle.net>
Date: Mon, 17 Jul 2017 17:40:29 -1000
MIME-Version: 1.0
In-Reply-To: <20170718002700.GA7414@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 10/45] translate-all: guarantee that
 tb_hash only holds valid TBs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org

On 07/17/2017 02:27 PM, Emilio G. Cota wrote:
> On Mon, Jul 17, 2017 at 12:55:03 -1000, Richard Henderson wrote:
>> On 07/16/2017 10:03 AM, Emilio G. Cota wrote:
>>> @@ -1073,13 +1073,17 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr)
>>>       assert_tb_locked();
>>> -    atomic_set(&tb->invalid, true);
>>> -
>>>       /* remove the TB from the hash list */
>>>       phys_pc = tb->page_addr[0] + (tb->pc & ~TARGET_PAGE_MASK);
>>>       h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->trace_vcpu_dstate);
>>>       qht_remove(&tcg_ctx.tb_ctx.htable, tb, h);
>>> +    /*
>>> +     * Mark the TB as invalid *after* it's been removed from tb_hash, which
>>> +     * eliminates the need to check this bit on lookups.
>>> +     */
>>> +    tb->invalid = true;
>>
>> I believe you need atomic_store_release here.  Previously we were relying on
>> the lock acquisition in qht_remove to provide the required memory barrier.
>>
>> We definitely need to make sure this reaches memory before we zap the TB in
>> the CPU_FOREACH loop.
> 
> After this patch tb->invalid is only read/set with tb_lock held, so no need for
> atomics while accessing it.

I think there's a path by which we do get stale data.
For threads A and B,

   (A) Lookup succeeds for TB in hash without tb_lock
        (B) Removes TB from hash
        (B) Sets tb->invalid
        (B) Clears FORALL_CPU jmp_cache
   (A) Store TB into local jmp_cache

... and since we never check for invalid again, there's nothing to evict TB 
from the jmp_cache again.

Here's a plan that will make me happy:

(1) Drop this patch, leaving the set of tb->invalid (or CF_INVALID) in place.
(2) Include CF_INVALID in the mask of bits compared in tb_lookup__cpu_state.
     (a) At this point in the patch set that's just

	(tb->flags & CF_INVALID) == 0

     (b) Later in the patch series when CF_PARALLEL is introduced
         (and CF_HASH_MASK, lets call it, instead of the cf_mask
         function you have now), this becomes

         (tb->flags & (CF_HASH_MASK | CF_INVALID)) == cf_mask

So that we continue to check CF_INVALID each time we lookup a TB, but now we 
get it for free as a part of the other flags check.


r~
