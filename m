Received: from eggs.gnu.org ([2001:4830:134:3::10]:44569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dfnRm-0008RM-6Z
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 09:24:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dfnRj-0006o0-Bd
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 09:24:22 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:48262
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1dfnRj-0006nS-5D
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 09:24:19 -0400
References: <1498577836-25883-1-git-send-email-edgar.iglesias@gmail.com>
	<1498577836-25883-7-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA_7_EwgxfnEmr+moHc5u4uprKjyL+ZA1VzspYwqONjfCg@mail.gmail.com>
	<9fc966eb-ee33-d5b8-fef8-5472853ca4fc@redhat.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <927da8fe-7e5a-f22e-069a-b0cfef312a73@adacore.com>
Date: Thu, 10 Aug 2017 15:23:48 +0200
MIME-Version: 1.0
In-Reply-To: <9fc966eb-ee33-d5b8-fef8-5472853ca4fc@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v2 6/7] exec: allow to get a pointer for
 some mmio memory region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Edgar Iglesias <edgar.iglesias@xilinx.com>



On 08/10/2017 02:59 PM, Paolo Bonzini wrote:
> On 10/08/2017 14:56, Peter Maydell wrote:
>>> +    qemu_mutex_lock_iothread();
>>> +
>>> +    /* Reset dirty so this doesn't happen later. */
>>> +    cpu_physical_memory_test_and_clear_dirty(offset, size, 1);
>>> +
>>> +    if (section.mr != mr) {
>>> +        /* memory_region_find add a ref on section.mr */
>>> +        memory_region_unref(section.mr);
>>> +        if (MMIO_INTERFACE(section.mr->owner)) {
>>
>> Could somebody explain why it's OK to unref section.mr here before
>> we go on to do things with it, rather than only unrefing it after
>> we've finished using it?
> 
> The memory region won't disappear until you release the BQL and/or
> RCU-read-lock, but yes it's cleaner to move it later, and yes there is a
> leak.

I missed the case here where section.mr != mr but this shouldn't
happen. Either we make it acceptable and fix the leak.. or just
trigger an error as it is a bogus device. I'd rather go for the
first.
This is the same for memory_region_unref(section.mr).
memory_region_find must hit a MMIO_INTERFACE. In this case the
reference of MMIO_INTERFACE can't be zero here.

Thanks,
Fred

> 
> Paolo
> 
>> Also, by my reading memory_region_find() will always ref
>> ret.mr (if it's not NULL), whereas this code only unrefs it
>> if section.mr == mr. Does this leak a reference in the case
>> where section.mr != mr, or am I missing something ?
>>
> 
