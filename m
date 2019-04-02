Received: from eggs.gnu.org ([209.51.188.92]:44058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hBGIv-0003bH-Pd
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:06:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hBG74-0007t0-3Q
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 05:53:51 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:36051 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Mateja.Marjanovic@rt-rk.com>)
	id 1hBG73-0006iH-LJ
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 05:53:50 -0400
References: <1554129501-27175-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554129501-27175-2-git-send-email-mateja.marjanovic@rt-rk.com>
	<CY4PR2201MB1254A518F1B7BF965D82E941C6550@CY4PR2201MB1254.namprd22.prod.outlook.com>
From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
Message-ID: <7e269903-f29c-97d3-5e97-3b87d6e27746@rt-rk.com>
Date: Tue, 2 Apr 2019 11:52:43 +0200
MIME-Version: 1.0
In-Reply-To: <CY4PR2201MB1254A518F1B7BF965D82E941C6550@CY4PR2201MB1254.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] target/mips: DIV_<U|S>.<B|H|W|D> MSA
 insturctions fixed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>


On 1.4.19. 19:28, Aleksandar Markovic wrote:
>> From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
>> Subject: [PATCH 1/2] target/mips: DIV_<U|S>.<B|H|W|D> MSA insturctions=
 fixed
> "insturctions" -> "instructions". Try to find a spell checking tool tha=
t will help
> you avoid such cases in the future, especially since you tend to make t=
he
> same mistakes over and over.
>
> The title of the patch (after "target/mips:") should begin with an impe=
rative.
>
> Also, using the word "fix" here is debatable - there is no wrong behavi=
or of
> the emulator, since these cases are "unpredictable", so any result is r=
ight.
> The expression "Make results of division by zero be the same as on the
> reference hardware", or similar, would be more appropriate.
You are right, I will change that in v2.
>> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>>
>> In case of dividing integers by zero, the result is unpredictable [1],
> Page number(s) is(are) missing.
I will add them in v2.
>
>> but according to the hardware, the result is 1 or -1, depending on
> "but according to the hardware," -> "but, if executed on the reference =
hardware,"
Same goes for this.
>
>> the sign of the dividend.
>>
>> [1] MIPS=C2=AE Architecture for Programmers
>>      Volume IV-j: The MIPS64=C2=AE SIMD
>>      Architecture Module, Revision 1.12
>>
>> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
>>
>> ---
>> target/mips/msa_helper.c | 7 +++++--
>> 1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
>> index 655148d..46a5aac 100644
>> --- a/target/mips/msa_helper.c
>> +++ b/target/mips/msa_helper.c
>> @@ -641,14 +641,17 @@ static inline int64_t msa_div_s_df(uint32_t df, =
int64_t arg1, int64_t arg2)
>>       if (arg1 =3D=3D DF_MIN_INT(df) && arg2 =3D=3D -1) {
>>           return DF_MIN_INT(df);
>>       }
>> -    return arg2 ? arg1 / arg2 : 0;
>> +    if (arg2 =3D=3D 0) {
>> +        return arg1 >=3D 0 ? -1 : 1;
>> +    }
>> +    return arg1 / arg2;
>>   }
>>
>> static inline int64_t msa_div_u_df(uint32_t df, int64_t arg1, int64_t =
arg2)
>> {
>>      uint64_t u_arg1 =3D UNSIGNED(arg1, df);
>>      uint64_t u_arg2 =3D UNSIGNED(arg2, df);
>> -    return u_arg2 ? u_arg1 / u_arg2 : 0;
>> +    return arg2 ? u_arg1 / u_arg2 : -1;
>> }
> Unnecessary inconsistency. For DIV_S.<B|H|W|D>, you use a full
> "if" statement, and for DUV_U.<B|H|W|D> a conditional operator.
> Use the same in both cases.
Yes, it is a little inconsistent, but they are not really the same,=20
DIV_U.<B|H|W|D> can return the
result of division or -1, if arg2 is equal to zero, unlike=20
DIV_S.<B|H|W|D> who can that and 1, I
thought about putting that in one ternary operator (which has another=20
ternary operator in it),
but it seemed too complicated, but if you think it would be better, I=20
will change it.
> Thanks,
> Aleksandar
>
>> static inline int64_t msa_mod_s_df(uint32_t df, int64_t arg1, int64_t =
arg2)
>> --
>> 2.7.4
Regards,
Mateja
