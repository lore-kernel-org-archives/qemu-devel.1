Received: from eggs.gnu.org ([2001:4830:134:3::10]:43726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1ejwkf-00079Z-Kx
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 19:41:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1ejwke-0005Cs-MF
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 19:41:17 -0500
Message-ID: <1518136859.14456.14.camel@aj.id.au>
From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 09 Feb 2018 11:10:59 +1030
In-Reply-To: <5562bd02-5399-b1af-f183-d9a16b0a1c62@amsat.org>
References: <20180208172202.9984-1-f4bug@amsat.org>
	<20180208172202.9984-2-f4bug@amsat.org>
	<CAFEAcA_0rt7cCJs43BjW3OcQh=oeby+4j2dtFPSzgCn9tqW1qQ@mail.gmail.com>
	<5562bd02-5399-b1af-f183-d9a16b0a1c62@amsat.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-g/Ze0FZMha2DgFY+D60N"
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/arm/aspeed: directly map the serial
 device to the system address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>


--=-g/Ze0FZMha2DgFY+D60N
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-02-08 at 14:40 -0300, Philippe Mathieu-Daud=C3=A9 wrote:
> On 02/08/2018 02:30 PM, Peter Maydell wrote:
> > On 8 February 2018 at 17:22, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> > > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > > ---
> > >  hw/arm/aspeed_soc.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> > > index c83b7e207b..a786750e14 100644
> > > --- a/hw/arm/aspeed_soc.c
> > > +++ b/hw/arm/aspeed_soc.c
> > > @@ -257,7 +257,7 @@ static void aspeed_soc_realize(DeviceState *dev, =
Error **errp)
> > >      /* UART - attach an 8250 to the IO space as our UART5 */
> > >      if (serial_hds[0]) {
> > >          qemu_irq uart5 =3D qdev_get_gpio_in(DEVICE(&s->vic), uart_ir=
qs[4]);
> > > -        serial_mm_init(&s->iomem, ASPEED_SOC_UART_5_BASE, 2,
> > > +        serial_mm_init(get_system_memory(), ASPEED_SOC_UART_5_BASE, =
2,
> > >                         uart5, 38400, serial_hds[0], DEVICE_LITTLE_EN=
DIAN);
> > >      }
> >=20
> > Is this a bug fix? It certainly changes behaviour, which
> > suggests that a fuller commit message would be useful.
>=20
> This patch is buggy indeed, using system_memory the serial address
> should be ASPEED_SOC_IOMEM_BASE + ASPEED_SOC_UART_5_BASE.
>=20

If you'd like to test, you can grab images from here:

https://openpower.xyz/job/openbmc-build/distro=3Dubuntu,target=3Dromulus/

For example (without the patch):

    $ wget     https://openpower.xyz/job/openbmc-build/1240/distro=3Dubuntu=
,target=3Dromulus/artifact/deploy/images/romulus/image-bmc
...
$ qemu-system-arm -M romulus-bmc -m 512 -drive file=3Dimage-bmc,if=3Dmtd,fo=
rmat=3Draw -nographic


U-Boot 2016.07 (Jan 25 2018 - 16:31:27 +0000)  =20

       Watchdog enabled                        =20
DRAM:  496 MiB                                 =20
Flash: 32 MiB                                  =20
*** Warning - bad CRC, using default environment

In:    serial                                  =20
Out:   serial                                  =20
Err:   serial                                  =20
Net:   aspeednic#0                             =20
Error: aspeednic#0 address not set.            =20

Hit any key to stop autoboot:  0               =20
## Loading kernel from FIT Image at 20080000 ...
...

And yeah, this patch breaks output.

Thanks for the cleanup though.

Andrew
--=-g/Ze0FZMha2DgFY+D60N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJafO4bAAoJEJ0dnzgO5LT5txkP/2KVWKHTkbbw2Xlr1A8iu/05
zhY7E/oF+qorK2j2XArDxUQ0mkcfjU3/RT4fdSDawcXvwSSOMO6PrVfyauBvUmT0
ucM9bb73E4MQYpO6iG28p5/b7zkydoszgB2wQOy9nU+Iy0cNATXRczudfEAO0RII
7qtxdsAoqZTCUAa0U6bGXcwc5TEqgUhoQbq71Nbrx0/ncmK5kx+Vtkh7CW2Ly6Nw
YtSml/O4GINXLms7NXB7XRh19BoifOfyJ65I0WFmeV++71GVuEYctV+DgsblkmMG
GnVsdSplOE4cnGuRlhSraAV9L+xGTA454jJ/Akx27c231R6mcYou7z1pYLJsvZ0O
QguK6kAtdp7ciU0NORUnrbboXjV3J4wMeCSGEvMRNtB/zaplz0I/fpCgZzIRGRng
moipr7JoHutE3+uPahhnWVX/ZEiWPY63kpTNyuSNb/eOeZ14Tj/5oMawGlcLo54r
OVR6WYue/yAlv5dnyke3Mjx/hY2daQBncKfp183eBKKjO7lHK7nUHoi2veEwpn3e
NMUjFI5xRqj5FBAikVc0wJXgTvbllkTqRujHZoro31zEQYdRrTz76x1vHoQVv818
p1utCaxdumQypBqYmQ2Yn+IbO8hEXZw5bdx/ro4WblnQt1nG8gZQawnMG3CbjlJt
l1eKn8DCyiYkXXSb75Pg
=pl4p
-----END PGP SIGNATURE-----

--=-g/Ze0FZMha2DgFY+D60N--
