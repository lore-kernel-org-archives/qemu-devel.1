Received: from eggs.gnu.org ([209.51.188.92]:56805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLo0N-00047Z-Ax
	for qemu-devel@nongnu.org; Wed, 01 May 2019 08:06:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLo0K-0006e4-AD
	for qemu-devel@nongnu.org; Wed, 01 May 2019 08:06:31 -0400
References: <20190428155451.15653-1-thuth@redhat.com>
	<20190428155451.15653-3-thuth@redhat.com>
	<877eba77ps.fsf@zen.linaroharston>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3205a43e-20f3-b152-2f8c-a450dd8e7cdc@redhat.com>
Date: Wed, 1 May 2019 07:06:10 -0500
MIME-Version: 1.0
In-Reply-To: <877eba77ps.fsf@zen.linaroharston>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="F45pTOfiaZ1h9EkmYDIahfkltsXurWfiX"
Subject: Re: [Qemu-devel] [PATCH v2 2/8] tests/qemu-iotests/005: Add a
 sanity check for large sparse file support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, Ed Maste <emaste@freebsd.org>, Christophe Fergeau <cfergeau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F45pTOfiaZ1h9EkmYDIahfkltsXurWfiX
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Ed Maste <emaste@freebsd.org>, Christophe Fergeau <cfergeau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <3205a43e-20f3-b152-2f8c-a450dd8e7cdc@redhat.com>
Subject: Re: [PATCH v2 2/8] tests/qemu-iotests/005: Add a sanity check for
 large sparse file support
References: <20190428155451.15653-1-thuth@redhat.com>
 <20190428155451.15653-3-thuth@redhat.com> <877eba77ps.fsf@zen.linaroharston>
In-Reply-To: <877eba77ps.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/1/19 6:08 AM, Alex Benn=C3=A9e wrote:
>=20
> Thomas Huth <thuth@redhat.com> writes:
>=20
>> "check -raw 005" fails when running on ext4 filesystems - these do not=

>> support such large sparse files. Use the same check as in test 220 to
>> skip the test in this case.
>>
>> Suggested-by: Eric Blake <eblake@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/qemu-iotests/005 | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
>> index 2fef63af88..6136ced5c8 100755
>> --- a/tests/qemu-iotests/005
>> +++ b/tests/qemu-iotests/005
>> @@ -55,6 +55,15 @@ if [ "$IMGPROTO" =3D "sheepdog" ]; then
>>      _notrun "image protocol $IMGPROTO does not support large image si=
zes"
>>  fi
>>
>> +# Sanity check: For raw, we require a file system that permits the cr=
eation
>> +# of a HUGE (but very sparse) file.  tmpfs works, ext4 does not.
>=20
> Is this comment correct? Running on my ext4 home partition this test
> seems to be running fine and not skipping. Indeed:

>> +if [ "$IMGFMT" =3D "raw" ]; then
>> +    if ! truncate --size=3D5T "$TEST_IMG"; then

5T fits on ext4 but not ext3. This is not a straight copy from 220
(where the size in question was even bigger, at 513T), so the comment is
indeed slightly inaccurate; it may be worth figuring out which file
system actually failed to update the comment. But the code change is
correct once the comments are fixed.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--F45pTOfiaZ1h9EkmYDIahfkltsXurWfiX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzJi7MACgkQp6FrSiUn
Q2ruHgf9E8G/M1Rflj6m0/pjpBxJKZBbQaIu1+DYVqvQ++Rt5Euzuv69ikKVl34O
/eGor9gQYRUvaUK0eqSAijvbd2KEcjqrq9M5OmNSqfCbiNamQNl1kFUAa0XmX+/9
wVwkAwJ3QX8EYRhdOZdELOU8UuM/kN7OLpCM23Yjk25HQ1Q8eoUDztCKTZ5+3CTW
kZIYXJ2VR0//1d8+rT/gVKVoiXQOq6KyBDoCV7MYH9liVjuLVufpQ7NnE+Gn9UOO
md+awGMPwYD1B/qvAkoBrjXVm+s7v2F7925c1z2c2rGxfjV5iXuhWbwwSAlXdEe9
IKquF2Iq6ptyT3kLVp7LgxbgNWQKKw==
=v6jz
-----END PGP SIGNATURE-----

--F45pTOfiaZ1h9EkmYDIahfkltsXurWfiX--
