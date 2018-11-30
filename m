Received: from eggs.gnu.org ([2001:4830:134:3::10]:60245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gSnvT-0005ax-Vx
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 13:54:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gSnvL-0002HE-L8
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 13:54:07 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39623)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gSnvL-0002H3-F0
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 13:53:59 -0500
Received: by mail-oi1-x241.google.com with SMTP id i6so5595687oia.6
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 10:53:59 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
References: <20181126200435.23408-1-minyard@acm.org>
	<20181126200435.23408-5-minyard@acm.org>
	<CAFEAcA93S-9ujYS1jTw8g-sn+FMofxQmajM7nrfORNh_3rkbLA@mail.gmail.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <ef3ef7cc-4801-c054-c4c4-e585e8881bcb@acm.org>
Date: Fri, 30 Nov 2018 12:53:55 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA93S-9ujYS1jTw8g-sn+FMofxQmajM7nrfORNh_3rkbLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH v3 04/16] i2c: Don't check return value
 from i2c_recv()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>

On 11/30/18 11:25 AM, Peter Maydell wrote:
> On Mon, 26 Nov 2018 at 20:04, <minyard@acm.org> wrote:
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> i2c_recv() cannot fail, so there is no need to check the return
>> value.  It also returns unt8_t, so comparing with < 0 is not
>> meaningful.
>>
>> Fix up various I2C controllers to remove the unneeded code.
>>
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> diff --git a/hw/i2c/exynos4210_i2c.c b/hw/i2c/exynos4210_i2c.c
>> index c96fa7d7be..43f284eab7 100644
>> --- a/hw/i2c/exynos4210_i2c.c
>> +++ b/hw/i2c/exynos4210_i2c.c
>> @@ -106,12 +106,12 @@ static inline void exynos4210_i2c_raise_interrupt(Exynos4210I2CState *s)
>>   static void exynos4210_i2c_data_receive(void *opaque)
>>   {
>>       Exynos4210I2CState *s = (Exynos4210I2CState *)opaque;
>> -    int ret;
>> +    uint8_t ret;
>>
>>       s->i2cstat &= ~I2CSTAT_LAST_BIT;
>>       s->scl_free = false;
>>       ret = i2c_recv(s->bus);
>> -    if (ret < 0 && (s->i2ccon & I2CCON_ACK_GEN)) {
>> +    if (s->i2ccon & I2CCON_ACK_GEN) {
>>           s->i2cstat |= I2CSTAT_LAST_BIT;  /* Data is not acknowledged */
> Previously the code was doing this only if i2c_recv()
> failed (returned a negative value) and ACK_GEN was set.
> i2c_recv() can never fail, so this if() {} branch should
> be deleted entirely ("false && something" simplifies
> to "false", not "something").

Oops, yes.  Plus you can just remove the ret variable and simplify
this a lot.  Thanks for finding this.

-corey


>
>>       } else {
>>           s->i2cds = ret;
> The rest of the patch looks good.
>
> thanks
> -- PMM
