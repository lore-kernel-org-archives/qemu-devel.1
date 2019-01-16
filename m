Received: from eggs.gnu.org ([209.51.188.92]:51273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gjooF-0003E7-Mg
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:17:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gjooE-00087y-Ow
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:16:59 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gjooE-00085m-GK
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:16:58 -0500
Received: by mail-wm1-x343.google.com with SMTP id g67so2825138wmd.2
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 09:16:56 -0800 (PST)
References: <1547467955-17245-1-git-send-email-thuth@redhat.com>
	<20190116175014.6f6eafe4.cohuck@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190116175014.6f6eafe4.cohuck@redhat.com>
Date: Wed, 16 Jan 2019 17:16:53 +0000
Message-ID: <878szkzfne.fsf@linaro.org>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org


Cornelia Huck <cohuck@redhat.com> writes:

> On Mon, 14 Jan 2019 13:12:35 +0100
> Thomas Huth <thuth@redhat.com> wrote:
>
<snip>
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
>>      /* Need to use a TImode type to get an even register pair for DLGR.=
  */
>>      unsigned __int128 n =3D (unsigned __int128)n1 << 64 | n0;
>>      asm("dlgr %0, %1" : "+r"(n) : "r"(d));
>
> Ok, so what's the deal with this patch now? Fix compilation now,
> optimize later?
>
> If yes, should I pick it as an s390x build fix (I plan to send a pull
> request later this week), or will the fpu maintainers pick it?

I'm planning to send a FPU PR tomorrow and I'll happily include either
version.

I'm personally minded to go with the patch that makes s390 (and others)
fall back to the generic CONFIG_INT128 code. The numbers Thomas gathered
didn't look like it was much difference either way.

Unless you *really* care about milking that last bit of performance out of
the s390 TCG back-end?

--
Alex Benn=C3=A9e
