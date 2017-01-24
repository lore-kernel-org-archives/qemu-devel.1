Received: from eggs.gnu.org ([2001:4830:134:3::10]:42270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cW7xH-00023i-B2
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 15:44:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cW7xG-0007zB-KI
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 15:44:39 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:32878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cW7xG-0007yx-G2
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 15:44:38 -0500
Received: by mail-qt0-x242.google.com with SMTP id n13so28055590qtc.0
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 12:44:38 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170119170507.16185-1-alex.bennee@linaro.org>
	<20170119170507.16185-17-alex.bennee@linaro.org>
	<119e5de6-388c-3b02-8797-fa8eb07ca8ad@twiddle.net>
	<87lgu09p3q.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <1b3899b0-36de-782b-2759-c3f40be801d6@twiddle.net>
Date: Tue, 24 Jan 2017 12:44:33 -0800
MIME-Version: 1.0
In-Reply-To: <87lgu09p3q.fsf@linaro.org>
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: mttcg@greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, peter.maydell@linaro.org, claudio.fontana@huawei.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>, jan.kiszka@siemens.com, mark.burton@greensocs.com, serge.fdrv@gmail.com, pbonzini@redhat.com, bamvor.zhangjian@linaro.org

On 01/24/2017 12:31 PM, Alex Bennée wrote:
>> Why don't we just pass in this bitmap in the first place?  It's much better
>> than having to use varargs in tlb_flush_by_mmuidx...
> 
> We could. By not messing with the API it leaves the door open to having
> other non-MTTCG architectures that have lots of MMU indexes versus a
> hard limit based on page-size. That said I think the number of indexes
> also affects the size of the TLB so I guess the current design is
> limited for arbitrarily large sets if indexes?

We hard-limit at 12 indices, though even that is arguably too high.
I hope we never see more than PPC's current 8.

> Is ARM is the current outlier for this functionality? Apart from SPARC's
> two uses are we likely to see more architectures using this?

In theory, Alpha could use it to avoid ever flushing MMU_PHYS_IDX.  It appears
that there are a few others that could also avoid flushing a "mmu-disabled" index.

I suspect that PPC could make good use of it as well.  That one's complicated
enough that it probably needs a good going over -- especially for the non-local
flushes.


r~
