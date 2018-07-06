Received: from eggs.gnu.org ([2001:4830:134:3::10]:54709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fbITU-0007ce-HF
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 00:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fbITQ-0007sY-Hm
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 00:36:04 -0400
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:33448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1fbITQ-0007qE-6s
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 00:36:00 -0400
Received: by mail-pf0-x22f.google.com with SMTP id b17-v6so7299497pfi.0
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 21:36:00 -0700 (PDT)
References: <20180705182001.16537-1-mdavidsaver@gmail.com>
	<20180705182001.16537-4-mdavidsaver@gmail.com>
	<20180706033942.GN3450@umbus.fritz.box>
From: Michael Davidsaver <mdavidsaver@gmail.com>
Message-ID: <b7dfce5a-ee0e-b796-fbb6-236c8cf5ee9b@gmail.com>
Date: Thu, 5 Jul 2018 21:35:50 -0700
MIME-Version: 1.0
In-Reply-To: <20180706033942.GN3450@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="330zF1RZwihy9mmwbTQ6CEunepZFHF1g9"
Subject: Re: [Qemu-devel] [PATCH 03/14] timer: ds1338 persist 12-hour mode
 selection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Antoine Mathys <barsamin@gmail.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--330zF1RZwihy9mmwbTQ6CEunepZFHF1g9
From: Michael Davidsaver <mdavidsaver@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Antoine Mathys <barsamin@gmail.com>, qemu-devel@nongnu.org
Message-ID: <b7dfce5a-ee0e-b796-fbb6-236c8cf5ee9b@gmail.com>
Subject: Re: [PATCH 03/14] timer: ds1338 persist 12-hour mode selection
References: <20180705182001.16537-1-mdavidsaver@gmail.com>
 <20180705182001.16537-4-mdavidsaver@gmail.com>
 <20180706033942.GN3450@umbus.fritz.box>
In-Reply-To: <20180706033942.GN3450@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 07/05/2018 08:39 PM, David Gibson wrote:
> On Thu, Jul 05, 2018 at 11:19:50AM -0700, Michael Davidsaver wrote:
> 11;rgb:ffff/ffff/ffff> Need to save HOUR[HOUR12] bit to keep
>> track of guest selection of 12-hour mode.
>> Write through current time registers to
>> achieve this.  Will be overwritten
>> by the next read/latch.
>>
>> This was only being done in two of three
>> arms of this conditional block.
>>
>> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
>=20
> This looks dubious to me, or at least the explanation of it does.  The
> other branch of the conditional is covering different registers in the
> device, which are part of the RTC component, rather than the NVRAM
> area.  I wouldn't necessarily expect them to persist data as a rule
> the way the rest of the block does, even if this specific bit does
> need to be preserved.

The fact that the above capture_current_time() included the line

>     if (s->nvram[2] & HOURS_12) {

was enough to convince me that the original author intended to persist
the 12/24 hour mode in this way.  There are certainly other ways to
accomplish this, but they would involved adding to the vmstate,
which I've tried to avoid in this iteration.


Also, I though I had test coverage of this bug.  That's actually how I
noticed it to begin with.  But it seems my later change to allow for a
slow test runner also stopped testing readback of the 12/24 hour mode bit=
=2E
It just silently uses whichever it reads.  I'll be re-issuing an updated
version which restores this check.  Then you will be able to easily
see the effect of reverting 'timer: ds1338 persist 12-hour mode selection=
'.



>> ---
>>  hw/timer/ds1338.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/hw/timer/ds1338.c b/hw/timer/ds1338.c
>> index 7298c5af43..b56db5852e 100644
>> --- a/hw/timer/ds1338.c
>> +++ b/hw/timer/ds1338.c
>> @@ -220,10 +220,8 @@ static int ds1338_send(I2CSlave *i2c, uint8_t dat=
a)
>>             value unchanged. */
>>          data =3D (data & ~CTRL_OSF) | (data & s->nvram[s->ptr] & CTRL=
_OSF);
>> =20
>> -        s->nvram[s->ptr] =3D data;
>> -    } else {
>> -        s->nvram[s->ptr] =3D data;
>>      }
>> +    s->nvram[s->ptr] =3D data;
>>      inc_regptr(s);
>>      return 0;
>>  }
>=20



--330zF1RZwihy9mmwbTQ6CEunepZFHF1g9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEYyRdrpxuENu06SOrlAHmyz1/GOoFAls+8aoACgkQlAHmyz1/
GOq5Rw/9EVwod4An8V+pwgVVMLTr21qQrRj1vXEQLwZq4tvUXxKkCJ5/V8vnaYZQ
xCatP9rL58FA8/Yf6hrR0TEyCuepdoiS6IMvOI9ioCHWwZlQY6XUPI0tkFDRYOTg
FEMo5Q7lercH3qkmV1EyHh5qk4xDG+edtAZpX1v9VBfxshxa4KYZRzSHnWVhDdXD
80CSb4xsVxpayBoO7AIDNQ2xbrjeDHf5H5/v7DXxIdMYInPWZF0cmki7g7ECqYuY
P6x6zFboM+V1TLuMvL73nwwUQhQylpVc1GmCS3Fi/Y7W1KXbMrLCgH8t0SJ38/Q4
ufEmaSQFJx68xeq2iFALx/H3s/MdDuHlvxPOhCxCaSOBErqCRIK5Jwok7AA/JpLm
pAKvrACv7YSa5lcHfajnf3pyciSzqiZGhjyKFtTQe4UDI/WE9rAQ7ssQHacBrO5Y
m1gCKiV0iUlLHTaXsZHXhR4PkqcZqeTHu8ZMjGTkbpvMWvBHoccR0bN1ShvJOdMX
w1/JwulFMeOU1Xx4kHRPpvEniNh41R0Nk4clRXNTM0qfA3qO9sWwAsVOImekkfi7
l8s6XcxDtx13BEi8r3bEIAeR7VrqxUoGZ3yjhYZhD4NW2uuggolrZTM39zqenxDe
Lr6NsAgIAQKtW3Gi81raVYwdAPCgL+deYiHs0cXRzrCW4lDwHRw=
=UHDi
-----END PGP SIGNATURE-----

--330zF1RZwihy9mmwbTQ6CEunepZFHF1g9--
