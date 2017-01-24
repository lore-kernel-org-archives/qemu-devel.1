Received: from eggs.gnu.org ([2001:4830:134:3::10]:39592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cW7kn-0004wc-Qt
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 15:31:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cW7kj-0003vl-5j
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 15:31:45 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:37040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cW7ki-0003vU-Ul
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 15:31:41 -0500
Received: by mail-wm0-x229.google.com with SMTP id c206so228924719wme.0
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 12:31:40 -0800 (PST)
References: <20170119170507.16185-1-alex.bennee@linaro.org>
	<20170119170507.16185-17-alex.bennee@linaro.org>
	<119e5de6-388c-3b02-8797-fa8eb07ca8ad@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <119e5de6-388c-3b02-8797-fa8eb07ca8ad@twiddle.net>
Date: Tue, 24 Jan 2017 20:31:37 +0000
Message-ID: <87lgu09p3q.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 16/27] cputlb: add tlb_flush_by_mmuidx
 async routines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: mttcg@greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, peter.maydell@linaro.org, claudio.fontana@huawei.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>, jan.kiszka@siemens.com, mark.burton@greensocs.com, serge.fdrv@gmail.com, pbonzini@redhat.com, bamvor.zhangjian@linaro.org


Richard Henderson <rth@twiddle.net> writes:

> On 01/19/2017 09:04 AM, Alex Bennée wrote:
>> +/* Helper function to slurp va_args list into a bitmap
>> + */
>> +static inline unsigned long make_mmu_index_bitmap(va_list args)
>> +{
>> +    unsigned long bitmap = 0;
>> +    int mmu_index = va_arg(args, int);
>> +
>> +    /* An empty va_list would be a bad call */
>> +    g_assert(mmu_index > 0);
>> +
>> +    do {
>> +        set_bit(mmu_index, &bitmap);
>> +        mmu_index = va_arg(args, int);
>> +    } while (mmu_index >= 0);
>> +
>> +    return bitmap;
>> +}
>> +
>
> Why don't we just pass in this bitmap in the first place?  It's much better
> than having to use varargs in tlb_flush_by_mmuidx...

We could. By not messing with the API it leaves the door open to having
other non-MTTCG architectures that have lots of MMU indexes versus a
hard limit based on page-size. That said I think the number of indexes
also affects the size of the TLB so I guess the current design is
limited for arbitrarily large sets if indexes?

Is ARM is the current outlier for this functionality? Apart from SPARC's
two uses are we likely to see more architectures using this?

--
Alex Bennée
