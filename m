Received: from eggs.gnu.org ([2001:4830:134:3::10]:47048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCFTQ-0001XC-PD
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 22:52:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCFTL-0003Iw-Mv
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 22:52:44 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCFTL-0003Hh-Cx
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 22:52:39 -0400
Received: by mail-pf1-x441.google.com with SMTP id f78-v6so4903179pfe.1
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 19:52:39 -0700 (PDT)
References: <20181005211450.847-1-cota@braap.org>
	<20181005211450.847-5-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4f8df676-f854-e7fe-afed-51099a8abffe@linaro.org>
Date: Mon, 15 Oct 2018 19:52:34 -0700
MIME-Version: 1.0
In-Reply-To: <20181005211450.847-5-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/4] cputlb: read CPUTLBEntry.addr_write
 atomically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 10/5/18 2:14 PM, Emilio G. Cota wrote:
> -    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_write;
> +    target_ulong tlb_addr =
> +        atomic_read(&env->tlb_table[mmu_idx][index].addr_write);

This fails for 32-bit hosts emulating 64-bit hosts.
I think you need a separate helper function.  Perhaps

static inline target_ulong tlb_addr_write(CPUTLBEntry *ent)
{
#if TCG_OVERSIZED_GUEST
    return ent->addr_write;
#else
    return atomic_read(&ent->addr_write);
#endif
}

I'm going to drop this patch from my queue for now.
We can fix it up this week some time.


r~
