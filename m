Received: from eggs.gnu.org ([2001:4830:134:3::10]:41779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHwPm-0008NY-L8
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 12:35:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHwPl-0001dK-7H
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 12:35:26 -0500
Received: from mail-ua0-x22e.google.com ([2607:f8b0:400c:c08::22e]:34536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cHwPl-0001cl-2g
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 12:35:25 -0500
Received: by mail-ua0-x22e.google.com with SMTP id 51so44796335uai.1
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 09:35:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161129193052.11736-1-flus@cesar.org.br>
References: <20161123194605.94717-1-flus@cesar.org.br>
	<20161129193052.11736-1-flus@cesar.org.br>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Dec 2016 17:35:03 +0000
Message-ID: <CAFEAcA--cM3Sn+Y4RA8BwsPCOWsJEPbQ3Npue32RPa7wLDCz2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Fabio Urquiza <flus@cesar.org.br>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Corey Minyard <cminyard@mvista.com>, Alastair D'Silva <alastair@d-silva.org>

(added a couple of people to cc who might have an opinion on the i2c
protocol questions below)

On 29 November 2016 at 19:30, Fabio Urquiza <flus@cesar.org.br> wrote:
> ### Overview ###
>
> The TPM passthrough feature allow a developer to test TPM functionalities,
> like Measure Boot, without the need to tamper with critical parts of the
> host machine, ie. bootloader. It has been implemented to the x86 architecture
> and have the same interface that is provided to PC machines: TPM TIS.
>
> With the growing of use of the ARM server machines, also comes the need to
> reuse the same security features that are present in the in the PC server
> environment. So comes the need to use TPM devices in the ARM architecture.
>
> This patchset provides a new frontend to the QEMU TPM passthrough with an
> interface suitable to communicate with an ARM based machine.

Thanks for this patchset (and apologies for not getting to it
earlier). Unfortunately I'm completely unfamiliar with TPM, so
reviewing this is going to be difficult.

> ### Technical details ###
>
> The TPM devices on the PC architecture are integrated in a way that the
> interface to it is made using an abstraction layer provided by the BIOS/UFI
> firmware. That interface is not available to ARM machines, therefore a new
> QEMU front end with a more suitable interface needed to be developed. The
> options based on the available TPM devices in the market were I2C and SPI.
> To make the choice, we look into the supported TPM drivers available to
> ARM architecture in the Linux Kernel. One of the simplest drivers was the
> ATMEL I2C TPM AT97SC3204T, so that was our target for the emulation.
>
> We created a file called tpm_i2c_atmel.c based on the already available
> tpm_tis.c, registering as a I2C_SLAVE_CLASS and calling the tpm_backend
> functions.

I guess my primary question here is: is an I2C device going to be
the way that TPM is exposed on ARM hardware? If actual servers are
going to do something else then there's limited benefit to
implementing this in QEMU. (On the other hand, having this be
just-another-i2c-slave means that adding it to QEMU isn't going
to add maintenance complication in cases where it isn't used.)

> One of the problems we had to address is regarding the behavior of the
> ATMEL I2C TPM AT97SC3204T Linux driver. After the driver sends a request
> to the TPM, it keeps polling the device with I2C read request. The real
> AT97SC3204T hardware ignore those requests while the response is not ready
> simply by not ACKing the I2C read on its address. When the response is
> ready it will ACK the request and proceed writing the response in the wire.
>
> The QEMU I2C API does not provide a way to not ACK I2C requests when the
> device is not ready to transmit. In fact, if the device has been configured
> in the virtual machine, QEMU will automatically ACK every request without
> asking for the device permission for it. Therefore we created a flag in
> the I2CSlave struct that tells the I2C subsystem that the device is busy
> and not ready to ACK a I2C transfer. We understand that it could not be
> the best solution to the problem, but it appears to be the solution that
> have the least impact in the code overall. Suggestions on a different
> approach would be welcome.

I2C slaves definitely ought to be able to NAK I2C requests. This
is possible for sends, ie data sent from the master to the slave
(the slave just returns non-zero from its I2CSlaveClass::send function).
In i2c protocol terms, this corresponds to the slave generating a NAK
(by not taking SDA low) after the master has sent a byte of data.
The bitbang_i2c code used by versatile was buggy in handling NAKs
for sends until commit 9706e0162d24.

For recv I'm less sure how it ought to work, so if you can explain
in terms of the i2c protocol what slave h/w behaviour we're trying
to emulate that would help. At what points in the protocol can
the slave return a NAK?

Our current API seems to envisage that the slave can return a
negative value from I2CSlaveClass::recv instead of a data byte,
but I'm not sure what this means in the i2c protocol.

If I understand your patch correctly, this is adding support
for the slave refusing to ACK when the master sends out the
slave address and r/w bit. I think that makes sense, but rather
than having a state flag in the I2CSlave struct, we should
change the prototype of the I2CSlaveClass event method so that
it can return a value indicating ack or nak.

thanks
-- PMM
