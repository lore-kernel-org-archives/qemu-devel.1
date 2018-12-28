Received: from eggs.gnu.org ([208.118.235.92]:50431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <public@hansmi.ch>) id 1gcvAX-0007hK-Hn
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 11:40:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <public@hansmi.ch>) id 1gcvA2-0000rB-S8
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 11:39:29 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:50943)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <public@hansmi.ch>) id 1gcvA0-0000iR-Uh
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 11:38:58 -0500
From: Michael Hanselmann <public@hansmi.ch>
References: <e0d6e64a5f4b3ed436bb91aa3428986a06a0f1f1.1545911443.git.public@hansmi.ch>
	<CAAdtpL5L-BgsUJ_yNkGQBPvPhyneN=csQMaRxqiaZDx-XZzaag@mail.gmail.com>
Message-ID: <8344cc5b-b06a-200d-d31c-2967a9055269@msgid.hansmi.ch>
Date: Fri, 28 Dec 2018 17:38:37 +0100
MIME-Version: 1.0
In-Reply-To: <CAAdtpL5L-BgsUJ_yNkGQBPvPhyneN=csQMaRxqiaZDx-XZzaag@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="aV5Zz91YVyjfuiWyXbmtfxvwf9NmxweND"
Subject: Re: [Qemu-devel] [PATCH] smbus_eeprom: Limit data writes to 255
 bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <minyard@acm.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aV5Zz91YVyjfuiWyXbmtfxvwf9NmxweND
From: Michael Hanselmann <public@hansmi.ch>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <minyard@acm.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Corey Minyard <cminyard@mvista.com>
Message-ID: <8344cc5b-b06a-200d-d31c-2967a9055269@msgid.hansmi.ch>
Subject: Re: [Qemu-devel] [PATCH] smbus_eeprom: Limit data writes to 255 bytes
References: <e0d6e64a5f4b3ed436bb91aa3428986a06a0f1f1.1545911443.git.public@hansmi.ch>
 <CAAdtpL5L-BgsUJ_yNkGQBPvPhyneN=csQMaRxqiaZDx-XZzaag@mail.gmail.com>
In-Reply-To: <CAAdtpL5L-BgsUJ_yNkGQBPvPhyneN=csQMaRxqiaZDx-XZzaag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Philippe

On 27.12.18 20:03, Philippe Mathieu-Daud=C3=A9 wrote:
> On Thu, Dec 27, 2018 at 12:53 PM Michael Hanselmann <public@hansmi.ch> =
wrote:
> &gt; The "eeprom_write_data" function in "smbus_eeprom.c" had no provis=
ions
> &gt; to limit the length of data written. If a caller were able to mani=
pulate
> &gt; the "len" parameter they could potentially write before or after t=
he
> &gt; target buffer.
>=20
> You forgot to sign your commit:
> "Signed-off-by: Michael Hanselmann <public@hansmi.ch>"

Indeed I did and I'm sorry.

Signed-off-by: Michael Hanselmann <public@hansmi.ch>

>> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
>> index f18aa3de35..74fa1c328c 100644
>> --- a/hw/i2c/smbus_eeprom.c
>> +++ b/hw/i2c/smbus_eeprom.c
>> @@ -76,6 +76,7 @@ static void eeprom_write_data(SMBusDevice *dev, uint=
8_t cmd, uint8_t *buf, int l
>>         It is a block write without a length byte.  Fortunately we
>>         get the full block anyway.  */
>>      /* TODO: Should this set the current location?  */
>> +    len &=3D 0xff;
>>      if (cmd + len > 256)
>=20
> Corey Minyard sent a cleanup series [1] because this device model is
> known to be unsafe and need rewrite.
> There is a particular patch [2] which add the SMBUS_EEPROM_SIZE definit=
ion.
> He also provided a intent at cleaning this problem here [3] where
> Peter suggested to split it in fewer patches.

I agree with the assessment that the code as-is has room for
improvement, especially when it comes to the hardcoded sizes. My patch
is purely on top of the master branch (ca. QEMU 3.1.0).

Best regards,
Michael


--aV5Zz91YVyjfuiWyXbmtfxvwf9NmxweND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENEVC6w7lpobWh8t0Yy8zJpbbY3YFAlwmUZEACgkQYy8zJpbb
Y3ZAUBAAmjspyBx5Tub23KzbCfhNPbqHIDcbWoFIoUXsLKQSrFjhPlemFNnLUn15
dcTX7p/CacP4lKchxKW+1kyi5N3hiNkU0Kz+LnsxO8GzjiFnX9M2w5VOnypmgYcY
ERrjy6ElM+QQXT0AJr0FNghWUo6MoFpQjTarCeNLrqQQyjnTtl+trGQO/gNRQiDn
zmuEwQTMQ3dRCiutYe28odbajpn1YhzyEBDqK7OrTQMKSQzx4QnsVmuALFSxLUbp
sYWS7I4ODPzxumwfQ01lPp4IPo0UWS/ElSKy/iBewTfptmu7VX7Mawzp1tgfsDGz
I+deHBceJvtngok/oR00x/9otKf+vPrJbOlDQZdSJq3TTJYig73+W5yxX9sYQ5G+
uWxaec3H8zDG+pk9QRmweA1oEqS9OqAIjcaKkPa1PLJzGCZX2cpe4zmPzQQjS1RO
k929TaQQCeAD+Bj/ai5q1WleleIb+pJ5lrWo6Y+uPxipUxIXEL1aTFqhrOei+hDk
GDKzKMzSOxcT68eGAWjp8J7a4Lh1a7xu3AlF8+uoLLhG0YLStMqVW4jU6cXyqYMv
28WKa8o6g0L+xJsK+qW/MXebB4p4+96+i3LmXwWg4AlCxQJI1SybTdMZ9nNubgji
6F7ngawefVJTKfEziMgbw8PDK1vBOLalI2Apunk6W4rCdBvE3vI=
=JLi5
-----END PGP SIGNATURE-----

--aV5Zz91YVyjfuiWyXbmtfxvwf9NmxweND--
