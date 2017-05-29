Received: from eggs.gnu.org ([2001:4830:134:3::10]:54404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dFMs1-0004TA-PX
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:46:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dFMs0-0001JL-UX
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:46:13 -0400
References: <20170529152316.27647-1-mreitz@redhat.com>
	<20170529152316.27647-2-mreitz@redhat.com>
	<27c8dfc9-cef6-9d55-195a-20ef3a9a85e9@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a412a3b6-37ec-f321-c6d6-aa754153cfe0@redhat.com>
Date: Mon, 29 May 2017 17:46:01 +0200
MIME-Version: 1.0
In-Reply-To: <27c8dfc9-cef6-9d55-195a-20ef3a9a85e9@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bKoosFrkHGw51PIDkTpaHA7S1Xuk6lRvt"
Subject: Re: [Qemu-devel] [PATCH v3 1/2] iotests: Use absolute paths for
 executables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bKoosFrkHGw51PIDkTpaHA7S1Xuk6lRvt
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <a412a3b6-37ec-f321-c6d6-aa754153cfe0@redhat.com>
Subject: Re: [PATCH v3 1/2] iotests: Use absolute paths for executables
References: <20170529152316.27647-1-mreitz@redhat.com>
 <20170529152316.27647-2-mreitz@redhat.com>
 <27c8dfc9-cef6-9d55-195a-20ef3a9a85e9@redhat.com>
In-Reply-To: <27c8dfc9-cef6-9d55-195a-20ef3a9a85e9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-29 17:42, Eric Blake wrote:
> On 05/29/2017 10:23 AM, Max Reitz wrote:
>> A user may specify a relative path for accessing qemu, qemu-img, etc.
>> through environment variables ($QEMU_PROG and friends) or a symlink.
>>
>> If a test decides to change its working directory, relative paths will=

>> cease to work, however. Work around this by making all of the paths to=

>> programs that should undergo testing absolute. Besides "realpath", we
>> also have to use "which" to support programs in $PATH.
>=20
> 'type -p' is more portable than 'which' - especially since our scripts
> are bash scripts, and type is a bash builtin while which is not.
>=20
>>
>> As a side effect, this fixes specifying these programs as symlinks for=

>> out-of-tree builds: Before, you would have to create two symlinks, one=

>> in the build and one in the source tree (the first one for common.conf=
ig
>> to find, the second one for the iotest to use). Now it is sufficient t=
o
>> create one in the build tree because common.config will resolve it.
>>
>> Reported-by: Kevin Wolf <kwolf@redhat.com>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/common.config | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/com=
mon.config
>> index d1b45f5..08aac56 100644
>> --- a/tests/qemu-iotests/common.config
>> +++ b/tests/qemu-iotests/common.config
>> @@ -103,6 +103,12 @@ if [ -z "$QEMU_VXHS_PROG" ]; then
>>      export QEMU_VXHS_PROG=3D"`set_prog_path qnio_server`"
>>  fi
>> =20
>> +export QEMU_PROG=3D$(realpath "$(which "$QEMU_PROG")")
>> +export QEMU_IMG_PROG=3D$(realpath "$(which "$QEMU_IMG_PROG")")
>> +export QEMU_IO_PROG=3D$(realpath "$(which "$QEMU_IO_PROG")")
>> +export QEMU_NBD_PROG=3D$(realpath "$(which "$QEMU_NBD_PROG")")
>> +export QEMU_VXHS_PROG=3D$(realpath "$(which "$QEMU_VXHS_PROG")")
>=20
> If you switch all of these to $(realpath -- "$(type -p "$QEMU_...")"),
> you can add:

I'd love to, but this is what type -p outputs for me:

$ type -p qemu-img
qemu-img is /usr/bin/qemu-img

So I would need to parse the result (and it depends on the locale). If
that is indeed so, I'd rather stay with which, to be honest...

Max


--bKoosFrkHGw51PIDkTpaHA7S1Xuk6lRvt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZLEI5EhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQPPX
B/47zuSukQOjX2mqQveq/RiIOKok9C3ou0OQ5DSlsUf3JJnv0lIPdqYhSE/5t3c2
x56ittHn2Xpes9LRtCCXFgk136Xqpql3/26txOogcFX0P9/TYzv4W5I35oVMatS5
9JCfM7LY2nzTbQXGHBmMcSzJa1gpI+tq0kdXUOaM3iwCHJ6MAwcADB/TnLDR8FDM
9QyOfLKjvFFyl0asxSIzbWtc3+2sm3CdpQvlcJQflIoVr1/iY75apnzxtNa5DkRN
yMh4woeMV6cj0W5Z89lUi4QEY7Kx6RNOPvlmKkSBOVJQBI0VdpBo4WgVHXcWvi+e
Jnns72bvIe/Rzy7eCy720veh
=w9fH
-----END PGP SIGNATURE-----

--bKoosFrkHGw51PIDkTpaHA7S1Xuk6lRvt--
