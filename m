Received: from eggs.gnu.org ([209.51.188.92]:46454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hBLJX-0004HG-GL
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hBLJV-0004ny-9p
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:27:02 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:44996 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Mateja.Marjanovic@rt-rk.com>)
	id 1hBLJT-0004g9-V2
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:27:01 -0400
References: <1554207110-9113-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554207110-9113-2-git-send-email-mateja.marjanovic@rt-rk.com>
	<8dd10edf-a799-1c3b-2421-601d91eff0ac@redhat.com>
From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
Message-ID: <63f7b9ca-0d7b-96fc-d62f-94b16f758f2d@rt-rk.com>
Date: Tue, 2 Apr 2019 17:26:56 +0200
MIME-Version: 1.0
In-Reply-To: <8dd10edf-a799-1c3b-2421-601d91eff0ac@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] target/mips: Make the results of
 DIV_<U|S>.<B|H|W|D> the same as on hardware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: arikalo@wavecomp.com, Richard Henderson <rth@twiddle.net>, aurelien@aurel32.net


On 2.4.19. 17:08, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Mateja,
>
> On 4/2/19 2:11 PM, Mateja Marjanovic wrote:
>> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>>
>> MSA instructions DIV_<U|S>.<B|H|W|D> when dividing by zero,
>> didn't return the same value when executed on a referent hardware
>> (FPGA MIPS 64 r6, little endian) and when executed on QEMU, which
>> is not a real bug, because the result when dividing by zero is
>> UNPREDICTABLE [1] (page 141, 142).
> I'm surprised by the arch, I'd have expected a MSA floating point
> exception instead of UNPREDICTABLE.

Our architecture documents do not list any exceptions related to
division by zero, for instructions DIV_<U|S>.<B|H|W|D> and
MOD_<U|S>.<B|H|W|D>.

The only exceptions that are mentioned are:
Reserved Instruction Exception, MSA Disabled Exception. [1] (page 141,=20
142, 254, 255).

>
> So here we decide to follow the FPGA model behavior rather than the
> architecture...
> If the community agree, my only request is to add a comment in the code
> that this is the "FPGA MIPS 64 r6" behavior (else while looking at this
> code later I'd be tempted to revert to a 0 return value instead of -1/1=
).
>
>> [1] MIPS Architecture for Programmers
>>      Volume IV-j: The MIPS64 SIMD
>>      Architecture Module, Revision 1.12
>>
>> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
>> ---
>>   target/mips/msa_helper.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
>> index 655148d..8c77f12 100644
>> --- a/target/mips/msa_helper.c
>> +++ b/target/mips/msa_helper.c
>> @@ -641,14 +641,15 @@ static inline int64_t msa_div_s_df(uint32_t df, =
int64_t arg1, int64_t arg2)
>>       if (arg1 =3D=3D DF_MIN_INT(df) && arg2 =3D=3D -1) {
>>           return DF_MIN_INT(df);
>>       }
>> -    return arg2 ? arg1 / arg2 : 0;
>> +    return arg2 ? arg1 / arg2
>> +                : arg1 >=3D 0 ? -1 : 1;
>>   }
>>  =20
>>   static inline int64_t msa_div_u_df(uint32_t df, int64_t arg1, int64_=
t arg2)
>>   {
>>       uint64_t u_arg1 =3D UNSIGNED(arg1, df);
>>       uint64_t u_arg2 =3D UNSIGNED(arg2, df);
>> -    return u_arg2 ? u_arg1 / u_arg2 : 0;
>> +    return arg2 ? u_arg1 / u_arg2 : -1;
>>   }
>>  =20
>>   static inline int64_t msa_mod_s_df(uint32_t df, int64_t arg1, int64_=
t arg2)
Thanks,
Mateja
