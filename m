Received: from eggs.gnu.org ([209.51.188.92]:56903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1go4nx-0006VK-6j
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:10:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1go4nr-0005hm-LG
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:10:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1go4nq-0005hK-RT
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:10:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so17532517wrx.9
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 03:10:10 -0800 (PST)
References: <20190127101836.15451-1-sourav.jb1988@gmail.com>
	<33a499ed-6f6a-ccd2-a1f8-48646b6be6c9@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <05c9ef91-39d7-0579-b007-443748559007@redhat.com>
Date: Mon, 28 Jan 2019 12:10:07 +0100
MIME-Version: 1.0
In-Reply-To: <33a499ed-6f6a-ccd2-a1f8-48646b6be6c9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Thomas Huth <thuth@redhat.com>, kumar sourav <sourav.jb1988@gmail.com>, qemu-trivial@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org

Hi Thomas,

On 1/28/19 9:37 AM, Thomas Huth wrote:
>  Hi,
> 
> On 2019-01-27 11:18, kumar sourav wrote:
>> Sets the category of lm832x as DEVICE_CATEGORY_INPUT
>> Devices should be assigned to one of DEVICE_CATEGORY_XXXX
>>
>> Signed-off-by: kumar sourav <sourav.jb1988@gmail.com>
>> ---
>>  hw/input/lm832x.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/input/lm832x.c b/hw/input/lm832x.c
>> index cffbf586d4..07ae5e0aee 100644
>> --- a/hw/input/lm832x.c
>> +++ b/hw/input/lm832x.c
>> @@ -509,6 +509,7 @@ static void lm8323_class_init(ObjectClass *klass, void *data)
>>      k->recv = lm_i2c_rx;
>>      k->send = lm_i2c_tx;
>>      dc->vmsd = &vmstate_lm_kbd;
>> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>>  }
> 
> This device already has DEVICE_CATEGORY_MISC set since it is derived
> from TYPE_I2C_SLAVE. If you now set another category bit here, the
> device shows up twice in the output of "-device help". That's not so nice.
> 
> I see multiple options here:
> 
> 1) Drop this patch since the device already has a category
> 
> 2) Make sure to clear_bit() the MISC category here again
> 
> 3) Remove the set_bit(DEVICE_CATEGORY_MISC, k->categories) in
>    hw/i2c/core.c - it does not make that much sense to set the
>    MISC category for an abstract parent class.
> 
> 4) Introduce a new DEVICE_CATEGORY_I2C which could be used
>    instead of the DEVICE_CATEGORY_MISC in hw/i2c/core.c
> 
> One of the last two options sound most appealing to me.

Can we go with 0/3/4 together? 0 being this patch:

  0) This devices inherited DEVICE_CATEGORY_I2C from his
     abstract parent, also select the DEVICE_CATEGORY_INPUT
     bit.
