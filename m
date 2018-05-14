Received: from eggs.gnu.org ([2001:4830:134:3::10]:42525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIHGB-0006EH-Hw
	for qemu-devel@nongnu.org; Mon, 14 May 2018 13:27:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIHG8-0003ZO-D5
	for qemu-devel@nongnu.org; Mon, 14 May 2018 13:27:43 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:45098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fIHG8-0003Yf-6a
	for qemu-devel@nongnu.org; Mon, 14 May 2018 13:27:40 -0400
Received: by mail-pg0-x241.google.com with SMTP id w3-v6so5766208pgv.12
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 10:27:40 -0700 (PDT)
References: <20180512004311.9299-1-richard.henderson@linaro.org>
	<20180512004311.9299-14-richard.henderson@linaro.org>
	<CAFEAcA8EmpbGi=q=H_J+fhe0BzV4=FmWpfx0modhs5r720v=vQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <952f0ed7-1749-4bb1-33b4-13d34a05411f@linaro.org>
Date: Mon, 14 May 2018 10:27:36 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8EmpbGi=q=H_J+fhe0BzV4=FmWpfx0modhs5r720v=vQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 13/27] target/arm: convert conversion
 helpers to fpst/ahp_flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 05/14/2018 06:41 AM, Peter Maydell wrote:
> On 12 May 2018 at 01:42, Richard Henderson <richard.henderson@linaro.org> wrote:
>> From: Alex Bennée <alex.bennee@linaro.org>
>>
>> Instead of passing env and leaving it up to the helper to get the
>> right fpstatus we pass it explicitly. There was already a get_fpstatus
>> helper for neon for the 32 bit code. We also add an get_ahp_flag() for
>> passing the state of the alternative FP16 format flag. This leaves
>> scope for later tracking the AHP state in translation flags.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
>> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
>> index a0b0c43d12..570791e7b5 100644
>> --- a/target/arm/translate-a64.c
>> +++ b/target/arm/translate-a64.c
>> @@ -5147,10 +5147,15 @@ static void handle_fp_fcvt(DisasContext *s, int opcode,
>>          } else {
>>              /* Single to half */
>>              TCGv_i32 tcg_rd = tcg_temp_new_i32();
>> -            gen_helper_vfp_fcvt_f32_to_f16(tcg_rd, tcg_rn, cpu_env);
>> +            TCGv_i32 ahp = get_ahp_flag();
>> +            TCGv_ptr fpst = get_fpstatus_ptr(true);
> 
> This should be passing in 'false' to get_fpstatus_ptr(), as should
> all the other uses where we get an fpst to pass to an f*_to_f16 or
> f16_to_f* conversion helper. This is because conversions between
> f16 and other sizes ignore FPCR.FZ16 for the 16-bit end, but they
> still honour FPCR.FZ for the other end. So you need to pass in the
> fpstatus pointer which has the flush-denormals status flags set
> to match FPCR.FZ, not the fp16-specific one.
> 
> Otherwise you'll generate the wrong exception flags for cases like
>  FPCR.FZ = 1; FPCR.FZ16 = 0; s0 = 0x00000001; fcvt h1, s0
> (which should give h1 = 0x0000 and set InputDenormal).

Good catch, thanks.


r~
