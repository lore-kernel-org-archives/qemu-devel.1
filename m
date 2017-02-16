Received: from eggs.gnu.org ([2001:4830:134:3::10]:45681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceMmn-0007ar-9b
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:11:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceMmm-0006pK-29
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:11:53 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:37067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ceMml-0006op-SN
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:11:51 -0500
Received: by mail-wm0-x22d.google.com with SMTP id v77so16114999wmv.0
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 06:11:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-PFJp_9=NOCFqiQp=xF6Y-TnmE3bfU3zDa6xH7nK2Zfg@mail.gmail.com>
References: <1486065742-28639-1-git-send-email-peter.maydell@linaro.org>
	<1486065742-28639-4-git-send-email-peter.maydell@linaro.org>
	<87mvdnvcxx.fsf@linaro.org>
	<CAFEAcA-PFJp_9=NOCFqiQp=xF6Y-TnmE3bfU3zDa6xH7nK2Zfg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Feb 2017 14:11:29 +0000
Message-ID: <CAFEAcA8X1qvweDHBWQjZwH68xWdn4K+Wfqv0yRhjM5QCxd=VBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/9] armv7m: Rewrite NVIC to not use any
 GIC code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Michael Davidsaver <mdavidsaver@gmail.com>, Liviu Ionescu <ilg@livius.net>

On 15 February 2017 at 13:34, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
> On 15 February 2017 at 12:46, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>> +/* Return the value of the ISCR RETTOBASE bit:
>>> + * 1 if there is exactly one active exception
>>> + * 0 if there is more than one active exception
>>> + * UNKNOWN if there are no active exceptions (we choose 0)
>>> + */
>>
>> This doesn't match what the ARMv7M ARM says (for Handler mode):
>>
>>   0 There is an active exception other than the exception shown by IPSR.
>>   1 There is no active exception other than any exception shown by IPSR.
>
> They're only different if the guest code has managed
> to deactivate the IPSR exception without leaving the
> exception handler. This is bogus guest code and will cause
> an exception-return-integrity-check to fail when the guest
> exits the handler. It's also pretty hard to do: the only
> method is to clear the SHCSR bits for those few exceptions
> which report their active state there.
>
> Otherwise "no active exceptions" =3D> not in handler mode;
> "more than 1 active exception" =3D> IPSR exception and another;
> "exactly one active exception" =3D> the IPSR exception
>
> I would be unsurprised to find that the documentation of the
> RETTOBASE bit was just phrased in a way that forgot about
> the possible effect of the deactivated-your-own-exception
> corner case. I'll investigate a bit more what's going on
> here and whether eg the v8M ARM ARM nails down the behaviour
> more precisely, though.

The v8M ARM ARM defines RETTOBASE as:
Handler mode:
 0: "there is more than one active exception"
 1: "there is only one active exception"
Thread mode:
 UNKNOWN

The Cortex-M3 Devices Generic User Guide
http://infocenter.arm.com/help/topic/com.arm.doc.dui0552a/Cihfaaha.html
defines RETTOBASE as:
 0 =3D there are preempted active exceptions to execute
 1 =3D there are no active exceptions, or the currently-executing
     exception is the only active exception.
(ie it doesn't have Thread mode giving an UNKNOWN value)

I haven't actually checked real hardware behaviour, but I think
we can fairly safely implement this as not checking the IPSR
exception field. (We might as well go with the "reads 1 in
handler mode" choice of UNKNOWN that the M3 documents, though.)

thanks
-- PMM
