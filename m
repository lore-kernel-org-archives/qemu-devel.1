Received: from eggs.gnu.org ([2001:4830:134:3::10]:36773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dfn3v-0002cd-GQ
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 08:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dfn3r-0001dT-H4
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 08:59:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dfn3r-0001ch-BB
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 08:59:39 -0400
References: <1498577836-25883-1-git-send-email-edgar.iglesias@gmail.com>
	<1498577836-25883-7-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA_7_EwgxfnEmr+moHc5u4uprKjyL+ZA1VzspYwqONjfCg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9fc966eb-ee33-d5b8-fef8-5472853ca4fc@redhat.com>
Date: Thu, 10 Aug 2017 14:59:34 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_7_EwgxfnEmr+moHc5u4uprKjyL+ZA1VzspYwqONjfCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
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
To: Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, KONRAD Frederic <frederic.konrad@adacore.com>, Richard Henderson <rth@twiddle.net>, Edgar Iglesias <edgar.iglesias@xilinx.com>

On 10/08/2017 14:56, Peter Maydell wrote:
>> +    qemu_mutex_lock_iothread();
>> +
>> +    /* Reset dirty so this doesn't happen later. */
>> +    cpu_physical_memory_test_and_clear_dirty(offset, size, 1);
>> +
>> +    if (section.mr != mr) {
>> +        /* memory_region_find add a ref on section.mr */
>> +        memory_region_unref(section.mr);
>> +        if (MMIO_INTERFACE(section.mr->owner)) {
> 
> Could somebody explain why it's OK to unref section.mr here before
> we go on to do things with it, rather than only unrefing it after
> we've finished using it?

The memory region won't disappear until you release the BQL and/or
RCU-read-lock, but yes it's cleaner to move it later, and yes there is a
leak.

Paolo

> Also, by my reading memory_region_find() will always ref
> ret.mr (if it's not NULL), whereas this code only unrefs it
> if section.mr == mr. Does this leak a reference in the case
> where section.mr != mr, or am I missing something ?
> 
