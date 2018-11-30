Received: from eggs.gnu.org ([2001:4830:134:3::10]:42742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSWRH-0000DL-A5
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 19:13:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSWPp-0000Ax-65
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 19:12:22 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gSWPo-0000AK-V4
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 19:12:17 -0500
Received: by mail-pf1-x441.google.com with SMTP id z9so1862429pfi.2
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 16:12:16 -0800 (PST)
References: <f4349b9ee95cbd9d5b16e9033fdf0d7c9e99aebf.camel@kernel.crashing.org>
	<a9dd602b-9eb1-f57a-ef21-31f08fc18729@linaro.org>
	<408ef3b1c0bab7d26cffeb366a5ee87bb8448fa4.camel@kernel.crashing.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b8130aae-5158-bb31-73c0-82beee0ad176@linaro.org>
Date: Thu, 29 Nov 2018 16:12:12 -0800
MIME-Version: 1.0
In-Reply-To: <408ef3b1c0bab7d26cffeb366a5ee87bb8448fa4.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC/PATCH] i386: Atomically update PTEs with mttcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 11/29/18 2:54 PM, Benjamin Herrenschmidt wrote:
>>     pdpe_addr = (pml4e & PG_ADDRESS_MASK) +
>>                 (((gphys >> 30) & 0x1ff) << 3);
>>     pdpe = x86_ldq_phys(cs, pdpe_addr);
>>     do {
>>         if (!(pdpe & PG_PRESENT_MASK)) {
>>             goto do_fault;
>>         }
>>         if (pdpe & rsvd_mask) {
>>             goto do_fault_rsvd;
>>         }
>>         if (pdpe & PG_ACCESSED_MASK) {
>>             break;
>>         }
>>     } while (!update_entry(cs, pdpe_addr, &pdpe, PG_ACCESSED_MASK));
>>     ptep &= pdpe ^ PG_NX_MASK;
>>
>> ....
> 
> Hrm.. I see. So not re-do the full walk. Not sure it's really worth it
> though, how often do we expect to hit the failing case ?

It is probably rare-ish, I admit.

I suppose we could also signal "success" from update_entry if the cmpxchg
fails, but the value that was reloaded only differs in setting PG_ACCESSED_MASK
| PG_DIRTY_MASK, as long as 'bits' itself was set.

>> Although I think it would be really great if we could figure out something that
>> allows us to promote this whole load/cmpxchg loop into a primitive that avoids
>> multiple translations of the address.
>>
>> No, I don't know what that primitive would look like.  :-)
> 
> You mean translating once for the load and for the udpate ? Do you
> expect that translation to have such a significant cost considering
> that all it needs should be in L1 at that point ?

I guess if the update is rare-ish, the re-translating isn't a big deal.  And I
suppose we'd have to retain the RCU lock to hold on to the translation, which
probably isn't the best idea.

Nevermind on this.


r~
