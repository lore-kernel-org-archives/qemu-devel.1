Received: from eggs.gnu.org ([2001:4830:134:3::10]:54302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb3Y8-0002P0-DU
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:07:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb3Y2-00046C-MI
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:07:36 -0500
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:41376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eb3Y2-00045w-HR
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:07:30 -0500
Received: by mail-ot0-x231.google.com with SMTP id 44so9552331otk.8
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 04:07:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d7f23db3-6669-76fe-661e-a5b506cfbeaf@amsat.org>
References: <1515506513-31961-1-git-send-email-peter.maydell@linaro.org>
	<d7f23db3-6669-76fe-661e-a5b506cfbeaf@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2018 12:07:09 +0000
Message-ID: <CAFEAcA-bwHPH0W2WDOzoKrvTLff7WS-KN0NpRkP7tR=geL-HSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/4] Reset SD cards attached to
 legacy-API controllers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 9 January 2018 at 16:13, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> Hi Peter,
>
> On 01/09/2018 11:01 AM, Peter Maydell wrote:
>> It turns out that we don't reset the SD card model if it's
>> attached to a legacy-API controller. For new-style controllers
>> where the SD card object is attached to an SD_BUS, the generic
>> qbus infrastructure takes care of ensuring that the card's
>> DeviceState::reset method gets called. But for the legacy
>> API where the card is created by calling sd_init(), the card
>> object has no SD_BUS to plug into, and so the reset function
>> must be called manually.
>>
>> This mostly had no ill effects because a guest OS will typically
>> perform an SD reset command as part of its device driver init
>> sequence. However it does mean that migration won't work, because
>> it's in sd_reset() that we set up the wpgrps_size field, and
>> without that the migration struct on reload won't match.
>>
>> This patchset fixes up the four legacy controllers to call
>> reset on the SD card device in their controller reset functions.
>> The first 3 are cc:stable as migration bugfixes.
>>
>> This fixes https://bugs.launchpad.net/qemu/+bug/1739378
>>
>> Philippe: this probably clashes slightly with your sdcard
>> patchsets (and where you've updated devices to the new APIs
>> it becomes irrelevant), but I think we should apply these
>> first so we can have a simple patch to backport to the stable
>> tree.
>
> Sure, it makes sens.
>
> I didn't test migrating a card (but have a "sdcard migration qtest"
> entry in my TODO).
>
> this series:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Thanks for the review. I've applied this series to target-arm.next
(with the fix to the milkymist commit message and the removal
of s->mod =3D SSI_SD_CMD from the ssi-sd realize function that you
suggested).

-- PMM
