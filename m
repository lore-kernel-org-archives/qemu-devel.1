Received: from eggs.gnu.org ([2001:4830:134:3::10]:37181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cW4WR-0004in-9n
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:04:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cW4WQ-0002K3-H0
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:04:43 -0500
Received: from mail-vk0-x22b.google.com ([2607:f8b0:400c:c05::22b]:33746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cW4WQ-0002Jl-CM
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:04:42 -0500
Received: by mail-vk0-x22b.google.com with SMTP id k127so115942830vke.0
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 09:04:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87r33s9yzr.fsf@linaro.org>
References: <1484937883-1068-1-git-send-email-peter.maydell@linaro.org>
	<1484937883-1068-6-git-send-email-peter.maydell@linaro.org>
	<87r33s9yzr.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jan 2017 17:04:21 +0000
Message-ID: <CAFEAcA9O+fOeMFvX3tcBVsgbZcrnzDgPz69Kin4gg3fmyJR8wA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 5/6] armv7m: Fix reads of
 CONTROL register bit 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Liviu Ionescu <ilg@livius.net>, Michael Davidsaver <mdavidsaver@gmail.com>, "patches@linaro.org" <patches@linaro.org>

On 24 January 2017 at 16:58, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>> --- a/target/arm/machine.c
>> +++ b/target/arm/machine.c
>> @@ -96,15 +96,13 @@ static bool m_needed(void *opaque)
>>
>>  static const VMStateDescription vmstate_m =3D {
>>      .name =3D "cpu/m",
>> -    .version_id =3D 1,
>> -    .minimum_version_id =3D 1,
>> +    .version_id =3D 2,
>> +    .minimum_version_id =3D 2,
>>      .needed =3D m_needed,
>>      .fields =3D (VMStateField[]) {
>> -        VMSTATE_UINT32(env.v7m.other_sp, ARMCPU),
>>          VMSTATE_UINT32(env.v7m.vecbase, ARMCPU),
>>          VMSTATE_UINT32(env.v7m.basepri, ARMCPU),
>>          VMSTATE_UINT32(env.v7m.control, ARMCPU),
>> -        VMSTATE_INT32(env.v7m.current_sp, ARMCPU),
>>          VMSTATE_INT32(env.v7m.exception, ARMCPU),
>>          VMSTATE_END_OF_LIST()
>>      }
>
> Not that it matters for this but is there a way to add another level of
> indirection to the reading and writing of these fields to keep the same
> migration format?

It's possible. One approach would be to make the fields
versioned, so that if the source doesn't have them they stay
at whatever the CPU's reset values are. Or you could have
them in a separate vmstate subsection with a needed function
that does something clever. But since we don't claim to
support cross-version migration for M profile yet (and I
suspect also that none of our M profile boards have working
migration in all the devices) I took the easy route of
just bumping the version_id on this subfield. (It doesn't
affect migration compat for anything that's not M profile.)

thanks
-- PMM
