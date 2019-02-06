Received: from eggs.gnu.org ([209.51.188.92]:48746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1grKwp-0007ia-OI
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 06:01:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1grKwo-0003aW-Nv
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 06:00:55 -0500
References: <20190127101836.15451-1-sourav.jb1988@gmail.com>
	<33a499ed-6f6a-ccd2-a1f8-48646b6be6c9@redhat.com>
	<05c9ef91-39d7-0579-b007-443748559007@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fd1de933-9547-3ccb-97e4-090820d2ff31@redhat.com>
Date: Wed, 6 Feb 2019 12:00:05 +0100
MIME-Version: 1.0
In-Reply-To: <05c9ef91-39d7-0579-b007-443748559007@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/input/lm832x: set device category of
 lm832x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, kumar sourav <sourav.jb1988@gmail.com>, qemu-trivial@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On 2019-01-28 12:10, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Thomas,
>=20
> On 1/28/19 9:37 AM, Thomas Huth wrote:
>>  Hi,
>>
>> On 2019-01-27 11:18, kumar sourav wrote:
>>> Sets the category of lm832x as DEVICE_CATEGORY_INPUT
>>> Devices should be assigned to one of DEVICE_CATEGORY_XXXX
>>>
>>> Signed-off-by: kumar sourav <sourav.jb1988@gmail.com>
>>> ---
>>>  hw/input/lm832x.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/hw/input/lm832x.c b/hw/input/lm832x.c
>>> index cffbf586d4..07ae5e0aee 100644
>>> --- a/hw/input/lm832x.c
>>> +++ b/hw/input/lm832x.c
>>> @@ -509,6 +509,7 @@ static void lm8323_class_init(ObjectClass *klass,=
 void *data)
>>>      k->recv =3D lm_i2c_rx;
>>>      k->send =3D lm_i2c_tx;
>>>      dc->vmsd =3D &vmstate_lm_kbd;
>>> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>>>  }
>>
>> This device already has DEVICE_CATEGORY_MISC set since it is derived
>> from TYPE_I2C_SLAVE. If you now set another category bit here, the
>> device shows up twice in the output of "-device help". That's not so n=
ice.
>>
>> I see multiple options here:
>>
>> 1) Drop this patch since the device already has a category
>>
>> 2) Make sure to clear_bit() the MISC category here again
>>
>> 3) Remove the set_bit(DEVICE_CATEGORY_MISC, k->categories) in
>>    hw/i2c/core.c - it does not make that much sense to set the
>>    MISC category for an abstract parent class.
>>
>> 4) Introduce a new DEVICE_CATEGORY_I2C which could be used
>>    instead of the DEVICE_CATEGORY_MISC in hw/i2c/core.c
>>
>> One of the last two options sound most appealing to me.
>=20
> Can we go with 0/3/4 together? 0 being this patch:
>=20
>   0) This devices inherited DEVICE_CATEGORY_I2C from his
>      abstract parent, also select the DEVICE_CATEGORY_INPUT
>      bit.

Yes, I guess... Thinking about this again ... dc->categories is a
bitfield, so there is or at least was the original intention that a
device can go into multiple categories. Question: Is this what we want,
and if yes, is everybody fine with the fact that a device shows up
multiple times in the output of "-device help" ? If not, shall we change
the bitfield into a normal enum value?

Anyway, a DEVICE_CATEGORY_I2C is likely a good idea, at least it's
better than MISC here (and we already have DEVICE_CATOGORY_USB, too).
Anybody want to send a patch?

 Thomas
