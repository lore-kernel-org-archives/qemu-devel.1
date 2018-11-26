Received: from eggs.gnu.org ([2001:4830:134:3::10]:34550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRKvc-0000Af-CU
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:44:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRKvb-0006xH-Ji
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:44:12 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gRKvb-0006wz-7D
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:44:11 -0500
Received: by mail-oi1-x242.google.com with SMTP id h25so16667583oig.1
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 09:44:11 -0800 (PST)
MIME-Version: 1.0
References: <20181112214224.31560-1-contrib@steffen-goertz.de>
	<20181112214224.31560-6-contrib@steffen-goertz.de>
	<CAFEAcA_oxGQY6K4wQ3TTz1moa8rrXd=Hd3bcjE5NM2d=omn0YQ@mail.gmail.com>
	<e1e4c8d7-cb81-7f1d-ae38-a4cac5c85a48@steffen-goertz.de>
In-Reply-To: <e1e4c8d7-cb81-7f1d-ae38-a4cac5c85a48@steffen-goertz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Nov 2018 17:43:59 +0000
Message-ID: <CAFEAcA_Du4OTLqfNECY=BTvW089RTNu3qpxm2yv=iLL9g-m5qQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 05/14] hw/nvram/nrf51_nvm: Add nRF51
 non-volatile memories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>
Cc: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>

On Mon, 26 Nov 2018 at 00:24, Steffen G=C3=B6rtz <mail@steffen-goertz.de> w=
rote:
>
> Hi Peter,
>
> thank you for your remarks!
>
> >> +};
> >> +
> >> +static uint64_t ficr_read(void *opaque, hwaddr offset
> >
> >> +            value &=3D ~(NRF51_PAGE_SIZE - 1);
> >> +            if (value < (s->flash_size - NRF51_PAGE_SIZE)) {
> >> +                memset(s->storage + value / 4, 0xFF, NRF51_PAGE_SIZE)=
;
> >
> > Can the guest try to execute from the flash storage? If so
> > then just updating the backing storage directly like this is
> > not sufficient to ensure that QEMU discards any now-stale
> > translated code blocks from the affected memory.
>
> What else is necessary to invalidate stale blocks?

You need an AddressSpace that points to the MemoryRegion(s)
you're altering, and you need to use the operations on
the AddressSpace like address_space_write(). These will
under the hood do the right thing with TB invalidation.

> >> +static void nrf51_nvm_reset(DeviceState *dev)
> >> +{
> >> +    NRF51NVMState *s =3D NRF51_NVM(dev);
> >> +
> >> +    s->config =3D 0x00;
> >
> > Shouldn't uicr_content[] and storage be reset too ?
>
>
> Storage and uicr_content should be retained during a device reset.

If you want storage that lives over system reset, that is
painful, because it means you need to back it with a
block device (like we do for disks and for flash memory).
(This is because QEMU's system reset is a hard-power-cycle;
it should be equivalent to stopping QEMU entirely and
then restarting it, so any persistent storage needs to be
in a block device somewhere.)

thanks
-- PMM
