Received: from eggs.gnu.org ([2001:4830:134:3::10]:37014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYwvS-0007hi-B8
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:38:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYwvR-0003cF-8m
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:38:58 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1515506513-31961-1-git-send-email-peter.maydell@linaro.org>
	<1515506513-31961-4-git-send-email-peter.maydell@linaro.org>
	<12647bf7-eb9f-889a-76e0-32fb1f799160@amsat.org>
	<CAFEAcA9Gd6qLqFfrmzj4w69=SozWyP8D5mbGSaGEvw0BhwnyjA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bd8da759-6e40-7fbe-3c1e-a400d9e84d5c@amsat.org>
Date: Tue, 9 Jan 2018 13:38:47 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Gd6qLqFfrmzj4w69=SozWyP8D5mbGSaGEvw0BhwnyjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, qemu-stable <qemu-stable@nongnu.org>


On 01/09/2018 01:28 PM, Peter Maydell wrote:
> On 9 January 2018 at 16:25, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Hi Peter,
>>
>> On 01/09/2018 11:01 AM, Peter Maydell wrote:
>>> Since ssi-sd is still using the legacy SD card API, the SD
>>> card created by sd_init() is not plugged into any bus. This
>>> means that the controller has to reset it manually.
>>>
>>> Failing to do this mostly didn't affect the guest since the
>>> guest typically does a programmed SD card reset as part of
>>> its SD controller driver initialization, but meant that
>>> migration failed because it's only in sd_reset() that we
>>> set up the wpgrps_size field.
>>>
>>> In the case of sd-ssi, we have to implement an entire
>>> reset function since there wasn't one previously, and
>>> that requires a QOM cast macro that got omitted when this
>>> device was QOMified.
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>  hw/sd/ssi-sd.c | 24 +++++++++++++++++++++++-
>>>  1 file changed, 23 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
>>> index 24001dc..30d2a87 100644
>>> --- a/hw/sd/ssi-sd.c
>>> +++ b/hw/sd/ssi-sd.c
>>> @@ -50,6 +50,9 @@ typedef struct {
>>>      SDState *sd;
>>>  } ssi_sd_state;
>>>
>>> +#define TYPE_SSI_SD "ssi-sd"
>>> +#define SSI_SD(obj) OBJECT_CHECK(ssi_sd_state, (obj), TYPE_SSI_SD)
>>> +
>>>  /* State word bits.  */
>>>  #define SSI_SDR_LOCKED          0x0001
>>>  #define SSI_SDR_WP_ERASE        0x0002
>>> @@ -251,6 +254,24 @@ static void ssi_sd_realize(SSISlave *d, Error **errp)
>>>      }
>>>  }
>>>
>>> +static void ssi_sd_reset(DeviceState *dev)
>>> +{
>>> +    ssi_sd_state *s = SSI_SD(dev);
>>> +
>>> +    s->mode = SSI_SD_CMD;

And we can now drop the assignation in realize()

>>> +    s->cmd = 0;
>>
>> Not necessary/useful since s->mode = SSI_SD_CMD.
>>
>>> +    memset(s->cmdarg, 0, sizeof(s->cmdarg));
>>> +    memset(s->response, 0, sizeof(s->response));
>>
>> This might be cleaner to move it in ssi_sd_transfer() case SSI_SD_CMD.
>>
>>> +    s->arglen = 0;
>>
>> Not necessary/useful since s->mode = SSI_SD_CMD.
>>
>>> +    s->response_pos = 0;
>>
>> This might be safer to move this in ssi_sd_transfer() case SSI_SD_CMD.
>>
>>> +    s->stopping = 0;
>>
>> This might be cleaner to move it in ssi_sd_transfer() entry "Special
>> case else s->stopping = 0;"
> 
> I felt it was easier to reason about both (a) whether the reset
> function was correct and (b) what the state of the device might
> be at any point if the reset function just cleared everything
> back to the state it's in when the device is freshly created.

Got it!
