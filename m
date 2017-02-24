Received: from eggs.gnu.org ([2001:4830:134:3::10]:50826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chHKj-0007YW-NE
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:58:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chHKj-0003LS-1c
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:58:57 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:35937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1chHKi-0003L8-Rm
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:58:56 -0500
Received: by mail-wm0-x233.google.com with SMTP id v77so16402797wmv.1
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 06:58:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87varzll0r.fsf@linaro.org>
References: <1487604965-23220-1-git-send-email-peter.maydell@linaro.org>
	<1487604965-23220-10-git-send-email-peter.maydell@linaro.org>
	<87varzll0r.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 14:58:35 +0000
Message-ID: <CAFEAcA-qNT=5yQVMoB4GSpsDYXFTAHOHktGT652eNKBCBS-wYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/11] armv7m: Split systick out from NVIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Alistair Francis <alistair23@gmail.com>, Michael Davidsaver <mdavidsaver@gmail.com>

On 24 February 2017 at 14:29, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> The SysTick timer isn't really part of the NVIC proper;
>> we just modelled it that way back when we couldn't
>> easily have devices that only occupied a small chunk
>> of a memory region. Split it out into its own device.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "SysTick: Bad read offset 0x%" HWADDR_PRIx "\n", =
addr);
>> +        break;
>> +    }
>> +
>> +    trace_systick_read(addr, val, size);
>
> I'm getting the compiler complain:
>
> hw/timer/armv7m_systick.c: In function =E2=80=98systick_read=E2=80=99:
> hw/timer/armv7m_systick.c:81:14: error: =E2=80=98val=E2=80=99 may be used=
 uninitialized in this function [-Werror=3Dmaybe-uninitialized]
>      uint32_t val;
>               ^
> cc1: all warnings being treated as errors
>
> I suspect the trace function could pick up garbage if we take the
> GUEST_ERROR leg and default out....

Indeed, missing 'val =3D 0;' in the default case.

thanks
-- PMM
