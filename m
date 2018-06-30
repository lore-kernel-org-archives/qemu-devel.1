Received: from eggs.gnu.org ([2001:4830:134:3::10]:37115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fZ90u-0001IQ-M1
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fZ90p-0003zO-MU
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:05:40 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fZ90p-0003xz-Ey
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:05:35 -0400
Received: by mail-wr0-f196.google.com with SMTP id w16-v6so2909769wrn.5
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:05:35 -0700 (PDT)
References: <cover.1522769774.git.jan.kiszka@web.de>
	<fb0c41863e19c760eca91a71a86eb391147d083d.1522769774.git.jan.kiszka@web.de>
	<dff77a32-ef43-192f-2e36-16067052a60e@redhat.com>
	<6d1d6901-3fc8-8d0d-68f4-2dcce8086018@web.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8a17241d-4e22-a6f4-62bd-d13afc5d6681@redhat.com>
Date: Sat, 30 Jun 2018 08:05:30 +0200
MIME-Version: 1.0
In-Reply-To: <6d1d6901-3fc8-8d0d-68f4-2dcce8086018@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/4] target-i386: Add NPT support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Valentine Sinitsyn <valentine.sinitsyn@gmail.com>

On 30/06/2018 07:25, Jan Kiszka wrote:
> On 2018-06-27 14:14, Paolo Bonzini wrote:
>> On 03/04/2018 17:36, Jan Kiszka wrote:
>>>  
>>> +static hwaddr get_hphys(CPUState *cs, hwaddr gphys, MMUAccessType access_type,
>>> +                        int *prot)
>>> +{
>>> +    CPUX86State *env = &X86_CPU(cs)->env;
>>> +    uint64_t rsvd_mask = PG_HI_RSVD_MASK;
>>> +    uint64_t ptep, pte;
>>> +    uint64_t exit_info_1 = 0;
>>> +    target_ulong pde_addr, pte_addr;
>>> +    uint32_t page_offset;
>>> +    int page_size;
>>> +
>>> +    if (likely(!(env->hflags & HF_NPT_MASK))) {
>>> +        return gphys;
>>> +    }
>>
>> hflags are a somewhat limited resource.  Can this go in hflags2?
>>
> 
> Will have a look - I don't seen why not. Or is there any special
> semantical difference between both fields?

Yes, hflags become flags of the translation block, while hflags2 are
just random processor state.  If translate.c uses it you must use
hflags, but here hflags2 should be safe.

Thanks,

Paolo

>>>
>>> +
>>> +        env->nested_pg_mode = 0;
>>> +        if (env->cr[4] & CR4_PAE_MASK) {
>>> +            env->nested_pg_mode |= SVM_NPT_PAE;
>>> +        }
>>> +        if (env->hflags & HF_LMA_MASK) {
>>> +            env->nested_pg_mode |= SVM_NPT_LMA;
>>> +        }
>>> +        if (env->efer & MSR_EFER_NXE) {
>>> +            env->nested_pg_mode |= SVM_NPT_NXE;
>>> +        }
>>> +    }
>>> +
>>
>> This needs to be migrated.  You can put it in a subsection, conditional
>> on hflags & HF_SVMI_MASK.
> 
> OK.
> 
>>
>> Also, do you need to flush the TLB unconditionally, even if CR0.PG is zero?
> Cannot follow you here yet. What flush are you referring to?
> 
> Also, CR0.PG would not reflect if NPT is on, which now also contributes
> to our TLB.
> 
>>
>> Otherwise looks good.  I have queued patches 1-3, but hopefully this one
>> can go in the next release too.  Sorry for the delayed review.
> 
> No problem.
> 
> Thanks,
> Jan
> 
