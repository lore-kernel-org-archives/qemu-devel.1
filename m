Received: from eggs.gnu.org ([2001:4830:134:3::10]:43829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cminyard@mvista.com>) id 1cIyPB-0002xv-EY
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 08:55:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cminyard@mvista.com>) id 1cIyPA-0006C2-8x
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 08:55:05 -0500
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:33767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cminyard@mvista.com>) id 1cIyPA-0006A9-1V
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 08:55:04 -0500
Received: by mail-oi0-x22e.google.com with SMTP id w63so145463056oiw.0
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 05:55:02 -0800 (PST)
References: <20161123194605.94717-1-flus@cesar.org.br>
	<20161129193052.11736-1-flus@cesar.org.br>
	<CAFEAcA--cM3Sn+Y4RA8BwsPCOWsJEPbQ3Npue32RPa7wLDCz2A@mail.gmail.com>
	<1482112026.17769.25.camel@au1.ibm.com>
From: Corey Minyard <cminyard@mvista.com>
Message-ID: <f4e17469-ae67-271e-0645-b069df34e0f9@mvista.com>
Date: Mon, 19 Dec 2016 07:55:00 -0600
MIME-Version: 1.0
In-Reply-To: <1482112026.17769.25.camel@au1.ibm.com>
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
To: Alastair D'Silva <alastair@au1.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, Fabio Urquiza <flus@cesar.org.br>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 12/18/2016 07:47 PM, Alastair D'Silva wrote:
> On Fri, 2016-12-16 at 17:35 +0000, Peter Maydell wrote:
>> (added a couple of people to cc who might have an opinion on the i2c
>> protocol questions below)
> I'm certainly no expert, but I'll try :)

I know a little bit and I've implemented some stuff, so I'll try, too :).

>> On 29 November 2016 at 19:30, Fabio Urquiza <flus@cesar.org.br>
>> wrote:
> <snip>
<snip> some more
>> For recv I'm less sure how it ought to work, so if you can explain
>> in terms of the i2c protocol what slave h/w behaviour we're trying
>> to emulate that would help. At what points in the protocol can
>> the slave return a NAK?
>>
>> Our current API seems to envisage that the slave can return a
>> negative value from I2CSlaveClass::recv instead of a data byte,
>> but I'm not sure what this means in the i2c protocol.
> Negative values are propagated upwards, where they are treated as
> errors, eg, in hw/i2c/aspeed_i2c.c:aspeed_i2c_bus_handle_cmd():
>
> int ret = i2c_recv(bus->bus);
> if (ret < 0) {
>      qemu_log_mask(LOG_GUEST_ERROR, "%s: read failed\n", __func__);
>      ret = 0xff;
> }
>
> The call to i2c_recv is too late to issue the NAK, I believe they occur
> during the start_transfer() call.

Indeed, it is.  On the wire, a NAK after the address bits have been sent 
terminates
the transaction normally.

>
>> If I understand your patch correctly, this is adding support
>> for the slave refusing to ACK when the master sends out the
>> slave address and r/w bit. I think that makes sense, but rather
>> than having a state flag in the I2CSlave struct, we should
>> change the prototype of the I2CSlaveClass event method so that
>> it can return a value indicating ack or nak.
>>
> Hmm, this could end up being quite an invasive change, but ultimately
> more elegant. I'm not sure which way the community prefers.

I have a patch that adds a check_event() handler along side the event() 
handler.
If a device wants to send a NAK, it can implement check_event() instead of
event() and return non-zero to NAK.

I toyed with just changing all the event() calls, but there are a 
bunch.  This seemed
like the better approach.  I can send if you like.

-corey

>> thanks
>> -- PMM
