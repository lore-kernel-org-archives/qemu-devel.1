Received: from eggs.gnu.org ([2001:4830:134:3::10]:54047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCIS8-0003Ys-IH
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 02:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCIS0-00033C-9p
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 02:03:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gCIRq-0002tH-1H
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 02:03:18 -0400
References: <20181005211450.847-1-cota@braap.org>
	<20181005211450.847-5-cota@braap.org>
	<4f8df676-f854-e7fe-afed-51099a8abffe@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6ae5b4c7-3300-2059-b648-855d7ea00488@redhat.com>
Date: Tue, 16 Oct 2018 08:03:03 +0200
MIME-Version: 1.0
In-Reply-To: <4f8df676-f854-e7fe-afed-51099a8abffe@linaro.org>
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
To: Richard Henderson <richard.henderson@linaro.org>, "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 16/10/2018 04:52, Richard Henderson wrote:
> On 10/5/18 2:14 PM, Emilio G. Cota wrote:
>> -    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_write;
>> +    target_ulong tlb_addr =
>> +        atomic_read(&env->tlb_table[mmu_idx][index].addr_write);
> 
> This fails for 32-bit hosts emulating 64-bit hosts.
> I think you need a separate helper function.  Perhaps
> 
> static inline target_ulong tlb_addr_write(CPUTLBEntry *ent)
> {
> #if TCG_OVERSIZED_GUEST
>     return ent->addr_write;
> #else
>     return atomic_read(&ent->addr_write);
> #endif
> }
> 

Or just atomic_read__nocheck.

Paolo

> I'm going to drop this patch from my queue for now.
> We can fix it up this week some time.
> 
> 
> r~
> 
