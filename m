Received: from eggs.gnu.org ([2001:4830:134:3::10]:53237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cminyard@mvista.com>) id 1cJ0g6-0005sv-HV
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 11:20:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cminyard@mvista.com>) id 1cJ0g2-0006uA-3K
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 11:20:42 -0500
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:33296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cminyard@mvista.com>) id 1cJ0g1-0006tL-Nn
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 11:20:37 -0500
Received: by mail-oi0-x230.google.com with SMTP id w63so149960428oiw.0
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 08:20:37 -0800 (PST)
References: <20161123194605.94717-1-flus@cesar.org.br>
	<20161129193052.11736-1-flus@cesar.org.br>
	<CAFEAcA--cM3Sn+Y4RA8BwsPCOWsJEPbQ3Npue32RPa7wLDCz2A@mail.gmail.com>
	<1482112026.17769.25.camel@au1.ibm.com>
	<f4e17469-ae67-271e-0645-b069df34e0f9@mvista.com>
	<CAFEAcA84Ab393fUB=UKDqtJYpZhHUEsZp6wEV3PpdjqCAfvuew@mail.gmail.com>
From: Corey Minyard <cminyard@mvista.com>
Message-ID: <7a19e318-5f5f-92cc-0e66-b7ea44d4f9e3@mvista.com>
Date: Mon, 19 Dec 2016 10:20:35 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA84Ab393fUB=UKDqtJYpZhHUEsZp6wEV3PpdjqCAfvuew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/2] Add Atmel I2C TPM AT97SC3204T
 emulated device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alastair D'Silva <alastair@au1.ibm.com>, Fabio Urquiza <flus@cesar.org.br>, QEMU Developers <qemu-devel@nongnu.org>

On 12/19/2016 09:31 AM, Peter Maydell wrote:
> On 19 December 2016 at 13:55, Corey Minyard <cminyard@mvista.com> wrote:
>> On 12/18/2016 07:47 PM, Alastair D'Silva wrote:
>>> On Fri, 2016-12-16 at 17:35 +0000, Peter Maydell wrote:
>>>> Our current API seems to envisage that the slave can return a
>>>> negative value from I2CSlaveClass::recv instead of a data byte,
>>>> but I'm not sure what this means in the i2c protocol.
>>> Negative values are propagated upwards, where they are treated as
>>> errors, eg, in hw/i2c/aspeed_i2c.c:aspeed_i2c_bus_handle_cmd():
>>>
>>> int ret = i2c_recv(bus->bus);
>>> if (ret < 0) {
>>>       qemu_log_mask(LOG_GUEST_ERROR, "%s: read failed\n", __func__);
>>>       ret = 0xff;
>>> }
>>>
>>> The call to i2c_recv is too late to issue the NAK, I believe they occur
>>> during the start_transfer() call.
> OK, so if returning negative values from i2c_recv() isn't
> the device saying "I am NAKing this", what *do* they mean?

It actually makes no sense.  In real I2C hardware, the receiver of the 
byte always
does the ACK/NAK.  The NAK is sent by the receiver of the data to signal 
that it
has finished the transfer.

So when i2c_recv() is called, it's actually the I2c device doing a 
transmit and the
i2c master receiving the data.  So the device cannot send a NAK in that 
scenario.

The start conditions and address are always send by the master to the 
device, so
it makes sense for the start events to be able to return a NAK.

And for i2c_send(), the device should respond with a NAK to terminate the
transfer.  So it makes sense for i2c_send() to be able to return a NAK.  
This
doesn't appear to be properly implemented in a number of places.

>>>> If I understand your patch correctly, this is adding support
>>>> for the slave refusing to ACK when the master sends out the
>>>> slave address and r/w bit. I think that makes sense, but rather
>>>> than having a state flag in the I2CSlave struct, we should
>>>> change the prototype of the I2CSlaveClass event method so that
>>>> it can return a value indicating ack or nak.
>>>>
>>> Hmm, this could end up being quite an invasive change, but ultimately
>>> more elegant. I'm not sure which way the community prefers.
>>
>> I have a patch that adds a check_event() handler along side the event()
>> handler.
>> If a device wants to send a NAK, it can implement check_event() instead of
>> event() and return non-zero to NAK.
>>
>> I toyed with just changing all the event() calls, but there are a bunch.
>> This seemed
>> like the better approach.  I can send if you like.
> It looks like there are only a dozen or so. I think it would
> be better for the long term just to change the event calls.
> We should also document in the comments in the I2CSlaveClass
> struct definition exactly what the semantics of the various
> functions are.

Ok, my memory didn't serve me correctly.  I'll rework my patch for that.

Thanks,

-corey

> thanks
> -- PMM
