Received: from eggs.gnu.org ([2001:4830:134:3::10]:36285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ebPo8-0007WQ-7N
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:53:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ebPo4-00024J-Ab
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:53:36 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:43660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ebPo4-00022z-1w
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:53:32 -0500
Received: by mail-wm0-x241.google.com with SMTP id g1so7785905wmg.2
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 03:53:31 -0800 (PST)
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-8-alex.bennee@linaro.org>
	<CAFEAcA8GKN_shhnizPihdts0w-Tbg-+W-971Q6Mt5zFbT8hdYA@mail.gmail.com>
	<87efmqnipz.fsf@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87efmqnipz.fsf@linaro.org>
Date: Tue, 16 Jan 2018 11:53:29 +0000
Message-ID: <87d12anhom.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/20] fpu/softfloat: propagate
 signalling NaNs in MINMAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, bharata@linux.vnet.ibm.com, Andrew Dutcher <andrew@andrewdutcher.com>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On 9 January 2018 at 12:22, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>> While a comparison between a QNaN and a number will return the number
>>> it is not the same with a signaling NaN. In this case the SNaN will
>>> "win" and after potentially raising an exception it will be quietened.
>>>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>> v2
>>>   - added return for propageFloat
>>> ---
>>>  fpu/softfloat.c | 8 ++++++--
>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
>>> index 3a4ab1355f..44c043924e 100644
>>> --- a/fpu/softfloat.c
>>> +++ b/fpu/softfloat.c
>>> @@ -7683,6 +7683,7 @@ int float128_compare_quiet(float128 a, float128 b=
, float_status *status)
>>>   * minnum() and maxnum() functions. These are similar to the min()
>>>   * and max() functions but if one of the arguments is a QNaN and
>>>   * the other is numerical then the numerical argument is returned.
>>> + * SNaNs will get quietened before being returned.
>>>   * minnum() and maxnum correspond to the IEEE 754-2008 minNum()
>>>   * and maxNum() operations. min() and max() are the typical min/max
>>>   * semantics provided by many CPUs which predate that specification.
>>> @@ -7703,11 +7704,14 @@ static inline float ## s float ## s ## _minmax(=
float ## s a, float ## s b,     \
>>>      if (float ## s ## _is_any_nan(a) ||                               =
  \
>>>          float ## s ## _is_any_nan(b)) {                               =
  \
>>>          if (isieee) {                                                 =
  \
>>> -            if (float ## s ## _is_quiet_nan(a, status) &&             =
  \
>>> +            if (float ## s ## _is_signaling_nan(a, status) ||         =
  \
>>> +                float ## s ## _is_signaling_nan(b, status)) {         =
  \
>>> +                return propagateFloat ## s ## NaN(a, b, status);      =
  \
>>> +            } else  if (float ## s ## _is_quiet_nan(a, status) &&     =
  \
>>>                  !float ## s ##_is_any_nan(b)) {                       =
  \
>>>                  return b;                                             =
  \
>>>              } else if (float ## s ## _is_quiet_nan(b, status) &&      =
  \
>>> -                       !float ## s ## _is_any_nan(a)) {               =
 \
>>> +                       !float ## s ## _is_any_nan(a)) {               =
  \
>>>                  return a;                                             =
  \
>>>              }                                                         =
  \
>>>          }                                                             =
  \
>>>          return propagateFloat ## s ## NaN(a, b, status);              =
  \
>>>      }                                                                 =
  \
>>
>> [added a couple of extra lines of context at the end for clarity]
>>
>> Am I misreading this patch? I can't see in what case it makes a
>> difference to the result. The code change adds an explicit "if
>> either A or B is an SNaN then return the propagateFloat*NaN() result".
>> But if either A or B is an SNaN then we won't take either of the
>> previously existing branches in this if() ("if A is a QNaN and B is
>> not a NaN" and "if B is a QNaN and A is not a NaN"), and so we'll
>> end up falling through to the "return propagateFloat*NaN" line after
>> the end of the "is (ieee) {...}".
>
> I see your point. However the bug is there if we don't check for
> signalling NaNs first which probably means the xxx_is_quiet_nan() check
> is broken and reporting signalling NaN's as quiet.
>
> The logic is correct in the decomposed function as we have many NaN
> types to check against so we check for the signalling NaNs first.

So maybe the helper functions need to be clearer:

  /*-----------------------------------------------------------------------=
-----
  | Returns 1 if the half-precision floating-point value `a' is a quiet
  | NaN; otherwise returns 0.
  *------------------------------------------------------------------------=
----*/

  int float16_is_quiet_nan(float16 a_, float_status *status)
  {
      if (float16_is_any_nan(a_)) {
          uint16_t sbit =3D float16_val(a_) & (1 << 9);
          if (status->snan_bit_is_one) {
              return sbit ? 0 : 1;
          } else {
              return sbit ? 1 : 0;
          }

      }
      return 0;
  }

  /*-----------------------------------------------------------------------=
-----
  | Returns 1 if the half-precision floating-point value `a' is a signaling
  | NaN; otherwise returns 0.
  *------------------------------------------------------------------------=
----*/

  int float16_is_signaling_nan(float16 a_, float_status *status)
  {
      if (float16_is_any_nan(a_)) {
          uint16_t sbit =3D float16_val(a_) & (1 << 9);
          if (status->snan_bit_is_one) {
              return sbit ? 1 : 0;
          } else {
              return sbit ? 0 : 1;
          }

      }
      return 0;
  }


--
Alex Benn=C3=A9e
