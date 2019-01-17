Received: from eggs.gnu.org ([209.51.188.92]:46550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gk2Pq-0006dk-Fo
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:48:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gk2Pp-0000gD-7m
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:48:42 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gk2Pp-0000a8-0w
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:48:41 -0500
Received: by mail-wr1-x443.google.com with SMTP id p4so9816467wrt.7
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 23:48:33 -0800 (PST)
References: <20190116202349.29272-1-alex.bennee@linaro.org>
	<20190116202349.29272-5-alex.bennee@linaro.org>
	<1bef2aae-06dc-5062-4ce6-8e2e9adefb46@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1bef2aae-06dc-5062-4ce6-8e2e9adefb46@linaro.org>
Date: Thu, 17 Jan 2019 07:48:30 +0000
Message-ID: <875zunzpv5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/7] softfloat: fallback to __int128
 maths for s390x and others
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, cohuck@redhat.com, "open list:S390" <qemu-s390x@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 1/17/19 7:23 AM, Alex Benn=C3=A9e wrote:
>> Apparently some versions of clang can't handle inline assembly with
>> __int128 parameters, especially on s390. Instead of hand-coding the
>> s390 divide provide a generic fallback for anything that provides
>> __int128 capable maths.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Thomas Huth <thuth@redhat.com>
>> ---
>>  include/fpu/softfloat-macros.h | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macr=
os.h
>> index b1d772e6d4..1a43609eef 100644
>> --- a/include/fpu/softfloat-macros.h
>> +++ b/include/fpu/softfloat-macros.h
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
>> @@ -663,6 +657,10 @@ static inline uint64_t udiv_qrnnd(uint64_t *r, uint=
64_t n1,
>>      }
>>      *r =3D R;
>>      return Q;
>> +#elif defined(CONFIG_INT128)
>> +    unsigned __int128 n =3D (unsigned __int128)n1 << 64 | n0;
>> +    *r =3D n % d;
>> +    return n / d;
>>  #else
>
> I thought that we'd shown that, at least at present, no compiler is taking
> advantage of hardware insns for this, and is promoting this to a full 128=
-bit
> divide.  And further that the version using 64-bit arithmetic was competi=
tive
> with the hardware insn.

Yeah it seems so. While Thomas' numbers weren't convincing the
CONFIG_INT128 fallback did trigger on my SynQuacer an knocked off about
2 MFlops of it's admittedly slow performance. Amusingly of course it's
faster under translation because of the hardware fall back:

07:44:44 [alex@idun:~/l/q/t/fp] (8973c1e5=E2=80=A6) + ./fp-bench -o div -p =
double
13.28 MFlops
07:44:49 [alex@idun:~/l/q/t/fp] (8973c1e5=E2=80=A6) + ./fp-bench -o div -p =
double -t host
498.20 MFlops
07:44:53 [alex@idun:~/l/q/t/fp] (8973c1e5=E2=80=A6) + ../../aarch64-linux-u=
ser/qemu-aarch64  ./fp-bench -o div -p double -t host
52.71 MFlops

I'll drop this and use Thomas' #elif defined(__s390x__) &&
!defined(__clang__) version in the pull-request.

--
Alex Benn=C3=A9e
