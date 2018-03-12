Received: from eggs.gnu.org ([2001:4830:134:3::10]:47360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evNCH-0004VJ-6Q
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:09:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evNCB-0007Hf-Dt
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:09:01 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:41482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evNCB-0007Gu-8q
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:08:55 -0400
Received: by mail-ot0-x242.google.com with SMTP id w38so15151109ota.8
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 06:08:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c4a424b1-b66b-7a6e-e15c-ff34f2d2b3c5@amsat.org>
References: <20180309153654.13518-1-f4bug@amsat.org>
	<20180309153654.13518-6-f4bug@amsat.org>
	<CAFEAcA81Cz2d_7sL1f9piHtGhuYqCWwhV5XkBTFCqOW6Ezv-Ng@mail.gmail.com>
	<c4a424b1-b66b-7a6e-e15c-ff34f2d2b3c5@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Mar 2018 13:08:34 +0000
Message-ID: <CAFEAcA8rDcn5wqfURwwLQ08MU39f+nnnUJGOy5TyvpkhMX+jeQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/8] sdcard: Implement the UHS-I
 SWITCH_FUNCTION entries (Spec v3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair@alistair23.me>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>

On 12 March 2018 at 12:36, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
> On 03/09/2018 06:06 PM, Peter Maydell wrote:
>> On 9 March 2018 at 15:36, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>>> [based on a patch from Alistair Francis <alistair.francis@xilinx.com>
>>>  from qemu/xilinx tag xilinx-v2015.2]
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>>  hw/sd/sd.c         | 148 +++++++++++++++++++++++++++++++++++++++++++++=
--------
>>>  hw/sd/trace-events |   1 +
>>>  2 files changed, 127 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>> index 235e0518d6..b907d62aef 100644
>>> --- a/hw/sd/sd.c
>>> +++ b/hw/sd/sd.c
>>> @@ -124,6 +124,7 @@ struct SDState {
>>>      bool enable;
>>>      uint8_t dat_lines;
>>>      bool cmd_line;
>>> +    bool uhs_enabled;
>>
>> Oh, and what's the difference between s->uhs_enabled =3D false
>> (this patch) and s->uhs_mode =3D UHS_NOT_SUPPORTED (next patch) ?
>>
>> Do we need both? If so, a comment noting the difference would help
>> people to know which one various bits of code should be checking.
>
> Ok.
>
> The 'uhs_mode' is a read-only property before realize().
> Now if the sdcard supports any UHS, the host may negotiate to switch to
> UHS mode.
> To enter this mode with voltage level adjusted, the card needs to
> 'soft-reset' itself in the new mode. We use 'uhs_enabled' to track this
> runtime state. Maybe 'uhs_active' is more explicit?
> I intended to keep the properties vs runtime fields separated in the
> SDState.

Yes, static property vs runtime changeable should indeed be kept
separate -- we should just make sure it's clear which is which,
with a suitable comment and/or field name.

thanks
-- PMM
