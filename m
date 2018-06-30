Received: from eggs.gnu.org ([2001:4830:134:3::10]:40894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fZKVi-0007TF-2N
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 14:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fZKVh-0005oK-1w
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 14:22:14 -0400
Received: from mail-yw0-x242.google.com ([2607:f8b0:4002:c05::242]:43891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fZKVg-0005nt-SK
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 14:22:12 -0400
Received: by mail-yw0-x242.google.com with SMTP id r19-v6so5382661ywc.10
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 11:22:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <953186cb-c73b-c2ba-f083-58864e0bec41@linaro.org>
References: <20180622135823.32421-1-peter.maydell@linaro.org>
	<953186cb-c73b-c2ba-f083-58864e0bec41@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sat, 30 Jun 2018 11:22:11 -0700
Message-ID: <CAMo8BfJsZjeC7nD2YMj=1JZ+JkmEWUQM7gTWUWd1jGAFzZRyXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH] xtensa: Avoid calling
 get_page_addr_code() from helper function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Patch Tracking <patches@linaro.org>

On Sat, Jun 30, 2018 at 10:32 AM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 06/22/2018 06:58 AM, Peter Maydell wrote:
>> The xtensa frontend calls get_page_addr_code() from its
>> itlb_hit_test helper function. This function is really part
>> of the TCG core's internals, and calling it from a target
>> helper makes it awkward to make changes to that core code.
>> It also means that we don't pass the correct retaddr to
>> tlb_fill(), so we won't correctly handle the case where
>> an exception is generated.
>>
>> The helper is used for the instructions IHI, IHU and IPFL.
>
> I think the implementation of these instructions is completely wrong.
>
> (1a) IHI is not invalidating the cacheline within env->config->itlb,
> (1b) IHI is not invalidating the qemu TLB that might contain a copy
>      of same.
> (2a) IPFL is not locking the entry in env->config->itlb,
> (2b) IHU is not unlocking the same entry.

All the above instructions are meant to invalidate cache, not the TLB.

> (2c) "Xtensa ISA implementations that do not implement cache locking
>      must raise an illegal instruction exception when [IPFL or IHU]
>      is executed."

They will raise an illegal instruction exception, because such CPUs
will not recognize these instructions in the xtensa_opcode_decode.

I believe that the implementation we have currently is rather accurate.

-- 
Thanks.
-- Max
