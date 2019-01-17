Received: from eggs.gnu.org ([209.51.188.92]:46127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gk0mA-0003ti-Kv
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 01:03:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gk0g0-0005sZ-Nk
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 00:57:18 -0500
References: <1547467955-17245-1-git-send-email-thuth@redhat.com>
	<20190116175014.6f6eafe4.cohuck@redhat.com> <878szkzfne.fsf@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bf322d0d-1fac-3fc6-094c-43a95140fb57@redhat.com>
Date: Thu, 17 Jan 2019 06:57:09 +0100
MIME-Version: 1.0
In-Reply-To: <878szkzfne.fsf@linaro.org>
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Cornelia Huck <cohuck@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On 2019-01-16 18:16, Alex Benn=C3=A9e wrote:
>=20
> Cornelia Huck <cohuck@redhat.com> writes:
>=20
>> On Mon, 14 Jan 2019 13:12:35 +0100
>> Thomas Huth <thuth@redhat.com> wrote:
>>
> <snip>
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
>>>      /* Need to use a TImode type to get an even register pair for DL=
GR.  */
>>>      unsigned __int128 n =3D (unsigned __int128)n1 << 64 | n0;
>>>      asm("dlgr %0, %1" : "+r"(n) : "r"(d));
>>
>> Ok, so what's the deal with this patch now? Fix compilation now,
>> optimize later?
>>
>> If yes, should I pick it as an s390x build fix (I plan to send a pull
>> request later this week), or will the fpu maintainers pick it?
>=20
> I'm planning to send a FPU PR tomorrow and I'll happily include either
> version.
>=20
> I'm personally minded to go with the patch that makes s390 (and others)
> fall back to the generic CONFIG_INT128 code. The numbers Thomas gathere=
d
> didn't look like it was much difference either way.
>=20
> Unless you *really* care about milking that last bit of performance out=
 of
> the s390 TCG back-end?

I don't think that anybody buys a mainframe for this special case ;-)
I'd go with the !defined(__clang__) patch above.

 Thomas
