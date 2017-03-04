Received: from eggs.gnu.org ([2001:4830:134:3::10]:38171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj.dadhania@gmail.com>) id 1ck9tM-00018H-G8
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 08:38:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj.dadhania@gmail.com>) id 1ck9tL-0001iD-Eu
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 08:38:36 -0500
MIME-Version: 1.0
In-Reply-To: <3AA8BBB4-FF53-423E-86F6-9F95E7DAB5C6@gmail.com>
References: <mailman.56219.1488535159.22740.qemu-ppc@nongnu.org>
	<3AA8BBB4-FF53-423E-86F6-9F95E7DAB5C6@gmail.com>
From: Nikunj Dadhania <nikunj.dadhania@gmail.com>
Date: Sat, 4 Mar 2017 19:08:30 +0530
Message-ID: <CALAZu3-HkNub==6LDz7qoVg8CHhGDtknrmxXvZdWvq=N1O_Bqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/3] target/ppc: fmadd check for
 excp independently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, "list@suse.de:PowerPC list:PowerPC" <qemu-ppc@nongnu.org>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

>> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
>> index 0535ad0..a547f58 100644
>> --- a/target/ppc/fpu_helper.c
>> +++ b/target/ppc/fpu_helper.c
>> @@ -747,17 +747,21 @@ static void float64_maddsub_update_excp(CPUPPCState *env, float64 arg1,
>>                                         float64 arg2, float64 arg3,
>>                                         unsigned int madd_flags)
>> {
>> +    if (unlikely(float64_is_signaling_nan(arg1, &env->fp_status) ||
>> +                 float64_is_signaling_nan(arg2, &env->fp_status) ||
>> +                 float64_is_signaling_nan(arg3, &env->fp_status))) {
>> +        /* sNaN operation */
>> +        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
>> +    }
>> +
>>     if (unlikely((float64_is_infinity(arg1) && float64_is_zero(arg2)) ||
>>                  (float64_is_zero(arg1) && float64_is_infinity(arg2)))) {
>>         /* Multiplication of zero by infinity */
>> -        arg1 = float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);
>> -    } else if (unlikely(float64_is_signaling_nan(arg1, &env->fp_status) ||
>> -                        float64_is_signaling_nan(arg2, &env->fp_status) ||
>> -                        float64_is_signaling_nan(arg3, &env->fp_status))) {
>> -        /* sNaN operation */
>> -        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
>> -    } else if ((float64_is_infinity(arg1) || float64_is_infinity(arg2)) &&
>> -               float64_is_infinity(arg3)) {
>> +        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);
>> +    }
>> +
>> +    if ((float64_is_infinity(arg1) || float64_is_infinity(arg2)) &&
>> +        float64_is_infinity(arg3)) {
>>         uint8_t aSign, bSign, cSign;
>>
>>         aSign = float64_is_neg(arg1);
>> --
>> 2.7.4
>
>
> I'm having difficulty applying this patch. I took a look at float64_maddsub_update_excp()
> in fpu_helper.c and found out why. This function doesn't exist. Are you missing a patch?

That patch is in ppc-for-2.9, here is the link

https://github.com/dgibson/qemu/commit/992d7e976c7eca2b3129cd4bae4a0d350a8065fa

Regards
Nikunj
