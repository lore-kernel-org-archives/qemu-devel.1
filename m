Received: from eggs.gnu.org ([2001:4830:134:3::10]:55279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYaFY-0006sg-AN
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYaFX-0005Za-Gw
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:58:28 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:39033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYaFX-0005XR-8d
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:58:27 -0400
Received: by mail-oi0-x241.google.com with SMTP id 18-v6so5854170oiq.6
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 09:58:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7b97505c-5391-02f3-5abb-daa73ec2419d@amsat.org>
References: <20180626180324.5537-1-peter.maydell@linaro.org>
	<7b97505c-5391-02f3-5abb-daa73ec2419d@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Jun 2018 17:58:06 +0100
Message-ID: <CAFEAcA-B9GdAa01Ny=Y0mx0Ush8eV9r3xKS2EdnL_x2gHgAFJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] sd: Don't trace SDRequest crc field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 26 June 2018 at 19:20, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> On 06/26/2018 03:03 PM, Peter Maydell wrote:
>> We don't actually implement SD command CRC checking, because
>> for almost all of our SD controllers the CRC generation is
>> done in hardware, and so modelling CRC generation and checking
>> would be a bit pointless. (The exception is that milkymist-memcard
>> makes the guest software compute the CRC.)
>>
>> As a result almost all of our SD controller models don't bother
>> to set the SDRequest crc field, and the SD card model doesn't
>> check it. So the tracing of it in sdbus_do_command() provokes
>> Coverity warnings about use of uninitialized data.
>>
>> Drop the CRC field from the trace; we can always add it back
>> if and when we do anything useful with the CRC.
>>
>> Fixes Coverity issues 1386072, 1386074, 1386076, 1390571.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> We might also want to try to improve our CRC handling
>> (eg so that the controller can say "I have not set the CRC,
>> don't bother checking it" or "I have set the CRC, do check
>> it because it's come from the guest software"), but let's
>> put in the simple tweak to make Coverity happy for the moment.
>
> Thanks for this simple patch... So simple I couldn't even think of it...
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Thanks; applied to target-arm.next.

-- PMM
