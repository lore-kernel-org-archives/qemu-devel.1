Received: from eggs.gnu.org ([2001:4830:134:3::10]:34058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1faHeZ-0006I5-TA
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1faHeX-0003ds-6r
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:31:19 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:34103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1faHeW-0003dA-SR
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:31:17 -0400
Received: by mail-wr0-x244.google.com with SMTP id a12-v6so1226304wro.1
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 02:31:16 -0700 (PDT)
Date: Tue, 3 Jul 2018 10:31:13 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180703093113.GF16791@stefanha-x1.localdomain>
References: <20180626093204.27612-1-contrib@steffen-goertz.de>
	<20180627094456.GB4325@stefanha-x1.localdomain>
	<CAFEAcA-j8z4TLN=Qo82JicSQ_=YnJnGjAoLiMOnyfmd1QtQo7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Wb5NtZlyOqqy58h0"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-j8z4TLN=Qo82JicSQ_=YnJnGjAoLiMOnyfmd1QtQo7w@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC v2] arm: Add NRF51 SOC non-volatile memory
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>, QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Thomas Huth <thuth@redhat.com>


--Wb5NtZlyOqqy58h0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 01:18:35PM +0100, Peter Maydell wrote:
> On 27 June 2018 at 10:44, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > On Tue, Jun 26, 2018 at 11:32:04AM +0200, Steffen G=F6rtz wrote:
> >> Changes since V1:
> >> - Code style changes
> >
> > Please put the changelog below '---'.
> >
> >> diff --git a/hw/nvram/nrf51_nvmc.c b/hw/nvram/nrf51_nvmc.c
> >> new file mode 100644
> >> index 0000000000..5dde3088a8
> >> --- /dev/null
> >> +++ b/hw/nvram/nrf51_nvmc.c
> >> @@ -0,0 +1,168 @@
> >> +/*
> >> + * nrf51_nvmc.c
> >> + *
> >> + * Copyright 2018 Steffen G=F6rtz <contrib@steffen-goertz.de>
> >> + *
> >> + * This code is licensed under the GPL version 2 or later.  See
> >> + * the COPYING file in the top-level directory.
> >> + */
> >
> > Please mention the full name of the peripheral so its purpose is clear
> > and include a link to the datasheet.
> >
> > It's convenient to have this information in the .c file, since that's
> > where the majority of code changes happen.
> >
> >> diff --git a/include/hw/nvram/nrf51_nvmc.h b/include/hw/nvram/nrf51_nv=
mc.h
> >> new file mode 100644
> >> index 0000000000..3a63b7e5ad
> >> --- /dev/null
> >> +++ b/include/hw/nvram/nrf51_nvmc.h
> >> @@ -0,0 +1,51 @@
> >> +/*
> >> + * nrf51_nvmc.h
> >> + *
> >> + * Copyright 2018 Steffen G=F6rtz <contrib@steffen-goertz.de>
> >> + *
> >> + * This code is licensed under the GPL version 2 or later.  See
> >> + * the COPYING file in the top-level directory.
> >> + *
> >> + * See Nrf51 reference manual 6 Non-Volatile Memory Controller (NVMC)
> >> + * See Nrf51 product sheet 8.22 NVMC specifications
> >> + *
> >> + * QEMU interface:
> >> + * + sysbus MMIO regions 0: Memory Region with registers
> >> + *   to be mapped to the peripherals instance address by the SOC.
> >> + * + page_size property to set the page size in bytes.
> >> + * + code_size property to set the code size in number of pages.
> >> + *
> >> + * Accuracy of the peripheral model:
> >> + * + The NVMC is always ready, all requested erase operations succeed
> >> + *   immediately.
> >> + * + CONFIG.WEN and CONFIG.EEN flags can be written and read back
> >> + *   but are not evaluated to check whether a requested write/erase o=
peration
> >> + *   is legal.
> >
> > Checking CONFIG.EEN would be easy, please do it.
> >
> > Peter: CONFIG.WEN determines whether stores to the flash memory region
> > are allowed.  What is the best way to implement this protection?
>=20
> What accesses do they gate? If this is just accesses that go
> via the io_read() and io_write() functions then this is easy:
> just put a check in those functions in the appropriate place.
> The harder case is if they affect accesses to a region that
> is implemented as an MMIO ram region which can be executed from;
> that can be done, but gets annoyingly complicated:
>  * unmap the RAM and map an MMIO region which handles the errors
>    (only possible if the config bit gates the reads as well)
>  * use a ROM device memory region (only possible if reads are
>    always ok but writes might not be
>  * use the IOMMU APIs (maximum flexibility, maximum pain)
>=20
> A quick scan of the code suggests you're in the easy case
> where you can just have io_read() and io_write() handle
> the config switch checks, though.

Thanks!

> >> +    MemoryRegion *mr;
> >> +    AddressSpace as;
> >
> > I remember you said you tried
> > address_space_read/write(get_system_memory(), ...) but it didn't work.
> > Did you figure out why?
>=20
> Devices directly talking to get_system_memory() isn't a great
> design anyway.
>=20
> It's not clear to me what this device is doing with its
> AddressSpace, though; comments that went into more detail
> about what the device is and what the "memory" property is
> for might help.

I understand this issue now.  It's the same as qtest.

This device is only visible from cpu->as, it's not visible from
address_space_memory (system_memory).

The NVMC needs access to the SoC's flash memory region, and that's what
mr/as achieve here.  I agree that comments explaining the purpose of
mr/as would be useful.

--Wb5NtZlyOqqy58h0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbO0JhAAoJEJykq7OBq3PIQ6YH/2198w28gajjriWwSuUP62+Y
M6tmcDuX1extU+zBYshOW3nPkG32iqsn7pOsMRO2Oq8jsiU6dBYNbbf9vdYDpbIT
JIlGb6fXAXUNJVCxyDymdQ7BBNXyJDPnXAkcmXkqUiofplFnZUk4Raj2l6ERi/eM
oPoyXMjKhcj8xj/tw0Hi+d7CiE1/V53YfR2cGax/CGk7Nzie2cgCBzes8kGny4jj
+kR+a6UBW+B52N4a83jHAWsuZ/C2RS9qCNiwHxm9Nq3d+gzlm0/puhGrypH7BqP5
USKwnsU7AIOFY1eOOYWDXlTgNOsgQ6AAY29wkTu6rv8kmBqB2DbSdW/BwOG10eQ=
=BJAF
-----END PGP SIGNATURE-----

--Wb5NtZlyOqqy58h0--
