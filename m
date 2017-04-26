Received: from eggs.gnu.org ([2001:4830:134:3::10]:33250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3VRg-0004S0-4j
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 18:30:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3VRf-0002yI-Bp
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 18:30:00 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1493187803-4510-1-git-send-email-cota@braap.org>
	<1493187803-4510-2-git-send-email-cota@braap.org>
	<e206fe3e-5920-49c5-8f95-e4961aad5f89@twiddle.net>
	<20170426215604.GA16014@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <22fb44cc-b8de-c3fb-0980-bfc908229a2e@twiddle.net>
Date: Thu, 27 Apr 2017 00:29:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170426215604.GA16014@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 01/10] tcg-runtime: add lookup_tb_ptr
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

On 04/26/2017 11:56 PM, Emilio G. Cota wrote:
> On Wed, Apr 26, 2017 at 10:40:45 +0200, Richard Henderson wrote:
>> On 04/26/2017 08:23 AM, Emilio G. Cota wrote:
> (snip)
>>> +    cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
>>> +    tb = atomic_rcu_read(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(addr)]);
>>> +    if (likely(tb && tb->pc == addr && tb->cs_base == cs_base &&
>>> +               tb->flags == flags)) {
>>
>> This comparison is wrong.  It will incorrectly reject a TB for i386 guest
>> when CS_BASE != 0.  You really want
>>
>>    tb = atomic_rcu_read(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(addr)]);
>>    if (tb) {
>>      cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
>>      if (tb->pc == pc && tb->cs_base == cs_base && tb->flags == flags) {
>>        return tb->tc_ptr;
>>      }
>>    }
>>    return tcg_ctx.code_gen_epilogue;
> 
> wrt the comparison, the only change I notice in your suggested change is
>    tb->pc == pc
> 
> instead of
>    tb->pc == addr
> 
> , which seems innocuous to me (since tb->pc == addr).
> 
> I fail to see how this relates to your "CS_BASE != 0" comment.
> What am I missing?

Recall how you computed vaddr for target/i386:

   addr = pc + cs_base


r~
