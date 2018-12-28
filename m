Received: from eggs.gnu.org ([208.118.235.92]:34715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <public@hansmi.ch>) id 1gcvyj-0004f1-CC
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 12:31:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <public@hansmi.ch>) id 1gcvh7-0001A9-Vl
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 12:13:56 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:42361)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <public@hansmi.ch>) id 1gcvHM-0001CX-7F
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 11:46:32 -0500
References: <e0d6e64a5f4b3ed436bb91aa3428986a06a0f1f1.1545911443.git.public@hansmi.ch>
	<62ec6c1d-4ed8-11ad-f8a6-dd85f4fe53ab@redhat.com>
From: Michael Hanselmann <public@hansmi.ch>
Message-ID: <b7a71557-88c2-f9eb-4292-3feb68f31156@msgid.hansmi.ch>
Date: Fri, 28 Dec 2018 17:46:23 +0100
MIME-Version: 1.0
In-Reply-To: <62ec6c1d-4ed8-11ad-f8a6-dd85f4fe53ab@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="gR8XmQC1J80WOVaMwzIgjDpmxaF4j62t5"
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
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gR8XmQC1J80WOVaMwzIgjDpmxaF4j62t5
From: Michael Hanselmann <public@hansmi.ch>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com
Message-ID: <b7a71557-88c2-f9eb-4292-3feb68f31156@msgid.hansmi.ch>
Subject: Re: [PATCH] smbus_eeprom: Limit data writes to 255 bytes
References: <e0d6e64a5f4b3ed436bb91aa3428986a06a0f1f1.1545911443.git.public@hansmi.ch>
 <62ec6c1d-4ed8-11ad-f8a6-dd85f4fe53ab@redhat.com>
In-Reply-To: <62ec6c1d-4ed8-11ad-f8a6-dd85f4fe53ab@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Paolo

On 28.12.18 14:52, Paolo Bonzini wrote:
> On 27/12/18 12:51, Michael Hanselmann wrote:
>> The "eeprom_write_data" function in "smbus_eeprom.c" had no provisions=

>> to limit the length of data written. If a caller were able to manipula=
te
>> the "len" parameter they could potentially write before or after the
>> target buffer.
>> ---
>>  hw/i2c/smbus_eeprom.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
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
>>          n =3D 256 - cmd;
>>      else
>>
>=20
> Note that len is limited to 33 bytes (smbus_do_write and smbus_i2c_send=
).

In practice it turns out to be the case. I thought I had discovered an
out-of-bounds write because hw/i2c/smbus.c:smbus_i2c_recv increases
dev->data_len unconditionally. The I2C controller implemented in
hw/i2c/aspeed_i2c.c and used by certain ARM board emulations allows
fine-grained control of the communication which allowed me to increase
data_len easily (up to and beyond an overflow if intended). It was only
the state machine in smbus.c which made it impossible to actually get to
a usable point in my experiment (increasing data_len requires
SMBUS_WRITE_DATA->SMBUS_READ_DATA, then the communication must be
stopped via NACK to avoid resetting data_len in I2C_FINISH, but there's
no way from SMBUS_DONE to SMBUS_WRITE_DATA).

Adding bitwise-and for 0xff defuses this particular situation regardless
of what state an attacker can bring the emulated devices into.

Best regards,
Michael


--gR8XmQC1J80WOVaMwzIgjDpmxaF4j62t5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENEVC6w7lpobWh8t0Yy8zJpbbY3YFAlwmU18ACgkQYy8zJpbb
Y3ZrahAArgdi+Xe4E5cYOl5aU1H5qc88IS/kLdk1UzQ9Wu+7ZSxEkqC9JjwrOetK
kCQVra6tJI0s7Rn4ojLnhotUcq9T5fMxfXNNswZTHSIhadUQyeLef8aTIOhlF9Oy
srqBtTYP3NH/+1L+UMmh3A7ecrU/hrzPi6YzJSk5OB6kPTdyH2S3ckMo+X1XDM5m
DvEkiBBAwm1io/xJskYtfiAXw8jVtCqaFC74pFn0GievldNTjUKV5n5UnSWvpz6O
nl8CHJhdiQRYR13Td16WM4aoBwd8o6oWJGhSTNyGGWulUim7lwrDMMxKYsKwL+R0
p+JQ3/+04VeiCbmubeerymRDstlbZx/+n9hI33+hVt+Pf2Ubm0UWtAkZZDAoN7RD
TYt1Q97Psjh+efGnD78ekTRvsxIPlRFvpkolIsTf+n8ZDu0Nd1pxdKZdTWo24A+j
PWgwGqdJzNtIEixY7m+/PxBDe44JsgmF1DgRVEivZdXVen73YjP4h0FR3CxKzvJs
JbAnnb41qXqW1cWcU1I+fWTpqP/2lYf6Aps+/d4d52fG/FKA/QovS1/9jDTqY9ji
WmhwFBewE1REpI78FtW+5/ZGjHB+CXTfO56dSP1K6uNhMKSWYp69uMH8aMbm1QvL
xtuQ4NX5k1BhXWPDFXzFJb9uYo6g/ulefbdnMlLzOc3iiBtAETM=
=7t/z
-----END PGP SIGNATURE-----

--gR8XmQC1J80WOVaMwzIgjDpmxaF4j62t5--
