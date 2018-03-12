Received: from eggs.gnu.org ([2001:4830:134:3::10]:49260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evNK6-00032M-5X
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:17:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evNK5-0004eQ-AM
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:17:06 -0400
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:46053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evNK5-0004dU-4x
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:17:05 -0400
Received: by mail-ot0-x235.google.com with SMTP id f11so15176355otj.12
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 06:17:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0cf434fe-a8f3-dc24-4350-197d2d56c4f3@amsat.org>
References: <20180309153654.13518-1-f4bug@amsat.org>
	<20180309153654.13518-6-f4bug@amsat.org>
	<CAFEAcA8jPcjk+sj0FVE8P5dA82GdNDNr-Zg_7T6PGqufr2157A@mail.gmail.com>
	<0cf434fe-a8f3-dc24-4350-197d2d56c4f3@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Mar 2018 13:16:44 +0000
Message-ID: <CAFEAcA_ed2RsYXN5jP2u5L0UYi3XP7MxjjF76RoKsjjwBKtLCw@mail.gmail.com>
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

On 12 March 2018 at 13:03, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
> On 03/09/2018 06:03 PM, Peter Maydell wrote:
>> I think the spec says that if the guest makes an invalid selection
>> for one function in the group then we must ignore all the set values,
>
> ... for the current group? ...
>
>> not just the one that was wrong, so we need to check everything
>> first before we start writing the new values back.
>
> I'm following the "Physical Layer Simplified Specification Version 3.01".
>
>   4.3.10.3 Mode 1 Operation - Set Function
>
>   Switching to a new functionality is done by:
>   =E2=80=A2 When a function cannot be switched because it is busy,
>     the card returns the current function number (not returns 0xF),
>     the other functions in the other groups may still be switched.
>
>   In response to a set function, the switch function will return ...
>   =E2=80=A2 The function that is the result of the switch command. In cas=
e
>     of invalid selection of one function or more, all set values
>     are ignored and no change will be done (identical to the case
>     where the host selects 0xF for all functions groups). The
>     response to an invalid selection of function will be 0xF.
>
> I'm not sure how to interpret this paragraph, I understand it as:
> "all set values are ignored [in the current group]" but this is
> confusing because of the "identical to ... all functions groups".

The command only lets you specify one value function in each
group, so "all set values" must mean "the set values for every
group", I think, and the parenthesised text confirms that --
it should act as if the command specified 0xf for everything.
It's slightly less clear what exactly the response should be:
should it return 0xf for the groups where there was an invalid
selection, and <whatever the current value is> for the groups
where the selection request was ok, or just 0xf for everything ?
(This is probably most easily answered by testing the behaviour
of a real sd card I guess...)

thanks
-- PMM
