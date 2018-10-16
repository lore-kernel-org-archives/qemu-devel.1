Received: from eggs.gnu.org ([2001:4830:134:3::10]:55438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCRiJ-0001Aw-8E
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:56:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCRiF-0002kW-TC
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:56:55 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:37347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCRiF-0002e1-Dn
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:56:51 -0400
Received: by mail-pl1-x642.google.com with SMTP id u6-v6so8494444plz.4
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 08:56:49 -0700 (PDT)
References: <20181005211450.847-1-cota@braap.org>
	<20181005211450.847-5-cota@braap.org>
	<4f8df676-f854-e7fe-afed-51099a8abffe@linaro.org>
	<6ae5b4c7-3300-2059-b648-855d7ea00488@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4e8d6cb0-2fb0-df55-afed-d71c76b1e526@linaro.org>
Date: Tue, 16 Oct 2018 08:56:45 -0700
MIME-Version: 1.0
In-Reply-To: <6ae5b4c7-3300-2059-b648-855d7ea00488@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 10/15/18 11:03 PM, Paolo Bonzini wrote:
> On 16/10/2018 04:52, Richard Henderson wrote:
>> On 10/5/18 2:14 PM, Emilio G. Cota wrote:
>>> -    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_write;
>>> +    target_ulong tlb_addr =
>>> +        atomic_read(&env->tlb_table[mmu_idx][index].addr_write);
>>
>> This fails for 32-bit hosts emulating 64-bit hosts.
>> I think you need a separate helper function.  Perhaps
>>
>> static inline target_ulong tlb_addr_write(CPUTLBEntry *ent)
>> {
>> #if TCG_OVERSIZED_GUEST
>>     return ent->addr_write;
>> #else
>>     return atomic_read(&ent->addr_write);
>> #endif
>> }
>>
> 
> Or just atomic_read__nocheck.

No, it won't be present, necessarily.


r~
