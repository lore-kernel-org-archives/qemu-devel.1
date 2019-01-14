Received: from eggs.gnu.org ([209.51.188.92]:33771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gjB1k-0001zW-Fl
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:48:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gjB1j-0005yR-Ik
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:48:16 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:41958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gjB1j-0005xb-BJ
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:48:15 -0500
Received: by mail-wr1-x431.google.com with SMTP id x10so785874wrs.8
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 14:48:15 -0800 (PST)
References: <1547467955-17245-1-git-send-email-thuth@redhat.com>
	<30917d5b-f8cb-e799-6c3e-3202195122b4@redhat.com>
	<871s5fp54s.fsf@linaro.org>
	<e94b51d7-c90f-b599-fb68-ea8c2603989b@redhat.com>
	<87zhs3nk1m.fsf@linaro.org>
	<a0646a85-603d-99a8-c676-76e43a42e0fb@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <a0646a85-603d-99a8-c676-76e43a42e0fb@twiddle.net>
Date: Mon, 14 Jan 2019 22:48:12 +0000
Message-ID: <87y37monyr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] include/fpu/softfloat: Fix compilation
 with Clang on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Thomas Huth <thuth@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org


Richard Henderson <rth@twiddle.net> writes:

> On 1/15/19 5:58 AM, Alex Benn=C3=A9e wrote:
>>
>> Thomas Huth <thuth@redhat.com> writes:
>>
>>> On 2019-01-14 17:37, Alex Benn=C3=A9e wrote:
>>>>
>>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>>>
>>>>> On 1/14/19 1:12 PM, Thomas Huth wrote:
>>>>>> Clang v7.0.1 does not like the __int128 variable type for inline
>>>>>> assembly on s390x:
>>>>>>
>>>>>> In file included from fpu/softfloat.c:97:
>>>>>> include/fpu/softfloat-macros.h:647:9: error: inline asm error:
>>>>>>  This value type register class is not natively supported!
>>>>>>     asm("dlgr %0, %1" : "+r"(n) : "r"(d));
>>>>>>         ^
>>>>>>
>>>>>> Disable this code part there now when compiling with Clang, so that
>>>>>> the generic code gets used instead.
>>>>>>
>>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>>> ---
>>>>>>  include/fpu/softfloat-macros.h | 2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-=
macros.h
>>>>>> index b1d772e..bd5b641 100644
>>>>>> --- a/include/fpu/softfloat-macros.h
>>>>>> +++ b/include/fpu/softfloat-macros.h
>>>>>> @@ -641,7 +641,7 @@ static inline uint64_t udiv_qrnnd(uint64_t *r, u=
int64_t n1,
>>>>>>      uint64_t q;
>>>>>>      asm("divq %4" : "=3Da"(q), "=3Dd"(*r) : "0"(n0), "1"(n1), "rm"(=
d));
>>>>>>      return q;
>>>>>> -#elif defined(__s390x__)
>>>>>> +#elif defined(__s390x__) && !defined(__clang__)
>>>>>
>>>>> Can we rather check if __int128 is natively supported? So this part g=
et
>>>>> compiled once Clang do support it, else we'll never use it...
>>>>
>>>> We already define CONFIG_INT128 so you could just use that.
>>>>
>>>> Thomas does the s390 clang leave CONFIG_INT128=3Dy in config-host.mak?
>>>
>>> Yes, CONFIG_INT128=3Dy is also set with Clang on s390x. It's really just
>>> that it does not like __int128  to be passed as parameters for inline
>>> assembly...
>>
>> What about something like this:
>>
>> modified   include/fpu/softfloat-macros.h
>> @@ -641,12 +641,6 @@ static inline uint64_t udiv_qrnnd(uint64_t *r, uint=
64_t n1,
>>      uint64_t q;
>>      asm("divq %4" : "=3Da"(q), "=3Dd"(*r) : "0"(n0), "1"(n1), "rm"(d));
>>      return q;
>> -#elif defined(__s390x__)
>> -    /* Need to use a TImode type to get an even register pair for DLGR.=
  */
>> -    unsigned __int128 n =3D (unsigned __int128)n1 << 64 | n0;
>> -    asm("dlgr %0, %1" : "+r"(n) : "r"(d));
>> -    *r =3D n >> 64;
>> -    return n;
>>  #elif defined(_ARCH_PPC64) && defined(_ARCH_PWR7)
>>      /* From Power ISA 2.06, programming note for divdeu.  */
>>      uint64_t q1, q2, Q, r1, r2, R;
>> @@ -663,6 +657,11 @@ static inline uint64_t udiv_qrnnd(uint64_t *r, uint=
64_t n1,
>>      }
>>      *r =3D R;
>>      return Q;
>> +#elif defined(CONFIG_INT128)
>> +    unsigned __int128 n =3D (unsigned __int128)n1 << 64 | n0;
>> +    unsigned __int128 q =3D n / d;
>> +    *r =3D q >> 64;
>> +    return q;
>
> Because that is not what the assembly does, for one.

Doh...

> But perhaps
>
>     unsigned __int128 n =3D (unsigned __int128)n1 << 64 | n0;
>     *r =3D n % d;
>     return n / d;
>
> will allow the compiler to do what the assembly does for some 64-bit
> hosts.

I wonder how much cost is incurred by the jumping to the (libgcc?) div
helper? Anyone got an s390x about so we can benchmark the two
approaches?

If it's in the noise then it would be nice to avoid getting too #ifdef
happy.

--
Alex Benn=C3=A9e
