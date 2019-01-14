Received: from eggs.gnu.org ([209.51.188.92]:33653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj5F5-0004TO-9t
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:37:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj5F3-0003qg-9H
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:37:39 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:36174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gj5Ez-0003jQ-Ob
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:37:34 -0500
Received: by mail-wm1-x32c.google.com with SMTP id p6so221951wmc.1
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 08:37:26 -0800 (PST)
References: <1547467955-17245-1-git-send-email-thuth@redhat.com>
	<30917d5b-f8cb-e799-6c3e-3202195122b4@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <30917d5b-f8cb-e799-6c3e-3202195122b4@redhat.com>
Date: Mon, 14 Jan 2019 16:37:23 +0000
Message-ID: <871s5fp54s.fsf@linaro.org>
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
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 1/14/19 1:12 PM, Thomas Huth wrote:
>> Clang v7.0.1 does not like the __int128 variable type for inline
>> assembly on s390x:
>>
>> In file included from fpu/softfloat.c:97:
>> include/fpu/softfloat-macros.h:647:9: error: inline asm error:
>>  This value type register class is not natively supported!
>>     asm("dlgr %0, %1" : "+r"(n) : "r"(d));
>>         ^
>>
>> Disable this code part there now when compiling with Clang, so that
>> the generic code gets used instead.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  include/fpu/softfloat-macros.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macr=
os.h
>> index b1d772e..bd5b641 100644
>> --- a/include/fpu/softfloat-macros.h
>> +++ b/include/fpu/softfloat-macros.h
>> @@ -641,7 +641,7 @@ static inline uint64_t udiv_qrnnd(uint64_t *r, uint6=
4_t n1,
>>      uint64_t q;
>>      asm("divq %4" : "=3Da"(q), "=3Dd"(*r) : "0"(n0), "1"(n1), "rm"(d));
>>      return q;
>> -#elif defined(__s390x__)
>> +#elif defined(__s390x__) && !defined(__clang__)
>
> Can we rather check if __int128 is natively supported? So this part get
> compiled once Clang do support it, else we'll never use it...

We already define CONFIG_INT128 so you could just use that.

Thomas does the s390 clang leave CONFIG_INT128=3Dy in config-host.mak?

>
>>      /* Need to use a TImode type to get an even register pair for DLGR.=
  */
>>      unsigned __int128 n =3D (unsigned __int128)n1 << 64 | n0;
>>      asm("dlgr %0, %1" : "+r"(n) : "r"(d));
>>


--
Alex Benn=C3=A9e
