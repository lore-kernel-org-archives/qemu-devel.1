Received: from eggs.gnu.org ([2001:4830:134:3::10]:49177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZsJf-0002NM-9A
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 01:23:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZsJc-0005jV-3u
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 01:23:31 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-12-f4bug@amsat.org>
	<CAFEAcA9nkfXfXn3fiZMS3dnrp7v8NVysqFS+pb-Ehf=+xOFfWQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d8f9188c-d60f-b873-d012-1d2436fdbaac@amsat.org>
Date: Tue, 25 Jul 2017 02:23:23 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9nkfXfXn3fiZMS3dnrp7v8NVysqFS+pb-Ehf=+xOFfWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 11/35] i2c/exynos4210: correctly
 check i2c_recv() return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 07/24/2017 06:13 PM, Peter Maydell wrote:
> On 24 July 2017 at 19:27, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> i2c_recv() returns -1 on error, if the I2CCON_ACK_GEN bit was not set this code
>> was setting i2cds = -1.
>>
>> i2c/exynos4210_i2c.c:117:20: warning: Loss of sign in implicit conversion
>>          s->i2cds = ret;
>>                     ^~~
>>
>> Reported-by: Clang Static Analyzer
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   hw/i2c/exynos4210_i2c.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/i2c/exynos4210_i2c.c b/hw/i2c/exynos4210_i2c.c
>> index c96fa7d7be..4424dbd233 100644
>> --- a/hw/i2c/exynos4210_i2c.c
>> +++ b/hw/i2c/exynos4210_i2c.c
>> @@ -111,10 +111,12 @@ static void exynos4210_i2c_data_receive(void *opaque)
>>       s->i2cstat &= ~I2CSTAT_LAST_BIT;
>>       s->scl_free = false;
>>       ret = i2c_recv(s->bus);
>> -    if (ret < 0 && (s->i2ccon & I2CCON_ACK_GEN)) {
>> -        s->i2cstat |= I2CSTAT_LAST_BIT;  /* Data is not acknowledged */
>> -    } else {
>> +    if (ret >= 0) {
>>           s->i2cds = ret;
>> +    } else {
>> +        if (s->i2ccon & I2CCON_ACK_GEN) {
>> +            s->i2cstat |= I2CSTAT_LAST_BIT;  /* Data is not acknowledged */
>> +        }
>>       }
>>       exynos4210_i2c_raise_interrupt(s);
>>   }
>> --
> 
> Have you checked this change against the data sheet for
> the device?

Here is the relevant part of the Exynos4210_UM DS:

[*] 14.3.5 Data Transfer Format
... If the I2C-bus is operating in Master mode, master transmits the 
address field. Each byte should be followed by an acknowledgement (ACK) bit.

[*] 14.3.6 ACK Signal Transmission
To complete a one-byte transfer operation, the receiver sends an ACK bit 
to the transmitter. The ACK pulse occurs at the ninth clock of the SCL 
line. ...
The software (I2CSTAT) enables or disables ACK bit transmit function. 
However, the ACK pulse on the ninth clock of SCL is required to complete 
the one-byte data transfer operation.

[*] 14.3.9 Abort Conditions
If a slave receiver cannot acknowledge the confirmation of the slave 
address, it holds the level of the SDA line High. In this case, the 
master generates a Stop condition and cancels the transfer.
If a master receiver is involved in the aborted transfer, it signals the 
end of slave transmit operation by canceling the generation of an ACK 
after the last data byte received from the slave. The slave transmitter 
releases the SDA to allow a master to generate a Stop condition.

I2C-bus last-received bit status flag bit. (I2CSTAT_LAST_BIT)
0 = Last-received bit is 0 (ACK was received).
1 = Last-received bit is 1 (ACK was not received).

An I2C-bus interrupt occurs if 1) if a 1-byte transmit or receive 
operation is complete. In other words, ack period is finished. 2) A 
general call or a slave address match occurs, 3) Bus arbitration fails.

--

So the current code is not wrong and matches the datashit, crap is 
shifted into I2CDS and the guest has to poll I2CSTAT to check the peer 
ACK... Still it is weird to shift 0xff as of the current implementation, 
but it might have some usefulness while debugging, who knows...

I might add few comments in that file during 2.11 cycle.

Thank for the review!

Patch dropped.

Regards,

Phil.
