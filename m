Received: from eggs.gnu.org ([2001:4830:134:3::10]:41457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dXBRf-0000vY-Kc
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 15:12:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dXBRe-0006bT-Kl
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 15:12:39 -0400
References: <20170717151207.24919-1-mreitz@redhat.com>
	<c8ff1dc0-e1a1-73eb-a5d1-11ed50eff148@reactos.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ce2f1e11-202b-6941-e5b5-f72cdb2824a0@redhat.com>
Date: Mon, 17 Jul 2017 21:12:29 +0200
MIME-Version: 1.0
In-Reply-To: <c8ff1dc0-e1a1-73eb-a5d1-11ed50eff148@reactos.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mn4SmEjwj0T3d3w3g4qcS1JB67plrXAtu"
Subject: Re: [Qemu-devel] [PATCH] block/vvfat: Fix compiler warning with gcc
 7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mn4SmEjwj0T3d3w3g4qcS1JB67plrXAtu
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <ce2f1e11-202b-6941-e5b5-f72cdb2824a0@redhat.com>
Subject: Re: [PATCH] block/vvfat: Fix compiler warning with gcc 7
References: <20170717151207.24919-1-mreitz@redhat.com>
 <c8ff1dc0-e1a1-73eb-a5d1-11ed50eff148@reactos.org>
In-Reply-To: <c8ff1dc0-e1a1-73eb-a5d1-11ed50eff148@reactos.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2017-07-17 20:40, Herv=E9 Poussineau wrote:
> Le 17/07/2017 =E0 17:12, Max Reitz a =E9crit :
>> gcc 7 complains that the sprintf() might write a null byte beyond the
>> end of the tail buffer.  That is wrong, but we can silence it by makin=
g
>> i unsigned (it can never be negative anyway, see the if condition righ=
t
>> before).  For some reason, this allows gcc to suddenly accurately
>> calculate the range of i so we can give the tail[] array the exact siz=
e
>> it needs to have (which is 8 bytes) without gcc complaining.
>>
>> In addition, let us convert the sprintf() to snprintf(), because that =
is
>> always nicer, and add an assertion about the range of the return value=

>> afterwards so we can see that "8 - len" will never be negative and thu=
s
>> "entry->name + MIN(j, 8 - len)" will never be out of bounds.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/vvfat.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/vvfat.c b/block/vvfat.c
>> index 6b11596..a9e207f 100644
>> --- a/block/vvfat.c
>> +++ b/block/vvfat.c
>> @@ -549,7 +549,7 @@ static direntry_t
>> *create_short_filename(BDRVVVFATState *s,
>>      const gchar *p, *last_dot =3D NULL;
>>      gunichar c;
>>      bool lossy_conversion =3D false;
>> -    char tail[11];
>> +    char tail[8];
>>
>>      if (!entry) {
>>          return NULL;
>> @@ -614,7 +614,8 @@ static direntry_t
>> *create_short_filename(BDRVVVFATState *s,
>>      for (i =3D lossy_conversion ? 1 : 0; i < 999999; i++) {
>>          direntry_t *entry1;
>>          if (i > 0) {
>> -            int len =3D sprintf(tail, "~%d", i);
>> +            int len =3D snprintf(tail, sizeof(tail), "~%u", (unsigned=
)i);
>> +            assert(len <=3D 7);
>=20
> As i is on minimum between 0 or 1 and on maximum equal at 999999, does
> it work if you change the type of i from int to unsigned int?
> That way, you probably won't need the cast to unsigned in the s(n)print=
f.

Hm... It works in a way, but then gcc likes to think tail[] needs to be
9 bytes long (for whatever reason). So... It works in a sense, but not
quite as well.

So I'm not quite sure which way is better. :-)

Max


--mn4SmEjwj0T3d3w3g4qcS1JB67plrXAtu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZbQwdEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQIz6
B/9+HUtK5H+Fxu/uvh9ByQTvKhaHMMeaMV1Uyo4hNYqhKrJ3hlNaBNlLyGtM/otl
bNEI3E6V/V8slI6pgKOXDMpRLSpcomnG1SyrhLadiHO0yZw22b9MOdgJy70jUG/+
XX5rkUkJq4EGYhJc9/+WOpse5TI8TsKsJ61Qb5knj8RsymL/PBpnL5HZOp/DYlgh
VIhlpJC+fAqI07hSs3xTpYcXuP8c8e938gmyygKjytF2CwHnqx6v9Ce1mnh2Q2eY
ef+8EIZGdXBGxd3ssYHGPoxiL0AJGPMo9jg9zu+BFyyqn9fLz2cGoqRkYKHOJo6I
ATkAvrg5qJ/Pv3CvVLQSLC5P
=UoBA
-----END PGP SIGNATURE-----

--mn4SmEjwj0T3d3w3g4qcS1JB67plrXAtu--
