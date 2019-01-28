Received: from eggs.gnu.org ([209.51.188.92]:37681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1go5R8-0001Gv-2f
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:50:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1go5R5-0002BJ-PS
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:50:45 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1go5R5-0002AQ-IG
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:50:43 -0500
Received: by mail-wm1-f66.google.com with SMTP id p6so13545985wmc.1
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 03:50:35 -0800 (PST)
References: <20181119110757.2692-1-ppandit@redhat.com>
	<20190128093157.GA27483@hle-laptop>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <83722857-5a7f-c722-4b56-6b04d78a9e2e@redhat.com>
Date: Mon, 28 Jan 2019 12:50:31 +0100
MIME-Version: 1.0
In-Reply-To: <20190128093157.GA27483@hle-laptop>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OOzV20WzeCUaYmImRmDvj8G3Lwunf4kBG"
Subject: Re: [Qemu-devel] [PATCH v2] bt: use size_t type for length
 parameters instead of int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hugo Lefeuvre <hle@debian.org>, P J P <ppandit@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>, Arash TC <tohidi.arash@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, debian-lts@lists.debian.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OOzV20WzeCUaYmImRmDvj8G3Lwunf4kBG
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Hugo Lefeuvre <hle@debian.org>, P J P <ppandit@redhat.com>,
 Eric Blake <eblake@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Arash TC <tohidi.arash@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, debian-lts@lists.debian.org
Message-ID: <83722857-5a7f-c722-4b56-6b04d78a9e2e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] bt: use size_t type for length parameters
 instead of int
References: <20181119110757.2692-1-ppandit@redhat.com>
 <20190128093157.GA27483@hle-laptop>
In-Reply-To: <20190128093157.GA27483@hle-laptop>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Hugo,

On 1/28/19 10:31 AM, Hugo Lefeuvre wrote:
> Hi,
>=20
>> The length parameter values are not negative, thus use an unsigned
>> type 'size_t' for them. Many routines pass 'len' values to memcpy(3)
>> calls. If it was negative, it could lead to memory corruption issues.
>> Add check to avoid it.
>=20
> I'm working on a Debian LTS security update for qemu and am currently
> thinking about addressing this issue as well.
>=20
> I see this patch has not been applied yet and the bluetooth subsystem
> is pending deprecation. Are you still considering to apply it?

I have been assigned to fix this issue, but rather fixing locally this
BT device, fix the pattern on all devices.
I'll post the series during the week and Cc you (and eventually the
Debian LTS list when it gets merged). The series obsoletes this patch,
so the plan is to not apply it.

>=20
>> @@ -113,6 +113,7 @@ static void vhci_host_send(void *opaque,
>>      static uint8_t buf[4096];
>> =20
>>      buf[0] =3D type;
>> +    assert(len < sizeof(buf));
>>      memcpy(buf + 1, data, len);
>> =20
>>      while (write(s->fd, buf, len + 1) < 0)
>=20
> Any reason why assert() calls are used here ?
>=20
> These checks should always be executed, but they won't if user compiles=

> without asserts. Also, AFAIK any assert failure will stop the qemu host=

> process which is not what we want in this case.

There was a discussion about this, and the outcome is QEMU does not
support building without assertions. See this commit:

https://git.qemu.org/?p=3Dqemu.git;a=3Dblobdiff;f=3Dinclude/qemu/osdep.h;=
h=3D9966638;hp=3D6855b94;hb=3D262a69f42;hpb=3D825bfa005

Regards,

Phil.


--OOzV20WzeCUaYmImRmDvj8G3Lwunf4kBG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAlxO7IgACgkQoqP9bt6t
wN7wkxAAr8YLQMsufSlXA2tgaSkJaTkP1ORXitZfzyuuB5IOncpU13rSsHF1Et+q
CrjMIjksz6X+hmR4tGzIcLNN3apL9rmVR7p9BMncN9FHkKqzo8mZONKWNJ4EsmbY
yRVheHdgeVJV4QRmLGG05tS/aRyu1BAua6pvNoaj3IqTXWMJXX6enbWslkaWFmPz
4WSSkAsneWgiFoKh9hFm+MN8uqP9CGFdXIGEf/b9jX7dXug9APy7SRI4hpPsDJU3
ktQlGT0y2p3cws1VavVdXmuHr/A/I/G9yuT0qFiJ8197lGuohzY7ifBH3dpq0JMW
2463fak1B9gqth90sycj6s3cGv6732adv31aTyCLPVYCmLdpaVmmEoZBrVwqJmWc
P3/XKu4Plcav3jZnWWNUR0OjDP2Sm7GIVDuusoRFz3xALNIi714thzmQClZUsB2G
/lTgAwyLORqTOMUUCmk8VASOZgWim2dRE7DcP+06XJkbZTDX6d3fuQ/aZFRXoJqY
aYJgN1hZ3fNagb1l4MJ+JLec+8X/xjLsGA89bGWMzm3wBEv/q1+DFPxngS5nf/Bl
pgH6z8mXGYjhSVBVp9Ej+oX5YzPRTMDVEGuqlsm9s7n0d07N7WGSOT14Da2NDfhB
H3qwdaYsU4ZDubKLQJgEIcACZEwHZ/lXPq3Z8Ctd59tIJc6hE2w=
=WsEE
-----END PGP SIGNATURE-----

--OOzV20WzeCUaYmImRmDvj8G3Lwunf4kBG--
