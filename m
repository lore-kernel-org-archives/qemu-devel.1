Received: from eggs.gnu.org ([2001:4830:134:3::10]:44565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alastair@au1.ibm.com>) id 1cIn2t-0001Zt-QB
	for qemu-devel@nongnu.org; Sun, 18 Dec 2016 20:47:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alastair@au1.ibm.com>) id 1cIn2q-0007er-Ld
	for qemu-devel@nongnu.org; Sun, 18 Dec 2016 20:47:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43461
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alastair@au1.ibm.com>)
	id 1cIn2q-0007dc-FQ
	for qemu-devel@nongnu.org; Sun, 18 Dec 2016 20:47:16 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBJ1i7HK144767
	for <qemu-devel@nongnu.org>; Sun, 18 Dec 2016 20:47:12 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27dt5yu88x-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 18 Dec 2016 20:47:12 -0500
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alastair@au1.ibm.com>;
	Mon, 19 Dec 2016 11:47:09 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9D7C42BB0045
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 12:47:07 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	uBJ1l7hm6619544
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 12:47:07 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
	by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	uBJ1l7sK006110
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 12:47:07 +1100
From: "Alastair D'Silva" <alastair@au1.ibm.com>
Date: Mon, 19 Dec 2016 12:47:06 +1100
In-Reply-To: <CAFEAcA--cM3Sn+Y4RA8BwsPCOWsJEPbQ3Npue32RPa7wLDCz2A@mail.gmail.com>
References: <20161123194605.94717-1-flus@cesar.org.br>
	<20161129193052.11736-1-flus@cesar.org.br>
	<CAFEAcA--cM3Sn+Y4RA8BwsPCOWsJEPbQ3Npue32RPa7wLDCz2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1482112026.17769.25.camel@au1.ibm.com>
Content-Transfer-Encoding: quoted-printable
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
To: Peter Maydell <peter.maydell@linaro.org>, Fabio Urquiza <flus@cesar.org.br>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Corey Minyard <cminyard@mvista.com>


On Fri, 2016-12-16 at 17:35 +0000, Peter Maydell wrote:
> (added a couple of people to cc who might have an opinion on the i2c
> protocol questions below)

I'm certainly no expert, but I'll try :)

> On 29 November 2016 at 19:30, Fabio Urquiza <flus@cesar.org.br>
> wrote:
<snip>
> >=20
> > One of the problems we had to address is regarding the behavior of
> > the
> > ATMEL I2C TPM AT97SC3204T Linux driver. After the driver sends a
> > request
> > to the TPM, it keeps polling the device with I2C read request. The
> > real
> > AT97SC3204T hardware ignore those requests while the response is
> > not ready
> > simply by not ACKing the I2C read on its address. When the response
> > is
> > ready it will ACK the request and proceed writing the response in
> > the wire.
> >=20
> > The QEMU I2C API does not provide a way to not ACK I2C requests
> > when the
> > device is not ready to transmit. In fact, if the device has been
> > configured
> > in the virtual machine, QEMU will automatically ACK every request
> > without
> > asking for the device permission for it. Therefore we created a
> > flag in
> > the I2CSlave struct that tells the I2C subsystem that the device is
> > busy
> > and not ready to ACK a I2C transfer. We understand that it could
> > not be
> > the best solution to the problem, but it appears to be the solution
> > that
> > have the least impact in the code overall. Suggestions on a
> > different
> > approach would be welcome.
>=20
> I2C slaves definitely ought to be able to NAK I2C requests. This
> is possible for sends, ie data sent from the master to the slave
> (the slave just returns non-zero from its I2CSlaveClass::send
> function).
> In i2c protocol terms, this corresponds to the slave generating a NAK
> (by not taking SDA low) after the master has sent a byte of data.
> The bitbang_i2c code used by versatile was buggy in handling NAKs
> for sends until commit 9706e0162d24.
>=20

I agree that they should be able to NAK, it seems that this may be the
first device that actually needs that functionality (or at least, has
implemented it).

The change looks about as minimal as one could make it, so I'm mostly
happy with it.

I think we may need to add the busy field to hw/i2c/core.c:
VMStateDescription vmstate_i2c_slave, if this state should be
persisted.

Also, it looks like the busy element is only ever used in a boolean
context, so a boolean type may be more appropriate.

> For recv I'm less sure how it ought to work, so if you can explain
> in terms of the i2c protocol what slave h/w behaviour we're trying
> to emulate that would help. At what points in the protocol can
> the slave return a NAK?
>=20
> Our current API seems to envisage that the slave can return a
> negative value from I2CSlaveClass::recv instead of a data byte,
> but I'm not sure what this means in the i2c protocol.

Negative values are propagated upwards, where they are treated as
errors, eg, in hw/i2c/aspeed_i2c.c:aspeed_i2c_bus_handle_cmd():

int ret =3D i2c_recv(bus->bus);
if (ret < 0) {
=C2=A0=C2=A0=C2=A0=C2=A0qemu_log_mask(LOG_GUEST_ERROR, "%s: read failed\n=
", __func__);
=C2=A0=C2=A0=C2=A0=C2=A0ret =3D 0xff;
}

The call to i2c_recv is too late to issue the NAK, I believe they occur
during the start_transfer() call.


> If I understand your patch correctly, this is adding support
> for the slave refusing to ACK when the master sends out the
> slave address and r/w bit. I think that makes sense, but rather
> than having a state flag in the I2CSlave struct, we should
> change the prototype of the I2CSlaveClass event method so that
> it can return a value indicating ack or nak.
>=20

Hmm, this could end up being quite an invasive change, but ultimately
more elegant. I'm not sure which way the community prefers.

> thanks
> -- PMM

--=20
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819
