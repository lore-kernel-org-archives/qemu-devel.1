Received: from eggs.gnu.org ([209.51.188.92]:46344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gj9ug-00012G-AO
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 16:36:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gj9ud-0005WT-QP
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 16:36:53 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1547467955-17245-1-git-send-email-thuth@redhat.com>
	<30917d5b-f8cb-e799-6c3e-3202195122b4@redhat.com>
	<871s5fp54s.fsf@linaro.org>
	<e94b51d7-c90f-b599-fb68-ea8c2603989b@redhat.com>
	<87zhs3nk1m.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a0646a85-603d-99a8-c676-76e43a42e0fb@twiddle.net>
Date: Tue, 15 Jan 2019 08:36:24 +1100
MIME-Version: 1.0
In-Reply-To: <87zhs3nk1m.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On 1/15/19 5:58 AM, Alex Bennée wrote:
> 
> Thomas Huth <thuth@redhat.com> writes:
> 
>> On 2019-01-14 17:37, Alex Bennée wrote:
>>>
>>> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
>>>
>>>> On 1/14/19 1:12 PM, Thomas Huth wrote:
>>>>> Clang v7.0.1 does not like the __int128 variable type for inline
>>>>> assembly on s390x:
>>>>>
>>>>> In file included from fpu/softfloat.c:97:
>>>>> include/fpu/softfloat-macros.h:647:9: error: inline asm error:
>>>>>  This value type register class is not natively supported!
>>>>>     asm("dlgr %0, %1" : "+r"(n) : "r"(d));
>>>>>         ^
>>>>>
>>>>> Disable this code part there now when compiling with Clang, so that
>>>>> the generic code gets used instead.
>>>>>
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>>  include/fpu/softfloat-macros.h | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
>>>>> index b1d772e..bd5b641 100644
>>>>> --- a/include/fpu/softfloat-macros.h
>>>>> +++ b/include/fpu/softfloat-macros.h
>>>>> @@ -641,7 +641,7 @@ static inline uint64_t udiv_qrnnd(uint64_t *r, uint64_t n1,
>>>>>      uint64_t q;
>>>>>      asm("divq %4" : "=a"(q), "=d"(*r) : "0"(n0), "1"(n1), "rm"(d));
>>>>>      return q;
>>>>> -#elif defined(__s390x__)
>>>>> +#elif defined(__s390x__) && !defined(__clang__)
>>>>
>>>> Can we rather check if __int128 is natively supported? So this part get
>>>> compiled once Clang do support it, else we'll never use it...
>>>
>>> We already define CONFIG_INT128 so you could just use that.
>>>
>>> Thomas does the s390 clang leave CONFIG_INT128=y in config-host.mak?
>>
>> Yes, CONFIG_INT128=y is also set with Clang on s390x. It's really just
>> that it does not like __int128  to be passed as parameters for inline
>> assembly...
> 
> What about something like this:
> 
> modified   include/fpu/softfloat-macros.h
> @@ -641,12 +641,6 @@ static inline uint64_t udiv_qrnnd(uint64_t *r, uint64_t n1,
>      uint64_t q;
>      asm("divq %4" : "=a"(q), "=d"(*r) : "0"(n0), "1"(n1), "rm"(d));
>      return q;
> -#elif defined(__s390x__)
> -    /* Need to use a TImode type to get an even register pair for DLGR.  */
> -    unsigned __int128 n = (unsigned __int128)n1 << 64 | n0;
> -    asm("dlgr %0, %1" : "+r"(n) : "r"(d));
> -    *r = n >> 64;
> -    return n;
>  #elif defined(_ARCH_PPC64) && defined(_ARCH_PWR7)
>      /* From Power ISA 2.06, programming note for divdeu.  */
>      uint64_t q1, q2, Q, r1, r2, R;
> @@ -663,6 +657,11 @@ static inline uint64_t udiv_qrnnd(uint64_t *r, uint64_t n1,
>      }
>      *r = R;
>      return Q;
> +#elif defined(CONFIG_INT128)
> +    unsigned __int128 n = (unsigned __int128)n1 << 64 | n0;
> +    unsigned __int128 q = n / d;
> +    *r = q >> 64;
> +    return q;

Because that is not what the assembly does, for one.

But perhaps

    unsigned __int128 n = (unsigned __int128)n1 << 64 | n0;
    *r = n % d;
    return n / d;

will allow the compiler to do what the assembly does for some 64-bit hosts.


r~
