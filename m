Received: from eggs.gnu.org ([2001:4830:134:3::10]:60119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYwlH-000779-Og
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:28:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYwlG-0001Vy-Os
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:28:27 -0500
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:35833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYwlG-0001V6-Js
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:28:26 -0500
Received: by mail-ot0-x233.google.com with SMTP id q5so11800324oth.2
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 08:28:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <12647bf7-eb9f-889a-76e0-32fb1f799160@amsat.org>
References: <1515506513-31961-1-git-send-email-peter.maydell@linaro.org>
	<1515506513-31961-4-git-send-email-peter.maydell@linaro.org>
	<12647bf7-eb9f-889a-76e0-32fb1f799160@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jan 2018 16:28:05 +0000
Message-ID: <CAFEAcA9Gd6qLqFfrmzj4w69=SozWyP8D5mbGSaGEvw0BhwnyjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 3/4] hw/sd/ssi-sd: Reset SD card
 on controller reset
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

On 9 January 2018 at 16:25, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> Hi Peter,
>
> On 01/09/2018 11:01 AM, Peter Maydell wrote:
>> Since ssi-sd is still using the legacy SD card API, the SD
>> card created by sd_init() is not plugged into any bus. This
>> means that the controller has to reset it manually.
>>
>> Failing to do this mostly didn't affect the guest since the
>> guest typically does a programmed SD card reset as part of
>> its SD controller driver initialization, but meant that
>> migration failed because it's only in sd_reset() that we
>> set up the wpgrps_size field.
>>
>> In the case of sd-ssi, we have to implement an entire
>> reset function since there wasn't one previously, and
>> that requires a QOM cast macro that got omitted when this
>> device was QOMified.
>>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  hw/sd/ssi-sd.c | 24 +++++++++++++++++++++++-
>>  1 file changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
>> index 24001dc..30d2a87 100644
>> --- a/hw/sd/ssi-sd.c
>> +++ b/hw/sd/ssi-sd.c
>> @@ -50,6 +50,9 @@ typedef struct {
>>      SDState *sd;
>>  } ssi_sd_state;
>>
>> +#define TYPE_SSI_SD "ssi-sd"
>> +#define SSI_SD(obj) OBJECT_CHECK(ssi_sd_state, (obj), TYPE_SSI_SD)
>> +
>>  /* State word bits.  */
>>  #define SSI_SDR_LOCKED          0x0001
>>  #define SSI_SDR_WP_ERASE        0x0002
>> @@ -251,6 +254,24 @@ static void ssi_sd_realize(SSISlave *d, Error **err=
p)
>>      }
>>  }
>>
>> +static void ssi_sd_reset(DeviceState *dev)
>> +{
>> +    ssi_sd_state *s =3D SSI_SD(dev);
>> +
>> +    s->mode =3D SSI_SD_CMD;
>
>> +    s->cmd =3D 0;
>
> Not necessary/useful since s->mode =3D SSI_SD_CMD.
>
>> +    memset(s->cmdarg, 0, sizeof(s->cmdarg));
>> +    memset(s->response, 0, sizeof(s->response));
>
> This might be cleaner to move it in ssi_sd_transfer() case SSI_SD_CMD.
>
>> +    s->arglen =3D 0;
>
> Not necessary/useful since s->mode =3D SSI_SD_CMD.
>
>> +    s->response_pos =3D 0;
>
> This might be safer to move this in ssi_sd_transfer() case SSI_SD_CMD.
>
>> +    s->stopping =3D 0;
>
> This might be cleaner to move it in ssi_sd_transfer() entry "Special
> case else s->stopping =3D 0;"

I felt it was easier to reason about both (a) whether the reset
function was correct and (b) what the state of the device might
be at any point if the reset function just cleared everything
back to the state it's in when the device is freshly created.

thanks
-- PMM
