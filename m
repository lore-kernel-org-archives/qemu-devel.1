Received: from eggs.gnu.org ([2001:4830:134:3::10]:53446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cpzyS-0001ln-PO
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 12:16:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cpzyP-0005jy-F9
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 12:16:00 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:35678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cpzyP-0005j6-3a
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 12:15:57 -0400
Received: by mail-wr0-x22a.google.com with SMTP id g10so95821394wrg.2
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 09:15:57 -0700 (PDT)
References: <20170320153441.2181-1-alex.bennee@linaro.org>
	<20170320153441.2181-2-alex.bennee@linaro.org>
	<fb507927-7be0-9901-8657-02455e0af46d@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <fb507927-7be0-9901-8657-02455e0af46d@redhat.com>
Date: Mon, 20 Mar 2017 16:16:20 +0000
Message-ID: <87k27jore3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 1/3] cputlb: ensure tbl_set_dirty1
 updates addr_write atomically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: peter.maydell@linaro.org, rth@twiddle.net, qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 20/03/2017 16:34, Alex Bennée wrote:
>>  static inline void tlb_set_dirty1(CPUTLBEntry *tlb_entry, target_ulong vaddr)
>>  {
>> +#if TCG_OVERSIZED_GUEST
>>      if (tlb_entry->addr_write == (vaddr | TLB_NOTDIRTY)) {
>>          tlb_entry->addr_write = vaddr;
>>      }
>> +#else
>> +    uintptr_t orig_addr = atomic_mb_read(&tlb_entry->addr_write);
>
> atomic_read is enough, since we don't care at all about cases where the
> address doesn't match.  Otherwise

Good catch. Will fix for my pullreq

>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
>
> Paolo
>
>> +    if (orig_addr == (vaddr | TLB_NOTDIRTY)) {
>> +        atomic_cmpxchg(&tlb_entry->addr_write, orig_addr, vaddr);
>> +    }
>> +#endif
>>  }


--
Alex Bennée
