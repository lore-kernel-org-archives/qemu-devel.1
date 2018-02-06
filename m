Received: from eggs.gnu.org ([2001:4830:134:3::10]:58626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ej2xK-0003JR-E5
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 08:06:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ej2xJ-0004rh-CR
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 08:06:38 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:38226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ej2xJ-0004qt-7a
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 08:06:37 -0500
Received: by mail-ot0-x242.google.com with SMTP id h14so847988otj.5
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 05:06:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5a373a1f-6289-a216-cd02-254402069c12@amsat.org>
References: <20180123035837.16578-1-f4bug@amsat.org>
	<20180123035837.16578-5-f4bug@amsat.org>
	<CAKmqyKMoUcPhkr8bM1DU1QeBaRbJ9kAfOp_j-vFxf1y8p=1AbA@mail.gmail.com>
	<5a373a1f-6289-a216-cd02-254402069c12@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Feb 2018 13:06:16 +0000
Message-ID: <CAFEAcA8UzFXVyWKHKdOtjtoPjKCJ-dxu_MSZD4_1i3Hoge7eKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/6] hw/sd/pl181: expose a SDBus and
 connect the SDCard to it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Michael Walle <michael@walle.cc>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Stefan Weil <sw@weilnetz.de>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "open list:ARM PrimeCell and..." <qemu-arm@nongnu.org>

On 6 February 2018 at 12:43, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> Hi Alistair,
>
> On 01/31/2018 01:41 PM, Alistair Francis wrote:
>> On Mon, Jan 22, 2018 at 7:58 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsa=
t.org> wrote:
>>> using the sdbus_*() API.
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>>  hw/sd/pl181.c | 31 ++++++++++++++++++++-----------
>>>  1 file changed, 20 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
>>> index 3ba1f7dd23..ce696c5d7d 100644
>>> --- a/hw/sd/pl181.c
>>> +++ b/hw/sd/pl181.c
>>> @@ -33,6 +33,7 @@ typedef struct PL181State {
>>>      SysBusDevice parent_obj;
>>>
>>>      MemoryRegion iomem;
>>> +    SDBus sdbus;
>>>      SDState *card;
>>
>> Shouludn't card be removed?
>
> Not yet :( It is still used by sd_set_cb() in pl181_reset().

I think you have to change that sd_set_cb() code now.
If you look at sd_cardchange() it uses "is this SD card
object on an SDBus" to determine whether to notify the
controller via the old-API IRQ lines, or using the
set_inserted() and set_readonly() callbacks on the SDBusClass.

> In my first approach [1] I added the SDBus SLAVE/MASTER interfaces and
> the cards inserted/readonly signals were only accessible by the bus, not
> the HCI, leaving the SDCard objects only pluggable to SDBus (removing
> the sdbus_reparent_card() need). But since it was out of scope for the
> UHS cards goal, I kept it for later.

How do you manage to get rid of sdbus_reparent_card()? Raspi
needs it for its weirdo multiplexed SD controller setup, and
AFAIK we don't have a way to say "this thing is hotpluggable
but not by the user" yet...

PS: have you checked that these sd card refactorings don't
accidentally break the monitor "change" and "eject" commands
operating on SD cards ? (They are a bit weird because they
affect which backing file is attached to the SD card object,
rather than actually deleting and recreating the SD card
object.)

thanks
-- PMM
