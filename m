Received: from eggs.gnu.org ([2001:4830:134:3::10]:53720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1exqlJ-0003IB-8M
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 05:07:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1exqlG-0000gW-3I
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 05:07:25 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:42609)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1exqlF-0000gN-Ou
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 05:07:22 -0400
References: <20180318161228.21307-1-laurent@vivier.eu>
	<2e64bf25-1318-2773-5d17-6c8a9bb835c9@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <755d05ce-50d1-a3c0-f3a5-822916916f03@vivier.eu>
Date: Mon, 19 Mar 2018 10:07:12 +0100
MIME-Version: 1.0
In-Reply-To: <2e64bf25-1318-2773-5d17-6c8a9bb835c9@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target/m68k: add a mechanism to
 automatically free TCGv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

Le 19/03/2018 à 09:39, Richard Henderson a écrit :
> On 03/19/2018 12:12 AM, Laurent Vivier wrote:
>> SRC_EA() and gen_extend() can return either a temporary
>> TCGv or a memory allocated one. Mark them when they are
>> allocated, and free them automatically at end of the
>> instruction translation.
>>
>> We want to free locally allocated TCGv to avoid
>> overflow in sequence like:
>>
>>   0xc00ae406:  movel %fp@(-132),%fp@(-268)
>>   0xc00ae40c:  movel %fp@(-128),%fp@(-264)
>>   0xc00ae412:  movel %fp@(-20),%fp@(-212)
>>   0xc00ae418:  movel %fp@(-16),%fp@(-208)
>>   0xc00ae41e:  movel %fp@(-60),%fp@(-220)
>>   0xc00ae424:  movel %fp@(-56),%fp@(-216)
>>   0xc00ae42a:  movel %fp@(-124),%fp@(-252)
>>   0xc00ae430:  movel %fp@(-120),%fp@(-248)
>>   0xc00ae436:  movel %fp@(-12),%fp@(-260)
>>   0xc00ae43c:  movel %fp@(-8),%fp@(-256)
>>   0xc00ae442:  movel %fp@(-52),%fp@(-276)
>>   0xc00ae448:  movel %fp@(-48),%fp@(-272)
>>   ...
>>
>> That can fill a lot of TCGv entries in a sequence,
>> especially since 15fa08f845 ("tcg: Dynamically allocate TCGOps")
>> we have no limit to fill the TCGOps cache and we can fill
>> the entire TCG variables array and overflow it.
>>
>> Suggested-by: Richard Henderson <rth@twiddle.net>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
> 
> This is a good start.  It's hard to see all of where else might have been
> missed; at least the call to gen_load in gen_lea_indexed.
> 
> For next development cycle it would be good to convert the translator loop and
> enable TCGv leak detection.

I agree.

> That said, this looks good so far.
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I'm going to update the patch by splitting it in two as Philippe asked
and mark the missing gen_load() in gen_lea_indexed().

Thanks,
Laurent
