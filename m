Received: from eggs.gnu.org ([2001:4830:134:3::10]:36488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gP9MY-0006Ua-J8
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 11:59:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gP9MP-0005Ny-4I
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 11:58:54 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gP9MN-0005Jh-5X
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 11:58:48 -0500
Received: by mail-ot1-x343.google.com with SMTP id u16so2286621otk.8
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 08:58:42 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
References: <20181115192446.17187-1-minyard@acm.org>
	<20181115192446.17187-5-minyard@acm.org>
	<CAFEAcA8uTFRiYZuJx=9o0Bs483TgVt=TTAV50n3JNsZCJaqKfA@mail.gmail.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <f2179250-a92b-ef40-46a5-b403f17e0056@acm.org>
Date: Tue, 20 Nov 2018 10:58:38 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8uTFRiYZuJx=9o0Bs483TgVt=TTAV50n3JNsZCJaqKfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH v2 04/12] i2c: Add a length check to the
 SMBus write handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Corey Minyard <cminyard@mvista.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 11/20/18 9:33 AM, Peter Maydell wrote:
> On 15 November 2018 at 19:24,  <minyard@acm.org> wrote:
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> Avoid an overflow.
>>
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>> ---
>>   hw/i2c/smbus_slave.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
>> index 83ca041b5d..fa988919d8 100644
>> --- a/hw/i2c/smbus_slave.c
>> +++ b/hw/i2c/smbus_slave.c
>> @@ -182,7 +182,11 @@ static int smbus_i2c_send(I2CSlave *s, uint8_t data)
>>       switch (dev->mode) {
>>       case SMBUS_WRITE_DATA:
>>           DPRINTF("Write data %02x\n", data);
>> -        dev->data_buf[dev->data_len++] = data;
>> +        if (dev->data_len >= sizeof(dev->data_buf)) {
>> +            BADF("Too many bytes sent\n");
>> +        } else {
>> +            dev->data_buf[dev->data_len++] = data;
>> +        }
>>           break;
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> What happens on a real device in this situation ?

It's device specific.  Some devices (most eeproms, I suspect) will just keep
taking data, wrapping around when you hit the end of the memory. Some
devices (IPMI BMCs, generally) will ignore the extra data.  Some devices
may return a NAK on a byte if it gets too much data.  The specification
says:

    The slave device detects an invalid command or invalid data. In this
    case the slave
    device must NACK the received byte. The master upon detection of
    this condition
    must generate a STOP condition and retry the transaction.

So a NAK may be appropriate here, but it's kind of fuzzy.  Since generating
a NAK is more complicated, I would guess that most devices don't.

-corey


> thanks
> -- PMM
