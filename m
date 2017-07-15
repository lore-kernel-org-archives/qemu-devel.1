Received: from eggs.gnu.org ([2001:4830:134:3::10]:59171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWAr6-0007KB-Fe
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 20:22:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWAr1-0003uo-IG
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 20:22:44 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35897)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWAr1-0003uQ-Bo
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 20:22:39 -0400
Received: by mail-qt0-x241.google.com with SMTP id v31so11868310qtb.3
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 17:22:37 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170710204521.2058-1-rth@twiddle.net>
	<20170710204521.2058-2-rth@twiddle.net>
	<20170714210105.mchifmgphjjmaehz@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <dba696e6-5e94-dedc-417e-c5723880454e@twiddle.net>
Date: Fri, 14 Jul 2017 14:22:30 -1000
MIME-Version: 1.0
In-Reply-To: <20170714210105.mchifmgphjjmaehz@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/8] target/s390x: Implement CSST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org, david@redhat.com

On 07/14/2017 11:01 AM, Aurelien Jarno wrote:
>> +    if (parallel_cpus) {
>> +        int mask = 0;
>> +#if !defined(CONFIG_ATOMIC64)
>> +        mask = -8;
>> +#elif !defined(CONFIG_ATOMIC128)
>> +        mask = -16;
>> +#endif
>> +        if (((4 << fc) | (1 << sc)) & mask) {
>> +            cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
>> +        }
>> +    }
> 
> This doesn't look correct. For a 16-byte store, ie sc = 4, and with
> ATOMIC128 support, ie mask = -16, the condition is true.

That's WITHOUT atomic128 support that mask = -16.
If we have atomic128, then mask = 0.

>> +            if (parallel_cpus) {
>> +#ifdef CONFIG_USER_ONLY
>> +                uint32_t *haddr = g2h(a1);
>> +                ov = atomic_cmpxchg__nocheck(haddr, cv, nv);
>> +#else
>> +                TCGMemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mem_idx);
>> +                ov = helper_atomic_cmpxchgl_be_mmu(env, a1, cv, nv, oi, ra);
>> +#endif
> 
> Not a problem with the patch itself, but how complicated would it be to
> make helper_atomic_cmpxchgl_be_mmu (just like the o version) available
> also in user mode? That would make less #ifdef in the backends.

Dunno.  Probably not too bad.  I have wondered about doing that, as these sorts 
of functions are quite ugly to write.


r~
