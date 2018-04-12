Received: from eggs.gnu.org ([2001:4830:134:3::10]:41548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f6cCd-0007W6-4U
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 09:23:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f6cCX-0002T2-D7
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 09:23:51 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36493)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f6cCX-0002SK-4c
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 09:23:45 -0400
Received: by mail-wm0-x244.google.com with SMTP id x82so9565416wmg.1
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 06:23:45 -0700 (PDT)
References: <20180412115838.10208-1-alex.bennee@linaro.org>
	<20180412115838.10208-3-alex.bennee@linaro.org>
	<CAFEAcA_9F3s5h8r-BGF2K_3-qgs7qUzpQQpjwtn+CdgUF-9zkg@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_9F3s5h8r-BGF2K_3-qgs7qUzpQQpjwtn+CdgUF-9zkg@mail.gmail.com>
Date: Thu, 12 Apr 2018 14:23:42 +0100
Message-ID: <87muy8much.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 2/2] fpu/softfloat: raise float_invalid
 for NaN in float_to_int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Aurelien Jarno <aurelien@aurel32.net>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 12 April 2018 at 12:58, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>> Fixes https://bugs.launchpad.net/qemu/+bug/1759264
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>> ---
>>  fpu/softfloat.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
>> index 9b99aa6ec8..ddc77c273c 100644
>> --- a/fpu/softfloat.c
>> +++ b/fpu/softfloat.c
>> @@ -1344,6 +1344,7 @@ static int64_t round_to_int_and_pack(FloatParts in=
, int rmode,
>>      case float_class_qnan:
>>      case float_class_dnan:
>>      case float_class_msnan:
>> +        s->float_exception_flags =3D orig_flags | float_flag_invalid;
>>          return max;
>>      case float_class_inf:
>>          return p.sign ? min : max;
>
> Don't we also need to raise the Invalid flag for float_class_inf ?
>
> In both cases, this is fixing a regression introduced in
> commit ab52f973a50, I think.

And I guess the round_to_uint_and_pack as well which doesn't handle the
input inf case.

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e
