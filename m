Received: from eggs.gnu.org ([2001:4830:134:3::10]:58557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fY8lV-0004qU-05
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fY8lR-00036c-Cn
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:37:36 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fY8lR-00035W-4I
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:37:33 -0400
Received: by mail-wr0-x241.google.com with SMTP id a12-v6so1706857wro.1
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 04:37:33 -0700 (PDT)
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-3-richard.henderson@linaro.org>
	<87lgb1wvz6.fsf@linaro.org>
	<292aa987-8644-c22e-4594-c3ad6518c4c3@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <292aa987-8644-c22e-4594-c3ad6518c4c3@linaro.org>
Date: Wed, 27 Jun 2018 12:37:30 +0100
Message-ID: <87fu18wjd1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 02/35] target/arm: Implement SVE
 Contiguous Load, first-fault and no-fault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> On 06/26/2018 05:52 AM, Alex Benn=C3=A9e wrote:
>>> +#define DO_LDFF1(PART, FN, TYPEE, TYPEM, H)                           =
  \
>>> +static void do_sve_ldff1##PART(CPUARMState *env, void *vd, void *vg,  =
  \
>>> +                               target_ulong addr, intptr_t oprsz,     =
  \
>>> +                               bool first, uintptr_t ra)              =
  \
>>> +{                                                                     =
  \
>>> +    intptr_t i =3D 0;                                                 =
    \
>>> +    do {                                                              =
  \
>>> +        uint16_t pg =3D *(uint16_t *)(vg + H1_2(i >> 3));             =
    \
>>> +        do {                                                          =
  \
>>> +            TYPEM m =3D 0;                                            =
    \
>>> +            if (pg & 1) {                                             =
  \
>>> +                if (!first &&                                         =
  \
>>> +                    page_check_range(addr, sizeof(TYPEM), PAGE_READ)) =
{ \
>>> +                    record_fault(env, i, oprsz);                      =
  \
>>> +                    return;                                           =
  \
>>> +                }                                                     =
  \
>>> +                m =3D FN(env, addr, ra);                              =
    \
>>> +                first =3D false;                                      =
    \
>>> +            }                                                         =
  \
>>> +            *(TYPEE *)(vd + H(i)) =3D m;                              =
    \
>>> +            i +=3D sizeof(TYPEE), pg >>=3D sizeof(TYPEE);             =
      \
>>> +            addr +=3D sizeof(TYPEM);                                  =
    \
>>> +        } while (i & 15);                                             =
  \
>>> +    } while (i < oprsz);                                              =
  \
>>> +}
>>>  \
>> So I noticed that the disassembly of these two functions is mostly
>> parameter pushing and popping. Is there a case to be made to use the
>> __flatten__ approach and see how the compiler unrolls it all?
>
> Em... for the most part the functions being called are not inlinable,
> being defined in accel/tcg/.

*sigh* I guess. It's a shame because the numbers get more disappointing:

12:13:48 [alex@zen:~/l/q/q/aarch64-linux-user] review/rth-sve-v5(+26/-1) + =
./qemu-aarch64 ./tests/simd-memcpy libc intreg intpair simdreg simdpair sve
libc, 248298053, 4228 kb/s
intreg, 646085220, 1623 kb/s
intpair, 369350825, 2841 kb/s
simdreg, 1422096252, 737 kb/s
simdpair, 1369635566, 765 kb/s
sve, 2646179942, 396 kb/s

and the above example doesn't have the cost of page_check_range. I guess
this isn't something that could be improved until other architectures had a
similar predicated load solution we could use in generated code. Helpers
are always going to suck here :-/

Anyway my boy-racer disappointments aside:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
