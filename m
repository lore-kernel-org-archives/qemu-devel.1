Received: from eggs.gnu.org ([2001:4830:134:3::10]:39153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dL07e-0005Tb-Re
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 00:41:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dL07b-0002vb-Cl
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 00:41:38 -0400
Received: from mail-qk0-x22e.google.com ([2607:f8b0:400d:c09::22e]:32844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dL07b-0002vL-6Y
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 00:41:35 -0400
Received: by mail-qk0-x22e.google.com with SMTP id r62so27783049qkf.0
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 21:41:35 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170613214736.19963-1-david@redhat.com>
	<20170613214736.19963-3-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <3c564230-7879-45ff-ffa1-c4e7bea17902@twiddle.net>
Date: Tue, 13 Jun 2017 21:41:30 -0700
MIME-Version: 1.0
In-Reply-To: <20170613214736.19963-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/3] target/s390x: implement mvcos
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, Miroslav Benes <mbenes@suse.cz>

On 06/13/2017 02:47 PM, David Hildenbrand wrote:
> +static inline bool psw_key_valid(CPUS390XState *env, uint8_t psw_key)
> +{
> +    uint16_t pkm = ((env->cregs[3] & CR3_PKM) >> 16);
> +
> +    if (env->psw.mask & PSW_MASK_PSTATE) {
> +        /* PSW key has range 0..15, it is valid if the bit is 1 in the PKM */
> +        return pkm & (1 << (psw_key & 0xff));

Did you intend to write & 0xf?  Otherwise this mask is pointless...


> +        switch (src_as) {
> +        case 0x0:
> +            x = cpu_ldub_primary_ra(env, src, ra);
> +            break;
> +        case 0x2:
> +            x = cpu_ldub_secondary_ra(env, src, ra);
> +            break;
> +        case 0x3:
> +            x = cpu_ldub_home_ra(env, src, ra);
> +            break;
> +        }
> +        switch (dest_as) {
> +        case 0x0:
> +            cpu_stb_primary_ra(env, dest, x, ra);
> +            break;
> +        case 0x2:
> +            cpu_stb_secondary_ra(env, dest, x, ra);
> +            break;
> +        case 0x3:
> +            cpu_stb_home_ra(env, dest, x, ra);
> +            break;
> +        }

Rather than these switches, you can use helper_ret_ldub_mmu.  Of course, that 
will only work for SOFTMMU.  But for CONFIG_USER_ONLY, there's surely only one 
address space that's legal, so you could simply forward to fast_memmove.

> +    if (!(env->psw.mask & PSW_MASK_DAT)) {
> +        program_interrupt(env, PGM_SPECIAL_OP, 6);
> +    }

You should use restore_program_state before program_interrupt (or add a new 
entry-point to do both).  Then you can drop ...

> +    potential_page_fault(s);
> +    gen_helper_mvcos(cc_op, cpu_env, o->addr1, o->in2, regs[r3]);

... the potential_page_fault.


r~
