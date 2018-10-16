Received: from eggs.gnu.org ([2001:4830:134:3::10]:58859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCRsB-0006WI-Lh
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 12:07:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCRs6-0006XW-Mw
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 12:07:07 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCRs6-0006Vw-8J
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 12:07:02 -0400
Received: by mail-pg1-x541.google.com with SMTP id a5-v6so11055789pgv.13
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 09:07:02 -0700 (PDT)
References: <20181008212205.17752-1-richard.henderson@linaro.org>
	<20181008212205.17752-4-richard.henderson@linaro.org>
	<CAFEAcA_QxgmO+dhT=J4J5_jvVHE9zBE4nFL1+2Q-qL+jCLMZrw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3765a38a-37d8-cdb8-6afc-aa051dfd071c@linaro.org>
Date: Tue, 16 Oct 2018 09:06:57 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_QxgmO+dhT=J4J5_jvVHE9zBE4nFL1+2Q-qL+jCLMZrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 03/10] target/arm: Convert v8 extensions
 from feature bits to isar tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 10/16/18 3:40 AM, Peter Maydell wrote:
> On 8 October 2018 at 22:21, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> Most of the v8 extensions are self-contained within the ISAR
>> registers and are not implied by other feature bits, which
>> makes them the easiest to convert.
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
>> diff --git a/target/arm/translate.h b/target/arm/translate.h
>> index c1b65f3efb..1d60569583 100644
>> --- a/target/arm/translate.h
>> +++ b/target/arm/translate.h
>> @@ -7,6 +7,7 @@
>>  /* internal defines */
>>  typedef struct DisasContext {
>>      DisasContextBase base;
>> +    ARMCPU *cpu;  /* for access to the id_* registers */
> 
> The translate code is not supposed to have access to either ARMCPU
> or the ARMCPUState env pointer. Putting a pointer to cpu into the
> DisasContext defeats this. This is why aarch64_tr_init_disas_context()
> and the 32-bit equivalent extract all the info they need from
> arm_cpu and env and put it into DisasContext fields.

I know that.

I also know that if we don't do it this way, then we need to duplicate all of
the routines that query the ID registers.  I think this way is cleaner.

We simply have to be vigilant about how ctx->cpu is used otherwise.


r~
