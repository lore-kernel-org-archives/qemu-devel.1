Received: from eggs.gnu.org ([209.51.188.92]:42405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gj5eK-0000Bs-Uq
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 12:03:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gj5eJ-0004eM-TA
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 12:03:44 -0500
References: <1547467955-17245-1-git-send-email-thuth@redhat.com>
	<30917d5b-f8cb-e799-6c3e-3202195122b4@redhat.com>
	<871s5fp54s.fsf@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e94b51d7-c90f-b599-fb68-ea8c2603989b@redhat.com>
Date: Mon, 14 Jan 2019 18:03:36 +0100
MIME-Version: 1.0
In-Reply-To: <871s5fp54s.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On 2019-01-14 17:37, Alex Benn=C3=A9e wrote:
>=20
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> On 1/14/19 1:12 PM, Thomas Huth wrote:
>>> Clang v7.0.1 does not like the __int128 variable type for inline
>>> assembly on s390x:
>>>
>>> In file included from fpu/softfloat.c:97:
>>> include/fpu/softfloat-macros.h:647:9: error: inline asm error:
>>>  This value type register class is not natively supported!
>>>     asm("dlgr %0, %1" : "+r"(n) : "r"(d));
>>>         ^
>>>
>>> Disable this code part there now when compiling with Clang, so that
>>> the generic code gets used instead.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  include/fpu/softfloat-macros.h | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-m=
acros.h
>>> index b1d772e..bd5b641 100644
>>> --- a/include/fpu/softfloat-macros.h
>>> +++ b/include/fpu/softfloat-macros.h
>>> @@ -641,7 +641,7 @@ static inline uint64_t udiv_qrnnd(uint64_t *r, ui=
nt64_t n1,
>>>      uint64_t q;
>>>      asm("divq %4" : "=3Da"(q), "=3Dd"(*r) : "0"(n0), "1"(n1), "rm"(d=
));
>>>      return q;
>>> -#elif defined(__s390x__)
>>> +#elif defined(__s390x__) && !defined(__clang__)
>>
>> Can we rather check if __int128 is natively supported? So this part ge=
t
>> compiled once Clang do support it, else we'll never use it...
>=20
> We already define CONFIG_INT128 so you could just use that.
>=20
> Thomas does the s390 clang leave CONFIG_INT128=3Dy in config-host.mak?

Yes, CONFIG_INT128=3Dy is also set with Clang on s390x. It's really just
that it does not like __int128  to be passed as parameters for inline
assembly...

 Thomas
