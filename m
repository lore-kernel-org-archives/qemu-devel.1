Received: from eggs.gnu.org ([2001:4830:134:3::10]:53292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dpOID-0003Sm-5t
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 20:34:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dpOIC-0000s6-7O
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 20:34:09 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:34971)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1dpOIC-0000rd-1g
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 20:34:08 -0400
Received: by mail-it0-x241.google.com with SMTP id b76so874107itb.2
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 17:34:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <efa7f1f6-af37-a06b-10b0-d40be2a502f0@twiddle.net>
References: <20170829172326.1131-1-bobby.prani@gmail.com>
	<efa7f1f6-af37-a06b-10b0-d40be2a502f0@twiddle.net>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Tue, 5 Sep 2017 20:33:35 -0400
Message-ID: <CAJhHMCBoOGrts1UvNVbC+g6fxLf_9MCYssNQ4nmqiTyzTLFXuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tcg/softmmu: Increase size of TLB caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>

On Tue, Sep 5, 2017 at 5:50 PM, Richard Henderson <rth@twiddle.net> wrote:
> On 08/29/2017 10:23 AM, Pranith Kumar wrote:
>> This patch increases the number of entries cached in the TLB. I went
>> over a few architectures to see if increasing it is problematic. Only
>> armv6 seems to have a limitation that only 8 bits can be used for
>> indexing these entries. For other architectures, the number of TLB
>> entries is increased to a 4K-sized cache. The patch also doubles the
>> number of victim TLB entries.
>>
>> Some statistics collected from a build benchmark for various cache
>> sizes is listed below:
>>
>> | TLB bits\vTLB entires |             8 |            16  |            32 |
>> |                     8 | 952.94(+0.0%) | 929.99(+2.4%)  | 919.02(+3.6%) |
>> |                    10 | 898.92(+5.6%) | 886.13(+7.0%)  | 887.03(+6.9%) |
>> |                    12 | 878.56(+7.8%) | 873.53(+8.3%)* | 875.34(+8.1%) |
>>
>> The best combination for this workload came out to be 12 bits for the
>> TLB and a 16 entry vTLB cache.
>
> This significantly degrades performance of alpha-softmmu.
> It spends about 25% of all cpu time in memset.

What workload does it degrade for? I will try to reproduce and see
which memset is causing this.

-- 
Pranith
