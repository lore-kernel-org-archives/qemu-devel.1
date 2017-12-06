Received: from eggs.gnu.org ([2001:4830:134:3::10]:36504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eMQLv-0002Pq-RD
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 22:26:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eMQLu-0007RC-Sy
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 22:26:31 -0500
References: <cover.1511731946.git.mdavidsaver@gmail.com>
	<6cafcb638eb9c002b16e2459475d8ef7a2440849.1511731946.git.mdavidsaver@gmail.com>
	<20171205064905.GJ3057@umbus.fritz.box>
From: Michael Davidsaver <mdavidsaver@gmail.com>
Message-ID: <26f88d6d-cc31-5bcd-8c1d-9573527bd1b8@gmail.com>
Date: Tue, 5 Dec 2017 22:26:16 -0500
MIME-Version: 1.0
In-Reply-To: <20171205064905.GJ3057@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1N4Xk1n4o957URl5PEw3UQO95BrD8WQ68"
Subject: Re: [Qemu-devel] [PATCH 12/17] e500: add i2c controller to CCSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1N4Xk1n4o957URl5PEw3UQO95BrD8WQ68
From: Michael Davidsaver <mdavidsaver@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Message-ID: <26f88d6d-cc31-5bcd-8c1d-9573527bd1b8@gmail.com>
Subject: Re: [PATCH 12/17] e500: add i2c controller to CCSR
References: <cover.1511731946.git.mdavidsaver@gmail.com>
 <6cafcb638eb9c002b16e2459475d8ef7a2440849.1511731946.git.mdavidsaver@gmail.com>
 <20171205064905.GJ3057@umbus.fritz.box>
In-Reply-To: <20171205064905.GJ3057@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 12/05/2017 01:49 AM, David Gibson wrote:
> On Sun, Nov 26, 2017 at 03:59:10PM -0600, Michael Davidsaver wrote:
>> Add i2c controller found on mpc8540,
>> mpc8544, and P2010 (newer ppc, unmodeled).
>=20
> This adds it unconditionally.  Are there any E500 models where it
> doesn't exist?

Not in the devices I've looked at, though I certainly haven't looked
at them all.  In fact the mpc8544 has two i2c controllers.

I keep mentioning the P2010 as it is about a decade
newer than the mpc85xx chips.  My _assumption_ is that the commonalities
between these are a reasonable least common denominator.


>>
>> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
>> ---
>>  hw/ppc/e500_ccsr.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/hw/ppc/e500_ccsr.c b/hw/ppc/e500_ccsr.c
>> index c479ed91ee..cd8216daaf 100644
>> --- a/hw/ppc/e500_ccsr.c
>> +++ b/hw/ppc/e500_ccsr.c
>> @@ -46,6 +46,8 @@
>>  #define E500_ERR_DETECT  (0x2e40)
>>  #define E500_ERR_DISABLE (0x2e44)
>> =20
>> +#define E500_I2C_OFFSET  (0x3000)
>> +
>>  #define E500_DUART_OFFSET(N) (0x4500 + (N) * 0x100)
>> =20
>>  #define E500_PORPLLSR    (0xE0000)
>> @@ -72,6 +74,7 @@ typedef struct {
>>      uint32_t ccb_freq;
>> =20
>>      DeviceState *pic;
>> +    DeviceState *i2c;
>>  } CCSRState;
>> =20
>>  #define TYPE_E500_CCSR "e500-ccsr"
>> @@ -272,6 +275,18 @@ static void e500_ccsr_realize(DeviceState *dev, E=
rror **errp)
>>                                  sysbus_mmio_get_region(pic, 0));
>>      /* Note: MPIC internal interrupts are offset by 16 */
>> =20
>> +    /* attach I2C controller */
>> +    ccsr->i2c =3D qdev_create(NULL, "mpc8540-i2c");
>=20
> Ah.. so I think I missed this on many earlier patches.  I believe
> you're not generally supposed to create new subdevices at realize()
> time.  Instead the device should be created at CCSR instance_init()
> time (but the sub device's "realized" property will need to be set to
> 1 from CCSR realize()).
>=20
>> +    object_property_add_child(qdev_get_machine(), "i2c[*]",
>> +                              OBJECT(ccsr->i2c), NULL);
>> +    qdev_init_nofail(ccsr->i2c);
>> +    memory_region_add_subregion(&ccsr->iomem, E500_I2C_OFFSET,
>> +                                sysbus_mmio_get_region(
>> +                                    SYS_BUS_DEVICE(ccsr->i2c), 0));
>> +    sysbus_connect_irq(SYS_BUS_DEVICE(ccsr->i2c), 0,
>> +                          qdev_get_gpio_in(ccsr->pic, 16 + 27));
>> +
>> +
>>      /* DUARTS */
>>      /* for mpc8540, mpc8544, and P2010 (unmodeled), the DUART referen=
ce clock
>>       * is the CCB clock divided by 16.
>=20



--1N4Xk1n4o957URl5PEw3UQO95BrD8WQ68
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEYyRdrpxuENu06SOrlAHmyz1/GOoFAlonY1gACgkQlAHmyz1/
GOrqzhAApIwSmhSexaozMioKZuQy8Kr8i/Ato8bbBCBjvzURU685aeBwUV8AToDS
kF9PKvEKQ8P51JX+iliUyjGUUKhusojOaRaFy2xPiaU2Kel1uIiJ22Jp9hQBxnoa
6hHUhnwmHSVJXiNXUckAejHRV1p3SAzXPMyv3/DAOADr66f/lN3Z2D9L2DQjc7De
sxbOpd1xBLT2bxQSFzFZOLPkM6i3hdIZBBcZLJNftl/E5GzupTAtt+ZSqsJL3jrX
Y4D22IkW4tGbCAOYaZyHHGrTZEmfFDMAaH0oxUPWpa0Q4HV5WOPivRAT3VpSPyQQ
AAvZjfts94lE4U5ZHVdnRF0YDB0mnVO5YgTpDmZWc1AeLNaqs9WTTHm9MbQ4XfXb
ssaDBzLYaw0YTfctAZTWr8oEq4OpL4B+7SqHoAP++HIs3ELnhN647H9HgM8jtkXq
CAIgnvpk2iub3AGENO5GcMo2eyiBo2csMig1jxC746kQuugXNtrZ87fjNoblDjVc
aqoOaMHWcOO7uRYrHUDck2yUj/27OEMeY8EMfzN2hzZfSr4CbcFepRFwApfmqS3b
8GjXQGWZ0jSMjpoVT9WRPfEogX0n1XtIztHhqkhEQd8DZ1Gc90Hcb9qE0hXIhp9j
jwVPOl+mBCLsZQS3zWNSv0Oa0TkXnriQI9BrJzwiiDdXyd6pVLA=
=T9P1
-----END PGP SIGNATURE-----

--1N4Xk1n4o957URl5PEw3UQO95BrD8WQ68--
