Received: from eggs.gnu.org ([2001:4830:134:3::10]:33213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIGkD-0007QE-HO
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:54:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIGk9-00056k-Tt
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:54:41 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:43294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fIGk9-000568-Mn
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:54:37 -0400
Received: by mail-pl0-x243.google.com with SMTP id c41-v6so2494096plj.10
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 09:54:37 -0700 (PDT)
References: <20180512004311.9299-1-richard.henderson@linaro.org>
	<20180512004311.9299-25-richard.henderson@linaro.org>
	<CAFEAcA-XuyMiKXOC1D=UJ1JSQsnc0h_-Ygb8y5OrHA__EJ-djg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <be71495d-001a-b952-599b-9504ea85a271@linaro.org>
Date: Mon, 14 May 2018 09:54:33 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-XuyMiKXOC1D=UJ1JSQsnc0h_-Ygb8y5OrHA__EJ-djg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 24/27] fpu/softfloat: Specialize on
 snan_bit_is_one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>

On 05/14/2018 07:44 AM, Peter Maydell wrote:
> On 12 May 2018 at 01:43, Richard Henderson <richard.henderson@linaro.org> wrote:
>> Only MIPS requires snan_bit_is_one to be variable.  While we are
>> specializing softfloat behaviour, allow other targets to eliminate
>> this runtime check.
>>
>> Cc: Aurelien Jarno <aurelien@aurel32.net>
>> Cc: Yongbok Kim <yongbok.kim@mips.com>
>> Cc: David Gibson <david@gibson.dropbear.id.au>
>> Cc: Alexander Graf <agraf@suse.de>
>> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  fpu/softfloat-specialize.h    | 68 ++++++++++++++++++++++-------------
>>  include/fpu/softfloat-types.h |  1 +
>>  include/fpu/softfloat.h       |  4 ---
>>  target/mips/cpu.h             |  4 +--
>>  target/hppa/cpu.c             |  1 -
>>  target/mips/translate_init.c  |  4 +--
>>  target/ppc/fpu_helper.c       |  1 -
>>  target/sh4/cpu.c              |  1 -
>>  target/unicore32/cpu.c        |  2 --
>>  9 files changed, 48 insertions(+), 38 deletions(-)
> 
> 
>> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
>> index 69f4dbc4db..e72cc9525d 100644
>> --- a/include/fpu/softfloat.h
>> +++ b/include/fpu/softfloat.h
>> @@ -125,10 +125,6 @@ static inline void set_default_nan_mode(flag val, float_status *status)
>>  {
>>      status->default_nan_mode = val;
>>  }
>> -static inline void set_snan_bit_is_one(flag val, float_status *status)
>> -{
>> -    status->snan_bit_is_one = val;
>> -}
>>  static inline int get_float_detect_tininess(float_status *status)
>>  {
>>      return status->float_detect_tininess;
>> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
>> index cfe1735e0e..2abce47ea3 100644
>> --- a/target/mips/cpu.h
>> +++ b/target/mips/cpu.h
>> @@ -755,8 +755,8 @@ target_ulong exception_resume_pc (CPUMIPSState *env);
>>
>>  static inline void restore_snan_bit_mode(CPUMIPSState *env)
>>  {
>> -    set_snan_bit_is_one((env->active_fpu.fcr31 & (1 << FCR31_NAN2008)) == 0,
>> -                        &env->active_fpu.fp_status);
>> +    env->active_fpu.fp_status.snan_bit_is_one
>> +        = (env->active_fpu.fcr31 & (1 << FCR31_NAN2008)) == 0;
>>  }
>>
>>  static inline void cpu_get_tb_cpu_state(CPUMIPSState *env, target_ulong *pc,
>>
>> diff --git a/target/mips/translate_init.c b/target/mips/translate_init.c
>> index c7ba6ee5f9..5e40d6a198 100644
>> --- a/target/mips/translate_init.c
>> +++ b/target/mips/translate_init.c
>> @@ -878,6 +878,6 @@ static void msa_reset(CPUMIPSState *env)
>>      /* clear float_status nan mode */
>>      set_default_nan_mode(0, &env->active_tc.msa_fp_status);
>>
>> -    /* set proper signanling bit meaning ("1" means "quiet") */
>> -    set_snan_bit_is_one(0, &env->active_tc.msa_fp_status);
>> +    /* set proper signaling bit meaning ("1" means "quiet") */
>> +    env->active_tc.msa_fp_status.snan_bit_is_one = 0;
>>  }
> 
> Why remove the set_snan_bit_is_one() helper and require mips
> to manually look inside the float_status struct?

What I really wanted was to #ifdef TARGET_MIPS around the function and the
field, but it's poisoned at that point.  But you're right, I could have left
the function.


r~
