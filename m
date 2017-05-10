Received: from eggs.gnu.org ([2001:4830:134:3::10]:48823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8SGh-0001La-V2
	for qemu-devel@nongnu.org; Wed, 10 May 2017 10:07:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8SGe-0001P9-0Q
	for qemu-devel@nongnu.org; Wed, 10 May 2017 10:07:07 -0400
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:35234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d8SGd-0001Oy-R4
	for qemu-devel@nongnu.org; Wed, 10 May 2017 10:07:03 -0400
Received: by mail-pg0-x22c.google.com with SMTP id o3so17267914pgn.2
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 07:07:03 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170509180715.22910-1-rth@twiddle.net>
	<20170509180715.22910-6-rth@twiddle.net>
	<66216250-14b3-b7e0-f981-15a57bf11361@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d6915c28-56d0-2599-4037-9211dc44e6c1@twiddle.net>
Date: Wed, 10 May 2017 07:07:00 -0700
MIME-Version: 1.0
In-Reply-To: <66216250-14b3-b7e0-f981-15a57bf11361@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/6] target/s390x: Use atomic operations
 for COMPARE SWAP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On 05/09/2017 08:51 PM, Thomas Huth wrote:
>> +    int mem_idx = cpu_mmu_index(env, false);
>> +    Int128 oldv;
>> +    bool fail;
>> +
>> +    if (parallel_cpus) {
>> +#ifndef CONFIG_ATOMIC128
>> +        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
>> +#else
>> +        TCGMemOpIdx oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
>> +        oldv = helper_atomic_cmpxchgo_be_mmu(env, addr, cmpv, newv, oi, ra);
>> +        fail = !int128_eq(oldv, cmpv);
>> +#endif
>> +    } else {
> 
> Have you seen the compilation issue that patchew reported? I think
> you've got to move the definition of mem_idx into the "#else" part, too.

No, I didn't.  But I can see it now that you point it out.
I'll fix that and also make sure to test on a host that does not have 
CONFIG_ATOMIC128.


r~
